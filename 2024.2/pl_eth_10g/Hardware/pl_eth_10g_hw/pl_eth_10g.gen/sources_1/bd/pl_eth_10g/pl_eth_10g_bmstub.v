// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module pl_eth_10g (
  gt_ref_clk_clk_n,
  gt_ref_clk_clk_p,
  gt_rtl_grx_n,
  gt_rtl_grx_p,
  gt_rtl_gtx_n,
  gt_rtl_gtx_p,
  sfp_tx_dis
);

  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 gt_ref_clk CLK_N" *)
  (* X_INTERFACE_MODE = "slave gt_ref_clk" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gt_ref_clk, CAN_DEBUG false, FREQ_HZ 156250000" *)
  input gt_ref_clk_clk_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 gt_ref_clk CLK_P" *)
  input gt_ref_clk_clk_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:gt:1.0 gt_rtl GRX_N" *)
  (* X_INTERFACE_MODE = "master gt_rtl" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gt_rtl, CAN_DEBUG false" *)
  input [0:0]gt_rtl_grx_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:gt:1.0 gt_rtl GRX_P" *)
  input [0:0]gt_rtl_grx_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:gt:1.0 gt_rtl GTX_N" *)
  output [0:0]gt_rtl_gtx_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:gt:1.0 gt_rtl GTX_P" *)
  output [0:0]gt_rtl_gtx_p;
  (* X_INTERFACE_IGNORE = "true" *)
  output [0:0]sfp_tx_dis;

  // stub module has no contents

endmodule
