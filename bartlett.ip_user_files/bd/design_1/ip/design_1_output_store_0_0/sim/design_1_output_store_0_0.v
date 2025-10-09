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


// IP VLNV: xilinx.com:module_ref:output_store:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_output_store_0_0 (
  clk,
  reset_n,
  s_axis_theta_tdata,
  s_axis_theta_tvalid,
  s_axis_theta_tlast,
  s_axis_theta_tuser,
  s_axis_theta_tready,
  s_axis_weight_tdata,
  s_axis_weight_tvalid,
  s_axis_weight_tlast,
  s_axis_weight_tuser,
  s_axis_weight_tready,
  m_axis_all_tdata,
  m_axis_all_tvalid,
  m_axis_all_tuser,
  m_axis_all_tlast,
  m_axis_all_tready
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF m_axis_all:s_axis_theta:s_axis_weight, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_aclk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_n RST" *)
input wire reset_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_theta TDATA" *)
input wire [4 : 0] s_axis_theta_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_theta TVALID" *)
input wire s_axis_theta_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_theta TLAST" *)
input wire s_axis_theta_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_theta TUSER" *)
input wire s_axis_theta_tuser;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_theta, TDATA_NUM_BYTES 0, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_aclk_0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_theta TREADY" *)
output wire s_axis_theta_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_weight TDATA" *)
input wire [31 : 0] s_axis_weight_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_weight TVALID" *)
input wire s_axis_weight_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_weight TLAST" *)
input wire s_axis_weight_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_weight TUSER" *)
input wire s_axis_weight_tuser;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_weight, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_aclk_0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_weight TREADY" *)
output wire s_axis_weight_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_all TDATA" *)
output wire [607 : 0] m_axis_all_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_all TVALID" *)
output wire m_axis_all_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_all TUSER" *)
output wire m_axis_all_tuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_all TLAST" *)
output wire m_axis_all_tlast;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_all, TDATA_NUM_BYTES 76, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_aclk_0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_all TREADY" *)
input wire m_axis_all_tready;

  output_store #(
    .NUM_SIZE(32)
  ) inst (
    .clk(clk),
    .reset_n(reset_n),
    .s_axis_theta_tdata(s_axis_theta_tdata),
    .s_axis_theta_tvalid(s_axis_theta_tvalid),
    .s_axis_theta_tlast(s_axis_theta_tlast),
    .s_axis_theta_tuser(s_axis_theta_tuser),
    .s_axis_theta_tready(s_axis_theta_tready),
    .s_axis_weight_tdata(s_axis_weight_tdata),
    .s_axis_weight_tvalid(s_axis_weight_tvalid),
    .s_axis_weight_tlast(s_axis_weight_tlast),
    .s_axis_weight_tuser(s_axis_weight_tuser),
    .s_axis_weight_tready(s_axis_weight_tready),
    .m_axis_all_tdata(m_axis_all_tdata),
    .m_axis_all_tvalid(m_axis_all_tvalid),
    .m_axis_all_tuser(m_axis_all_tuser),
    .m_axis_all_tlast(m_axis_all_tlast),
    .m_axis_all_tready(m_axis_all_tready)
  );
endmodule
