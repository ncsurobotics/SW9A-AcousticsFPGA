// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Wed Jan 14 19:20:58 2026
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/bigpi/AMD/Vivado/2022.2/Projects/SW9A-AcousticsFPGA-top/SW9A-AcousticsFPGA.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(UART_clk, SPI_clk_2x, clk_100mhz, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="UART_clk,SPI_clk_2x,clk_100mhz,clk_in1" */;
  output UART_clk;
  output SPI_clk_2x;
  output clk_100mhz;
  input clk_in1;
endmodule
