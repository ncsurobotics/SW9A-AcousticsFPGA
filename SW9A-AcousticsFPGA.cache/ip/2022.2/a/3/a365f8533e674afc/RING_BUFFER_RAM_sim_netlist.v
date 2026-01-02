// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Wed Dec 17 21:04:37 2025
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ RING_BUFFER_RAM_sim_netlist.v
// Design      : RING_BUFFER_RAM
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "RING_BUFFER_RAM,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_5 U0
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
iAY5+I82NZKE8ioGKBY5WEVpXUVzqFvLjShztNU=
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
