module fft_block 
  (
   input wire	      aclk,			    // input wire aclk
   input wire [15:0]  s_axis_config_tdata,	    // input wire [15 : 0] s_axis_config_tdata
   input wire	      s_axis_config_tvalid,	    // input wire s_axis_config_tvalid
   output wire	      s_axis_config_tready,	    // output wire s_axis_config_tready
   input wire [63:0]  s_axis_data_tdata,	    // input wire [63 : 0] s_axis_data_tdata
   input wire	      s_axis_data_tvalid,	    // input wire s_axis_data_tvalid
   input wire	      s_axis_data_tready,	    // output wire s_axis_data_tready
   input wire	      s_axis_data_tlast,	    // input wire s_axis_data_tlast
       
   output wire [95:0] m_axis_data_tdata,	    // output wire [95 : 0] m_axis_data_tdata
   output wire	      m_axis_data_tvalid,	    // output wire m_axis_data_tvalid
   input wire	      m_axis_data_tready,	    // input wire m_axis_data_tready
   output wire	      m_axis_data_tlast,	    // output wire m_axis_data_tlast
   output wire	      event_frame_started,	    // output wire event_frame_started
   output wire	      event_tlast_unexpected,	    // output wire event_tlast_unexpected
   output wire	      event_tlast_missing,	    // output wire event_tlast_missing
   output wire	      event_status_channel_halt,    // output wire event_status_channel_halt
   output wire	      event_data_in_channel_halt,   // output wire event_data_in_channel_halt
   output wire	      event_data_out_channel_halt);
endmodule // fft_block

     
