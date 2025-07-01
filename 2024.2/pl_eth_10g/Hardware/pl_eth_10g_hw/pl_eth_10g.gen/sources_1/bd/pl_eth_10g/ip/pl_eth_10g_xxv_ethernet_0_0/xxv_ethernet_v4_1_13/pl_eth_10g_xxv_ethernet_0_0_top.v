// ------------------------------------------------------------------------------
//   (c) Copyright 2020-2021 Advanced Micro Devices, Inc. All rights reserved.
// 
//   This file contains confidential and proprietary information
//   of Advanced Micro Devices, Inc. and is protected under U.S. and
//   international copyright and other intellectual property
//   laws.
// 
//   DISCLAIMER
//   This disclaimer is not a license and does not grant any
//   rights to the materials distributed herewith. Except as
//   otherwise provided in a valid license issued to you by
//   AMD, and to the maximum extent permitted by applicable
//   law: (1) THESE MATERIALS ARE MADE AVAILABLE \"AS IS\" AND
//   WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
//   AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//   BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//   INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//   (2) AMD shall not be liable (whether in contract or tort,
//   including negligence, or under any other theory of
//   liability) for any loss or damage of any kind or nature
//   related to, arising under or in connection with these
//   materials, including for any direct, or any indirect,
//   special, incidental, or consequential loss or damage
//   (including loss of data, profits, goodwill, or any type of
//   loss or damage suffered as a result of any action brought
//   by a third party) even if such damage or loss was
//   reasonably foreseeable or AMD had been advised of the
//   possibility of the same.
// 
//   CRITICAL APPLICATIONS
//   AMD products are not designed or intended to be fail-
//   safe, or for use in any application requiring fail-safe
//   performance, such as life-support or safety devices or
//   systems, Class III medical devices, nuclear facilities,
//   applications related to the deployment of airbags, or any
//   other applications that could lead to death, personal
//   injury, or severe property or environmental damage
//   (individually and collectively, \"Critical
//   Applications\"). Customer assumes the sole risk and
//   liability of any use of AMD products in Critical
//   Applications, subject only to applicable laws and
//   regulations governing limitations on product liability.
// 
//   THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//   PART OF THIS FILE AT ALL TIMES.
//
// 
//
//       Owner:          
//       Revision:       $Id: $
//                       $Author: $
//                       $DateTime: $
//                       $Change: $
//       Description:
//
// 
////------------------------------------------------------------------------------


`timescale 1fs/1fs

(* DowngradeIPIdentifiedWarnings="yes" *)
module pl_eth_10g_xxv_ethernet_0_0_top #(
  parameter RX_STAT_STATUS_DBNC_CNT = 13'h1387,
  parameter SERDES_WIDTH = 64
)(
  //// #-------------------
  //// # Clocks and Resets
  //// #-------------------
  input  wire tx_clk,
  input  wire rx_clk,
  input  wire tx_reset,
  input  wire rx_reset,
  input  wire rx_serdes_clk,
  input  wire rx_serdes_reset,
  input  gtwiz_reset_tx_done,
  input  gtwiz_reset_rx_done,


  //// #-----------------------
  //// # AXI Control Interface
  //// #-----------------------
  input  wire s_axi_aclk,
  input  wire s_axi_aresetn,
  input  wire [31:0] s_axi_awaddr,
  input  wire s_axi_awvalid,
  output wire s_axi_awready,
  input  wire [31:0] s_axi_wdata,
  input  wire [3:0] s_axi_wstrb,
  input  wire s_axi_wvalid,
  output wire s_axi_wready,
  output wire [1:0] s_axi_bresp,
  output wire s_axi_bvalid,
  input  wire s_axi_bready,
  input  wire [31:0] s_axi_araddr,
  input  wire s_axi_arvalid,
  output wire s_axi_arready,
  output wire [31:0] s_axi_rdata,
  output wire [1:0] s_axi_rresp,
  output wire s_axi_rvalid,
  input  wire s_axi_rready,
  input  wire pm_tick,

  //// #-----------------------
  //// # Control Interface
  //// #-----------------------
  input  wire ctl_tx_send_lfi,
  input  wire ctl_tx_send_rfi,
  input  wire ctl_tx_send_idle,

  output  wire ctl_rx_wdt_disable,
  output  wire ctl_gt_tx_reset,
  output  wire ctl_gt_rx_reset,
  output  wire ctl_gt_reset_all,
  output  wire ctl_local_loopback,
  output  wire [31:0] user_reg0,

  //// #---------------------
  //// # Stats Interface
  //// #---------------------
  output  wire stat_rx_status,
  output wire stat_rx_block_lock,
  output wire stat_rx_framing_err_valid,
  output wire stat_rx_framing_err,
  output wire stat_rx_hi_ber,
  output wire stat_rx_valid_ctrl_code,
  output wire stat_rx_bad_code,
  output wire [1:0] stat_rx_total_packets,
  output wire stat_rx_total_good_packets,
  output wire [3:0] stat_rx_total_bytes,
  output wire [13:0] stat_rx_total_good_bytes,
  output wire stat_rx_packet_small,
  output wire stat_rx_jabber,
  output wire stat_rx_packet_large,
  output wire stat_rx_oversize,
  output wire stat_rx_undersize,
  output wire stat_rx_toolong,
  output wire stat_rx_fragment,
  output wire stat_rx_packet_64_bytes,
  output wire stat_rx_packet_65_127_bytes,
  output wire stat_rx_packet_128_255_bytes,
  output wire stat_rx_packet_256_511_bytes,
  output wire stat_rx_packet_512_1023_bytes,
  output wire stat_rx_packet_1024_1518_bytes,
  output wire stat_rx_packet_1519_1522_bytes,
  output wire stat_rx_packet_1523_1548_bytes,
  output wire [1:0] stat_rx_bad_fcs,
  output wire stat_rx_packet_bad_fcs,
  output wire [1:0] stat_rx_stomped_fcs,
  output wire stat_rx_packet_1549_2047_bytes,
  output wire stat_rx_packet_2048_4095_bytes,
  output wire stat_rx_packet_4096_8191_bytes,
  output wire stat_rx_packet_8192_9215_bytes,
  output wire stat_rx_unicast,
  output wire stat_rx_multicast,
  output wire stat_rx_broadcast,
  output wire stat_rx_vlan,
  output wire stat_rx_inrangeerr,
  output wire stat_rx_bad_preamble,
  output wire stat_rx_bad_sfd,
  output wire stat_rx_got_signal_os,
  output wire stat_rx_test_pattern_mismatch,
  output wire stat_rx_truncated,
  output wire stat_rx_local_fault,
  output wire stat_rx_remote_fault,
  output wire stat_rx_internal_local_fault,
  output wire stat_rx_received_local_fault,
  output wire stat_tx_total_packets,
  output wire [3:0] stat_tx_total_bytes,
  output wire stat_tx_total_good_packets,
  output wire [13:0] stat_tx_total_good_bytes,
  output wire stat_tx_packet_64_bytes,
  output wire stat_tx_packet_65_127_bytes,
  output wire stat_tx_packet_128_255_bytes,
  output wire stat_tx_packet_256_511_bytes,
  output wire stat_tx_packet_512_1023_bytes,
  output wire stat_tx_packet_1024_1518_bytes,
  output wire stat_tx_packet_1519_1522_bytes,
  output wire stat_tx_packet_1523_1548_bytes,
  output wire stat_tx_packet_small,
  output wire stat_tx_packet_large,
  output wire stat_tx_packet_1549_2047_bytes,
  output wire stat_tx_packet_2048_4095_bytes,
  output wire stat_tx_packet_4096_8191_bytes,
  output wire stat_tx_packet_8192_9215_bytes,
  output wire stat_tx_unicast,
  output wire stat_tx_multicast,
  output wire stat_tx_broadcast,
  output wire stat_tx_vlan,
  output wire stat_tx_bad_fcs,
  output wire stat_tx_frame_error,
  output wire stat_tx_local_fault,



  //// #-------------------
  //// # User Interface
  //// #-------------------
  output wire rx_axis_tvalid,
  output wire [63:0] rx_axis_tdata,
  output wire rx_axis_tlast,
  output wire [7:0] rx_axis_tkeep,
  output wire rx_axis_tuser,
  output wire [55:0] rx_preambleout,
  output wire tx_axis_tready,
  input  wire tx_axis_tvalid,
  input  wire [63:0] tx_axis_tdata,
  input  wire tx_axis_tlast,
  input  wire [7:0] tx_axis_tkeep,
  input  wire tx_axis_tuser,
  output wire tx_unfout,
  input  wire [55:0] tx_preamblein,


  //// #---------------------
  //// # Tx Serdes Interface
  //// #---------------------
  output wire [64-1:0] tx_serdes_data0,
  output wire [1:0] tx_serdes_header0,

  //// #---------------------
  //// # Rx Serdes Interface
  //// #---------------------
  input  wire [64-1:0] rx_serdes_data0,
  input  wire [1:0] rx_serdes_header0,
  input  wire rx_serdes_headervalid0,
  input  wire rx_serdes_datavalid0,
  output wire rx_serdes_bitslip0
);


  //// #----------------------
  //// # Control Interface
  //// #----------------------
  wire ctl_rx_test_pattern;
  wire ctl_rx_test_pattern_enable;
  wire ctl_rx_data_pattern_select;
  wire ctl_rx_enable;
  wire ctl_rx_delete_fcs;
  wire ctl_rx_ignore_fcs;
  wire [14:0] ctl_rx_max_packet_len;
  wire [7:0] ctl_rx_min_packet_len;
  wire ctl_rx_custom_preamble_enable;
  wire ctl_rx_check_sfd;
  wire ctl_rx_check_preamble;
  wire ctl_rx_process_lfi;
  wire ctl_rx_force_resync;
  wire ctl_tx_test_pattern;
  wire ctl_tx_test_pattern_enable;
  wire ctl_tx_test_pattern_select;
  wire ctl_tx_data_pattern_select;
  wire [57:0] ctl_tx_test_pattern_seed_a;
  wire [57:0] ctl_tx_test_pattern_seed_b;
  wire ctl_tx_enable;
  wire ctl_tx_fcs_ins_enable;
  wire [3:0] ctl_tx_ipg_value;
  wire ctl_tx_custom_preamble_enable;
  wire ctl_tx_ignore_fcs;


  wire rx_reset_axi;
  wire tx_reset_axi;
  wire rx_serdes_reset_axi;
  wire tx_serdes_reset_axi;

  wire [1:0]  tx_ptp_1588op_in = 2'b0;
  wire [15:0] tx_ptp_tag_field_in = 16'b0;
  wire tx_ptp_tstamp_valid_out;
  wire [15:0] tx_ptp_tstamp_tag_out;
  wire [79:0] tx_ptp_tstamp_out;
  wire [79:0] rx_ptp_tstamp_out;
  wire rx_ptp_tstamp_valid_out;
  wire [79:0] ctl_rx_systemtimerin = 80'b0;
  wire [79:0] ctl_tx_systemtimerin = 80'b0;
  wire stat_tx_ptp_fifo_read_error;
  wire stat_tx_ptp_fifo_write_error;
  wire [63:0] tx_period_ns;
  wire [63:0] rx_period_ns;
  wire [1-1:0] lane_clk;
  wire [1-1:0] lane_reset;

  assign lane_reset = rx_serdes_reset;
  assign lane_clk   = rx_serdes_clk;

  wire [63:0] hsec_tx_serdes_data0;
  wire [1:0] hsec_tx_serdes_header0;
  wire [63:0] hsec_rx_serdes_data0;
  wire [1:0] hsec_rx_serdes_header0;
  wire hsec_rx_serdes_headervalid0;
  wire hsec_rx_serdes_datavalid0;
  wire hsec_rx_serdes_bitslip0;

  wire ctl_tx_send_lfi_axi;
  wire ctl_tx_send_rfi_axi;
  wire ctl_tx_send_idle_axi;

  wire internal_ctl_tx_send_lfi;
  wire internal_ctl_tx_send_rfi;
  wire internal_ctl_tx_send_idle;

  assign internal_ctl_tx_send_lfi = ctl_tx_send_lfi | ctl_tx_send_lfi_axi;
  assign internal_ctl_tx_send_rfi = ctl_tx_send_rfi | ctl_tx_send_rfi_axi;
  assign internal_ctl_tx_send_idle = ctl_tx_send_idle | ctl_tx_send_idle_axi;

  wire stat_core_speed;

  
  wire axi_ctl_core_mode_switch; 
  assign stat_core_speed = 1'b1;
  wire [7:0] rx_parityout;
  wire  stat_tx_bad_parity;

  //// #---------------------------------------------------------
  //// #                      Core
  //// #---------------------------------------------------------
  xxv_ethernet_v4_1_13_mac_baser_axis_nopause_hsec_cores #(
    .SERDES_WIDTH (SERDES_WIDTH)
  ) i_pl_eth_10g_xxv_ethernet_0_0_CORE (
    //// #----------------------
    //// # Tx Clocks and Resets
    //// #----------------------
    .tx_clk (tx_clk),
    .tx_reset (tx_reset | tx_reset_axi),
    //// #----------------------
    //// # Rx Clocks and Resets
    //// #----------------------
    .rx_serdes_clk (lane_clk),
    .rx_serdes_reset (lane_reset | rx_serdes_reset_axi),
    .rx_clk (rx_clk),
    .rx_reset (rx_reset | rx_reset_axi),

    //// #----------------------
    //// # Control Interface
    //// #----------------------
    .ctl_tx_send_lfi (internal_ctl_tx_send_lfi),
    .ctl_tx_send_rfi (internal_ctl_tx_send_rfi),
    .ctl_tx_send_idle (internal_ctl_tx_send_idle),
    .ctl_tx_test_pattern (ctl_tx_test_pattern),
    .ctl_tx_test_pattern_enable (ctl_tx_test_pattern_enable),
    .ctl_tx_test_pattern_select (ctl_tx_test_pattern_select),
    .ctl_tx_data_pattern_select (ctl_tx_data_pattern_select),
    .ctl_tx_test_pattern_seed_a (ctl_tx_test_pattern_seed_a),
    .ctl_tx_test_pattern_seed_b (ctl_tx_test_pattern_seed_b),
    .ctl_tx_enable (ctl_tx_enable),
    .ctl_tx_fcs_ins_enable (ctl_tx_fcs_ins_enable),
    .ctl_tx_ipg_value (ctl_tx_ipg_value),
    .ctl_tx_custom_preamble_enable (ctl_tx_custom_preamble_enable),
    .ctl_tx_ignore_fcs (ctl_tx_ignore_fcs),

    .ctl_data_rate (1'b1),
    .ctl_rx_test_pattern (ctl_rx_test_pattern),
    .ctl_rx_test_pattern_enable (ctl_rx_test_pattern_enable),
    .ctl_rx_data_pattern_select (ctl_rx_data_pattern_select),
    .ctl_rx_enable (ctl_rx_enable),
    .ctl_rx_delete_fcs (ctl_rx_delete_fcs),
    .ctl_rx_ignore_fcs (ctl_rx_ignore_fcs),
    .ctl_rx_max_packet_len (ctl_rx_max_packet_len),
    .ctl_rx_min_packet_len (ctl_rx_min_packet_len),
    .ctl_rx_custom_preamble_enable (ctl_rx_custom_preamble_enable),
    .ctl_rx_check_sfd (ctl_rx_check_sfd),
    .ctl_rx_check_preamble (ctl_rx_check_preamble),
    .ctl_rx_process_lfi (ctl_rx_process_lfi),
    .ctl_rx_force_resync (ctl_rx_force_resync),
    .ctl_rx_systemtimerin (ctl_rx_systemtimerin),
    .ctl_tx_systemtimerin (ctl_tx_systemtimerin),
    .ctl_ptp_transpclk_mode (ctl_ptp_transpclk_mode),


    //// #----------------------
    //// # Rx User Interface
    //// #----------------------
    .rx_axis_tvalid (rx_axis_tvalid),
    .rx_axis_tdata (rx_axis_tdata),
    .rx_axis_tlast (rx_axis_tlast),
    .rx_axis_tkeep (rx_axis_tkeep),
    .rx_axis_tuser (rx_axis_tuser),
    .rx_preambleout (rx_preambleout),

    .tx_ptp_1588op_in (tx_ptp_1588op_in),
    .tx_ptp_tag_field_in (tx_ptp_tag_field_in),
    .tx_ptp_tstamp_valid_out (tx_ptp_tstamp_valid_out),
    .tx_ptp_tstamp_tag_out (tx_ptp_tstamp_tag_out),
    .tx_ptp_tstamp_out (tx_ptp_tstamp_out),
    .rx_ptp_tstamp_valid_out (rx_ptp_tstamp_valid_out),
    .rx_ptp_tstamp_out (rx_ptp_tstamp_out),

    //// #----------------------
    //// # Tx User Interface
    //// #----------------------
    .tx_axis_tready (tx_axis_tready),
    .tx_axis_tvalid (tx_axis_tvalid),
    .tx_axis_tdata (tx_axis_tdata),
    .tx_axis_tlast (tx_axis_tlast),
    .tx_axis_tkeep (tx_axis_tkeep),
    .tx_axis_tuser (tx_axis_tuser),
    .tx_unfout (tx_unfout),
    .tx_preamblein (tx_preamblein),
    //// #--------------------
    //// # Stats Interface
    //// #--------------------
    .stat_tx_total_packets (stat_tx_total_packets),
    .stat_tx_total_bytes (stat_tx_total_bytes),
    .stat_tx_total_good_packets (stat_tx_total_good_packets),
    .stat_tx_total_good_bytes (stat_tx_total_good_bytes),
    .stat_tx_packet_64_bytes (stat_tx_packet_64_bytes),
    .stat_tx_packet_65_127_bytes (stat_tx_packet_65_127_bytes),
    .stat_tx_packet_128_255_bytes (stat_tx_packet_128_255_bytes),
    .stat_tx_packet_256_511_bytes (stat_tx_packet_256_511_bytes),
    .stat_tx_packet_512_1023_bytes (stat_tx_packet_512_1023_bytes),
    .stat_tx_packet_1024_1518_bytes (stat_tx_packet_1024_1518_bytes),
    .stat_tx_packet_1519_1522_bytes (stat_tx_packet_1519_1522_bytes),
    .stat_tx_packet_1523_1548_bytes (stat_tx_packet_1523_1548_bytes),
    .stat_tx_packet_small (stat_tx_packet_small),
    .stat_tx_packet_large (stat_tx_packet_large),
    .stat_tx_packet_1549_2047_bytes (stat_tx_packet_1549_2047_bytes),
    .stat_tx_packet_2048_4095_bytes (stat_tx_packet_2048_4095_bytes),
    .stat_tx_packet_4096_8191_bytes (stat_tx_packet_4096_8191_bytes),
    .stat_tx_packet_8192_9215_bytes (stat_tx_packet_8192_9215_bytes),
    .stat_tx_unicast (stat_tx_unicast),
    .stat_tx_multicast (stat_tx_multicast),
    .stat_tx_broadcast (stat_tx_broadcast),
    .stat_tx_vlan (stat_tx_vlan),
    .stat_tx_bad_fcs (stat_tx_bad_fcs),
    .stat_tx_frame_error (stat_tx_frame_error),
    .stat_tx_local_fault (stat_tx_local_fault),
    .stat_rx_block_lock (stat_rx_block_lock),
    .stat_rx_framing_err_valid (stat_rx_framing_err_valid),
    .stat_rx_framing_err (stat_rx_framing_err),
    .stat_rx_hi_ber (stat_rx_hi_ber),
    .stat_rx_valid_ctrl_code (stat_rx_valid_ctrl_code),
    .stat_rx_bad_code (stat_rx_bad_code),
    .stat_rx_total_packets (stat_rx_total_packets),
    .stat_rx_total_good_packets (stat_rx_total_good_packets),
    .stat_rx_total_bytes (stat_rx_total_bytes),
    .stat_rx_total_good_bytes (stat_rx_total_good_bytes),
    .stat_rx_packet_small (stat_rx_packet_small),
    .stat_rx_jabber (stat_rx_jabber),
    .stat_rx_packet_large (stat_rx_packet_large),
    .stat_rx_oversize (stat_rx_oversize),
    .stat_rx_undersize (stat_rx_undersize),
    .stat_rx_toolong (stat_rx_toolong),
    .stat_rx_fragment (stat_rx_fragment),
    .stat_rx_packet_64_bytes (stat_rx_packet_64_bytes),
    .stat_rx_packet_65_127_bytes (stat_rx_packet_65_127_bytes),
    .stat_rx_packet_128_255_bytes (stat_rx_packet_128_255_bytes),
    .stat_rx_packet_256_511_bytes (stat_rx_packet_256_511_bytes),
    .stat_rx_packet_512_1023_bytes (stat_rx_packet_512_1023_bytes),
    .stat_rx_packet_1024_1518_bytes (stat_rx_packet_1024_1518_bytes),
    .stat_rx_packet_1519_1522_bytes (stat_rx_packet_1519_1522_bytes),
    .stat_rx_packet_1523_1548_bytes (stat_rx_packet_1523_1548_bytes),
    .stat_rx_bad_fcs (stat_rx_bad_fcs),
    .stat_rx_packet_bad_fcs (stat_rx_packet_bad_fcs),
    .stat_rx_stomped_fcs (stat_rx_stomped_fcs),
    .stat_rx_packet_1549_2047_bytes (stat_rx_packet_1549_2047_bytes),
    .stat_rx_packet_2048_4095_bytes (stat_rx_packet_2048_4095_bytes),
    .stat_rx_packet_4096_8191_bytes (stat_rx_packet_4096_8191_bytes),
    .stat_rx_packet_8192_9215_bytes (stat_rx_packet_8192_9215_bytes),
    .stat_rx_unicast (stat_rx_unicast),
    .stat_rx_multicast (stat_rx_multicast),
    .stat_rx_broadcast (stat_rx_broadcast),
    .stat_rx_vlan (stat_rx_vlan),
    .stat_rx_inrangeerr (stat_rx_inrangeerr),
    .stat_rx_bad_preamble (stat_rx_bad_preamble),
    .stat_rx_bad_sfd (stat_rx_bad_sfd),
    .stat_rx_got_signal_os (stat_rx_got_signal_os),
    .stat_rx_test_pattern_mismatch (stat_rx_test_pattern_mismatch),
    .stat_rx_truncated (stat_rx_truncated),
    .stat_rx_local_fault (stat_rx_local_fault),
    .stat_rx_remote_fault (stat_rx_remote_fault),
    .stat_rx_internal_local_fault (stat_rx_internal_local_fault),
    .stat_rx_received_local_fault (stat_rx_received_local_fault),
    .stat_tx_ptp_fifo_read_error (stat_tx_ptp_fifo_read_error),
    .stat_tx_ptp_fifo_write_error (stat_tx_ptp_fifo_write_error),
    .tx_period_ns (tx_period_ns),
    .rx_period_ns (rx_period_ns),
    .ctl_tx_parity_err_response (1'b0),
    .tx_parityin (8'b0),
    .rx_parityout (rx_parityout),
    .stat_tx_bad_parity (stat_tx_bad_parity),
    //// #---------------------
    //// # Tx Serdes Interface
    //// #---------------------
    .tx_serdes_data0 (hsec_tx_serdes_data0),
    .tx_serdes_header0 (hsec_tx_serdes_header0),
    // #---------------------
    // # Rx Serdes Interface
    // #---------------------
    .rx_serdes_data0 (hsec_rx_serdes_data0),
    .rx_serdes_header0 (hsec_rx_serdes_header0),
    .rx_serdes_headervalid0 (hsec_rx_serdes_headervalid0),
    .rx_serdes_datavalid0 (hsec_rx_serdes_datavalid0),
    .rx_serdes_bitslip0 (hsec_rx_serdes_bitslip0)
  ); //// i_HSEC_CORES


  assign hsec_rx_serdes_data0 = rx_serdes_data0;
  assign hsec_rx_serdes_header0 = rx_serdes_header0;
  assign hsec_rx_serdes_headervalid0 = rx_serdes_headervalid0;
  assign hsec_rx_serdes_datavalid0 = rx_serdes_datavalid0;

  assign tx_serdes_data0 = hsec_tx_serdes_data0;
  assign tx_serdes_header0 = hsec_tx_serdes_header0;
  assign rx_serdes_bitslip0 = hsec_rx_serdes_bitslip0;

  wire rx_reset_axi_not_sync;
  wire tx_reset_axi_not_sync;
  wire rx_serdes_reset_axi_not_sync;
  wire tx_serdes_reset_axi_not_sync;
  wire rx_reset_sync;
  wire tx_reset_sync;

  assign tx_serdes_reset_axi = tx_serdes_reset_axi_not_sync;
  assign rx_reset_sync = rx_reset;
  assign tx_reset_sync = tx_reset;


  pl_eth_10g_xxv_ethernet_0_0_axi4lite_syncer_reset i_pl_eth_10g_xxv_ethernet_0_0_RX_SERDES_RESET_AXI_SYNCER (
    .clk             ( lane_clk ),
    .reset_async     ( rx_serdes_reset_axi_not_sync ),
    .reset           ( rx_serdes_reset_axi )
  ) ;
  pl_eth_10g_xxv_ethernet_0_0_axi4lite_syncer_reset i_pl_eth_10g_xxv_ethernet_0_0_RX_RESET_AXI_SYNCER (
    .clk             ( rx_clk ),
    .reset_async     ( rx_reset_axi_not_sync ),
    .reset           ( rx_reset_axi )
  ) ;

  pl_eth_10g_xxv_ethernet_0_0_axi4lite_syncer_reset i_pl_eth_10g_xxv_ethernet_0_0_TX_RESET_AXI_SYNCER (
    .clk             ( tx_clk ),
    .reset_async     ( tx_reset_axi_not_sync ),
    .reset           ( tx_reset_axi )
  ) ;

  pl_eth_10g_xxv_ethernet_0_0_mac_baser_axis_axi_if_top i_pl_eth_10g_xxv_ethernet_0_0_axi_if_top (

    .ctl_tx_test_pattern (ctl_tx_test_pattern),
    .ctl_rx_test_pattern (ctl_rx_test_pattern),
    .ctl_tx_test_pattern_enable (ctl_tx_test_pattern_enable),
    .ctl_tx_test_pattern_select (ctl_tx_test_pattern_select),
    .ctl_tx_data_pattern_select (ctl_tx_data_pattern_select),
    .ctl_tx_test_pattern_seed_a (ctl_tx_test_pattern_seed_a),
    .ctl_tx_test_pattern_seed_b (ctl_tx_test_pattern_seed_b),
    .ctl_rx_test_pattern_enable (ctl_rx_test_pattern_enable),
    .ctl_rx_data_pattern_select (ctl_rx_data_pattern_select),
    .axi_ctl_core_mode_switch (axi_ctl_core_mode_switch),
    .ctl_tx_enable (ctl_tx_enable),
    .ctl_rx_enable (ctl_rx_enable),
    .ctl_rx_wdt_disable (ctl_rx_wdt_disable),
    .ctl_tx_fcs_ins_enable (ctl_tx_fcs_ins_enable),
    .ctl_rx_delete_fcs (ctl_rx_delete_fcs),
    .ctl_rx_ignore_fcs (ctl_rx_ignore_fcs),
    .ctl_rx_max_packet_len (ctl_rx_max_packet_len),
    .ctl_rx_min_packet_len (ctl_rx_min_packet_len),
    .ctl_tx_ipg_value (ctl_tx_ipg_value),
    .ctl_tx_custom_preamble_enable (ctl_tx_custom_preamble_enable),
    .ctl_rx_custom_preamble_enable (ctl_rx_custom_preamble_enable),
    .ctl_local_loopback (ctl_local_loopback),
    .ctl_gt_reset_all (ctl_gt_reset_all),
    .ctl_gt_tx_reset (ctl_gt_tx_reset),
    .ctl_gt_rx_reset (ctl_gt_rx_reset),
    .ctl_rx_check_sfd (ctl_rx_check_sfd),
    .ctl_rx_check_preamble (ctl_rx_check_preamble),
    .ctl_rx_process_lfi (ctl_rx_process_lfi),
    .ctl_rx_force_resync (ctl_rx_force_resync),
    .ctl_tx_ignore_fcs (ctl_tx_ignore_fcs),
    .ctl_tx_send_lfi (ctl_tx_send_lfi_axi),
    .ctl_tx_send_rfi (ctl_tx_send_rfi_axi),
    .ctl_tx_send_idle (ctl_tx_send_idle_axi),
    .user_reg0 (user_reg0),

    .stat_rx_block_lock (stat_rx_block_lock),
    .stat_rx_status_dbnc (stat_rx_status),
    .stat_rx_framing_err_valid (stat_rx_framing_err_valid),
    .stat_rx_framing_err (stat_rx_framing_err),
    .stat_rx_hi_ber (stat_rx_hi_ber),
    .stat_rx_valid_ctrl_code (stat_rx_valid_ctrl_code),
    .stat_rx_bad_code (stat_rx_bad_code),
    .stat_rx_total_packets (stat_rx_total_packets),
    .stat_rx_total_good_packets (stat_rx_total_good_packets),
    .stat_rx_total_bytes (stat_rx_total_bytes),
    .stat_rx_total_good_bytes (stat_rx_total_good_bytes),
    .stat_rx_packet_small (stat_rx_packet_small),
    .stat_rx_jabber (stat_rx_jabber),
    .stat_rx_packet_large (stat_rx_packet_large),
    .stat_rx_oversize (stat_rx_oversize),
    .stat_rx_undersize (stat_rx_undersize),
    .stat_rx_toolong (stat_rx_toolong),
    .stat_rx_fragment (stat_rx_fragment),
    .stat_rx_packet_64_bytes (stat_rx_packet_64_bytes),
    .stat_rx_packet_65_127_bytes (stat_rx_packet_65_127_bytes),
    .stat_rx_packet_128_255_bytes (stat_rx_packet_128_255_bytes),
    .stat_rx_packet_256_511_bytes (stat_rx_packet_256_511_bytes),
    .stat_rx_packet_512_1023_bytes (stat_rx_packet_512_1023_bytes),
    .stat_rx_packet_1024_1518_bytes (stat_rx_packet_1024_1518_bytes),
    .stat_rx_packet_1519_1522_bytes (stat_rx_packet_1519_1522_bytes),
    .stat_rx_packet_1523_1548_bytes (stat_rx_packet_1523_1548_bytes),
    .stat_rx_bad_fcs (stat_rx_bad_fcs),
    .stat_rx_packet_bad_fcs (stat_rx_packet_bad_fcs),
    .stat_rx_stomped_fcs (stat_rx_stomped_fcs),
    .stat_rx_packet_1549_2047_bytes (stat_rx_packet_1549_2047_bytes),
    .stat_rx_packet_2048_4095_bytes (stat_rx_packet_2048_4095_bytes),
    .stat_rx_packet_4096_8191_bytes (stat_rx_packet_4096_8191_bytes),
    .stat_rx_packet_8192_9215_bytes (stat_rx_packet_8192_9215_bytes),
    .stat_rx_unicast (stat_rx_unicast),
    .stat_rx_multicast (stat_rx_multicast),
    .stat_rx_broadcast (stat_rx_broadcast),
    .stat_rx_vlan (stat_rx_vlan),
    .stat_rx_inrangeerr (stat_rx_inrangeerr),
    .stat_rx_bad_preamble (stat_rx_bad_preamble),
    .stat_rx_bad_sfd (stat_rx_bad_sfd),
    .stat_rx_got_signal_os (stat_rx_got_signal_os),
    .stat_rx_test_pattern_mismatch (stat_rx_test_pattern_mismatch),
    .stat_rx_truncated (stat_rx_truncated),
    .stat_rx_local_fault (stat_rx_local_fault),
    .stat_rx_remote_fault (stat_rx_remote_fault),
    .stat_rx_internal_local_fault (stat_rx_internal_local_fault),
    .stat_rx_received_local_fault (stat_rx_received_local_fault),
    .stat_tx_total_packets (stat_tx_total_packets),
    .stat_tx_total_bytes (stat_tx_total_bytes),
    .stat_tx_total_good_packets (stat_tx_total_good_packets),
    .stat_tx_total_good_bytes (stat_tx_total_good_bytes),
    .stat_tx_packet_64_bytes (stat_tx_packet_64_bytes),
    .stat_tx_packet_65_127_bytes (stat_tx_packet_65_127_bytes),
    .stat_tx_packet_128_255_bytes (stat_tx_packet_128_255_bytes),
    .stat_tx_packet_256_511_bytes (stat_tx_packet_256_511_bytes),
    .stat_tx_packet_512_1023_bytes (stat_tx_packet_512_1023_bytes),
    .stat_tx_packet_1024_1518_bytes (stat_tx_packet_1024_1518_bytes),
    .stat_tx_packet_1519_1522_bytes (stat_tx_packet_1519_1522_bytes),
    .stat_tx_packet_1523_1548_bytes (stat_tx_packet_1523_1548_bytes),
    .stat_tx_packet_small (stat_tx_packet_small),
    .stat_tx_packet_large (stat_tx_packet_large),
    .stat_tx_packet_1549_2047_bytes (stat_tx_packet_1549_2047_bytes),
    .stat_tx_packet_2048_4095_bytes (stat_tx_packet_2048_4095_bytes),
    .stat_tx_packet_4096_8191_bytes (stat_tx_packet_4096_8191_bytes),
    .stat_tx_packet_8192_9215_bytes (stat_tx_packet_8192_9215_bytes),
    .stat_tx_unicast (stat_tx_unicast),
    .stat_tx_multicast (stat_tx_multicast),
    .stat_tx_broadcast (stat_tx_broadcast),
    .stat_tx_vlan (stat_tx_vlan),
    .stat_tx_bad_fcs (stat_tx_bad_fcs),
    .stat_tx_frame_error (stat_tx_frame_error),
    .stat_tx_bad_parity (stat_tx_bad_parity),
    .stat_tx_local_fault (stat_tx_local_fault),
    .stat_core_speed (stat_core_speed),
    .rx_clk (rx_serdes_clk),
    .tx_clk (tx_clk),
    .rx_reset (rx_reset | rx_serdes_reset_axi),
    .tx_reset (tx_reset | tx_reset_axi),

    .stat_gtwiz_reset_tx_done (gtwiz_reset_tx_done),
    .stat_gtwiz_reset_rx_done (gtwiz_reset_rx_done),
    .rx_reset_out (rx_reset_axi_not_sync),
    .tx_reset_out (tx_reset_axi_not_sync),
    .rx_serdes_reset_out (rx_serdes_reset_axi_not_sync),
    .tx_serdes_reset_out (tx_serdes_reset_axi_not_sync),

    .s_axi_aclk (s_axi_aclk),
    .s_axi_aresetn (s_axi_aresetn),
    .s_axi_awaddr (s_axi_awaddr),
    .s_axi_awvalid (s_axi_awvalid),
    .s_axi_awready (s_axi_awready),
    .s_axi_wdata (s_axi_wdata),
    .s_axi_wstrb (s_axi_wstrb),
    .s_axi_wvalid (s_axi_wvalid),
    .s_axi_wready (s_axi_wready),
    .s_axi_bresp (s_axi_bresp),
    .s_axi_bvalid (s_axi_bvalid),
    .s_axi_bready (s_axi_bready),
    .s_axi_araddr (s_axi_araddr),
    .s_axi_arvalid (s_axi_arvalid),
    .s_axi_arready (s_axi_arready),
    .s_axi_rdata (s_axi_rdata),
    .s_axi_rresp (s_axi_rresp),
    .s_axi_rvalid (s_axi_rvalid),
    .s_axi_rready (s_axi_rready),
    .pm_tick (pm_tick)
  );
  
  reg stat_rx_valid_ctrl_code_5K;
  reg [12:0] rx_clk_count;
  reg [13:0] rx_clk_noctrlcode_count;
  wire stat_rx_not_loss;
  reg start_count_5K;
  wire [12:0] dbnc_cnt_reset_value;
  assign dbnc_cnt_reset_value = RX_STAT_STATUS_DBNC_CNT;

  assign stat_rx_not_loss = stat_rx_valid_ctrl_code_5K;

  always @(posedge rx_serdes_clk)
  begin
    if (rx_serdes_reset == 1'b1)
    begin
      start_count_5K <= 1'b0;
      rx_clk_count   <= dbnc_cnt_reset_value;
    end
    else
    begin
      if(stat_rx_block_lock == 1'b0)
      begin
        start_count_5K <= 1'b0;
        rx_clk_count   <= dbnc_cnt_reset_value;
      end
      else if (stat_rx_valid_ctrl_code_5K == 1'b1)
      begin
        rx_clk_count   <= dbnc_cnt_reset_value;
        start_count_5K <= 1'b0;
      end
      else if (start_count_5K == 1'b1)
      begin
        rx_clk_count <= rx_clk_count - 1'b1;
      end
      else if (stat_rx_valid_ctrl_code == 1'b1)
      begin
        start_count_5K <= 1'b1;
      end
    end
  end

  always @(posedge rx_serdes_clk)
  begin
   if (rx_serdes_reset == 1'b1)
   begin
     rx_clk_noctrlcode_count       <=  14'h270F;
   end
   else
   begin
    if (stat_rx_valid_ctrl_code == 1'b1)
     begin
       rx_clk_noctrlcode_count       <=  14'h270F;
     end
    else rx_clk_noctrlcode_count       <=  rx_clk_noctrlcode_count - 1; 
    end
  end

  always @(posedge rx_serdes_clk)
  begin
    if (rx_serdes_reset == 1'b1)
      stat_rx_valid_ctrl_code_5K <= 1'b0;
    else
    begin
      if(stat_rx_block_lock == 1'b0 || rx_clk_noctrlcode_count == 14'h0)
        stat_rx_valid_ctrl_code_5K <= 1'b0;
      else if (rx_clk_count == 13'h000)
        stat_rx_valid_ctrl_code_5K <= 1'b1;
    end
  end

    assign stat_rx_status = stat_rx_block_lock && ~stat_rx_hi_ber && stat_rx_valid_ctrl_code;

endmodule



