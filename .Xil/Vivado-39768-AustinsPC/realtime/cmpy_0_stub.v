// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "cmpy_v6_0_21,Vivado 2022.2" *)
module cmpy_0(aclk, aclken, aresetn, s_axis_a_tvalid, 
  s_axis_a_tready, s_axis_a_tuser, s_axis_a_tlast, s_axis_a_tdata, s_axis_b_tvalid, 
  s_axis_b_tready, s_axis_b_tuser, s_axis_b_tlast, s_axis_b_tdata, m_axis_dout_tvalid, 
  m_axis_dout_tready, m_axis_dout_tuser, m_axis_dout_tlast, m_axis_dout_tdata);
  input aclk;
  input aclken;
  input aresetn;
  input s_axis_a_tvalid;
  output s_axis_a_tready;
  input [4:0]s_axis_a_tuser;
  input s_axis_a_tlast;
  input [63:0]s_axis_a_tdata;
  input s_axis_b_tvalid;
  output s_axis_b_tready;
  input [0:0]s_axis_b_tuser;
  input s_axis_b_tlast;
  input [63:0]s_axis_b_tdata;
  output m_axis_dout_tvalid;
  input m_axis_dout_tready;
  output [5:0]m_axis_dout_tuser;
  output m_axis_dout_tlast;
  output [127:0]m_axis_dout_tdata;
endmodule
