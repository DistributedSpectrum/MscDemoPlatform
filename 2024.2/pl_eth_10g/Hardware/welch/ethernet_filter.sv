module ethernet_filter
  (
   input wire	     clk,
   input wire	     resetn,
   input wire [63:0] s_axis_tdata,
   input wire [7:0]  s_axis_tkeep,
   input wire	     s_axis_tlast,
   output wire	     s_axis_tready,
   input wire	     s_axis_tuser,
   input wire	     s_axis_tvalid,

   output reg	     frame_start,
   output reg	     frame_end,
   output reg [63:0] data_out,
   output reg	     data_out_valid
   
   );

   localparam TYPE_INDEX = 4;
   localparam IQ_TYPE = 16'h0008;


   logic [63:0]	buffer_line;
   
   enum {Idle, Type1, Data1, Last1} state;

   logic [15:0]	foo;
   
   
   assign s_axis_tready = 1'b1;

   assign foo = s_axis_tdata[TYPE_INDEX*8-1 -: 16];
   
   
   always @(posedge clk or negedge resetn) begin
      if (~resetn) begin
	 state <= Idle;
	 buffer_line <= 'h0;
	 data_out <= 'h0;
	 data_out_valid <= 1'b0;
	 frame_start <= 1'b0;
	 frame_end <= 1'b0;
      end
      else begin
	 data_out_valid <= 1'b0;
	 frame_start <= 1'b0;
	 frame_end <= 1'b0;
	 
	 case (state)
	   Idle : begin
	      buffer_line <= 'h0;
	      data_out <= 'h0;
	      
	      if (s_axis_tvalid == 1'b1)
		state <= Type1;
	   end

	   Type1 : begin
	      if (s_axis_tdata[TYPE_INDEX*8-1 -: 16] == IQ_TYPE) begin
		 state <= Data1;
		 buffer_line[(TYPE_INDEX-2)*8-1 : 0] <= s_axis_tdata[(TYPE_INDEX-2)*8-1 : 0];
		 frame_start <= 1'b1;
	      end
	      else
		state <= Idle;
	   end

	   Data1 : begin
	      buffer_line[(TYPE_INDEX-2)*8-1 : 0] <= s_axis_tdata[(TYPE_INDEX-2)*8-1 : 0];
	      
	      data_out <= {buffer_line[(TYPE_INDEX-2)*8-1:0],
			   s_axis_tdata[64-1 -: (TYPE_INDEX+2)*8]};
	      
	      data_out_valid <= 1'b1;

	      if (s_axis_tlast == 1'b1 && s_axis_tvalid == 1'b1) begin
		 state <= Last1;
	      end
	   end
	   
	   Last1 : begin
	      data_out <= 'h0;
	      data_out[64-1: (TYPE_INDEX-1)*8] <= buffer_line[(TYPE_INDEX-3)*8-1 : 0];
	      //data_out_valid <= 1'b1;
	      
	      state <= Idle;
	      frame_end <= 1'b1;  // Should this be pulled back by 1 cycle?
	   end

	   default : begin
	      state <= Idle;
	      buffer_line <= 'h0;
	      data_out <= 'h0;
	      data_out_valid <= 1'b0;
	      frame_start <= 1'b0;
	      frame_end <= 1'b0;
	   end
	 endcase // case (state)
      end
   end
   
   
endmodule // ethernet_filter
