// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Mon Dec 29 01:57:35 2025
// Host        : AustinsPC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top cmpy_1 -prefix
//               cmpy_1_ cmpy_1_stub.v
// Design      : cmpy_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "cmpy_v6_0_21,Vivado 2022.2" *)
module cmpy_1(aclk, aresetn, s_axis_a_tvalid, 
  s_axis_a_tready, s_axis_a_tuser, s_axis_a_tdata, s_axis_b_tvalid, s_axis_b_tready, 
  s_axis_b_tuser, s_axis_b_tlast, s_axis_b_tdata, m_axis_dout_tvalid, m_axis_dout_tready, 
  m_axis_dout_tuser, m_axis_dout_tlast, m_axis_dout_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,aresetn,s_axis_a_tvalid,s_axis_a_tready,s_axis_a_tuser[3:0],s_axis_a_tdata[31:0],s_axis_b_tvalid,s_axis_b_tready,s_axis_b_tuser[4:0],s_axis_b_tlast,s_axis_b_tdata[31:0],m_axis_dout_tvalid,m_axis_dout_tready,m_axis_dout_tuser[8:0],m_axis_dout_tlast,m_axis_dout_tdata[63:0]" */;
  input aclk;
  input aresetn;
  input s_axis_a_tvalid;
  output s_axis_a_tready;
  input [3:0]s_axis_a_tuser;
  input [31:0]s_axis_a_tdata;
  input s_axis_b_tvalid;
  output s_axis_b_tready;
  input [4:0]s_axis_b_tuser;
  input s_axis_b_tlast;
  input [31:0]s_axis_b_tdata;
  output m_axis_dout_tvalid;
  input m_axis_dout_tready;
  output [8:0]m_axis_dout_tuser;
  output m_axis_dout_tlast;
  output [63:0]m_axis_dout_tdata;
endmodule
