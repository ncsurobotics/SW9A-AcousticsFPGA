// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Mon Oct 26 20:34:32 2026
// Host        : JokeJet running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim {c:/Users/Praneeth
//               Satishkumar/eda/designs/riscv32-sky130-asic/SW9A-AcousticsFPGA/SW9A-AcousticsFPGA.gen/sources_1/bd/design_2/ip/design_2_UART_TRANSACTION_HAN_0_0/design_2_UART_TRANSACTION_HAN_0_0_sim_netlist.v}
// Design      : design_2_UART_TRANSACTION_HAN_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_2_UART_TRANSACTION_HAN_0_0,UART_TRANSACTION_HANDLER,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "UART_TRANSACTION_HANDLER,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module design_2_UART_TRANSACTION_HAN_0_0
   (clk,
    reset_n,
    rx_data,
    rx_ready,
    uart_tx_ready,
    Word_To_Send,
    Word_To_Send_en,
    max_angle,
    m_axi_awaddr,
    m_axi_awvalid,
    m_axi_awready,
    m_axi_wdata,
    m_axi_wstrb,
    m_axi_wvalid,
    m_axi_wready,
    m_axi_bresp,
    m_axi_bvalid,
    m_axi_bready,
    m_axi_araddr,
    m_axi_arvalid,
    m_axi_arready,
    m_axi_rdata,
    m_axi_rresp,
    m_axi_rvalid,
    m_axi_rready);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF m_axi, FREQ_HZ 100285714, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_n RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input reset_n;
  input [7:0]rx_data;
  input rx_ready;
  input uart_tx_ready;
  output [7:0]Word_To_Send;
  output Word_To_Send_en;
  input [31:0]max_angle;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWADDR" *) output [31:0]m_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWVALID" *) output m_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWREADY" *) input m_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WDATA" *) output [31:0]m_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WSTRB" *) output [3:0]m_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WVALID" *) output m_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WREADY" *) input m_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BRESP" *) input [1:0]m_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BVALID" *) input m_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BREADY" *) output m_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARADDR" *) output [31:0]m_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARVALID" *) output m_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARREADY" *) input m_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RDATA" *) input [31:0]m_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RRESP" *) input [1:0]m_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RVALID" *) input m_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100285714, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output m_axi_rready;

  wire \<const0> ;
  wire [7:0]Word_To_Send;
  wire Word_To_Send_en;
  wire clk;
  wire [5:0]\^m_axi_araddr ;
  wire m_axi_arready;
  wire m_axi_arvalid;
  wire [5:0]\^m_axi_awaddr ;
  wire m_axi_awready;
  wire m_axi_awvalid;
  wire m_axi_bready;
  wire m_axi_bvalid;
  wire [31:0]m_axi_rdata;
  wire m_axi_rready;
  wire [1:0]m_axi_rresp;
  wire m_axi_rvalid;
  wire [31:0]m_axi_wdata;
  wire m_axi_wready;
  wire [2:2]\^m_axi_wstrb ;
  wire m_axi_wvalid;
  wire [31:0]max_angle;
  wire reset_n;
  wire [7:0]rx_data;
  wire rx_ready;
  wire uart_tx_ready;

  assign m_axi_araddr[31] = \<const0> ;
  assign m_axi_araddr[30] = \<const0> ;
  assign m_axi_araddr[29] = \<const0> ;
  assign m_axi_araddr[28] = \<const0> ;
  assign m_axi_araddr[27] = \<const0> ;
  assign m_axi_araddr[26] = \<const0> ;
  assign m_axi_araddr[25] = \<const0> ;
  assign m_axi_araddr[24] = \<const0> ;
  assign m_axi_araddr[23] = \<const0> ;
  assign m_axi_araddr[22] = \<const0> ;
  assign m_axi_araddr[21] = \<const0> ;
  assign m_axi_araddr[20] = \<const0> ;
  assign m_axi_araddr[19] = \<const0> ;
  assign m_axi_araddr[18] = \<const0> ;
  assign m_axi_araddr[17] = \<const0> ;
  assign m_axi_araddr[16] = \<const0> ;
  assign m_axi_araddr[15] = \<const0> ;
  assign m_axi_araddr[14] = \<const0> ;
  assign m_axi_araddr[13] = \<const0> ;
  assign m_axi_araddr[12] = \<const0> ;
  assign m_axi_araddr[11] = \<const0> ;
  assign m_axi_araddr[10] = \<const0> ;
  assign m_axi_araddr[9] = \<const0> ;
  assign m_axi_araddr[8] = \<const0> ;
  assign m_axi_araddr[7] = \<const0> ;
  assign m_axi_araddr[6] = \<const0> ;
  assign m_axi_araddr[5:0] = \^m_axi_araddr [5:0];
  assign m_axi_awaddr[31] = \<const0> ;
  assign m_axi_awaddr[30] = \<const0> ;
  assign m_axi_awaddr[29] = \<const0> ;
  assign m_axi_awaddr[28] = \<const0> ;
  assign m_axi_awaddr[27] = \<const0> ;
  assign m_axi_awaddr[26] = \<const0> ;
  assign m_axi_awaddr[25] = \<const0> ;
  assign m_axi_awaddr[24] = \<const0> ;
  assign m_axi_awaddr[23] = \<const0> ;
  assign m_axi_awaddr[22] = \<const0> ;
  assign m_axi_awaddr[21] = \<const0> ;
  assign m_axi_awaddr[20] = \<const0> ;
  assign m_axi_awaddr[19] = \<const0> ;
  assign m_axi_awaddr[18] = \<const0> ;
  assign m_axi_awaddr[17] = \<const0> ;
  assign m_axi_awaddr[16] = \<const0> ;
  assign m_axi_awaddr[15] = \<const0> ;
  assign m_axi_awaddr[14] = \<const0> ;
  assign m_axi_awaddr[13] = \<const0> ;
  assign m_axi_awaddr[12] = \<const0> ;
  assign m_axi_awaddr[11] = \<const0> ;
  assign m_axi_awaddr[10] = \<const0> ;
  assign m_axi_awaddr[9] = \<const0> ;
  assign m_axi_awaddr[8] = \<const0> ;
  assign m_axi_awaddr[7] = \<const0> ;
  assign m_axi_awaddr[6] = \<const0> ;
  assign m_axi_awaddr[5:0] = \^m_axi_awaddr [5:0];
  assign m_axi_wstrb[3] = \^m_axi_wstrb [2];
  assign m_axi_wstrb[2] = \^m_axi_wstrb [2];
  assign m_axi_wstrb[1] = \^m_axi_wstrb [2];
  assign m_axi_wstrb[0] = \^m_axi_wstrb [2];
  GND GND
       (.G(\<const0> ));
  design_2_UART_TRANSACTION_HAN_0_0_UART_TRANSACTION_HANDLER inst
       (.Word_To_Send(Word_To_Send),
        .Word_To_Send_en(Word_To_Send_en),
        .clk(clk),
        .m_axi_araddr(\^m_axi_araddr ),
        .m_axi_arready(m_axi_arready),
        .m_axi_arvalid(m_axi_arvalid),
        .m_axi_awaddr(\^m_axi_awaddr ),
        .m_axi_awready(m_axi_awready),
        .m_axi_awvalid(m_axi_awvalid),
        .m_axi_bready(m_axi_bready),
        .m_axi_bvalid(m_axi_bvalid),
        .m_axi_rdata(m_axi_rdata),
        .m_axi_rready_reg_0(m_axi_rready),
        .m_axi_rresp(m_axi_rresp),
        .m_axi_rvalid(m_axi_rvalid),
        .m_axi_wdata(m_axi_wdata),
        .m_axi_wready(m_axi_wready),
        .m_axi_wstrb(\^m_axi_wstrb ),
        .m_axi_wvalid(m_axi_wvalid),
        .max_angle(max_angle),
        .reset_n(reset_n),
        .rx_data(rx_data),
        .rx_ready(rx_ready),
        .uart_tx_ready(uart_tx_ready));
endmodule

(* ORIG_REF_NAME = "UART_RX_DECODER" *) 
module design_2_UART_TRANSACTION_HAN_0_0_UART_RX_DECODER
   (E,
    uart_addr_reg_0,
    \SIPO_reg[0][7]_0 ,
    D,
    \SIPO_reg[0][6]_0 ,
    \SIPO_reg[0][6]_1 ,
    reset_n_0,
    \SIPO_reg[0][5]_0 ,
    \SIPO_reg[1][7]_0 ,
    Q,
    \FSM_onehot_state_reg[0] ,
    \FSM_onehot_state_reg[0]_0 ,
    \FSM_onehot_state_reg[0]_1 ,
    rx_ready,
    m_axi_rvalid,
    \tx_data_in_reg[0] ,
    rx_data,
    w_done,
    w_done_reg,
    aw_done,
    aw_done_reg,
    reset_n,
    clk);
  output [0:0]E;
  output uart_addr_reg_0;
  output [0:0]\SIPO_reg[0][7]_0 ;
  output [3:0]D;
  output \SIPO_reg[0][6]_0 ;
  output \SIPO_reg[0][6]_1 ;
  output reset_n_0;
  output [5:0]\SIPO_reg[0][5]_0 ;
  output [31:0]\SIPO_reg[1][7]_0 ;
  input [4:0]Q;
  input \FSM_onehot_state_reg[0] ;
  input \FSM_onehot_state_reg[0]_0 ;
  input \FSM_onehot_state_reg[0]_1 ;
  input rx_ready;
  input m_axi_rvalid;
  input \tx_data_in_reg[0] ;
  input [7:0]rx_data;
  input w_done;
  input w_done_reg;
  input aw_done;
  input aw_done_reg;
  input reset_n;
  input clk;

  wire [3:0]D;
  wire [0:0]E;
  wire \FSM_onehot_state[5]_i_2_n_0 ;
  wire \FSM_onehot_state_reg[0] ;
  wire \FSM_onehot_state_reg[0]_0 ;
  wire \FSM_onehot_state_reg[0]_1 ;
  wire \FSM_sequential_byte_counter[0]_i_1_n_0 ;
  wire \FSM_sequential_byte_counter[1]_i_1_n_0 ;
  wire \FSM_sequential_byte_counter[2]_i_1_n_0 ;
  wire [4:0]Q;
  wire SIPO;
  wire [7:0]SIPO0_in;
  wire \SIPO[0][7]_i_1_n_0 ;
  wire \SIPO[1][7]_i_1_n_0 ;
  wire \SIPO[2][7]_i_1_n_0 ;
  wire \SIPO[3][7]_i_1_n_0 ;
  wire \SIPO[4][0]_i_1_n_0 ;
  wire \SIPO[4][1]_i_1_n_0 ;
  wire \SIPO[4][2]_i_1_n_0 ;
  wire \SIPO[4][3]_i_1_n_0 ;
  wire \SIPO[4][4]_i_1_n_0 ;
  wire \SIPO[4][5]_i_1_n_0 ;
  wire \SIPO[4][6]_i_1_n_0 ;
  wire \SIPO[4][7]_i_2_n_0 ;
  wire [5:0]\SIPO_reg[0][5]_0 ;
  wire \SIPO_reg[0][6]_0 ;
  wire \SIPO_reg[0][6]_1 ;
  wire [0:0]\SIPO_reg[0][7]_0 ;
  wire [31:0]\SIPO_reg[1][7]_0 ;
  wire aw_done;
  wire aw_done_reg;
  wire [2:0]byte_counter__0;
  wire clk;
  wire m_axi_rvalid;
  wire [1:0]p_1_in;
  wire reset_n;
  wire reset_n_0;
  wire [7:0]rx_data;
  wire rx_ready;
  wire \tx_data_in_reg[0] ;
  wire uart_addr_reg_0;
  wire w_done;
  wire w_done_reg;

  LUT6 #(
    .INIT(64'hEFEEEEEEEEEEEEEE)) 
    \FSM_onehot_state[0]_i_1 
       (.I0(Q[4]),
        .I1(Q[2]),
        .I2(\FSM_onehot_state[5]_i_2_n_0 ),
        .I3(Q[0]),
        .I4(p_1_in[1]),
        .I5(p_1_in[0]),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hF01010F0F0F0F0F0)) 
    \FSM_onehot_state[1]_i_1 
       (.I0(p_1_in[0]),
        .I1(p_1_in[1]),
        .I2(Q[0]),
        .I3(byte_counter__0[1]),
        .I4(byte_counter__0[0]),
        .I5(byte_counter__0[2]),
        .O(D[1]));
  LUT6 #(
    .INIT(64'h0000080008000000)) 
    \FSM_onehot_state[3]_i_1 
       (.I0(p_1_in[0]),
        .I1(Q[0]),
        .I2(p_1_in[1]),
        .I3(byte_counter__0[2]),
        .I4(byte_counter__0[0]),
        .I5(byte_counter__0[1]),
        .O(D[2]));
  LUT5 #(
    .INIT(32'hFFFF0040)) 
    \FSM_onehot_state[5]_i_1 
       (.I0(\FSM_onehot_state[5]_i_2_n_0 ),
        .I1(Q[0]),
        .I2(p_1_in[1]),
        .I3(p_1_in[0]),
        .I4(Q[1]),
        .O(D[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h9F)) 
    \FSM_onehot_state[5]_i_2 
       (.I0(byte_counter__0[1]),
        .I1(byte_counter__0[0]),
        .I2(byte_counter__0[2]),
        .O(\FSM_onehot_state[5]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_onehot_state[6]_i_1 
       (.I0(Q[3]),
        .I1(uart_addr_reg_0),
        .I2(\FSM_onehot_state_reg[0] ),
        .I3(\FSM_onehot_state_reg[0]_0 ),
        .I4(\FSM_onehot_state_reg[0]_1 ),
        .O(E));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hD21A)) 
    \FSM_sequential_byte_counter[0]_i_1 
       (.I0(rx_ready),
        .I1(byte_counter__0[2]),
        .I2(byte_counter__0[0]),
        .I3(byte_counter__0[1]),
        .O(\FSM_sequential_byte_counter[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hD3E0)) 
    \FSM_sequential_byte_counter[1]_i_1 
       (.I0(rx_ready),
        .I1(byte_counter__0[2]),
        .I2(byte_counter__0[0]),
        .I3(byte_counter__0[1]),
        .O(\FSM_sequential_byte_counter[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF00000FF00FFB0)) 
    \FSM_sequential_byte_counter[2]_i_1 
       (.I0(rx_data[7]),
        .I1(rx_data[6]),
        .I2(rx_ready),
        .I3(byte_counter__0[2]),
        .I4(byte_counter__0[0]),
        .I5(byte_counter__0[1]),
        .O(\FSM_sequential_byte_counter[2]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:010,iSTATE1:011,iSTATE2:100,iSTATE3:110,iSTATE4:001,iSTATE5:101" *) 
  FDCE \FSM_sequential_byte_counter_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(reset_n_0),
        .D(\FSM_sequential_byte_counter[0]_i_1_n_0 ),
        .Q(byte_counter__0[0]));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:010,iSTATE1:011,iSTATE2:100,iSTATE3:110,iSTATE4:001,iSTATE5:101" *) 
  FDCE \FSM_sequential_byte_counter_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(reset_n_0),
        .D(\FSM_sequential_byte_counter[1]_i_1_n_0 ),
        .Q(byte_counter__0[1]));
  (* FSM_ENCODED_STATES = "iSTATE:000,iSTATE0:010,iSTATE1:011,iSTATE2:100,iSTATE3:110,iSTATE4:001,iSTATE5:101" *) 
  FDCE \FSM_sequential_byte_counter_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(reset_n_0),
        .D(\FSM_sequential_byte_counter[2]_i_1_n_0 ),
        .Q(byte_counter__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[0][0]_i_1 
       (.I0(rx_data[0]),
        .I1(byte_counter__0[2]),
        .O(SIPO0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[0][1]_i_1 
       (.I0(rx_data[1]),
        .I1(byte_counter__0[2]),
        .O(SIPO0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[0][2]_i_1 
       (.I0(rx_data[2]),
        .I1(byte_counter__0[2]),
        .O(SIPO0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[0][3]_i_1 
       (.I0(rx_data[3]),
        .I1(byte_counter__0[2]),
        .O(SIPO0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[0][4]_i_1 
       (.I0(rx_data[4]),
        .I1(byte_counter__0[2]),
        .O(SIPO0_in[4]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[0][5]_i_1 
       (.I0(rx_data[5]),
        .I1(byte_counter__0[2]),
        .O(SIPO0_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[0][6]_i_1 
       (.I0(rx_data[6]),
        .I1(byte_counter__0[2]),
        .O(SIPO0_in[6]));
  LUT4 #(
    .INIT(16'h3002)) 
    \SIPO[0][7]_i_1 
       (.I0(rx_ready),
        .I1(byte_counter__0[0]),
        .I2(byte_counter__0[1]),
        .I3(byte_counter__0[2]),
        .O(\SIPO[0][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[0][7]_i_2 
       (.I0(rx_data[7]),
        .I1(byte_counter__0[2]),
        .O(SIPO0_in[7]));
  LUT4 #(
    .INIT(16'h3008)) 
    \SIPO[1][7]_i_1 
       (.I0(rx_ready),
        .I1(byte_counter__0[0]),
        .I2(byte_counter__0[1]),
        .I3(byte_counter__0[2]),
        .O(\SIPO[1][7]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h3020)) 
    \SIPO[2][7]_i_1 
       (.I0(rx_ready),
        .I1(byte_counter__0[0]),
        .I2(byte_counter__0[1]),
        .I3(byte_counter__0[2]),
        .O(\SIPO[2][7]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h3080)) 
    \SIPO[3][7]_i_1 
       (.I0(rx_ready),
        .I1(byte_counter__0[0]),
        .I2(byte_counter__0[1]),
        .I3(byte_counter__0[2]),
        .O(\SIPO[3][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[4][0]_i_1 
       (.I0(rx_data[0]),
        .I1(byte_counter__0[1]),
        .O(\SIPO[4][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[4][1]_i_1 
       (.I0(rx_data[1]),
        .I1(byte_counter__0[1]),
        .O(\SIPO[4][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[4][2]_i_1 
       (.I0(rx_data[2]),
        .I1(byte_counter__0[1]),
        .O(\SIPO[4][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[4][3]_i_1 
       (.I0(rx_data[3]),
        .I1(byte_counter__0[1]),
        .O(\SIPO[4][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[4][4]_i_1 
       (.I0(rx_data[4]),
        .I1(byte_counter__0[1]),
        .O(\SIPO[4][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[4][5]_i_1 
       (.I0(rx_data[5]),
        .I1(byte_counter__0[1]),
        .O(\SIPO[4][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[4][6]_i_1 
       (.I0(rx_data[6]),
        .I1(byte_counter__0[1]),
        .O(\SIPO[4][6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h3200)) 
    \SIPO[4][7]_i_1 
       (.I0(rx_ready),
        .I1(byte_counter__0[0]),
        .I2(byte_counter__0[1]),
        .I3(byte_counter__0[2]),
        .O(SIPO));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \SIPO[4][7]_i_2 
       (.I0(rx_data[7]),
        .I1(byte_counter__0[1]),
        .O(\SIPO[4][7]_i_2_n_0 ));
  FDCE \SIPO_reg[0][0] 
       (.C(clk),
        .CE(\SIPO[0][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[0]),
        .Q(\SIPO_reg[0][5]_0 [0]));
  FDCE \SIPO_reg[0][1] 
       (.C(clk),
        .CE(\SIPO[0][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[1]),
        .Q(\SIPO_reg[0][5]_0 [1]));
  FDCE \SIPO_reg[0][2] 
       (.C(clk),
        .CE(\SIPO[0][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[2]),
        .Q(\SIPO_reg[0][5]_0 [2]));
  FDCE \SIPO_reg[0][3] 
       (.C(clk),
        .CE(\SIPO[0][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[3]),
        .Q(\SIPO_reg[0][5]_0 [3]));
  FDCE \SIPO_reg[0][4] 
       (.C(clk),
        .CE(\SIPO[0][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[4]),
        .Q(\SIPO_reg[0][5]_0 [4]));
  FDCE \SIPO_reg[0][5] 
       (.C(clk),
        .CE(\SIPO[0][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[5]),
        .Q(\SIPO_reg[0][5]_0 [5]));
  FDCE \SIPO_reg[0][6] 
       (.C(clk),
        .CE(\SIPO[0][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[6]),
        .Q(p_1_in[0]));
  FDCE \SIPO_reg[0][7] 
       (.C(clk),
        .CE(\SIPO[0][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[7]),
        .Q(p_1_in[1]));
  FDCE \SIPO_reg[1][0] 
       (.C(clk),
        .CE(\SIPO[1][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[0]),
        .Q(\SIPO_reg[1][7]_0 [24]));
  FDCE \SIPO_reg[1][1] 
       (.C(clk),
        .CE(\SIPO[1][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[1]),
        .Q(\SIPO_reg[1][7]_0 [25]));
  FDCE \SIPO_reg[1][2] 
       (.C(clk),
        .CE(\SIPO[1][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[2]),
        .Q(\SIPO_reg[1][7]_0 [26]));
  FDCE \SIPO_reg[1][3] 
       (.C(clk),
        .CE(\SIPO[1][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[3]),
        .Q(\SIPO_reg[1][7]_0 [27]));
  FDCE \SIPO_reg[1][4] 
       (.C(clk),
        .CE(\SIPO[1][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[4]),
        .Q(\SIPO_reg[1][7]_0 [28]));
  FDCE \SIPO_reg[1][5] 
       (.C(clk),
        .CE(\SIPO[1][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[5]),
        .Q(\SIPO_reg[1][7]_0 [29]));
  FDCE \SIPO_reg[1][6] 
       (.C(clk),
        .CE(\SIPO[1][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[6]),
        .Q(\SIPO_reg[1][7]_0 [30]));
  FDCE \SIPO_reg[1][7] 
       (.C(clk),
        .CE(\SIPO[1][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[7]),
        .Q(\SIPO_reg[1][7]_0 [31]));
  FDCE \SIPO_reg[2][0] 
       (.C(clk),
        .CE(\SIPO[2][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[0]),
        .Q(\SIPO_reg[1][7]_0 [16]));
  FDCE \SIPO_reg[2][1] 
       (.C(clk),
        .CE(\SIPO[2][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[1]),
        .Q(\SIPO_reg[1][7]_0 [17]));
  FDCE \SIPO_reg[2][2] 
       (.C(clk),
        .CE(\SIPO[2][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[2]),
        .Q(\SIPO_reg[1][7]_0 [18]));
  FDCE \SIPO_reg[2][3] 
       (.C(clk),
        .CE(\SIPO[2][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[3]),
        .Q(\SIPO_reg[1][7]_0 [19]));
  FDCE \SIPO_reg[2][4] 
       (.C(clk),
        .CE(\SIPO[2][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[4]),
        .Q(\SIPO_reg[1][7]_0 [20]));
  FDCE \SIPO_reg[2][5] 
       (.C(clk),
        .CE(\SIPO[2][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[5]),
        .Q(\SIPO_reg[1][7]_0 [21]));
  FDCE \SIPO_reg[2][6] 
       (.C(clk),
        .CE(\SIPO[2][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[6]),
        .Q(\SIPO_reg[1][7]_0 [22]));
  FDCE \SIPO_reg[2][7] 
       (.C(clk),
        .CE(\SIPO[2][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[7]),
        .Q(\SIPO_reg[1][7]_0 [23]));
  FDCE \SIPO_reg[3][0] 
       (.C(clk),
        .CE(\SIPO[3][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[0]),
        .Q(\SIPO_reg[1][7]_0 [8]));
  FDCE \SIPO_reg[3][1] 
       (.C(clk),
        .CE(\SIPO[3][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[1]),
        .Q(\SIPO_reg[1][7]_0 [9]));
  FDCE \SIPO_reg[3][2] 
       (.C(clk),
        .CE(\SIPO[3][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[2]),
        .Q(\SIPO_reg[1][7]_0 [10]));
  FDCE \SIPO_reg[3][3] 
       (.C(clk),
        .CE(\SIPO[3][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[3]),
        .Q(\SIPO_reg[1][7]_0 [11]));
  FDCE \SIPO_reg[3][4] 
       (.C(clk),
        .CE(\SIPO[3][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[4]),
        .Q(\SIPO_reg[1][7]_0 [12]));
  FDCE \SIPO_reg[3][5] 
       (.C(clk),
        .CE(\SIPO[3][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[5]),
        .Q(\SIPO_reg[1][7]_0 [13]));
  FDCE \SIPO_reg[3][6] 
       (.C(clk),
        .CE(\SIPO[3][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[6]),
        .Q(\SIPO_reg[1][7]_0 [14]));
  FDCE \SIPO_reg[3][7] 
       (.C(clk),
        .CE(\SIPO[3][7]_i_1_n_0 ),
        .CLR(reset_n_0),
        .D(SIPO0_in[7]),
        .Q(\SIPO_reg[1][7]_0 [15]));
  FDCE \SIPO_reg[4][0] 
       (.C(clk),
        .CE(SIPO),
        .CLR(reset_n_0),
        .D(\SIPO[4][0]_i_1_n_0 ),
        .Q(\SIPO_reg[1][7]_0 [0]));
  FDCE \SIPO_reg[4][1] 
       (.C(clk),
        .CE(SIPO),
        .CLR(reset_n_0),
        .D(\SIPO[4][1]_i_1_n_0 ),
        .Q(\SIPO_reg[1][7]_0 [1]));
  FDCE \SIPO_reg[4][2] 
       (.C(clk),
        .CE(SIPO),
        .CLR(reset_n_0),
        .D(\SIPO[4][2]_i_1_n_0 ),
        .Q(\SIPO_reg[1][7]_0 [2]));
  FDCE \SIPO_reg[4][3] 
       (.C(clk),
        .CE(SIPO),
        .CLR(reset_n_0),
        .D(\SIPO[4][3]_i_1_n_0 ),
        .Q(\SIPO_reg[1][7]_0 [3]));
  FDCE \SIPO_reg[4][4] 
       (.C(clk),
        .CE(SIPO),
        .CLR(reset_n_0),
        .D(\SIPO[4][4]_i_1_n_0 ),
        .Q(\SIPO_reg[1][7]_0 [4]));
  FDCE \SIPO_reg[4][5] 
       (.C(clk),
        .CE(SIPO),
        .CLR(reset_n_0),
        .D(\SIPO[4][5]_i_1_n_0 ),
        .Q(\SIPO_reg[1][7]_0 [5]));
  FDCE \SIPO_reg[4][6] 
       (.C(clk),
        .CE(SIPO),
        .CLR(reset_n_0),
        .D(\SIPO[4][6]_i_1_n_0 ),
        .Q(\SIPO_reg[1][7]_0 [6]));
  FDCE \SIPO_reg[4][7] 
       (.C(clk),
        .CE(SIPO),
        .CLR(reset_n_0),
        .D(\SIPO[4][7]_i_2_n_0 ),
        .Q(\SIPO_reg[1][7]_0 [7]));
  LUT5 #(
    .INIT(32'hFFF7FF00)) 
    aw_done_i_1
       (.I0(uart_addr_reg_0),
        .I1(p_1_in[0]),
        .I2(p_1_in[1]),
        .I3(aw_done),
        .I4(aw_done_reg),
        .O(\SIPO_reg[0][6]_1 ));
  LUT1 #(
    .INIT(2'h1)) 
    \m_axi_awaddr[5]_i_1 
       (.I0(reset_n),
        .O(reset_n_0));
  LUT6 #(
    .INIT(64'hFF08080808080808)) 
    \tx_data_in[31]_i_1 
       (.I0(uart_addr_reg_0),
        .I1(p_1_in[1]),
        .I2(p_1_in[0]),
        .I3(Q[1]),
        .I4(m_axi_rvalid),
        .I5(\tx_data_in_reg[0] ),
        .O(\SIPO_reg[0][7]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \uart_addr_reg[5]_i_1 
       (.I0(byte_counter__0[0]),
        .I1(byte_counter__0[1]),
        .I2(byte_counter__0[2]),
        .I3(Q[0]),
        .O(uart_addr_reg_0));
  LUT5 #(
    .INIT(32'hFFF7FF00)) 
    w_done_i_1
       (.I0(uart_addr_reg_0),
        .I1(p_1_in[0]),
        .I2(p_1_in[1]),
        .I3(w_done),
        .I4(w_done_reg),
        .O(\SIPO_reg[0][6]_0 ));
endmodule

(* ORIG_REF_NAME = "UART_TRANSACTION_HANDLER" *) 
module design_2_UART_TRANSACTION_HAN_0_0_UART_TRANSACTION_HANDLER
   (m_axi_arvalid,
    m_axi_awaddr,
    m_axi_wdata,
    m_axi_wstrb,
    m_axi_araddr,
    Word_To_Send_en,
    m_axi_awvalid,
    m_axi_wvalid,
    m_axi_rready_reg_0,
    m_axi_bready,
    Word_To_Send,
    rx_data,
    rx_ready,
    clk,
    uart_tx_ready,
    m_axi_awready,
    m_axi_wready,
    m_axi_rvalid,
    m_axi_arready,
    m_axi_bvalid,
    m_axi_rresp,
    m_axi_rdata,
    max_angle,
    reset_n);
  output m_axi_arvalid;
  output [5:0]m_axi_awaddr;
  output [31:0]m_axi_wdata;
  output [0:0]m_axi_wstrb;
  output [5:0]m_axi_araddr;
  output Word_To_Send_en;
  output m_axi_awvalid;
  output m_axi_wvalid;
  output m_axi_rready_reg_0;
  output m_axi_bready;
  output [7:0]Word_To_Send;
  input [7:0]rx_data;
  input rx_ready;
  input clk;
  input uart_tx_ready;
  input m_axi_awready;
  input m_axi_wready;
  input m_axi_rvalid;
  input m_axi_arready;
  input m_axi_bvalid;
  input [1:0]m_axi_rresp;
  input [31:0]m_axi_rdata;
  input [31:0]max_angle;
  input reset_n;

  wire \FSM_onehot_state[6]_i_3_n_0 ;
  wire \FSM_onehot_state[6]_i_4_n_0 ;
  wire \FSM_onehot_state_reg_n_0_[0] ;
  wire \FSM_onehot_state_reg_n_0_[1] ;
  wire \FSM_onehot_state_reg_n_0_[2] ;
  wire \FSM_onehot_state_reg_n_0_[3] ;
  wire \FSM_onehot_state_reg_n_0_[4] ;
  wire \FSM_onehot_state_reg_n_0_[6] ;
  wire [7:0]\SIPO_reg[1] ;
  wire [7:0]\SIPO_reg[2] ;
  wire [7:0]\SIPO_reg[3] ;
  wire [7:0]\SIPO_reg[4] ;
  wire UART_RX_DECODER_inst_n_0;
  wire UART_RX_DECODER_inst_n_2;
  wire UART_RX_DECODER_inst_n_3;
  wire UART_RX_DECODER_inst_n_4;
  wire UART_RX_DECODER_inst_n_5;
  wire UART_RX_DECODER_inst_n_6;
  wire UART_RX_DECODER_inst_n_7;
  wire UART_RX_DECODER_inst_n_8;
  wire UART_RX_DECODER_inst_n_9;
  wire UART_TX_ENCODER_inst_n_0;
  wire [7:0]Word_To_Send;
  wire Word_To_Send_en;
  wire aw_done;
  wire aw_done_reg_n_0;
  wire clk;
  wire [5:0]m_axi_araddr;
  wire m_axi_arready;
  wire m_axi_arvalid;
  wire m_axi_arvalid_i_1_n_0;
  wire [5:0]m_axi_awaddr;
  wire m_axi_awready;
  wire m_axi_awvalid;
  wire m_axi_awvalid_i_1_n_0;
  wire m_axi_bready;
  wire m_axi_bready_i_1_n_0;
  wire m_axi_bvalid;
  wire [31:0]m_axi_rdata;
  wire m_axi_rready_i_1_n_0;
  wire m_axi_rready_reg_0;
  wire [1:0]m_axi_rresp;
  wire m_axi_rvalid;
  wire [31:0]m_axi_wdata;
  wire m_axi_wready;
  wire [0:0]m_axi_wstrb;
  wire m_axi_wvalid;
  wire m_axi_wvalid_i_1_n_0;
  wire [31:0]max_angle;
  wire reset_n;
  wire [7:0]rx_data;
  wire rx_ready;
  wire [31:0]tx_data_in;
  wire \tx_data_in[0]_i_1_n_0 ;
  wire \tx_data_in[10]_i_1_n_0 ;
  wire \tx_data_in[11]_i_1_n_0 ;
  wire \tx_data_in[12]_i_1_n_0 ;
  wire \tx_data_in[13]_i_1_n_0 ;
  wire \tx_data_in[14]_i_1_n_0 ;
  wire \tx_data_in[15]_i_1_n_0 ;
  wire \tx_data_in[16]_i_1_n_0 ;
  wire \tx_data_in[17]_i_1_n_0 ;
  wire \tx_data_in[18]_i_1_n_0 ;
  wire \tx_data_in[19]_i_1_n_0 ;
  wire \tx_data_in[1]_i_1_n_0 ;
  wire \tx_data_in[20]_i_1_n_0 ;
  wire \tx_data_in[21]_i_1_n_0 ;
  wire \tx_data_in[22]_i_1_n_0 ;
  wire \tx_data_in[23]_i_1_n_0 ;
  wire \tx_data_in[24]_i_1_n_0 ;
  wire \tx_data_in[25]_i_1_n_0 ;
  wire \tx_data_in[26]_i_1_n_0 ;
  wire \tx_data_in[27]_i_1_n_0 ;
  wire \tx_data_in[28]_i_1_n_0 ;
  wire \tx_data_in[29]_i_1_n_0 ;
  wire \tx_data_in[2]_i_1_n_0 ;
  wire \tx_data_in[30]_i_1_n_0 ;
  wire \tx_data_in[31]_i_2_n_0 ;
  wire \tx_data_in[3]_i_1_n_0 ;
  wire \tx_data_in[4]_i_1_n_0 ;
  wire \tx_data_in[5]_i_1_n_0 ;
  wire \tx_data_in[6]_i_1_n_0 ;
  wire \tx_data_in[7]_i_1_n_0 ;
  wire \tx_data_in[8]_i_1_n_0 ;
  wire \tx_data_in[9]_i_1_n_0 ;
  wire tx_start;
  wire tx_start_i_1_n_0;
  wire tx_start_reg_n_0;
  wire [5:0]uart_addr;
  wire [5:0]uart_addr_reg;
  wire uart_addr_reg_0;
  wire [31:0]uart_data_reg;
  wire uart_tx_ready;
  wire w_done;
  wire w_done_reg_n_0;

  LUT6 #(
    .INIT(64'hFF80808080808080)) 
    \FSM_onehot_state[6]_i_3 
       (.I0(\FSM_onehot_state_reg_n_0_[4] ),
        .I1(m_axi_bvalid),
        .I2(m_axi_bready),
        .I3(\FSM_onehot_state_reg_n_0_[3] ),
        .I4(aw_done_reg_n_0),
        .I5(w_done_reg_n_0),
        .O(\FSM_onehot_state[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFF80808080808080)) 
    \FSM_onehot_state[6]_i_4 
       (.I0(\FSM_onehot_state_reg_n_0_[2] ),
        .I1(m_axi_rvalid),
        .I2(m_axi_rready_reg_0),
        .I3(m_axi_arvalid),
        .I4(m_axi_arready),
        .I5(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\FSM_onehot_state[6]_i_4_n_0 ));
  (* FSM_ENCODED_STATES = "AXI_READ_DATA:0000100,AXI_WRITE_RESP:0010000,UART_WAIT:1000000,IDLE:0000001,UART_SEND:0100000,AXI_WRITE:0001000,AXI_READ_ADDR:0000010" *) 
  FDPE #(
    .INIT(1'b1)) 
    \FSM_onehot_state_reg[0] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_0),
        .D(UART_RX_DECODER_inst_n_6),
        .PRE(UART_RX_DECODER_inst_n_9),
        .Q(\FSM_onehot_state_reg_n_0_[0] ));
  (* FSM_ENCODED_STATES = "AXI_READ_DATA:0000100,AXI_WRITE_RESP:0010000,UART_WAIT:1000000,IDLE:0000001,UART_SEND:0100000,AXI_WRITE:0001000,AXI_READ_ADDR:0000010" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[1] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(UART_RX_DECODER_inst_n_5),
        .Q(\FSM_onehot_state_reg_n_0_[1] ));
  (* FSM_ENCODED_STATES = "AXI_READ_DATA:0000100,AXI_WRITE_RESP:0010000,UART_WAIT:1000000,IDLE:0000001,UART_SEND:0100000,AXI_WRITE:0001000,AXI_READ_ADDR:0000010" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[2] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\FSM_onehot_state_reg_n_0_[1] ),
        .Q(\FSM_onehot_state_reg_n_0_[2] ));
  (* FSM_ENCODED_STATES = "AXI_READ_DATA:0000100,AXI_WRITE_RESP:0010000,UART_WAIT:1000000,IDLE:0000001,UART_SEND:0100000,AXI_WRITE:0001000,AXI_READ_ADDR:0000010" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[3] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(UART_RX_DECODER_inst_n_4),
        .Q(\FSM_onehot_state_reg_n_0_[3] ));
  (* FSM_ENCODED_STATES = "AXI_READ_DATA:0000100,AXI_WRITE_RESP:0010000,UART_WAIT:1000000,IDLE:0000001,UART_SEND:0100000,AXI_WRITE:0001000,AXI_READ_ADDR:0000010" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[4] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\FSM_onehot_state_reg_n_0_[3] ),
        .Q(\FSM_onehot_state_reg_n_0_[4] ));
  (* FSM_ENCODED_STATES = "AXI_READ_DATA:0000100,AXI_WRITE_RESP:0010000,UART_WAIT:1000000,IDLE:0000001,UART_SEND:0100000,AXI_WRITE:0001000,AXI_READ_ADDR:0000010" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[5] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(UART_RX_DECODER_inst_n_3),
        .Q(tx_start));
  (* FSM_ENCODED_STATES = "AXI_READ_DATA:0000100,AXI_WRITE_RESP:0010000,UART_WAIT:1000000,IDLE:0000001,UART_SEND:0100000,AXI_WRITE:0001000,AXI_READ_ADDR:0000010" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[6] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(tx_start),
        .Q(\FSM_onehot_state_reg_n_0_[6] ));
  design_2_UART_TRANSACTION_HAN_0_0_UART_RX_DECODER UART_RX_DECODER_inst
       (.D({UART_RX_DECODER_inst_n_3,UART_RX_DECODER_inst_n_4,UART_RX_DECODER_inst_n_5,UART_RX_DECODER_inst_n_6}),
        .E(UART_RX_DECODER_inst_n_0),
        .\FSM_onehot_state_reg[0] (UART_TX_ENCODER_inst_n_0),
        .\FSM_onehot_state_reg[0]_0 (\FSM_onehot_state[6]_i_3_n_0 ),
        .\FSM_onehot_state_reg[0]_1 (\FSM_onehot_state[6]_i_4_n_0 ),
        .Q({\FSM_onehot_state_reg_n_0_[6] ,tx_start,\FSM_onehot_state_reg_n_0_[4] ,\FSM_onehot_state_reg_n_0_[2] ,\FSM_onehot_state_reg_n_0_[0] }),
        .\SIPO_reg[0][5]_0 (uart_addr),
        .\SIPO_reg[0][6]_0 (UART_RX_DECODER_inst_n_7),
        .\SIPO_reg[0][6]_1 (UART_RX_DECODER_inst_n_8),
        .\SIPO_reg[0][7]_0 (UART_RX_DECODER_inst_n_2),
        .\SIPO_reg[1][7]_0 ({\SIPO_reg[1] ,\SIPO_reg[2] ,\SIPO_reg[3] ,\SIPO_reg[4] }),
        .aw_done(aw_done),
        .aw_done_reg(aw_done_reg_n_0),
        .clk(clk),
        .m_axi_rvalid(m_axi_rvalid),
        .reset_n(reset_n),
        .reset_n_0(UART_RX_DECODER_inst_n_9),
        .rx_data(rx_data),
        .rx_ready(rx_ready),
        .\tx_data_in_reg[0] (m_axi_rready_reg_0),
        .uart_addr_reg_0(uart_addr_reg_0),
        .w_done(w_done),
        .w_done_reg(w_done_reg_n_0));
  design_2_UART_TRANSACTION_HAN_0_0_UART_TX_ENCODER UART_TX_ENCODER_inst
       (.\PISO_reg[0][7]_0 (tx_data_in),
        .\PISO_reg[0][8]_0 (UART_RX_DECODER_inst_n_9),
        .\PISO_reg[1][8]_0 (UART_TX_ENCODER_inst_n_0),
        .\PISO_reg[3][8]_0 (tx_start_reg_n_0),
        .Q(\FSM_onehot_state_reg_n_0_[6] ),
        .Word_To_Send(Word_To_Send),
        .Word_To_Send_en(Word_To_Send_en),
        .clk(clk),
        .uart_tx_ready(uart_tx_ready));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'h80)) 
    aw_done_i_2
       (.I0(\FSM_onehot_state_reg_n_0_[3] ),
        .I1(m_axi_awready),
        .I2(m_axi_awvalid),
        .O(aw_done));
  FDCE aw_done_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(UART_RX_DECODER_inst_n_8),
        .Q(aw_done_reg_n_0));
  FDCE \m_axi_araddr_reg[0] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[1] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr_reg[0]),
        .Q(m_axi_araddr[0]));
  FDCE \m_axi_araddr_reg[1] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[1] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr_reg[1]),
        .Q(m_axi_araddr[1]));
  FDCE \m_axi_araddr_reg[2] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[1] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr_reg[2]),
        .Q(m_axi_araddr[2]));
  FDCE \m_axi_araddr_reg[3] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[1] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr_reg[3]),
        .Q(m_axi_araddr[3]));
  FDCE \m_axi_araddr_reg[4] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[1] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr_reg[4]),
        .Q(m_axi_araddr[4]));
  FDCE \m_axi_araddr_reg[5] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[1] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr_reg[5]),
        .Q(m_axi_araddr[5]));
  LUT2 #(
    .INIT(4'h7)) 
    m_axi_arvalid_i_1
       (.I0(m_axi_arvalid),
        .I1(m_axi_arready),
        .O(m_axi_arvalid_i_1_n_0));
  FDCE m_axi_arvalid_reg
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[1] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(m_axi_arvalid_i_1_n_0),
        .Q(m_axi_arvalid));
  FDCE \m_axi_awaddr_reg[0] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr_reg[0]),
        .Q(m_axi_awaddr[0]));
  FDCE \m_axi_awaddr_reg[1] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr_reg[1]),
        .Q(m_axi_awaddr[1]));
  FDCE \m_axi_awaddr_reg[2] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr_reg[2]),
        .Q(m_axi_awaddr[2]));
  FDCE \m_axi_awaddr_reg[3] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr_reg[3]),
        .Q(m_axi_awaddr[3]));
  FDCE \m_axi_awaddr_reg[4] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr_reg[4]),
        .Q(m_axi_awaddr[4]));
  FDCE \m_axi_awaddr_reg[5] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr_reg[5]),
        .Q(m_axi_awaddr[5]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT4 #(
    .INIT(16'h27AA)) 
    m_axi_awvalid_i_1
       (.I0(m_axi_awvalid),
        .I1(m_axi_awready),
        .I2(aw_done_reg_n_0),
        .I3(\FSM_onehot_state_reg_n_0_[3] ),
        .O(m_axi_awvalid_i_1_n_0));
  FDCE m_axi_awvalid_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(m_axi_awvalid_i_1_n_0),
        .Q(m_axi_awvalid));
  LUT6 #(
    .INIT(64'hFF70707070707070)) 
    m_axi_bready_i_1
       (.I0(\FSM_onehot_state_reg_n_0_[4] ),
        .I1(m_axi_bvalid),
        .I2(m_axi_bready),
        .I3(\FSM_onehot_state_reg_n_0_[3] ),
        .I4(aw_done_reg_n_0),
        .I5(w_done_reg_n_0),
        .O(m_axi_bready_i_1_n_0));
  FDCE m_axi_bready_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(m_axi_bready_i_1_n_0),
        .Q(m_axi_bready));
  LUT6 #(
    .INIT(64'hFF70707070707070)) 
    m_axi_rready_i_1
       (.I0(\FSM_onehot_state_reg_n_0_[2] ),
        .I1(m_axi_rvalid),
        .I2(m_axi_rready_reg_0),
        .I3(m_axi_arvalid),
        .I4(m_axi_arready),
        .I5(\FSM_onehot_state_reg_n_0_[1] ),
        .O(m_axi_rready_i_1_n_0));
  FDCE m_axi_rready_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(m_axi_rready_i_1_n_0),
        .Q(m_axi_rready_reg_0));
  FDCE \m_axi_wdata_reg[0] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[0]),
        .Q(m_axi_wdata[0]));
  FDCE \m_axi_wdata_reg[10] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[10]),
        .Q(m_axi_wdata[10]));
  FDCE \m_axi_wdata_reg[11] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[11]),
        .Q(m_axi_wdata[11]));
  FDCE \m_axi_wdata_reg[12] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[12]),
        .Q(m_axi_wdata[12]));
  FDCE \m_axi_wdata_reg[13] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[13]),
        .Q(m_axi_wdata[13]));
  FDCE \m_axi_wdata_reg[14] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[14]),
        .Q(m_axi_wdata[14]));
  FDCE \m_axi_wdata_reg[15] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[15]),
        .Q(m_axi_wdata[15]));
  FDCE \m_axi_wdata_reg[16] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[16]),
        .Q(m_axi_wdata[16]));
  FDCE \m_axi_wdata_reg[17] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[17]),
        .Q(m_axi_wdata[17]));
  FDCE \m_axi_wdata_reg[18] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[18]),
        .Q(m_axi_wdata[18]));
  FDCE \m_axi_wdata_reg[19] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[19]),
        .Q(m_axi_wdata[19]));
  FDCE \m_axi_wdata_reg[1] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[1]),
        .Q(m_axi_wdata[1]));
  FDCE \m_axi_wdata_reg[20] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[20]),
        .Q(m_axi_wdata[20]));
  FDCE \m_axi_wdata_reg[21] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[21]),
        .Q(m_axi_wdata[21]));
  FDCE \m_axi_wdata_reg[22] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[22]),
        .Q(m_axi_wdata[22]));
  FDCE \m_axi_wdata_reg[23] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[23]),
        .Q(m_axi_wdata[23]));
  FDCE \m_axi_wdata_reg[24] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[24]),
        .Q(m_axi_wdata[24]));
  FDCE \m_axi_wdata_reg[25] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[25]),
        .Q(m_axi_wdata[25]));
  FDCE \m_axi_wdata_reg[26] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[26]),
        .Q(m_axi_wdata[26]));
  FDCE \m_axi_wdata_reg[27] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[27]),
        .Q(m_axi_wdata[27]));
  FDCE \m_axi_wdata_reg[28] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[28]),
        .Q(m_axi_wdata[28]));
  FDCE \m_axi_wdata_reg[29] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[29]),
        .Q(m_axi_wdata[29]));
  FDCE \m_axi_wdata_reg[2] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[2]),
        .Q(m_axi_wdata[2]));
  FDCE \m_axi_wdata_reg[30] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[30]),
        .Q(m_axi_wdata[30]));
  FDCE \m_axi_wdata_reg[31] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[31]),
        .Q(m_axi_wdata[31]));
  FDCE \m_axi_wdata_reg[3] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[3]),
        .Q(m_axi_wdata[3]));
  FDCE \m_axi_wdata_reg[4] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[4]),
        .Q(m_axi_wdata[4]));
  FDCE \m_axi_wdata_reg[5] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[5]),
        .Q(m_axi_wdata[5]));
  FDCE \m_axi_wdata_reg[6] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[6]),
        .Q(m_axi_wdata[6]));
  FDCE \m_axi_wdata_reg[7] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[7]),
        .Q(m_axi_wdata[7]));
  FDCE \m_axi_wdata_reg[8] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[8]),
        .Q(m_axi_wdata[8]));
  FDCE \m_axi_wdata_reg[9] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_data_reg[9]),
        .Q(m_axi_wdata[9]));
  FDCE \m_axi_wstrb_reg[3] 
       (.C(clk),
        .CE(\FSM_onehot_state_reg_n_0_[3] ),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(1'b1),
        .Q(m_axi_wstrb));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT4 #(
    .INIT(16'h27AA)) 
    m_axi_wvalid_i_1
       (.I0(m_axi_wvalid),
        .I1(m_axi_wready),
        .I2(w_done_reg_n_0),
        .I3(\FSM_onehot_state_reg_n_0_[3] ),
        .O(m_axi_wvalid_i_1_n_0));
  FDCE m_axi_wvalid_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(m_axi_wvalid_i_1_n_0),
        .Q(m_axi_wvalid));
  LUT6 #(
    .INIT(64'hFFFFF0E0F0E0F0E0)) 
    \tx_data_in[0]_i_1 
       (.I0(m_axi_rresp[1]),
        .I1(m_axi_rresp[0]),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(m_axi_rdata[0]),
        .I4(\FSM_onehot_state_reg_n_0_[0] ),
        .I5(max_angle[0]),
        .O(\tx_data_in[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[10]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[10]),
        .I2(m_axi_rdata[10]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[11]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[11]),
        .I2(m_axi_rdata[11]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[12]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[12]),
        .I2(m_axi_rdata[12]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[13]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[13]),
        .I2(m_axi_rdata[13]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[14]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[14]),
        .I2(m_axi_rdata[14]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[15]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[15]),
        .I2(m_axi_rdata[15]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF0E0F0E0F0E0)) 
    \tx_data_in[16]_i_1 
       (.I0(m_axi_rresp[1]),
        .I1(m_axi_rresp[0]),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(m_axi_rdata[16]),
        .I4(\FSM_onehot_state_reg_n_0_[0] ),
        .I5(max_angle[16]),
        .O(\tx_data_in[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[17]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[17]),
        .I2(m_axi_rdata[17]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF0E0F0E0F0E0)) 
    \tx_data_in[18]_i_1 
       (.I0(m_axi_rresp[1]),
        .I1(m_axi_rresp[0]),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(m_axi_rdata[18]),
        .I4(\FSM_onehot_state_reg_n_0_[0] ),
        .I5(max_angle[18]),
        .O(\tx_data_in[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF0E0F0E0F0E0)) 
    \tx_data_in[19]_i_1 
       (.I0(m_axi_rresp[1]),
        .I1(m_axi_rresp[0]),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(m_axi_rdata[19]),
        .I4(\FSM_onehot_state_reg_n_0_[0] ),
        .I5(max_angle[19]),
        .O(\tx_data_in[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[1]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[1]),
        .I2(m_axi_rdata[1]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[20]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[20]),
        .I2(m_axi_rdata[20]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF0E0F0E0F0E0)) 
    \tx_data_in[21]_i_1 
       (.I0(m_axi_rresp[1]),
        .I1(m_axi_rresp[0]),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(m_axi_rdata[21]),
        .I4(\FSM_onehot_state_reg_n_0_[0] ),
        .I5(max_angle[21]),
        .O(\tx_data_in[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[22]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[22]),
        .I2(m_axi_rdata[22]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF0E0F0E0F0E0)) 
    \tx_data_in[23]_i_1 
       (.I0(m_axi_rresp[1]),
        .I1(m_axi_rresp[0]),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(m_axi_rdata[23]),
        .I4(\FSM_onehot_state_reg_n_0_[0] ),
        .I5(max_angle[23]),
        .O(\tx_data_in[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[24]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[24]),
        .I2(m_axi_rdata[24]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF0E0F0E0F0E0)) 
    \tx_data_in[25]_i_1 
       (.I0(m_axi_rresp[1]),
        .I1(m_axi_rresp[0]),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(m_axi_rdata[25]),
        .I4(\FSM_onehot_state_reg_n_0_[0] ),
        .I5(max_angle[25]),
        .O(\tx_data_in[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF0E0F0E0F0E0)) 
    \tx_data_in[26]_i_1 
       (.I0(m_axi_rresp[1]),
        .I1(m_axi_rresp[0]),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(m_axi_rdata[26]),
        .I4(\FSM_onehot_state_reg_n_0_[0] ),
        .I5(max_angle[26]),
        .O(\tx_data_in[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF0E0F0E0F0E0)) 
    \tx_data_in[27]_i_1 
       (.I0(m_axi_rresp[1]),
        .I1(m_axi_rresp[0]),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(m_axi_rdata[27]),
        .I4(\FSM_onehot_state_reg_n_0_[0] ),
        .I5(max_angle[27]),
        .O(\tx_data_in[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF0E0F0E0F0E0)) 
    \tx_data_in[28]_i_1 
       (.I0(m_axi_rresp[1]),
        .I1(m_axi_rresp[0]),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(m_axi_rdata[28]),
        .I4(\FSM_onehot_state_reg_n_0_[0] ),
        .I5(max_angle[28]),
        .O(\tx_data_in[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[29]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[29]),
        .I2(m_axi_rdata[29]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[2]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[2]),
        .I2(m_axi_rdata[2]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF0E0F0E0F0E0)) 
    \tx_data_in[30]_i_1 
       (.I0(m_axi_rresp[1]),
        .I1(m_axi_rresp[0]),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(m_axi_rdata[30]),
        .I4(\FSM_onehot_state_reg_n_0_[0] ),
        .I5(max_angle[30]),
        .O(\tx_data_in[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF0E0F0E0F0E0)) 
    \tx_data_in[31]_i_2 
       (.I0(m_axi_rresp[1]),
        .I1(m_axi_rresp[0]),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(m_axi_rdata[31]),
        .I4(\FSM_onehot_state_reg_n_0_[0] ),
        .I5(max_angle[31]),
        .O(\tx_data_in[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[3]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[3]),
        .I2(m_axi_rdata[3]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[4]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[4]),
        .I2(m_axi_rdata[4]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[5]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[5]),
        .I2(m_axi_rdata[5]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[6]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[6]),
        .I2(m_axi_rdata[6]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[7]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[7]),
        .I2(m_axi_rdata[7]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[8]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[8]),
        .I2(m_axi_rdata[8]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888888888888F888)) 
    \tx_data_in[9]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(max_angle[9]),
        .I2(m_axi_rdata[9]),
        .I3(\FSM_onehot_state_reg_n_0_[2] ),
        .I4(m_axi_rresp[1]),
        .I5(m_axi_rresp[0]),
        .O(\tx_data_in[9]_i_1_n_0 ));
  FDCE \tx_data_in_reg[0] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[0]_i_1_n_0 ),
        .Q(tx_data_in[0]));
  FDCE \tx_data_in_reg[10] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[10]_i_1_n_0 ),
        .Q(tx_data_in[10]));
  FDCE \tx_data_in_reg[11] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[11]_i_1_n_0 ),
        .Q(tx_data_in[11]));
  FDCE \tx_data_in_reg[12] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[12]_i_1_n_0 ),
        .Q(tx_data_in[12]));
  FDCE \tx_data_in_reg[13] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[13]_i_1_n_0 ),
        .Q(tx_data_in[13]));
  FDCE \tx_data_in_reg[14] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[14]_i_1_n_0 ),
        .Q(tx_data_in[14]));
  FDCE \tx_data_in_reg[15] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[15]_i_1_n_0 ),
        .Q(tx_data_in[15]));
  FDCE \tx_data_in_reg[16] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[16]_i_1_n_0 ),
        .Q(tx_data_in[16]));
  FDCE \tx_data_in_reg[17] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[17]_i_1_n_0 ),
        .Q(tx_data_in[17]));
  FDCE \tx_data_in_reg[18] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[18]_i_1_n_0 ),
        .Q(tx_data_in[18]));
  FDCE \tx_data_in_reg[19] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[19]_i_1_n_0 ),
        .Q(tx_data_in[19]));
  FDCE \tx_data_in_reg[1] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[1]_i_1_n_0 ),
        .Q(tx_data_in[1]));
  FDCE \tx_data_in_reg[20] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[20]_i_1_n_0 ),
        .Q(tx_data_in[20]));
  FDCE \tx_data_in_reg[21] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[21]_i_1_n_0 ),
        .Q(tx_data_in[21]));
  FDCE \tx_data_in_reg[22] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[22]_i_1_n_0 ),
        .Q(tx_data_in[22]));
  FDCE \tx_data_in_reg[23] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[23]_i_1_n_0 ),
        .Q(tx_data_in[23]));
  FDCE \tx_data_in_reg[24] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[24]_i_1_n_0 ),
        .Q(tx_data_in[24]));
  FDCE \tx_data_in_reg[25] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[25]_i_1_n_0 ),
        .Q(tx_data_in[25]));
  FDCE \tx_data_in_reg[26] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[26]_i_1_n_0 ),
        .Q(tx_data_in[26]));
  FDCE \tx_data_in_reg[27] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[27]_i_1_n_0 ),
        .Q(tx_data_in[27]));
  FDCE \tx_data_in_reg[28] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[28]_i_1_n_0 ),
        .Q(tx_data_in[28]));
  FDCE \tx_data_in_reg[29] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[29]_i_1_n_0 ),
        .Q(tx_data_in[29]));
  FDCE \tx_data_in_reg[2] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[2]_i_1_n_0 ),
        .Q(tx_data_in[2]));
  FDCE \tx_data_in_reg[30] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[30]_i_1_n_0 ),
        .Q(tx_data_in[30]));
  FDCE \tx_data_in_reg[31] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[31]_i_2_n_0 ),
        .Q(tx_data_in[31]));
  FDCE \tx_data_in_reg[3] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[3]_i_1_n_0 ),
        .Q(tx_data_in[3]));
  FDCE \tx_data_in_reg[4] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[4]_i_1_n_0 ),
        .Q(tx_data_in[4]));
  FDCE \tx_data_in_reg[5] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[5]_i_1_n_0 ),
        .Q(tx_data_in[5]));
  FDCE \tx_data_in_reg[6] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[6]_i_1_n_0 ),
        .Q(tx_data_in[6]));
  FDCE \tx_data_in_reg[7] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[7]_i_1_n_0 ),
        .Q(tx_data_in[7]));
  FDCE \tx_data_in_reg[8] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[8]_i_1_n_0 ),
        .Q(tx_data_in[8]));
  FDCE \tx_data_in_reg[9] 
       (.C(clk),
        .CE(UART_RX_DECODER_inst_n_2),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\tx_data_in[9]_i_1_n_0 ),
        .Q(tx_data_in[9]));
  LUT4 #(
    .INIT(16'hCDCC)) 
    tx_start_i_1
       (.I0(\FSM_onehot_state_reg_n_0_[6] ),
        .I1(tx_start),
        .I2(\FSM_onehot_state_reg_n_0_[0] ),
        .I3(tx_start_reg_n_0),
        .O(tx_start_i_1_n_0));
  FDCE tx_start_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(tx_start_i_1_n_0),
        .Q(tx_start_reg_n_0));
  FDCE \uart_addr_reg_reg[0] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr[0]),
        .Q(uart_addr_reg[0]));
  FDCE \uart_addr_reg_reg[1] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr[1]),
        .Q(uart_addr_reg[1]));
  FDCE \uart_addr_reg_reg[2] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr[2]),
        .Q(uart_addr_reg[2]));
  FDCE \uart_addr_reg_reg[3] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr[3]),
        .Q(uart_addr_reg[3]));
  FDCE \uart_addr_reg_reg[4] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr[4]),
        .Q(uart_addr_reg[4]));
  FDCE \uart_addr_reg_reg[5] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(uart_addr[5]),
        .Q(uart_addr_reg[5]));
  FDCE \uart_data_reg_reg[0] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[4] [0]),
        .Q(uart_data_reg[0]));
  FDCE \uart_data_reg_reg[10] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[3] [2]),
        .Q(uart_data_reg[10]));
  FDCE \uart_data_reg_reg[11] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[3] [3]),
        .Q(uart_data_reg[11]));
  FDCE \uart_data_reg_reg[12] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[3] [4]),
        .Q(uart_data_reg[12]));
  FDCE \uart_data_reg_reg[13] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[3] [5]),
        .Q(uart_data_reg[13]));
  FDCE \uart_data_reg_reg[14] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[3] [6]),
        .Q(uart_data_reg[14]));
  FDCE \uart_data_reg_reg[15] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[3] [7]),
        .Q(uart_data_reg[15]));
  FDCE \uart_data_reg_reg[16] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[2] [0]),
        .Q(uart_data_reg[16]));
  FDCE \uart_data_reg_reg[17] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[2] [1]),
        .Q(uart_data_reg[17]));
  FDCE \uart_data_reg_reg[18] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[2] [2]),
        .Q(uart_data_reg[18]));
  FDCE \uart_data_reg_reg[19] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[2] [3]),
        .Q(uart_data_reg[19]));
  FDCE \uart_data_reg_reg[1] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[4] [1]),
        .Q(uart_data_reg[1]));
  FDCE \uart_data_reg_reg[20] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[2] [4]),
        .Q(uart_data_reg[20]));
  FDCE \uart_data_reg_reg[21] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[2] [5]),
        .Q(uart_data_reg[21]));
  FDCE \uart_data_reg_reg[22] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[2] [6]),
        .Q(uart_data_reg[22]));
  FDCE \uart_data_reg_reg[23] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[2] [7]),
        .Q(uart_data_reg[23]));
  FDCE \uart_data_reg_reg[24] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[1] [0]),
        .Q(uart_data_reg[24]));
  FDCE \uart_data_reg_reg[25] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[1] [1]),
        .Q(uart_data_reg[25]));
  FDCE \uart_data_reg_reg[26] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[1] [2]),
        .Q(uart_data_reg[26]));
  FDCE \uart_data_reg_reg[27] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[1] [3]),
        .Q(uart_data_reg[27]));
  FDCE \uart_data_reg_reg[28] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[1] [4]),
        .Q(uart_data_reg[28]));
  FDCE \uart_data_reg_reg[29] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[1] [5]),
        .Q(uart_data_reg[29]));
  FDCE \uart_data_reg_reg[2] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[4] [2]),
        .Q(uart_data_reg[2]));
  FDCE \uart_data_reg_reg[30] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[1] [6]),
        .Q(uart_data_reg[30]));
  FDCE \uart_data_reg_reg[31] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[1] [7]),
        .Q(uart_data_reg[31]));
  FDCE \uart_data_reg_reg[3] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[4] [3]),
        .Q(uart_data_reg[3]));
  FDCE \uart_data_reg_reg[4] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[4] [4]),
        .Q(uart_data_reg[4]));
  FDCE \uart_data_reg_reg[5] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[4] [5]),
        .Q(uart_data_reg[5]));
  FDCE \uart_data_reg_reg[6] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[4] [6]),
        .Q(uart_data_reg[6]));
  FDCE \uart_data_reg_reg[7] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[4] [7]),
        .Q(uart_data_reg[7]));
  FDCE \uart_data_reg_reg[8] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[3] [0]),
        .Q(uart_data_reg[8]));
  FDCE \uart_data_reg_reg[9] 
       (.C(clk),
        .CE(uart_addr_reg_0),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(\SIPO_reg[3] [1]),
        .Q(uart_data_reg[9]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'h80)) 
    w_done_i_2
       (.I0(\FSM_onehot_state_reg_n_0_[3] ),
        .I1(m_axi_wready),
        .I2(m_axi_wvalid),
        .O(w_done));
  FDCE w_done_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(UART_RX_DECODER_inst_n_9),
        .D(UART_RX_DECODER_inst_n_7),
        .Q(w_done_reg_n_0));
endmodule

(* ORIG_REF_NAME = "UART_TX_ENCODER" *) 
module design_2_UART_TRANSACTION_HAN_0_0_UART_TX_ENCODER
   (\PISO_reg[1][8]_0 ,
    Word_To_Send_en,
    Word_To_Send,
    uart_tx_ready,
    \PISO_reg[3][8]_0 ,
    Q,
    \PISO_reg[0][7]_0 ,
    clk,
    \PISO_reg[0][8]_0 );
  output \PISO_reg[1][8]_0 ;
  output Word_To_Send_en;
  output [7:0]Word_To_Send;
  input uart_tx_ready;
  input \PISO_reg[3][8]_0 ;
  input [0:0]Q;
  input [31:0]\PISO_reg[0][7]_0 ;
  input clk;
  input \PISO_reg[0][8]_0 ;

  wire PISO;
  wire \PISO[0][0]_i_1_n_0 ;
  wire \PISO[0][1]_i_1_n_0 ;
  wire \PISO[0][2]_i_1_n_0 ;
  wire \PISO[0][3]_i_1_n_0 ;
  wire \PISO[0][4]_i_1_n_0 ;
  wire \PISO[0][5]_i_1_n_0 ;
  wire \PISO[0][6]_i_1_n_0 ;
  wire \PISO[0][7]_i_1_n_0 ;
  wire \PISO[0][8]_i_1_n_0 ;
  wire \PISO[1][0]_i_1_n_0 ;
  wire \PISO[1][1]_i_1_n_0 ;
  wire \PISO[1][2]_i_1_n_0 ;
  wire \PISO[1][3]_i_1_n_0 ;
  wire \PISO[1][4]_i_1_n_0 ;
  wire \PISO[1][5]_i_1_n_0 ;
  wire \PISO[1][6]_i_1_n_0 ;
  wire \PISO[1][7]_i_1_n_0 ;
  wire \PISO[1][8]_i_1_n_0 ;
  wire \PISO[2][0]_i_1_n_0 ;
  wire \PISO[2][1]_i_1_n_0 ;
  wire \PISO[2][2]_i_1_n_0 ;
  wire \PISO[2][3]_i_1_n_0 ;
  wire \PISO[2][4]_i_1_n_0 ;
  wire \PISO[2][5]_i_1_n_0 ;
  wire \PISO[2][6]_i_1_n_0 ;
  wire \PISO[2][7]_i_1_n_0 ;
  wire \PISO[2][8]_i_1_n_0 ;
  wire [31:0]\PISO_reg[0][7]_0 ;
  wire \PISO_reg[0][8]_0 ;
  wire \PISO_reg[1][8]_0 ;
  wire [8:0]\PISO_reg[2] ;
  wire [8:0]\PISO_reg[3] ;
  wire \PISO_reg[3][8]_0 ;
  wire \PISO_reg_n_0_[0][0] ;
  wire \PISO_reg_n_0_[0][1] ;
  wire \PISO_reg_n_0_[0][2] ;
  wire \PISO_reg_n_0_[0][3] ;
  wire \PISO_reg_n_0_[0][4] ;
  wire \PISO_reg_n_0_[0][5] ;
  wire \PISO_reg_n_0_[0][6] ;
  wire \PISO_reg_n_0_[0][7] ;
  wire \PISO_reg_n_0_[1][0] ;
  wire \PISO_reg_n_0_[1][1] ;
  wire \PISO_reg_n_0_[1][2] ;
  wire \PISO_reg_n_0_[1][3] ;
  wire \PISO_reg_n_0_[1][4] ;
  wire \PISO_reg_n_0_[1][5] ;
  wire \PISO_reg_n_0_[1][6] ;
  wire \PISO_reg_n_0_[1][7] ;
  wire [0:0]Q;
  wire [7:0]Word_To_Send;
  wire Word_To_Send_en;
  wire clk;
  wire [7:0]p_0_in;
  wire p_0_in1_in;
  wire p_0_in_0;
  wire uart_tx_ready;

  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \FSM_onehot_state[6]_i_2 
       (.I0(p_0_in_0),
        .I1(Q),
        .I2(p_0_in1_in),
        .I3(uart_tx_ready),
        .O(\PISO_reg[1][8]_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[0][0]_i_1 
       (.I0(\PISO_reg[0][7]_0 [24]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg_n_0_[1][0] ),
        .O(\PISO[0][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[0][1]_i_1 
       (.I0(\PISO_reg[0][7]_0 [25]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg_n_0_[1][1] ),
        .O(\PISO[0][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[0][2]_i_1 
       (.I0(\PISO_reg[0][7]_0 [26]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg_n_0_[1][2] ),
        .O(\PISO[0][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[0][3]_i_1 
       (.I0(\PISO_reg[0][7]_0 [27]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg_n_0_[1][3] ),
        .O(\PISO[0][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[0][4]_i_1 
       (.I0(\PISO_reg[0][7]_0 [28]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg_n_0_[1][4] ),
        .O(\PISO[0][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[0][5]_i_1 
       (.I0(\PISO_reg[0][7]_0 [29]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg_n_0_[1][5] ),
        .O(\PISO[0][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[0][6]_i_1 
       (.I0(\PISO_reg[0][7]_0 [30]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg_n_0_[1][6] ),
        .O(\PISO[0][6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[0][7]_i_1 
       (.I0(\PISO_reg[0][7]_0 [31]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg_n_0_[1][7] ),
        .O(\PISO[0][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \PISO[0][8]_i_1 
       (.I0(\PISO_reg[3][8]_0 ),
        .I1(p_0_in_0),
        .O(\PISO[0][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[1][0]_i_1 
       (.I0(\PISO_reg[0][7]_0 [16]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[2] [0]),
        .O(\PISO[1][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[1][1]_i_1 
       (.I0(\PISO_reg[0][7]_0 [17]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[2] [1]),
        .O(\PISO[1][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[1][2]_i_1 
       (.I0(\PISO_reg[0][7]_0 [18]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[2] [2]),
        .O(\PISO[1][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[1][3]_i_1 
       (.I0(\PISO_reg[0][7]_0 [19]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[2] [3]),
        .O(\PISO[1][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[1][4]_i_1 
       (.I0(\PISO_reg[0][7]_0 [20]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[2] [4]),
        .O(\PISO[1][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[1][5]_i_1 
       (.I0(\PISO_reg[0][7]_0 [21]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[2] [5]),
        .O(\PISO[1][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[1][6]_i_1 
       (.I0(\PISO_reg[0][7]_0 [22]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[2] [6]),
        .O(\PISO[1][6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[1][7]_i_1 
       (.I0(\PISO_reg[0][7]_0 [23]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[2] [7]),
        .O(\PISO[1][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \PISO[1][8]_i_1 
       (.I0(\PISO_reg[3][8]_0 ),
        .I1(\PISO_reg[2] [8]),
        .O(\PISO[1][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[2][0]_i_1 
       (.I0(\PISO_reg[0][7]_0 [8]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[3] [0]),
        .O(\PISO[2][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[2][1]_i_1 
       (.I0(\PISO_reg[0][7]_0 [9]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[3] [1]),
        .O(\PISO[2][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[2][2]_i_1 
       (.I0(\PISO_reg[0][7]_0 [10]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[3] [2]),
        .O(\PISO[2][2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[2][3]_i_1 
       (.I0(\PISO_reg[0][7]_0 [11]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[3] [3]),
        .O(\PISO[2][3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[2][4]_i_1 
       (.I0(\PISO_reg[0][7]_0 [12]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[3] [4]),
        .O(\PISO[2][4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[2][5]_i_1 
       (.I0(\PISO_reg[0][7]_0 [13]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[3] [5]),
        .O(\PISO[2][5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[2][6]_i_1 
       (.I0(\PISO_reg[0][7]_0 [14]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[3] [6]),
        .O(\PISO[2][6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \PISO[2][7]_i_1 
       (.I0(\PISO_reg[0][7]_0 [15]),
        .I1(\PISO_reg[3][8]_0 ),
        .I2(\PISO_reg[3] [7]),
        .O(\PISO[2][7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \PISO[2][8]_i_1 
       (.I0(\PISO_reg[3][8]_0 ),
        .I1(\PISO_reg[3] [8]),
        .O(\PISO[2][8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \PISO[3][0]_i_1 
       (.I0(\PISO_reg[3][8]_0 ),
        .I1(\PISO_reg[0][7]_0 [0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \PISO[3][1]_i_1 
       (.I0(\PISO_reg[3][8]_0 ),
        .I1(\PISO_reg[0][7]_0 [1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \PISO[3][2]_i_1 
       (.I0(\PISO_reg[3][8]_0 ),
        .I1(\PISO_reg[0][7]_0 [2]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \PISO[3][3]_i_1 
       (.I0(\PISO_reg[3][8]_0 ),
        .I1(\PISO_reg[0][7]_0 [3]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \PISO[3][4]_i_1 
       (.I0(\PISO_reg[3][8]_0 ),
        .I1(\PISO_reg[0][7]_0 [4]),
        .O(p_0_in[4]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \PISO[3][5]_i_1 
       (.I0(\PISO_reg[3][8]_0 ),
        .I1(\PISO_reg[0][7]_0 [5]),
        .O(p_0_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \PISO[3][6]_i_1 
       (.I0(\PISO_reg[3][8]_0 ),
        .I1(\PISO_reg[0][7]_0 [6]),
        .O(p_0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \PISO[3][7]_i_1 
       (.I0(\PISO_reg[3][8]_0 ),
        .I1(\PISO_reg[0][7]_0 [7]),
        .O(p_0_in[7]));
  LUT3 #(
    .INIT(8'hF8)) 
    \PISO[3][8]_i_1 
       (.I0(p_0_in1_in),
        .I1(uart_tx_ready),
        .I2(\PISO_reg[3][8]_0 ),
        .O(PISO));
  FDCE \PISO_reg[0][0] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[0][0]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[0][0] ));
  FDCE \PISO_reg[0][1] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[0][1]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[0][1] ));
  FDCE \PISO_reg[0][2] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[0][2]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[0][2] ));
  FDCE \PISO_reg[0][3] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[0][3]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[0][3] ));
  FDCE \PISO_reg[0][4] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[0][4]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[0][4] ));
  FDCE \PISO_reg[0][5] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[0][5]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[0][5] ));
  FDCE \PISO_reg[0][6] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[0][6]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[0][6] ));
  FDCE \PISO_reg[0][7] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[0][7]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[0][7] ));
  FDCE \PISO_reg[0][8] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[0][8]_i_1_n_0 ),
        .Q(p_0_in1_in));
  FDCE \PISO_reg[1][0] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[1][0]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[1][0] ));
  FDCE \PISO_reg[1][1] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[1][1]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[1][1] ));
  FDCE \PISO_reg[1][2] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[1][2]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[1][2] ));
  FDCE \PISO_reg[1][3] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[1][3]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[1][3] ));
  FDCE \PISO_reg[1][4] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[1][4]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[1][4] ));
  FDCE \PISO_reg[1][5] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[1][5]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[1][5] ));
  FDCE \PISO_reg[1][6] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[1][6]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[1][6] ));
  FDCE \PISO_reg[1][7] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[1][7]_i_1_n_0 ),
        .Q(\PISO_reg_n_0_[1][7] ));
  FDCE \PISO_reg[1][8] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[1][8]_i_1_n_0 ),
        .Q(p_0_in_0));
  FDCE \PISO_reg[2][0] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[2][0]_i_1_n_0 ),
        .Q(\PISO_reg[2] [0]));
  FDCE \PISO_reg[2][1] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[2][1]_i_1_n_0 ),
        .Q(\PISO_reg[2] [1]));
  FDCE \PISO_reg[2][2] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[2][2]_i_1_n_0 ),
        .Q(\PISO_reg[2] [2]));
  FDCE \PISO_reg[2][3] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[2][3]_i_1_n_0 ),
        .Q(\PISO_reg[2] [3]));
  FDCE \PISO_reg[2][4] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[2][4]_i_1_n_0 ),
        .Q(\PISO_reg[2] [4]));
  FDCE \PISO_reg[2][5] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[2][5]_i_1_n_0 ),
        .Q(\PISO_reg[2] [5]));
  FDCE \PISO_reg[2][6] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[2][6]_i_1_n_0 ),
        .Q(\PISO_reg[2] [6]));
  FDCE \PISO_reg[2][7] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[2][7]_i_1_n_0 ),
        .Q(\PISO_reg[2] [7]));
  FDCE \PISO_reg[2][8] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO[2][8]_i_1_n_0 ),
        .Q(\PISO_reg[2] [8]));
  FDCE \PISO_reg[3][0] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(p_0_in[0]),
        .Q(\PISO_reg[3] [0]));
  FDCE \PISO_reg[3][1] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(p_0_in[1]),
        .Q(\PISO_reg[3] [1]));
  FDCE \PISO_reg[3][2] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(p_0_in[2]),
        .Q(\PISO_reg[3] [2]));
  FDCE \PISO_reg[3][3] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(p_0_in[3]),
        .Q(\PISO_reg[3] [3]));
  FDCE \PISO_reg[3][4] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(p_0_in[4]),
        .Q(\PISO_reg[3] [4]));
  FDCE \PISO_reg[3][5] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(p_0_in[5]),
        .Q(\PISO_reg[3] [5]));
  FDCE \PISO_reg[3][6] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(p_0_in[6]),
        .Q(\PISO_reg[3] [6]));
  FDCE \PISO_reg[3][7] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(p_0_in[7]),
        .Q(\PISO_reg[3] [7]));
  FDCE \PISO_reg[3][8] 
       (.C(clk),
        .CE(PISO),
        .CLR(\PISO_reg[0][8]_0 ),
        .D(\PISO_reg[3][8]_0 ),
        .Q(\PISO_reg[3] [8]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \Word_To_Send[0]_INST_0 
       (.I0(p_0_in1_in),
        .I1(\PISO_reg_n_0_[0][0] ),
        .O(Word_To_Send[0]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \Word_To_Send[1]_INST_0 
       (.I0(p_0_in1_in),
        .I1(\PISO_reg_n_0_[0][1] ),
        .O(Word_To_Send[1]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \Word_To_Send[2]_INST_0 
       (.I0(p_0_in1_in),
        .I1(\PISO_reg_n_0_[0][2] ),
        .O(Word_To_Send[2]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \Word_To_Send[3]_INST_0 
       (.I0(p_0_in1_in),
        .I1(\PISO_reg_n_0_[0][3] ),
        .O(Word_To_Send[3]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \Word_To_Send[4]_INST_0 
       (.I0(p_0_in1_in),
        .I1(\PISO_reg_n_0_[0][4] ),
        .O(Word_To_Send[4]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \Word_To_Send[5]_INST_0 
       (.I0(p_0_in1_in),
        .I1(\PISO_reg_n_0_[0][5] ),
        .O(Word_To_Send[5]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \Word_To_Send[6]_INST_0 
       (.I0(p_0_in1_in),
        .I1(\PISO_reg_n_0_[0][6] ),
        .O(Word_To_Send[6]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \Word_To_Send[7]_INST_0 
       (.I0(p_0_in1_in),
        .I1(\PISO_reg_n_0_[0][7] ),
        .O(Word_To_Send[7]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h8)) 
    Word_To_Send_en_INST_0
       (.I0(uart_tx_ready),
        .I1(p_0_in1_in),
        .O(Word_To_Send_en));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
