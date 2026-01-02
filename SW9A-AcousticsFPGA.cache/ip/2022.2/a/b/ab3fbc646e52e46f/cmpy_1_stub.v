// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Dec 22 20:17:45 2025
// Host        : fedora running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ cmpy_1_stub.v
// Design      : cmpy_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "cmpy_v6_0_21,Vivado 2022.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(aclk, aresetn, s_axis_a_tvalid, s_axis_a_tuser, 
  s_axis_a_tlast, s_axis_a_tdata, s_axis_b_tvalid, s_axis_b_tuser, s_axis_b_tlast, 
  s_axis_b_tdata, s_axis_ctrl_tvalid, s_axis_ctrl_tuser, s_axis_ctrl_tlast, 
  s_axis_ctrl_tdata, m_axis_dout_tvalid, m_axis_dout_tuser, m_axis_dout_tlast, 
  m_axis_dout_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,aresetn,s_axis_a_tvalid,s_axis_a_tuser[4:0],s_axis_a_tlast,s_axis_a_tdata[63:0],s_axis_b_tvalid,s_axis_b_tuser[4:0],s_axis_b_tlast,s_axis_b_tdata[63:0],s_axis_ctrl_tvalid,s_axis_ctrl_tuser[1:0],s_axis_ctrl_tlast,s_axis_ctrl_tdata[7:0],m_axis_dout_tvalid,m_axis_dout_tuser[11:0],m_axis_dout_tlast,m_axis_dout_tdata[127:0]" */;
  input aclk;
  input aresetn;
  input s_axis_a_tvalid;
  input [4:0]s_axis_a_tuser;
  input s_axis_a_tlast;
  input [63:0]s_axis_a_tdata;
  input s_axis_b_tvalid;
  input [4:0]s_axis_b_tuser;
  input s_axis_b_tlast;
  input [63:0]s_axis_b_tdata;
  input s_axis_ctrl_tvalid;
  input [1:0]s_axis_ctrl_tuser;
  input s_axis_ctrl_tlast;
  input [7:0]s_axis_ctrl_tdata;
  output m_axis_dout_tvalid;
  output [11:0]m_axis_dout_tuser;
  output m_axis_dout_tlast;
  output [127:0]m_axis_dout_tdata;
endmodule
