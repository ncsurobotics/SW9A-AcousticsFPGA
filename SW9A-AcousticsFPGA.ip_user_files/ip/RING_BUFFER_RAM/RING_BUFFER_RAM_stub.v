// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Thu Jan 15 20:00:55 2026
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/bigpi/AMD/Vivado/2022.2/Projects/SW9A-AcousticsFPGA-top/SW9A-AcousticsFPGA.gen/sources_1/ip/RING_BUFFER_RAM/RING_BUFFER_RAM_stub.v
// Design      : RING_BUFFER_RAM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *)
module RING_BUFFER_RAM(clka, ena, wea, addra, dina, douta, clkb, enb, web, addrb, 
  dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[8:0],dina[9:0],douta[9:0],clkb,enb,web[0:0],addrb[8:0],dinb[9:0],doutb[9:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [8:0]addra;
  input [9:0]dina;
  output [9:0]douta;
  input clkb;
  input enb;
  input [0:0]web;
  input [8:0]addrb;
  input [9:0]dinb;
  output [9:0]doutb;
endmodule
