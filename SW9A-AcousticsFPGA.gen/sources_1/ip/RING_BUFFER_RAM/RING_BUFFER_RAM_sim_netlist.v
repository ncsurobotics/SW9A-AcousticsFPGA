// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Wed Dec 17 21:04:37 2025
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/bigpi/AMD/Vivado/2022.2/Projects/SW9A-AcousticsFPGA/SW9A-AcousticsFPGA.gen/sources_1/ip/RING_BUFFER_RAM/RING_BUFFER_RAM_sim_netlist.v
// Design      : RING_BUFFER_RAM
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "RING_BUFFER_RAM,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module RING_BUFFER_RAM
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta,
    clkb,
    enb,
    web,
    addrb,
    dinb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [7:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [0:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [7:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [31:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;

  wire [7:0]addra;
  wire [7:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]dinb;
  wire [31:0]douta;
  wire [31:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire [0:0]web;
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
  wire [7:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "8" *) 
  (* C_ADDRB_WIDTH = "8" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.9043 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
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
  (* C_INIT_FILE = "RING_BUFFER_RAM.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "256" *) 
  (* C_READ_DEPTH_B = "256" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
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
  (* C_WRITE_DEPTH_A = "256" *) 
  (* C_WRITE_DEPTH_B = "256" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  RING_BUFFER_RAM_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[7:0]),
        .regcea(1'b0),
        .regceb(1'b0),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[7:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VHPlDkoDlWlBfBMvPBmGYmaek3s9hXXhjF28kllYPnaNm3TSnzzpXHWHc8Ye9/2L2yiQfJ1hTWou
Ia/zeQ8h9/dtr6QB5YkyW4wlb/LbMgXb+DGIXPSllNl0IMsRQIcQDbcQm1bO/nlhb+2pjxiuaQrl
DbvxoDwPs7z3LunRxsg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lmIhoX8hXuc7tNV1sXY1K2/gXL7Y7Hq73qQF7+x03UWWTRd3uhGmVQtOMVbhIW+66UkWUHiD26zL
fzqGor8bgSNGpSFyS11k4TwLQT4OfAMGO8C9Qmmh4+VENBnpS9TW+wHzCv8oUwht7xYtYRZvOvYK
F3fMppz2sBkUd1lciw98ZE/UmNkhqBuMfIYF43j45DEJ55PBhOZNg91Ls4v3qBHyBAaYPFFoMry3
d5Fw1PZyFQSEOSSpwgyds2aN0g6oIwl7zm0LJrM9VDAOxBUE50hk+oHr4jj8J8UhHQJnlEHm1Idm
rvxKygNKRvfSpa90NYxZJFYgqnrMYg+19+9aZA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VkyCjO2onoeZWEoYQ/4ue7X5mkHyTYVW9xjdoTsGS4GdP/Q64VaCZL/jr6R8DVDXPMnH7tRMrDpo
jpYBnyzSgOkfgqM+96ioC2fDyAaG4gYgGLmrBR6qK3/mxXwAZZX+GJ9R/eWXkc9h8xN+gsSSX6/M
jIQCgeT6q7PB4dWT6KY=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Iub91V+TnhVlZCSLu6iKmFjix71y6/l83OPTs8uewWvkE7WcqYxEKi9fonXEkzAtWzuKwEUqnOlN
VBsNJqPUdKcd22q523mrdt89mpdosWD+hvZdO7ELhJniY5u9h49FFkubpN2JiUTcIcKEYxVNlds4
wyvaYUqbPVH5v2ooJwDdimS4GVn9HerCOgPwfshvQDNlMTxLcYju4v8BHMc5Rub9Q/ihvpQU74v2
ouZ9XIwA+C6pBLwvaqS8jE7HXOokgqJilaX/W/t+KEgiFry/txRTMU9WMD7tCN7lcfjCydmS3Lq+
3u6Hsr0S8BwNjcaDpZDnBTygUJd4JSqREnk33w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
U46EWFmKmpZGaWfyL+dokyQtJtaOYsa7HCW/+fdtw9/yHKTWFpmqKBZngBj5rPkNhtTDDCJkqsYj
tUXg1j4tgIBaCQn9B0q/aG+B3gPLrudp9hLL25mVbsfiTzdekiV2hJMmhuMoavKKPJHC6zyW7kZi
80er82OQy8h+Df/fe6TRjH9xEt3/b80tRKUMbxkLfnnkAyyf1KfOhB6/uyI4mwXuQR+DsAbzybKR
YtXpOiW72tGrXTFlzcwbHamWZefqsilVpBw6V5dh33vYKGx50xwWpj76maAkpQrOpB7zufeldJe4
W1UOEN84AZdRTLkVSxamWo/wp8nP9fiGS/ItRw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qczgIJYpE/SzErzK7eWJBGcDFEzDLm8cKbwJbPXuM6YnJxx44W+E60R3war7K2QGFAkOoCDUtDC7
SghJGF32btaDLzeKm0tQ669sBtQmMIaBrlt7I9QBkNM8zN9GL92qxNC9o3UVWMOYy5BmH8nUPgcE
O6lRubeltlrTuDe7UJQ2nEPHcXjpUJJ8dxktyW+LovBy1OxW8g4GRAsmEJsoOEg0HuDdWcc4IshJ
PvwPJ7LblELAKsdkSt65y9VaklaEm7MlH4ImlgIa74TgRmutLUbWxM1QYhGE5rAzFhGU5i3RJOdx
L3N7GGGvLMW2z9NSHbIFX+/eNII9fNJ9nZbgLA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ti1NUgDv8YPk90APMwfu/mRr38QYwAxZfv0T6zQ89YS55t2EquEGVqrEafYX6rTydLOw8le1Oucv
f2oERpSSSTih/ScZneSZmuPE/Zh2BU1Ajv0j+/+0uEWXU+5lLPbDJjnapTmJXih1MYPf0SHpZZmE
BKj2IEBI9MPZlh6bxpa5BWJnyPdAvHf+UNaMXU9+pmbtrzUVebql4mFJu45Z3+ehmFY4FBW3zXMF
44C4TlHACLwL3vHVMCVfeKhgdVDbpE+/IFhTStz7mZ9h9RKGanQcs6YDVM1R+2RKA1QT1fX4FiQc
1V+FGmrm1ujxmFGXwpfNKByVlfCY0oWhRJCYYQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
HuEXFK0NXt09xU2yxxjng1OLsT+ZEM4EhqBgpr9D2ljw2vDaMBrqEsRQTc2B9soDq3ewDduHJXBd
OGYxkPnoN6LhjULtB2nTgjcH6NxA4puZ1ZNcndDndVBo8rTW5W1OqHq6InAG0CqPpTIkuqz3ECPl
EysI++MCDfH6tIzlekxJFIJ1McJsTq5rFuLzMMcrmkBxgcayDpOcCFuzZzCczxmt/cCCIKmDybwT
OQXmOcLJoYLP4sFu6R9c6xO8i6p++crv2N3eIxZHKbek9xBBZqQM9EYuEtsbkqAs9XZpa16i5njR
BDFxTKcP6r7JgFALJE89AZhBbate5JXWp0v4ECZD18aEL17CipwcWPutNMdG1apzSPP5y59n7rMG
yxBPz1gKHc3Emkl4WcO0hjICxqmO6dMXoY8JvBSf6ry2l0sH9Ihr3Bq5WWmlhPHnoaNr5jl//vNe
KfToWtn97eoVSt1LnmXXnSpdigbHr0UIg8AdkpdkuNRaWdVicDdgSo49

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mokwst2bn6UxD6V9UdIgCIG1QQ/d0FiJqYGOTI2eHPV6YElaLjnJ8DnQmZnGS95o3x93FDOoa58C
RwYsX1fVoVtXkj1LuZq0k7q9vEe4T8xMjpkeYtIHY9k0Xhy1Lq/xRlfzGAf9fvf9e+f4r7aR/Sb/
uCZxxugG5niTwLENY1n3NthYL0jvo8Fmdw4Qg0nTCGWlVCws+09K0g9/lx6I9EcuHHemcHO3fOZG
lMc4NaPNozKwnyDMoWUkwiVxyFEPFaQLNYqzjvR+CqrWfhFLo96JWhL+eaDoNuZoBVYQtNH5ZwBL
BoO27Pw10lgcReGlZBz3BLO7T4ddynCx0+eSnw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PiP7AjOQqqouyQMoBQqgWIDhUSViq94rIvGiIJ/UKMDspM/yXw1caE8AhWHTjYckC4yLpPAz5P6s
1Z6flzDPrzVwg4e59X2cc4IMCHhedna0rDO804njcc6amRDTeLsMLTkWfvomB4xwszm2AgT+PRnB
WHd09ZUDVFjiBXT+Oa9AicgGJHrX3w823yBPuAa704kje/SzgtiDpcTU1eLmLhLW7LpEd9KIHd9s
ER7Uk9Orws0Kq9PMTqMX4hMn5K5mFakOeOURiEbUjdv5RiIJ2g/PlQXSItM8fHsBTQa6fOaJwQTI
vHwK3a8ZBHpfT1YH+n7wNiNUZwD4SFXm1QVx4g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ul5ZfTHJwMctaNhYRortUZizYMPYRef7uYqPSuMkxsArnxI/cjGh+KRMwzV86hyp/6TXSJIjm5ec
2wX2UONdPN+DOJ84jYC4JbgJQrPnTj7ioD8uLX/WlyPcQzyF5keqFgj5eR5s13FskVWCuAWf5m9w
mhFEKFjVXDAr7gVgAJh/hL8P6Psrnf+LGfiM8JhnDepsHEYykGlpD3fzru2BGgqHWqPqFMcnyVGl
vysaIXiJz/eYKvO8RGcgd3DJAM/wPm9A0m/DWcmSnczOgTjoqkHcBg2H5uJMLvufzmjImi6LYEqq
v04ESDEN31cSUzqUYcayvMFOnI/WNsWbFIa5+Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 28928)
`pragma protect data_block
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
lVa7WPHwnFP502KQ7Mxx8tS/B9A9LtvOArs3ZRI=
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
