// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Mon Aug  4 16:16:28 2025
// Host        : maxwell running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/elya/DS/MscDemoPlatform/2024.2/pl_eth_10g/Hardware/ip_repo/welch/ip/fft_block/fft_block_stub.v
// Design      : fft_block
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu9eg-ffvb1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "fft_block,xfft_v9_1_13,{}" *) (* core_generation_info = "fft_block,xfft_v9_1_13,{x_ipProduct=Vivado 2024.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xfft,x_ipVersion=9.1,x_ipCoreRevision=13,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_XDEVICEFAMILY=zynquplus,C_PART=xczu9eg-ffvb1156-2-e,C_S_AXIS_CONFIG_TDATA_WIDTH=16,C_S_AXIS_DATA_TDATA_WIDTH=64,C_M_AXIS_DATA_TDATA_WIDTH=96,C_M_AXIS_DATA_TUSER_WIDTH=1,C_M_AXIS_STATUS_TDATA_WIDTH=1,C_THROTTLE_SCHEME=1,C_NSSR=1,C_CHANNELS=1,C_NFFT_MAX=12,C_ARCH=1,C_HAS_NFFT=1,C_USE_FLT_PT=0,C_INPUT_WIDTH=28,C_TWIDDLE_WIDTH=16,C_OUTPUT_WIDTH=41,C_HAS_SCALING=0,C_HAS_BFP=0,C_HAS_ROUNDING=1,C_HAS_ACLKEN=0,C_HAS_ARESETN=0,C_HAS_OVFLO=0,C_HAS_NATURAL_INPUT=1,C_HAS_NATURAL_OUTPUT=1,C_HAS_CYCLIC_PREFIX=0,C_HAS_XK_INDEX=0,C_DATA_MEM_TYPE=1,C_TWIDDLE_MEM_TYPE=1,C_BRAM_STAGES=0,C_REORDER_MEM_TYPE=1,C_USE_HYBRID_RAM=0,C_OPTIMIZE_GOAL=0,C_CMPY_TYPE=1,C_BFLY_TYPE=0,C_SYSTOLICFFT_INV=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "xfft_v9_1_13,Vivado 2024.2" *) 
module fft_block(aclk, s_axis_config_tdata, 
  s_axis_config_tvalid, s_axis_config_tready, s_axis_data_tdata, s_axis_data_tvalid, 
  s_axis_data_tready, s_axis_data_tlast, m_axis_data_tdata, m_axis_data_tvalid, 
  m_axis_data_tready, m_axis_data_tlast, event_frame_started, event_tlast_unexpected, 
  event_tlast_missing, event_status_channel_halt, event_data_in_channel_halt, 
  event_data_out_channel_halt)
/* synthesis syn_black_box black_box_pad_pin="s_axis_config_tdata[15:0],s_axis_config_tvalid,s_axis_config_tready,s_axis_data_tdata[63:0],s_axis_data_tvalid,s_axis_data_tready,s_axis_data_tlast,m_axis_data_tdata[95:0],m_axis_data_tvalid,m_axis_data_tready,m_axis_data_tlast,event_frame_started,event_tlast_unexpected,event_tlast_missing,event_status_channel_halt,event_data_in_channel_halt,event_data_out_channel_halt" */
/* synthesis syn_force_seq_prim="aclk" */;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 aclk_intf CLK" *) (* x_interface_mode = "slave aclk_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME aclk_intf, ASSOCIATED_BUSIF S_AXIS_CONFIG:M_AXIS_DATA:M_AXIS_STATUS:S_AXIS_DATA, ASSOCIATED_RESET aresetn, ASSOCIATED_CLKEN aclken, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input aclk /* synthesis syn_isclock = 1 */;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_CONFIG TDATA" *) (* x_interface_mode = "slave S_AXIS_CONFIG" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXIS_CONFIG, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) input [15:0]s_axis_config_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_CONFIG TVALID" *) input s_axis_config_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_CONFIG TREADY" *) output s_axis_config_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_DATA TDATA" *) (* x_interface_mode = "slave S_AXIS_DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXIS_DATA, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) input [63:0]s_axis_data_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_DATA TVALID" *) input s_axis_data_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_DATA TREADY" *) output s_axis_data_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_DATA TLAST" *) input s_axis_data_tlast;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_DATA TDATA" *) (* x_interface_mode = "master M_AXIS_DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME M_AXIS_DATA, TDATA_NUM_BYTES 12, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) output [95:0]m_axis_data_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_DATA TVALID" *) output m_axis_data_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_DATA TREADY" *) input m_axis_data_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_DATA TLAST" *) output m_axis_data_tlast;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 event_frame_started_intf INTERRUPT" *) (* x_interface_mode = "master event_frame_started_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME event_frame_started_intf, SENSITIVITY EDGE_RISING, PortWidth 1" *) output event_frame_started;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 event_tlast_unexpected_intf INTERRUPT" *) (* x_interface_mode = "master event_tlast_unexpected_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME event_tlast_unexpected_intf, SENSITIVITY EDGE_RISING, PortWidth 1" *) output event_tlast_unexpected;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 event_tlast_missing_intf INTERRUPT" *) (* x_interface_mode = "master event_tlast_missing_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME event_tlast_missing_intf, SENSITIVITY EDGE_RISING, PortWidth 1" *) output event_tlast_missing;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 event_status_channel_halt_intf INTERRUPT" *) (* x_interface_mode = "master event_status_channel_halt_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME event_status_channel_halt_intf, SENSITIVITY EDGE_RISING, PortWidth 1" *) output event_status_channel_halt;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 event_data_in_channel_halt_intf INTERRUPT" *) (* x_interface_mode = "master event_data_in_channel_halt_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME event_data_in_channel_halt_intf, SENSITIVITY EDGE_RISING, PortWidth 1" *) output event_data_in_channel_halt;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 event_data_out_channel_halt_intf INTERRUPT" *) (* x_interface_mode = "master event_data_out_channel_halt_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME event_data_out_channel_halt_intf, SENSITIVITY EDGE_RISING, PortWidth 1" *) output event_data_out_channel_halt;
endmodule
