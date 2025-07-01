//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
//Date        : Wed Jun  4 09:25:51 2025
//Host        : maxwell running 64-bit Ubuntu 22.04.5 LTS
//Command     : generate_target pl_eth_10g_wrapper.bd
//Design      : pl_eth_10g_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module pl_eth_10g_wrapper
   (gt_ref_clk_clk_n,
    gt_ref_clk_clk_p,
    gt_rtl_grx_n,
    gt_rtl_grx_p,
    gt_rtl_gtx_n,
    gt_rtl_gtx_p,
    sfp_tx_dis);
  input gt_ref_clk_clk_n;
  input gt_ref_clk_clk_p;
  input [0:0]gt_rtl_grx_n;
  input [0:0]gt_rtl_grx_p;
  output [0:0]gt_rtl_gtx_n;
  output [0:0]gt_rtl_gtx_p;
  output [0:0]sfp_tx_dis;

  wire gt_ref_clk_clk_n;
  wire gt_ref_clk_clk_p;
  wire [0:0]gt_rtl_grx_n;
  wire [0:0]gt_rtl_grx_p;
  wire [0:0]gt_rtl_gtx_n;
  wire [0:0]gt_rtl_gtx_p;
  wire [0:0]sfp_tx_dis;

  pl_eth_10g pl_eth_10g_i
       (.gt_ref_clk_clk_n(gt_ref_clk_clk_n),
        .gt_ref_clk_clk_p(gt_ref_clk_clk_p),
        .gt_rtl_grx_n(gt_rtl_grx_n),
        .gt_rtl_grx_p(gt_rtl_grx_p),
        .gt_rtl_gtx_n(gt_rtl_gtx_n),
        .gt_rtl_gtx_p(gt_rtl_gtx_p),
        .sfp_tx_dis(sfp_tx_dis));
endmodule
