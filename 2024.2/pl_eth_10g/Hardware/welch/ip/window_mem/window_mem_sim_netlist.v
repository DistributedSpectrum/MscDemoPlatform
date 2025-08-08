// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Mon Aug  4 16:15:52 2025
// Host        : maxwell running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/elya/DS/MscDemoPlatform/2024.2/pl_eth_10g/Hardware/ip_repo/welch/ip/window_mem/window_mem_sim_netlist.v
// Design      : window_mem
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu9eg-ffvb1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "window_mem,blk_mem_gen_v8_4_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_9,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module window_mem
   (clka,
    ena,
    wea,
    addra,
    dina,
    clkb,
    enb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [11:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [15:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [11:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [15:0]doutb;

  wire [11:0]addra;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire [15:0]dina;
  wire [15:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [15:0]NLW_U0_douta_UNCONNECTED;
  wire [11:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [11:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "12" *) 
  (* C_ADDRB_WIDTH = "12" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     6.370178 mW" *) 
  (* C_FAMILY = "zynquplus" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "window_mem.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "4096" *) 
  (* C_READ_DEPTH_B = "4096" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "4096" *) 
  (* C_WRITE_DEPTH_B = "4096" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  window_mem_blk_mem_gen_v8_4_9 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[15:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[11:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[11:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2024.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
FPXllyX2NFs/RMngGqZy2bLYbZr92CdofeZrJOHklWXExpaPgHNYp2Lzm4MnflbnrfSkCmLwwKT5
zfRgEip7FKQ5Zhb73p0MAIADixBZ/ZRt4hQkJL0T9brm0waLHfanjnov2aCX6jN3LbQc3ujmDga6
Dd73k78u4xjRTDv1/P4=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kr7VKKvChFoiyRCReag+OvU3jnmG9pN0cv+BxhNmMKLthg/ksgNZyU3L+fQ7cmIQELtlUjwjkBAP
Jjq5RsCnHbJxj+Ys1GNhriiBsxLqxWCP8onhAVvgZN2xZFOih0UWpqlU8NVP8Eww1ohvkDgxTstC
3kDmYehxIUJjqCC/mgRZmuezqugrFdubYmBoz16tUvD17iA5qqCIMS9xSIXYp2LBNekmWEwrVqzu
R4koEo4UlXl/CEw0XY3QvMoHnlXgu6N/6sc+nxZtKSwjiMVvGnZE9UVvJPAC3Hn3zKFGlK53mmGO
Tj0dWzhwX0ahSYzkyJC/HLdbGZmriL2UNvDyFw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
CaLc9FGt3AdRHfNtGAsGFY/QEvHY1Vv4TvvgCDsdDMqiuDeLizFJDJeskBWjeKDoE2cufK8TxiBq
mySRQNJoeOKnxTiDdf+Rx6m0iR6h/YeswegYwgghpM5KVrl6mSwF3+4yEovPM7a+9ArDQ5vl+WT8
SilNGzyW0KnTwe7+szs=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cEnudSW1X71p0Xuq6jrXOxHnBku87IA0RA3zKqmeZHZM0r+9rEm5MSzX8RecnQ994yiqeyxbIH2l
fGEzUzr0ZzryS3fkf2LnJuB39f2YARW9eVCSiaeWaraZuY1l89T+h3vgdlurS/1LIraYLS1MyOXa
6F1LAcQp3W4OO4ctc3q1FRMZGldRS1biMsKwJ8Lxj8NEOm67UfgFrJNQAxbVXEfbWRWhKtwNxcTB
JbgC8j4EHkIA46mzoHloeBAL6KieplQUBjKXSSTb66rxglbFhWLy+mirROHcocu9J4ZbvTRYZEww
4lso1lqAllVLAoKYqa3WImZuSRoTbGDngBt9Lg==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
rOyI+x4PlmKcVSFoN3oKgSYpVlmYxc194Ej04il/YmBg10xopy4zmtu5sdCP/uGSNYcNGWeAiw01
mNf98KyNgTUFXruHCA38qjhhEIvl4vfWWn3W3mFRxrIuwmnreT6qTvgMaxIkCdVBDP7Iy7O6WmCf
3Va5X5hnCHhtXgX5UYniBHiLjmupv63B8XMAYDH2n6mQ3H0DF7mtb7psBafd0Z6+IWUbmzwMtKrf
ZrRJBGAhNT0i1KrEjEh/rWjN7Z7N32zQ+Pl1kc5gYCQIX5McfdTdqSaRVXZ/HF90ymS7/8d5LDyj
Er+ORdcjnOn6oAyY4PuUUl4OYUHv5k+RglTe5Q==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2023_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bJa7kPSpDipzoJoQu1APEjc8vFLqBfQZK/grZvWijD7/FgMTerFCWLUY6n8DWeGdvjXvTeyrqCHE
2rP/H57wUqPC8tIJlGm6ZYQGjZ3TgYqLrJshDE5zYMTO//q0vuSraWvZP7A7SLuW6y7tFE/nplpx
L8gbYORx6j70okGUwnamCMS9yhFr7Z2QTJne1k4GNFGvy66URk3k5cBPl5j4/1yc4xGV+aWYl6L8
q8RorRU/CltObHKrji/jdiY1WtdGrkpRyCEFc+XNPazL9xSLLu5bz6XlvKwoks+8a5KYT/VFUovM
JbM0bpAXM8Z7rGaPuXjqXtZBg5praTZLu/WNcA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PYKBDinOGc/kIVdFzXrz2wA4/QNFxLDrQfTWfR5TjYE6bm49vrZi0bawcr9HXp4OP1+XxPLB3oCP
oV5e/rYeDln531ebt8yEg27XCoSHEX4FU8oG8aBJ8fqgWayOnAMJt025WodOxuZXbhT1zPo7J3uh
6iO9Mv7RtYE2fZ1W+G8oN//FTOEJYPWlKYnt0cDeZrN3I4rHHptZHuu7l8T+df0PYea3x6U3Mvkl
ojZ+TwQtdu0NuYY5j3QNgx3+W2XYq1M773FAnEz/deW54EjE+jf1jjrBk2pl8SYxeKuutS15oPVF
eHdqXYVcJxoUY5JH8z04lITKEnZ4oq6sYS6dog==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
tl+2vFCWZ583gQGsVC7oopz2NCKBiJ9uOHYBGzJZheOHJMqI/ehNvo25l710eBx00tztXzM30AH6
ZhAJg+kJwE2jO0MV5fmG5dnwXmLqoGEJMBs7xwWxvYK7w/0z9M0AJKD7HnuC+IiLhNU/fIxyuE+I
+vWqp//RcfY0tMMp2I2J1yEW6GUahS1ve/4JchssZ7Xu7VthoSDWXMQWATbvsUsDzeSo2+Ruz8Kq
Dc05HqEU8NgBxDPPEKLCcdKLp4byglwj7iCAtCjsPy8P18qjgb2sycFjNgmaiNMMB51WqeD+hneG
hLOue9bqVdEojkrb3q4WbsGZKz0bAGsryxslOlYHP1b8vey3yI2ixA80wyERe8d3GRIeZiSxGykH
qWxsE6x/iyi8QRb5mXZPMApA+Fln8tYmn7+1rFCm8gF4gJWhr1PsSJqTi658symGrzT0Ghjvf2QL
SvvoaeNdy0pOsWs7jLBFndd4GiFA+9K6Y33sziLToU9EvvFokENIslod

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
oYiCujFRj1F3wKsGZlHR9niEtR9MLXEVAVfy+f/3xrmpW6Ye5a+fBCvm4TH+iRQefGHNdMPnzTNW
K/pEPAS9uMJjOdFiu+APT+LYrSRnEg4W0dX5buSDGM6LBWAuMseoTMjbJJoYDGLRckJgW43E30mX
ej4823nkbfwc+Ecbrup825qLyv8RTQLNHafvJA5lSapdqXwnlOIYRmcHn+sfAh5pGv9kW9aokcdh
ObR2XYxX99rYloyvz3x0pmjxD5ILW4SQMB1IUEuuyqX6eb5IQ+kZ41hjvsHIuQH29vzpCfV9Jqha
WC5yxxK1R+cleZSKD1H1gVzbTei8uFs/91Bgeg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
urNc+S8AFPj+GVFdqJE5V7P8O6QI6MA3nkwYb8NKbYbVufnXKg6voJIRYYeYr7EOa8mrqirozWbY
Lln9SLWnkaAy2LvL/N6WahoQdCt++4RH+xe768XvSrVUFPrIwZRixqMLurc/tPov4i5P/ukZKl18
ZPZvXRzUNlvCZnMPcF+5QCQihqPbjcZ0YyGgWgX/ipTGG3sNqmylGN7qLa4Rgqu/mB5a2xVyu5Wc
911+/X3VVFx697WVaP5V0SbOzYN8R8+8B8kdznwixMA+f4lSbBXyRysVOSzYjo8bKEMqyKMVBQn9
xDmEuV0DvVWXdO7VPvWA1LuJFwS07OxeI2GCcQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QcP7fsLZxaDrG29e9HQeXfu2TsKsdyW7Yc1vWct6lbmDEfXkWMU1fFWSPIjPzRc9UOnfEu0bRn+B
D+8MWokqes3WF7txljBmgUPiNGZ8arUU6ENa/IY/Wv7iaB/ZKM5PtdnFAkjDIrYyKFCTz/U6Yzwi
hBGGarK/wYQOLzeeKRewiPTiNUL7tztWuMZ1t1msxD951EeKrwjrjcXIIuf/TzrOGUOlWgjHlnrl
4Q/lfMAnRLBNTSWG+5wWewCE8jK2X/gJ5AV4p3x1WP3+JglbxpP39l3pzedXqciZPbuz2XlFnRPV
KByaUaAShzJ56p8+0HjWebibqQdieGNPiPWW0Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 49328)
`pragma protect data_block
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
L6Ao2lLNj9zrxG819R7pCFjbe2Fpdcg=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
