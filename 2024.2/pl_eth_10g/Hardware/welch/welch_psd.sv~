`timescale 1ns/10ps
`default_nettype none

module welch_psd
  #
  (parameter CHANNELS=4)
  (
   input wire		    clk,
   input wire		    reset,

   input wire [11:0]	    data_re_in,
   input wire [11:0]	    data_im_in,

   input wire		    cpu_clk,
   input wire [11:0]	    cpu_addr,
   input wire [15:0]	    cpu_data,
   input wire		    cpu_we, 

   input wire		    frame_start,
   input wire		    debug_in,
   output reg		    psd_done,

   input wire [11:0]	    overlap_samples,

   output wire [31:0]	    debug_out,
   
   output reg [2*40-18-1:0] sum_mag_sq,
   output reg		    sum_mag_sq_valid
   );

   import svlogger_pkg::*;
   localparam LG_CHANNELS = $clog2(CHANNELS);
   localparam TARGET_BITS = 16;
   
   logic [CHANNELS-1:0] channel_frame_start;

   logic [1:0] 		frame_start_pip;
   logic 		re_frame_start;
   
   enum 		{Idle,Start1} state;

   logic [CHANNELS-1:0]	ov_done;
   logic [CHANNELS-1:0]	fft_done;
   
   logic [CHANNELS-1:0]	mag_sq[2*40-1:0];
   logic [CHANNELS-1:0]	mag_sq_valid;
   
   logic [CHANNELS-1:0]	mag_sq_aligned[2*40-1:0];
   logic [CHANNELS-1:0]	mag_sq_aligned_valid;

   typedef struct {
      logic [2*40-1:0] mag_sq;
      logic mag_sq_valid;
      logic empty;

      logic rd_en;
      logic [2*40-1:0] mag_sq_aligned;
      logic mag_sq_aligned_valid;
      logic full;
      logic overflow;
   } wpc_fifo_struct;

   wpc_fifo_struct wpc_fifo[CHANNELS-1:0];
   
   enum 		{RIdle,Read1} rd_state;

   logic [2*40-1:0]	aligned_mag_sq[CHANNELS-1:0];
   
   logic [2*40-1:0]	sum_mag_sq_int;
   logic		sum_mag_sq_int_valid;

   logic [2*40-LG_CHANNELS-1:0]	sum_mag_sq_full;
   logic			sum_mag_sq_full_valid;

   logic [1:0]			sum_mag_sq_full_valid_pip;
   logic			fe_sum_mag_sq_valid_full;

   logic [31:0]			sum_mag_counter;
   
   
   // Debug
   logic			sample_counter_en;
   logic [14:0]			sample_counter;
   logic [CHANNELS-1:0]		fft_done_hold;
   logic			rd_state_read_hold;
   logic			fe_sum_mag_sq_valid_full_hold;
   
   //synthesis translate_off
   initial begin
      mylog = new("output", SVL_VERBOSE_DEBUG, SVL_ROUTE_FILE, SVL_NOCOLOR);
   end
   //synthesis translate_on
   
   
   always @(posedge clk or posedge reset) begin
      if (reset) begin
	 frame_start_pip <= 2'b0;
	 re_frame_start <= 1'b0;
      end
      else begin
	 frame_start_pip <= {frame_start_pip[0], frame_start};

	 re_frame_start <= 1'b0;
	 if (frame_start_pip == 2'b01)
	   re_frame_start <= 1'b1;
      end
   end
   
   always @(posedge clk or posedge reset) begin
      if (reset) begin
	 state <= Idle;
	 channel_frame_start[0] <= 1'b0;
      end
      else begin
	 channel_frame_start[0] <= 1'b0;
	 
	 case (state)
	   Idle : begin
	      if (re_frame_start) begin
		 state <= Start1;
		 channel_frame_start[0] <= 1'b1;
	      end
	   end

	   Start1 : begin
	      state <= Idle;
	   end

	   default : begin
	      state <= Idle;
	      channel_frame_start[0] <= 1'b0;
	   end
	 endcase // case (state)
      end
   end

   assign channel_frame_start[CHANNELS-1:1] = ov_done[CHANNELS-2:0];
   
   genvar 	     i;
   generate
   for (i = 0; i < CHANNELS;i++) begin
      welch_psd_channel
      #(.MAX_ADDR(12'hFFF))
      WPC1
	(
	 .clk(clk),
	 .reset(reset),

	 .data_re_in(data_re_in),
	 .data_im_in(data_im_in),
	 .data_in_valid(1'b0),
		
         .cpu_clk(cpu_clk),
	 .cpu_addr(cpu_addr),
	 .cpu_data(cpu_data),
	 .cpu_we(cpu_we),

	 .frame_start(channel_frame_start[i]),

	 .fft_size_m1(12'hFFF),
	 .overlap_samples(overlap_samples),

	 .fft_magnitude_sq(wpc_fifo[i].mag_sq),
	 .fft_magnitude_sq_valid(wpc_fifo[i].mag_sq_valid),

	 .overlap_done(ov_done[i]),
	 .fft_done(fft_done[i])
	 );

      wpc_align_fifo 
	FIFO0 
	  (
	   .clk(clk),                     // input wire clk
	   .srst(channel_frame_start[i]), // input wire srst
	   .din(wpc_fifo[i].mag_sq),                  // input wire [17 : 0] din
	   .wr_en(wpc_fifo[i].mag_sq_valid),              // input wire wr_en
	   .rd_en(wpc_fifo[i].rd_en),              // input wire rd_en
	   .dout(wpc_fifo[i].mag_sq_aligned),                // output wire [17 : 0] dout
	   .full(wpc_fifo[i].full),                // output wire full
	   .overflow(wpc_fifo[i].overflow),        // output wire overflow
	   .empty(wpc_fifo[i].empty),              // output wire empty
	   .valid(wpc_fifo[i].mag_sq_aligned_valid),              // output wire valid
	   .wr_rst_busy(),  // output wire wr_rst_busy
	   .rd_rst_busy()  // output wire rd_rst_busy
	   );

      //synthesis translate_off
      always @(posedge clk) begin
	 if (wpc_fifo[i].mag_sq_valid)
	   mylog.debug($sformatf("%m:WPC[%0d]:Mag_Sq=%0d", i, wpc_fifo[i].mag_sq));

	 if (ov_done[i] == 1'b1)
	   mylog.info($sformatf("%m:WPC[%0d]:Overlap_Done=1", i));
	 if (fft_done[i] == 1'b1)
	   mylog.info($sformatf("%m:WPC[%0d]:FFT_Done=1", i));
      end
      //synthesis translate_on
	
   end
   endgenerate

   always @(posedge clk or posedge reset) begin
      if (reset) begin
	 rd_state <= RIdle;
	 for (int i=0; i < CHANNELS;i=i+1)
	   wpc_fifo[i].rd_en <= 1'b0;
      end
      else begin
	 case (rd_state)
	   RIdle : begin
	      if (fft_done[CHANNELS-1]) begin
		 for (int i=0; i < CHANNELS;i=i+1)
		   wpc_fifo[i].rd_en <= 1'b1;
		 rd_state <= Read1;
		 $display("Reading aligned data");
	      end
	   end

	   Read1 : begin
	      if (!wpc_fifo[0].empty)
		for (int i=0; i < CHANNELS;i=i+1)
		  wpc_fifo[i].rd_en <= 1'b1;
	      else begin
		 rd_state <= RIdle;
		 for (int i=0; i < CHANNELS;i=i+1)
		   wpc_fifo[i].rd_en <= 1'b0;
	      end
	   end

	   default : begin
	      rd_state <= RIdle;
	      for (int i=0; i < CHANNELS;i=i+1)
		wpc_fifo[i].rd_en <= 1'b0;
	   end
	 endcase // case (rd_state)
      end
   end

   function automatic [2*40-1:0] sum(input [2*40-1:0] addends[CHANNELS-1:0]);
      logic[2*40-1:0] temp = 0;

      for (int i=0; i < CHANNELS;i++)
	temp = temp+addends[i];

      sum = temp;
   endfunction // sum
   
   genvar j;
   generate
      for (j=0; j < CHANNELS; j++) begin
	 assign aligned_mag_sq[j] = wpc_fifo[j].mag_sq_aligned;
      end
   endgenerate


   function automatic logic [2*40-LG_CHANNELS-TARGET_BITS-1:0] 
     round_to_bits(input logic [2*40-LG_CHANNELS-1:0] in_val);
       
      logic		     round_bit;                // The bit to determine rounding
      logic [2*40-LG_CHANNELS-TARGET_BITS-1:0] truncated;    // The truncated portion

      begin
         round_bit = in_val[TARGET_BITS-1];    // Get rounding bit
 	 truncated = in_val[2*40-LG_CHANNELS-1:TARGET_BITS];

         // Apply rounding: If round_bit is 1, add 1 to truncated
         round_to_bits = truncated + round_bit;
      end
   endfunction   

   // Generate artificial data
   always @(posedge clk or posedge reset) begin
      if (reset)
	sum_mag_counter <= 'h0;
      else begin
	 if (sum_mag_sq_full_valid)
	   sum_mag_counter <= sum_mag_counter + 1;
      end
   end
   
   
   always @(posedge clk or posedge reset) begin
      if (reset) begin
	 sum_mag_sq_int <= 0;
	 sum_mag_sq_int_valid <= 1'b0;

	 sum_mag_sq_full <= 0;
	 sum_mag_sq_full_valid <= 1'b0;
	 
	 sum_mag_sq <= 0;
	 sum_mag_sq_valid <= 1'b0;
      end
      
      else begin
	 if (wpc_fifo[0].mag_sq_aligned_valid)
	   sum_mag_sq_int <= sum(aligned_mag_sq);
	 sum_mag_sq_int_valid <= wpc_fifo[0].mag_sq_aligned_valid;

	 sum_mag_sq_full <= sum_mag_sq_int[2*40-1:LG_CHANNELS];
	 sum_mag_sq_full_valid <= sum_mag_sq_int_valid;

	 if (debug_in)
	   sum_mag_sq[$high(sum_mag_sq):$high(sum_mag_sq)-31]   <= sum_mag_counter;
	 else
	   sum_mag_sq <= round_to_bits(sum_mag_sq_full);
	 sum_mag_sq_valid <= sum_mag_sq_full_valid;
      end // else: !if(reset)
   end // always @ (posedge clk or posedge reset)

   always @(posedge clk or posedge reset) begin
      if (reset) begin
	 psd_done <= 1'b0;
	 sum_mag_sq_full_valid_pip <= 2'b00;
	 fe_sum_mag_sq_valid_full <= 1'b0;
      end
      else begin
	 sum_mag_sq_full_valid_pip <= {sum_mag_sq_full_valid_pip[0], 
				       sum_mag_sq_full_valid};
	 fe_sum_mag_sq_valid_full <= 1'b0;
	 if (sum_mag_sq_full_valid_pip == 2'b10)
	   fe_sum_mag_sq_valid_full <= 1'b1;

	 if (re_frame_start)
	   psd_done <= 1'b0;
	 else if (fe_sum_mag_sq_valid_full)
	   psd_done <= 1'b1;
      end // else: !if(reset)
   end

   //
   // Debug
   //

   always @(posedge clk or posedge reset) begin
      if (reset) begin
	 sample_counter_en <= 1'b0;
	 sample_counter <= 15'h0;
	 fft_done_hold <= 'h0;
	 rd_state_read_hold <= 1'b0;
	 fe_sum_mag_sq_valid_full_hold <= 1'b0;
      end
      else begin
	 if (re_frame_start)
	   sample_counter_en <= 1'b1;
	 else if (ov_done[CHANNELS-1])
	   sample_counter_en <= 1'b0;

	 if (sample_counter_en)
	   sample_counter <= sample_counter + 1;

	 for (int i=0; i < CHANNELS;i++) begin
	    if (re_frame_start)
	      fft_done_hold[i] <= 1'b0;
	    else if (fft_done[i] == 1'b1)
	      fft_done_hold[i] <= 1'b1;
	 end

	 if (re_frame_start)
	   rd_state_read_hold <= 1'b0;
	 else if (rd_state == Read1)
	   rd_state_read_hold <= 1'b1;

	 if (re_frame_start)
	   fe_sum_mag_sq_valid_full_hold <= 1'b0;
	 else if (fe_sum_mag_sq_valid_full)
	   fe_sum_mag_sq_valid_full_hold <= 1'b1;
	 
      end // else: !if(reset)
   end
   
   
   assign debug_out[31] = frame_start;

   assign debug_out[23] = psd_done;
   assign debug_out[22] = fe_sum_mag_sq_valid_full_hold;
   assign debug_out[21] = rd_state_read_hold;
   assign debug_out[20] = (rd_state == RIdle);
   assign debug_out[19:16] = fft_done_hold;
   assign debug_out[14:0] = sample_counter;
   
   
   //synthesis translate_off
   always @(posedge clk) begin
      if (wpc_fifo[0].mag_sq_aligned_valid)
	 for (int i=0; i < CHANNELS; i++)
	   mylog.debug($sformatf("%m:Mag_Sq_Aligned[%0d]=%0d", 
				 i, wpc_fifo[i].mag_sq_aligned));
      
      if (sum_mag_sq_int_valid)
	mylog.debug($sformatf("%m:Sum_Mag_Sq=%0d", sum_mag_sq_int));

      if (sum_mag_sq_full_valid)
	mylog.debug($sformatf("%m:Sum_Mag_Sq_Full=%0d", sum_mag_sq_full));
      
      if (sum_mag_sq_valid)
	mylog.debug($sformatf("%m:PSD=%0d", sum_mag_sq));
   end
   //synthesis translate_on

   
endmodule // welch_psd
