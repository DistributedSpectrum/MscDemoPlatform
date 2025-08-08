`timescale 1ns/100ps

module welch_preprocess_tb();

   logic clk=1'b0;
   logic resetn=1'b0;
   logic cpu_clk=1'b0;

   
   logic [63:0]	s_axis_tdata;
   logic [7:0]	s_axis_tkeep='h0;
   logic	s_axis_tlast=1'b0;
   logic	s_axis_tuser=1'b0;
   logic	s_axis_tvalid=1'b0;
   
   
   always
     #4 clk = !clk;

   always
     #5 cpu_clk = !cpu_clk;

   initial begin
      resetn = 1'b0;
      #20 resetn = 1'b1;

      #40
	WP0.frame_start = 1'b1;	
      
      #60 s_axis_tdata <= 'h0;

      
      
      @(posedge clk) s_axis_tdata = 64'hFFFFFFFFFFFF1122;
      s_axis_tvalid <= 1'b1;
      s_axis_tkeep <= 8'hFF;
      
      @(posedge clk) s_axis_tdata = 64'h5566778800081122;

      @(posedge clk) s_axis_tdata = 64'h33445566778899AA;
      @(posedge clk) s_axis_tdata = 64'hBBCCDDEEFF112233;
      
      for (int i = 0; i < 4;i++)
	@(posedge clk) s_axis_tdata = 64'hCAFECAFECAFECAFE;
      
      @(posedge clk) s_axis_tdata = 64'hDEADDEADDEADDEAD;
      s_axis_tlast <= 1'b1;

      @(posedge clk) s_axis_tlast = 1'b0;
      s_axis_tvalid = 1'b0;
      s_axis_tdata = 'h0;
   end
   
   welch_preprocess
     WP0
       (
	.clk(clk),
	.resetn(resetn),
	
	.s_axis_tdata(s_axis_tdata), // 64 bit
	.s_axis_tkeep(s_axis_tkeep), // 8 bit
	.s_axis_tlast(s_axis_tlast),
	.s_axis_tuser(s_axis_tuser),
	.s_axis_tvalid(s_axis_tvalid),

	.cpu_clk(cpu_clk),
	.cpu_awaddr(32'h0),
	.cpu_awvalid(1'b0),
	.cpu_awready(),
	.cpu_wdata(1'b0),
	.cpu_wvalid(1'b0),
	.cpu_wready(),
	.cpu_bresp(),
	.cpu_bvalid(),
	.cpu_bready(1'b0),
	.cpu_araddr(32'h0),
	.cpu_arvalid(1'b0),
	.cpu_arready(),
	.cpu_rdata(),
	.cpu_rresp(),
	.cpu_rvalid(),
	.cpu_rready(1'b0),

	.m_axis_tdata(), //64 bit
	.m_axis_tkeep(), // 8 bit
	.m_axis_tlast(),
	.m_axis_tready(1'b1),
	.m_axis_tuser(),
	.m_axis_tvalid());


   
endmodule // welch_preprocess_tb
