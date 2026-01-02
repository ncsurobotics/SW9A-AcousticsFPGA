// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Wed Dec 17 21:00:05 2025
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ BLOCK_RAM_32X64_sim_netlist.v
// Design      : BLOCK_RAM_32X64
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "BLOCK_RAM_32X64,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    wea,
    addra,
    dina,
    clkb,
    enb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [5:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [5:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;

  wire [5:0]addra;
  wire [5:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]doutb;
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
  wire [31:0]NLW_U0_douta_UNCONNECTED;
  wire [5:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [5:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "6" *) 
  (* C_ADDRB_WIDTH = "6" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.68295 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
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
  (* C_INIT_FILE = "BLOCK_RAM_32X64.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "64" *) 
  (* C_READ_DEPTH_B = "64" *) 
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
  (* C_WRITE_DEPTH_A = "64" *) 
  (* C_WRITE_DEPTH_B = "64" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
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
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[31:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[5:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[5:0]),
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
        .web(1'b0));
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20320)
`pragma protect data_block
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
x/5741uhGiBRXmlyFMIIqhs8RjiPu2LPhsSYbQ==
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
