`timescale 1ns/10ps
`default_nettype none

module welch_psd_channel
  #(parameter INSTANCE=0,
    parameter MAX_ADDR=12'hFFF,
    parameter DATA_WIDTH=12,
    parameter WINDOW_WIDTH=16) 
   (
   input wire 			 clk,
   input wire 			 reset,

   input wire [DATA_WIDTH-1:0] 	 data_re_in,
   input wire [DATA_WIDTH-1:0] 	 data_im_in,
   input wire 			 data_in_valid,

   input wire 			 cpu_clk,
   input wire [11:0] 		 cpu_addr, //For window mem
   input wire [WINDOW_WIDTH-1:0] cpu_data,
   input wire 			 cpu_we,
   
   input wire 			 frame_start,
   input wire [11:0] 		 overlap_samples,
   input wire [11:0] 		 fft_size_m1, //FFT size - 1
    
   output reg [2*40-1:0] 	 fft_magnitude_sq,
   output reg 			 fft_magnitude_sq_valid,

   output reg 			 overlap_done,
   output reg 			 fft_done
    );

   import svlogger_pkg::*;
   
   localparam EXTRA_START_DELAY = 1;
   localparam FFT_OUT_BIT_WIDTH=48;
   localparam REDUCED_FFT_WIDTH=40; // FFT Output is Q11.27
   
   
   enum 	     {Idle, Mult1} state;
   logic [11:0]      addr_counter='h0;
   logic [11:0]      read_addr;


   logic signed [DATA_WIDTH-1:0] data_re; // Q0.11
   logic signed [DATA_WIDTH-1:0] data_im; // Q0.11
   
   logic [WINDOW_WIDTH-1:0]      window_value; //UQ0.16
   logic [1:0] 	     window_read_dv;

   typedef struct {
      logic signed [WINDOW_WIDTH+DATA_WIDTH-1:0] re; //Q0.27
      logic signed [WINDOW_WIDTH+DATA_WIDTH-1:0] im; //Q0.27
      logic 		       valid;
      logic 		       last;
      logic 		       tready;
   } window_product_struct;
   
   window_product_struct window_product;
   
   typedef struct {
      logic [2*FFT_OUT_BIT_WIDTH-1:0] data; //Q11.27
      logic 			    valid;
      logic 			    tready;
      logic 			    tlast;
   } fft_output_struct;
   
   fft_output_struct fft_output;

   logic [REDUCED_FFT_WIDTH-1:0]    fft_out_reduced_re, fft_out_reduced_im;
   
   typedef struct {
      logic 	  frame_started;
      logic 	  tlast_unexpected;
      logic 	  tlast_missing;
      logic 	  status_channel_halt;
      logic 	  data_in_channel_halt;
      logic 	  data_out_channel_halt;
   } event_struct;

   event_struct events;

   logic [2*REDUCED_FFT_WIDTH-1:0] fft_real_sq, fft_imag_sq;
   logic 			   fft_sq_valid;

   logic 			   trunc_result;
   
   //svlogger mylog;
   //synthesis translate_off
   string 	  str;
   int 		  len_str;
   //synthesis translate_on
   
   //synthesis translate_off
   initial begin
      //$display("%t: WPC:fopen %d", $time, mylog.file_open);
      mylog = new("output", SVL_VERBOSE_DEBUG, SVL_ROUTE_FILE, SVL_NOCOLOR);
   end
   //synthesis translate_on
   
   window_mem 
     WM0 (
	  .clka(cpu_clk),
	  .ena(1'b1),      // input wire ena
	  .wea(cpu_we),      // input wire [0 : 0] wea
	  .addra(cpu_addr),  
	  .dina(cpu_data),    // input wire [15 : 0] dina
	  .clkb(clk),    // input wire clkb
	  .enb(1'b1),
	  .addrb(read_addr),  
	  .doutb(window_value)  // output wire [15 : 0] doutb
	  );

   assign read_addr = addr_counter;
   
   always @(posedge clk or posedge reset) begin
      if (reset) begin
	 state <= Idle;
	 addr_counter <= 'h0;
	 overlap_done <= 1'b0;
      end
      else begin
	 overlap_done <= 1'b0;
	 
	 case (state)
	    Idle : begin
	       if (frame_start) begin
		  state <= Mult1;
	       end
	    end
	   
	   Mult1 : begin
	      if (addr_counter == MAX_ADDR) begin
		 state <= Idle;
		 addr_counter <= 0;
		 //fft_done <= 1'b1;
	      end
	      else begin
		 addr_counter <= addr_counter + 1;
		 
		 if (fft_size_m1 - addr_counter == overlap_samples + EXTRA_START_DELAY) // Register RHS
		   overlap_done <= 1'b1;
	      end
	   end

	   default : begin
	      state <= Idle;
	      addr_counter <= 'h0;
	      overlap_done <= 1'b0;
	   end
	 endcase // case (state)
      end
   end // always @ (posedge clk or posedge reset)

   assign data_re = signed'(data_re_in);
   assign data_im = signed'(data_im_in);

   function [27:0] mult_signed_unsigned(input [DATA_WIDTH-1:0] a_signed, input[WINDOW_WIDTH-1:0] b_unsigned);
      logic [DATA_WIDTH-1:0] a_unsigned;
      logic [DATA_WIDTH+WINDOW_WIDTH-1:0] prod_unsigned;
      
      begin
	 if (a_signed[DATA_WIDTH-1] == 1'b0) begin // Positive
	    prod_unsigned = b_unsigned * unsigned'(a_signed);
	    mult_signed_unsigned = signed'(prod_unsigned);
	 end
	 else begin
	    a_unsigned = unsigned'(-a_signed);
	    prod_unsigned = a_unsigned * b_unsigned;
	    
	    mult_signed_unsigned = -(signed'(prod_unsigned));
	 end
      end
   endfunction				 
   
   always @(posedge clk or posedge reset) begin
      if (reset) begin
	 window_read_dv <= 2'b0;
	 window_product.re <= 'h0;
	 window_product.im <= 'h0;	 
	 window_product.valid <= 1'b0;

	 window_product.last <= 1'b0;
      end
      else begin
	 window_read_dv[0] <= 1'b0;
	 if (state == Mult1)
	   window_read_dv[0] <= 1'b1;

	 window_read_dv[1] <= window_read_dv[0];

	 // Assume that data is constantly streaming in
	 window_product.re <= 'h0;
	 window_product.im <= 'h0;
	 if (window_read_dv[1]) begin


	    window_product.re <= mult_signed_unsigned(data_re, window_value);	    
	    window_product.im <= mult_signed_unsigned(data_im, window_value);
	    //$display("Product=0x%0h",window_product);
	 end
	 
	 window_product.valid <= window_read_dv[1];

	 window_product.last <= 1'b0;
	 if (window_read_dv == 2'b10)
	   window_product.last <= 1'b1;
      end
   end

   //synthesis translate_off
   always @(posedge clk) begin
      if (window_read_dv[1])
	mylog.debug($sformatf("%m:Data_Re=%0d, Data_Im=%0d",data_re, data_im));
   end
   //synthesis translate_on

      
   //synthesis translate_off
   always @(posedge clk) begin
      if (window_product.valid)
	mylog.debug($sformatf("%m:WIN_Re=%0d, WIN_Im=%0d",signed'(window_product.re), signed'(window_product.im)));
   end
   //synthesis translate_on
   

   assign fft_output.tready = 1'b1;
   
fft_block 
  FFT0(
       .aclk(clk),                                                // input wire aclk
       .s_axis_config_tdata(16'h0),                  // input wire [15 : 0] s_axis_config_tdata
       .s_axis_config_tvalid(1'b0),                // input wire s_axis_config_tvalid
       .s_axis_config_tready(),                // output wire s_axis_config_tready
       .s_axis_data_tdata({4'h0, window_product.im, 4'h0, window_product.re}),  // input wire [63 : 0] s_axis_data_tdata
       .s_axis_data_tvalid(window_product.valid),                    // input wire s_axis_data_tvalid
       .s_axis_data_tready(window_product.tready),                    // output wire s_axis_data_tready
       .s_axis_data_tlast(window_product.last),                      // input wire s_axis_data_tlast
       
       .m_axis_data_tdata(fft_output.data),                      // output wire [95 : 0] m_axis_data_tdata
       .m_axis_data_tvalid(fft_output.valid),                    // output wire m_axis_data_tvalid
       .m_axis_data_tready(fft_output.tready),                    // input wire m_axis_data_tready
       .m_axis_data_tlast(fft_output.tlast),                      // output wire m_axis_data_tlast
       .event_frame_started(events.frame_started),                  // output wire event_frame_started
       .event_tlast_unexpected(events.tlast_unexpected),            // output wire event_tlast_unexpected
       .event_tlast_missing(events.tlast_missing),                  // output wire event_tlast_missing
       .event_status_channel_halt(events.status_channel_halt),      // output wire event_status_channel_halt
       .event_data_in_channel_halt(events.data_in_channel_halt),    // output wire event_data_in_channel_halt
       .event_data_out_channel_halt(events.data_out_channel_halt)  // output wire event_data_out_channel_halt
);   

   // Upper 8 bits are not being used
   assign fft_out_reduced_re = fft_output.data[REDUCED_FFT_WIDTH-1:0];
   assign fft_out_reduced_im = fft_output.data[REDUCED_FFT_WIDTH+FFT_OUT_BIT_WIDTH-1:FFT_OUT_BIT_WIDTH];
   
   
   //synthesis translate_off
   always @(posedge clk) begin
      if (fft_output.valid) begin

	 if ((fft_output.data[REDUCED_FFT_WIDTH-1] == 0 && |(fft_output.data[FFT_OUT_BIT_WIDTH-1:REDUCED_FFT_WIDTH-1]) == 1 ) ||
	     (fft_output.data[REDUCED_FFT_WIDTH-1] == 1 && &(fft_output.data[FFT_OUT_BIT_WIDTH-1:REDUCED_FFT_WIDTH-1]) == 0)) begin
	    $display("%t: Truncating significant (real) bits. Data=%0h", $time, fft_output.data[FFT_OUT_BIT_WIDTH-1:0]);
	    str = $sformatf("%m:Trunc_FFT_Real=%0h", fft_output.data[FFT_OUT_BIT_WIDTH-1:0]);
	    mylog.error(str);
	 end

	 if ((fft_output.data[REDUCED_FFT_WIDTH+FFT_OUT_BIT_WIDTH-1] == 0 && |(fft_output.data[2*FFT_OUT_BIT_WIDTH-1:REDUCED_FFT_WIDTH+FFT_OUT_BIT_WIDTH]) == 1 ) ||
	     (fft_output.data[REDUCED_FFT_WIDTH+FFT_OUT_BIT_WIDTH-1] == 1 && &(fft_output.data[2*FFT_OUT_BIT_WIDTH-1:REDUCED_FFT_WIDTH+FFT_OUT_BIT_WIDTH]) == 0 )) begin
	    $display("%t: Truncating significant (imag) bits. Data=%0h", $time, fft_output.data[2*FFT_OUT_BIT_WIDTH-1:FFT_OUT_BIT_WIDTH]);
	    str = $sformatf("%m:Trunc_FFT_Imag=%0h", fft_output.data[2*FFT_OUT_BIT_WIDTH-1:FFT_OUT_BIT_WIDTH]);
	    mylog.error(str);
	 end

	 mylog.debug($sformatf("%m:FFT_Re=%0d, FFT_Im=%0d",
			       signed'(fft_out_reduced_re), 
			       signed'(fft_out_reduced_im)));
      end // if (fft_output.valid)
   end
   //synthesis translate_on

   function [2*REDUCED_FFT_WIDTH-1:0] square(input [REDUCED_FFT_WIDTH-1:0] val);
      begin
	 if (val[REDUCED_FFT_WIDTH-1] == 1'b0)
	   square = val * val;
	 else
	   square = -signed'(val) * -signed'(val);
      end
   endfunction // square
   
   
   always @(posedge clk or posedge reset) begin
      if (reset) begin
	 fft_real_sq <= 0;
	 fft_imag_sq <= 0;
	 fft_sq_valid <= 1'b0;

	 fft_magnitude_sq <= 0;
	 fft_magnitude_sq_valid <= 1'b0;

	 fft_done <= 1'b0;
      end

      else begin
	 if (fft_output.valid) begin
	    fft_real_sq <= square(fft_out_reduced_re);
	    fft_imag_sq <= square(fft_out_reduced_im);
	 end
	 fft_sq_valid <= fft_output.valid;

	 if (fft_sq_valid)
	   fft_magnitude_sq <= fft_real_sq + fft_imag_sq;
	 fft_magnitude_sq_valid <= fft_sq_valid;

	 fft_done <= 1'b0;
	 if (fft_sq_valid == 1'b0 && fft_magnitude_sq_valid == 1'b1)
	   fft_done <= 1'b1;
      end
   end

   //synthesis translate_off
   always @(posedge clk) begin
      if (fft_sq_valid) begin
	 mylog.debug($sformatf("%m:Sq_Re=%0d, Sq_Im=%0d",signed'(fft_real_sq), signed'(fft_imag_sq)));
      end

      if (fft_magnitude_sq_valid) begin
	 mylog.debug($sformatf("%m:Mag_Sq=%0d",signed'(fft_magnitude_sq)));	 
      end
   end
   //synthesis translate_on
   
   
endmodule // welch_psd_channel

