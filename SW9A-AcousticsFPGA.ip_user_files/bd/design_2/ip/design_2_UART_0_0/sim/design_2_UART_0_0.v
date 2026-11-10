// (c) Copyright 1995-2026 Xilinx, Inc. All rights reserved.
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


// IP VLNV: xilinx.com:module_ref:UART:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_2_UART_0_0 (
  clk,
  UART_clk,
  reset_b,
  uart_aresetn,
  TX_Data_in,
  TX_en,
  RX_Data_in,
  TX_Data_out,
  TX_Ready_To_Send,
  RX_Data_out,
  RX_Data_Ready
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 100285714, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME UART_clk, FREQ_HZ 5760000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 UART_clk CLK" *)
input wire UART_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset_b, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_b RST" *)
input wire reset_b;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME uart_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 uart_aresetn RST" *)
input wire uart_aresetn;
input wire [7 : 0] TX_Data_in;
input wire TX_en;
input wire RX_Data_in;
output wire TX_Data_out;
output wire TX_Ready_To_Send;
output wire [7 : 0] RX_Data_out;
output wire RX_Data_Ready;

  UART #(
    .WORD_SIZE(8),
    .WORD_SIZE_WIDTH(4)
  ) inst (
    .clk(clk),
    .UART_clk(UART_clk),
    .reset_b(reset_b),
    .uart_aresetn(uart_aresetn),
    .TX_Data_in(TX_Data_in),
    .TX_en(TX_en),
    .RX_Data_in(RX_Data_in),
    .TX_Data_out(TX_Data_out),
    .TX_Ready_To_Send(TX_Ready_To_Send),
    .RX_Data_out(RX_Data_out),
    .RX_Data_Ready(RX_Data_Ready)
  );
endmodule
