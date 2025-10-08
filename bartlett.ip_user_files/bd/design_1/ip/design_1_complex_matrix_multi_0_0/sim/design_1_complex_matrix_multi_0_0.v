// (c) Copyright 1995-2025 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:complex_matrix_multiplier:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_complex_matrix_multi_0_0 (
  clk,
  reset_n,
  clken,
  s_axis_tvalid,
  s_axis_tlast,
  s_axis_tuser,
  m_axis_dout_tready,
  m_axis_dout_tvalid,
  s_axis_tready,
  m_axis_dout_tlast,
  m_axis_dout_tuser,
  channel_0_base,
  channel_1_base,
  channel_2_base,
  channel_3_base,
  result_matrix_0_0,
  result_matrix_0_1,
  result_matrix_0_2,
  result_matrix_0_3,
  result_matrix_1_0,
  result_matrix_1_1,
  result_matrix_1_2,
  result_matrix_1_3,
  result_matrix_2_0,
  result_matrix_2_1,
  result_matrix_2_2,
  result_matrix_2_3,
  result_matrix_3_0,
  result_matrix_3_1,
  result_matrix_3_2,
  result_matrix_3_3
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF m_axis_dout:s_axis, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_aclk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_n RST" *)
input wire reset_n;
input wire clken;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TVALID" *)
input wire s_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TLAST" *)
input wire s_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TUSER" *)
input wire [4 : 0] s_axis_tuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_dout TREADY" *)
input wire m_axis_dout_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_dout TVALID" *)
output wire m_axis_dout_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis, TDATA_NUM_BYTES 0, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 5, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_aclk_0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TREADY" *)
output wire s_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_dout TLAST" *)
output wire m_axis_dout_tlast;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_dout, TDATA_NUM_BYTES 0, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 5, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_aclk_0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_dout TUSER" *)
output wire [4 : 0] m_axis_dout_tuser;
input wire [31 : 0] channel_0_base;
input wire [31 : 0] channel_1_base;
input wire [31 : 0] channel_2_base;
input wire [31 : 0] channel_3_base;
output wire [63 : 0] result_matrix_0_0;
output wire [63 : 0] result_matrix_0_1;
output wire [63 : 0] result_matrix_0_2;
output wire [63 : 0] result_matrix_0_3;
output wire [63 : 0] result_matrix_1_0;
output wire [63 : 0] result_matrix_1_1;
output wire [63 : 0] result_matrix_1_2;
output wire [63 : 0] result_matrix_1_3;
output wire [63 : 0] result_matrix_2_0;
output wire [63 : 0] result_matrix_2_1;
output wire [63 : 0] result_matrix_2_2;
output wire [63 : 0] result_matrix_2_3;
output wire [63 : 0] result_matrix_3_0;
output wire [63 : 0] result_matrix_3_1;
output wire [63 : 0] result_matrix_3_2;
output wire [63 : 0] result_matrix_3_3;

  complex_matrix_multiplier #(
    .NUM_SIZE(32)
  ) inst (
    .clk(clk),
    .reset_n(reset_n),
    .clken(clken),
    .s_axis_tvalid(s_axis_tvalid),
    .s_axis_tlast(s_axis_tlast),
    .s_axis_tuser(s_axis_tuser),
    .m_axis_dout_tready(m_axis_dout_tready),
    .m_axis_dout_tvalid(m_axis_dout_tvalid),
    .s_axis_tready(s_axis_tready),
    .m_axis_dout_tlast(m_axis_dout_tlast),
    .m_axis_dout_tuser(m_axis_dout_tuser),
    .channel_0_base(channel_0_base),
    .channel_1_base(channel_1_base),
    .channel_2_base(channel_2_base),
    .channel_3_base(channel_3_base),
    .result_matrix_0_0(result_matrix_0_0),
    .result_matrix_0_1(result_matrix_0_1),
    .result_matrix_0_2(result_matrix_0_2),
    .result_matrix_0_3(result_matrix_0_3),
    .result_matrix_1_0(result_matrix_1_0),
    .result_matrix_1_1(result_matrix_1_1),
    .result_matrix_1_2(result_matrix_1_2),
    .result_matrix_1_3(result_matrix_1_3),
    .result_matrix_2_0(result_matrix_2_0),
    .result_matrix_2_1(result_matrix_2_1),
    .result_matrix_2_2(result_matrix_2_2),
    .result_matrix_2_3(result_matrix_2_3),
    .result_matrix_3_0(result_matrix_3_0),
    .result_matrix_3_1(result_matrix_3_1),
    .result_matrix_3_2(result_matrix_3_2),
    .result_matrix_3_3(result_matrix_3_3)
  );
endmodule
