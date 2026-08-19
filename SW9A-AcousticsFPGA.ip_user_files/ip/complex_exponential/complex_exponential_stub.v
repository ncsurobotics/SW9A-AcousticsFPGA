// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Mon Aug 17 17:14:46 2026
// Host        : AustinsPC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/Aweso/Verilog/Aquapack/sw9-jan/SW9A-AcousticsFPGA.gen/sources_1/ip/complex_exponential/complex_exponential_stub.v
// Design      : complex_exponential
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dds_compiler_v6_0_22,Vivado 2022.2" *)
module complex_exponential(aclk, aresetn, s_axis_phase_tvalid, 
  s_axis_phase_tready, s_axis_phase_tdata, s_axis_phase_tlast, m_axis_data_tvalid, 
  m_axis_data_tready, m_axis_data_tdata, m_axis_data_tlast)
/* synthesis syn_black_box black_box_pad_pin="aclk,aresetn,s_axis_phase_tvalid,s_axis_phase_tready,s_axis_phase_tdata[15:0],s_axis_phase_tlast,m_axis_data_tvalid,m_axis_data_tready,m_axis_data_tdata[31:0],m_axis_data_tlast" */;
  input aclk;
  input aresetn;
  input s_axis_phase_tvalid;
  output s_axis_phase_tready;
  input [15:0]s_axis_phase_tdata;
  input s_axis_phase_tlast;
  output m_axis_data_tvalid;
  input m_axis_data_tready;
  output [31:0]m_axis_data_tdata;
  output m_axis_data_tlast;
endmodule
