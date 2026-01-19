// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Wed Jan 14 19:13:09 2026
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/bigpi/AMD/Vivado/2022.2/Projects/SW9A-AcousticsFPGA-top/bartlett.gen/sources_1/ip/cmpy_rxx/cmpy_rxx_stub.v
// Design      : cmpy_rxx
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "cmpy_v6_0_21,Vivado 2022.2" *)
module cmpy_rxx(aclk, aresetn, s_axis_a_tvalid, 
  s_axis_a_tready, s_axis_a_tuser, s_axis_a_tlast, s_axis_a_tdata, s_axis_b_tvalid, 
  s_axis_b_tready, s_axis_b_tuser, s_axis_b_tdata, m_axis_dout_tvalid, m_axis_dout_tready, 
  m_axis_dout_tuser, m_axis_dout_tlast, m_axis_dout_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,aresetn,s_axis_a_tvalid,s_axis_a_tready,s_axis_a_tuser[1:0],s_axis_a_tlast,s_axis_a_tdata[31:0],s_axis_b_tvalid,s_axis_b_tready,s_axis_b_tuser[1:0],s_axis_b_tdata[31:0],m_axis_dout_tvalid,m_axis_dout_tready,m_axis_dout_tuser[3:0],m_axis_dout_tlast,m_axis_dout_tdata[31:0]" */;
  input aclk;
  input aresetn;
  input s_axis_a_tvalid;
  output s_axis_a_tready;
  input [1:0]s_axis_a_tuser;
  input s_axis_a_tlast;
  input [31:0]s_axis_a_tdata;
  input s_axis_b_tvalid;
  output s_axis_b_tready;
  input [1:0]s_axis_b_tuser;
  input [31:0]s_axis_b_tdata;
  output m_axis_dout_tvalid;
  input m_axis_dout_tready;
  output [3:0]m_axis_dout_tuser;
  output m_axis_dout_tlast;
  output [31:0]m_axis_dout_tdata;
endmodule
