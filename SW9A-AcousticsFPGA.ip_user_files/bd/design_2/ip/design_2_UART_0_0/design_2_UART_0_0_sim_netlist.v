// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Mon Nov  2 17:26:03 2026
// Host        : JokeJet running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim {c:/Users/Praneeth
//               Satishkumar/eda/designs/riscv32-sky130-asic/SW9A-AcousticsFPGA/SW9A-AcousticsFPGA.gen/sources_1/bd/design_2/ip/design_2_UART_0_0/design_2_UART_0_0_sim_netlist.v}
// Design      : design_2_UART_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_2_UART_0_0,UART,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "UART,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module design_2_UART_0_0
   (clk,
    UART_clk,
    reset_b,
    uart_aresetn,
    TX_Data_in,
    TX_en,
    RX_Data_in,
    TX_Data_out,
    TX_Ready_To_Send,
    RX_Data_out,
    RX_Data_Ready);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 100285714, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 UART_clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME UART_clk, FREQ_HZ 5760000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input UART_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_b RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset_b, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input reset_b;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 uart_aresetn RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME uart_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input uart_aresetn;
  input [7:0]TX_Data_in;
  input TX_en;
  input RX_Data_in;
  output TX_Data_out;
  output TX_Ready_To_Send;
  output [7:0]RX_Data_out;
  output RX_Data_Ready;

  wire RX_Data_Ready;
  wire RX_Data_in;
  wire [7:0]RX_Data_out;
  wire [7:0]TX_Data_in;
  wire TX_Data_out;
  wire TX_Ready_To_Send;
  wire TX_en;
  wire UART_clk;
  wire clk;
  wire reset_b;
  wire uart_aresetn;

  design_2_UART_0_0_UART inst
       (.RX_Data_Ready(RX_Data_Ready),
        .RX_Data_in(RX_Data_in),
        .RX_Data_out(RX_Data_out),
        .TX_Data_in(TX_Data_in),
        .TX_Data_out(TX_Data_out),
        .TX_Ready_To_Send(TX_Ready_To_Send),
        .TX_en(TX_en),
        .UART_clk(UART_clk),
        .clk(clk),
        .reset_b(reset_b),
        .uart_aresetn(uart_aresetn));
endmodule

(* ORIG_REF_NAME = "GENERAL_COUNTER" *) 
module design_2_UART_0_0_GENERAL_COUNTER
   (reset_b_0,
    \Counter_Value_reg_reg[8]_0 ,
    \Counter_Value_reg_reg[7]_0 ,
    \Counter_Value_reg_reg[6]_0 ,
    \Counter_Value_reg_reg[0]_0 ,
    reset_b,
    \Counter_Value_reg_reg[1]_0 ,
    clk,
    \Counter_Value_reg_reg[0]_1 );
  output reset_b_0;
  output \Counter_Value_reg_reg[8]_0 ;
  output \Counter_Value_reg_reg[7]_0 ;
  output \Counter_Value_reg_reg[6]_0 ;
  output \Counter_Value_reg_reg[0]_0 ;
  input reset_b;
  input [0:0]\Counter_Value_reg_reg[1]_0 ;
  input clk;
  input \Counter_Value_reg_reg[0]_1 ;

  wire [9:1]Counter_Value_reg;
  wire \Counter_Value_reg[1]_i_1__1_n_0 ;
  wire \Counter_Value_reg[2]_i_1__1_n_0 ;
  wire \Counter_Value_reg[3]_i_1__0_n_0 ;
  wire \Counter_Value_reg[4]_i_1__0_n_0 ;
  wire \Counter_Value_reg[5]_i_1_n_0 ;
  wire \Counter_Value_reg[6]_i_1_n_0 ;
  wire \Counter_Value_reg[7]_i_1_n_0 ;
  wire \Counter_Value_reg[8]_i_1_n_0 ;
  wire \Counter_Value_reg[9]_i_1_n_0 ;
  wire \Counter_Value_reg[9]_i_2_n_0 ;
  wire \Counter_Value_reg[9]_i_3_n_0 ;
  wire \Counter_Value_reg_reg[0]_0 ;
  wire \Counter_Value_reg_reg[0]_1 ;
  wire [0:0]\Counter_Value_reg_reg[1]_0 ;
  wire \Counter_Value_reg_reg[6]_0 ;
  wire \Counter_Value_reg_reg[7]_0 ;
  wire \Counter_Value_reg_reg[8]_0 ;
  wire clk;
  wire reset_b;
  wire reset_b_0;

  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h28)) 
    \Counter_Value_reg[1]_i_1__1 
       (.I0(\Counter_Value_reg_reg[1]_0 ),
        .I1(Counter_Value_reg[1]),
        .I2(\Counter_Value_reg_reg[0]_0 ),
        .O(\Counter_Value_reg[1]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h2888)) 
    \Counter_Value_reg[2]_i_1__1 
       (.I0(\Counter_Value_reg_reg[1]_0 ),
        .I1(Counter_Value_reg[2]),
        .I2(\Counter_Value_reg_reg[0]_0 ),
        .I3(Counter_Value_reg[1]),
        .O(\Counter_Value_reg[2]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'h28888888)) 
    \Counter_Value_reg[3]_i_1__0 
       (.I0(\Counter_Value_reg_reg[1]_0 ),
        .I1(Counter_Value_reg[3]),
        .I2(Counter_Value_reg[1]),
        .I3(\Counter_Value_reg_reg[0]_0 ),
        .I4(Counter_Value_reg[2]),
        .O(\Counter_Value_reg[3]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h2888888888888888)) 
    \Counter_Value_reg[4]_i_1__0 
       (.I0(\Counter_Value_reg_reg[1]_0 ),
        .I1(Counter_Value_reg[4]),
        .I2(Counter_Value_reg[3]),
        .I3(\Counter_Value_reg_reg[0]_0 ),
        .I4(Counter_Value_reg[1]),
        .I5(Counter_Value_reg[2]),
        .O(\Counter_Value_reg[4]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'h2888)) 
    \Counter_Value_reg[5]_i_1 
       (.I0(\Counter_Value_reg_reg[1]_0 ),
        .I1(Counter_Value_reg[5]),
        .I2(\Counter_Value_reg[9]_i_3_n_0 ),
        .I3(Counter_Value_reg[2]),
        .O(\Counter_Value_reg[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h28888888)) 
    \Counter_Value_reg[6]_i_1 
       (.I0(\Counter_Value_reg_reg[1]_0 ),
        .I1(Counter_Value_reg[6]),
        .I2(\Counter_Value_reg[9]_i_3_n_0 ),
        .I3(Counter_Value_reg[5]),
        .I4(Counter_Value_reg[2]),
        .O(\Counter_Value_reg[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h2888888888888888)) 
    \Counter_Value_reg[7]_i_1 
       (.I0(\Counter_Value_reg_reg[1]_0 ),
        .I1(Counter_Value_reg[7]),
        .I2(\Counter_Value_reg[9]_i_3_n_0 ),
        .I3(Counter_Value_reg[6]),
        .I4(Counter_Value_reg[2]),
        .I5(Counter_Value_reg[5]),
        .O(\Counter_Value_reg[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h82888888)) 
    \Counter_Value_reg[8]_i_1 
       (.I0(\Counter_Value_reg_reg[1]_0 ),
        .I1(Counter_Value_reg[8]),
        .I2(\Counter_Value_reg[9]_i_2_n_0 ),
        .I3(Counter_Value_reg[7]),
        .I4(\Counter_Value_reg[9]_i_3_n_0 ),
        .O(\Counter_Value_reg[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8288888888888888)) 
    \Counter_Value_reg[9]_i_1 
       (.I0(\Counter_Value_reg_reg[1]_0 ),
        .I1(Counter_Value_reg[9]),
        .I2(\Counter_Value_reg[9]_i_2_n_0 ),
        .I3(Counter_Value_reg[8]),
        .I4(Counter_Value_reg[7]),
        .I5(\Counter_Value_reg[9]_i_3_n_0 ),
        .O(\Counter_Value_reg[9]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h7F)) 
    \Counter_Value_reg[9]_i_2 
       (.I0(Counter_Value_reg[5]),
        .I1(Counter_Value_reg[2]),
        .I2(Counter_Value_reg[6]),
        .O(\Counter_Value_reg[9]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \Counter_Value_reg[9]_i_3 
       (.I0(Counter_Value_reg[3]),
        .I1(\Counter_Value_reg_reg[0]_0 ),
        .I2(Counter_Value_reg[1]),
        .I3(Counter_Value_reg[4]),
        .O(\Counter_Value_reg[9]_i_3_n_0 ));
  FDCE \Counter_Value_reg_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(reset_b_0),
        .D(\Counter_Value_reg_reg[0]_1 ),
        .Q(\Counter_Value_reg_reg[0]_0 ));
  FDCE \Counter_Value_reg_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(reset_b_0),
        .D(\Counter_Value_reg[1]_i_1__1_n_0 ),
        .Q(Counter_Value_reg[1]));
  FDCE \Counter_Value_reg_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(reset_b_0),
        .D(\Counter_Value_reg[2]_i_1__1_n_0 ),
        .Q(Counter_Value_reg[2]));
  FDCE \Counter_Value_reg_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(reset_b_0),
        .D(\Counter_Value_reg[3]_i_1__0_n_0 ),
        .Q(Counter_Value_reg[3]));
  FDCE \Counter_Value_reg_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(reset_b_0),
        .D(\Counter_Value_reg[4]_i_1__0_n_0 ),
        .Q(Counter_Value_reg[4]));
  FDCE \Counter_Value_reg_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(reset_b_0),
        .D(\Counter_Value_reg[5]_i_1_n_0 ),
        .Q(Counter_Value_reg[5]));
  FDCE \Counter_Value_reg_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .CLR(reset_b_0),
        .D(\Counter_Value_reg[6]_i_1_n_0 ),
        .Q(Counter_Value_reg[6]));
  FDCE \Counter_Value_reg_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .CLR(reset_b_0),
        .D(\Counter_Value_reg[7]_i_1_n_0 ),
        .Q(Counter_Value_reg[7]));
  FDCE \Counter_Value_reg_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .CLR(reset_b_0),
        .D(\Counter_Value_reg[8]_i_1_n_0 ),
        .Q(Counter_Value_reg[8]));
  FDCE \Counter_Value_reg_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .CLR(reset_b_0),
        .D(\Counter_Value_reg[9]_i_1_n_0 ),
        .Q(Counter_Value_reg[9]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hBFFFFFFF)) 
    \FSM_onehot_current_state[3]_i_2 
       (.I0(\Counter_Value_reg_reg[7]_0 ),
        .I1(Counter_Value_reg[8]),
        .I2(Counter_Value_reg[5]),
        .I3(Counter_Value_reg[2]),
        .I4(Counter_Value_reg[6]),
        .O(\Counter_Value_reg_reg[8]_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFB)) 
    \FSM_onehot_current_state[3]_i_3 
       (.I0(Counter_Value_reg[7]),
        .I1(Counter_Value_reg[9]),
        .I2(Counter_Value_reg[3]),
        .I3(Counter_Value_reg[4]),
        .I4(Counter_Value_reg[1]),
        .I5(\Counter_Value_reg_reg[0]_0 ),
        .O(\Counter_Value_reg_reg[7]_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \RX_Shift_Register_reg[7]_i_2 
       (.I0(reset_b),
        .O(reset_b_0));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    \softlock_prevention[9]_i_7 
       (.I0(Counter_Value_reg[6]),
        .I1(Counter_Value_reg[2]),
        .I2(Counter_Value_reg[5]),
        .I3(Counter_Value_reg[8]),
        .O(\Counter_Value_reg_reg[6]_0 ));
endmodule

(* ORIG_REF_NAME = "GENERAL_COUNTER" *) 
module design_2_UART_0_0_GENERAL_COUNTER__parameterized0
   (E,
    Q,
    \Counter_Value_reg_reg[1]_0 ,
    \Counter_Value_reg_reg[2]_0 ,
    \Counter_Value_reg_reg[3]_0 ,
    clk,
    \Counter_Value_reg_reg[3]_1 ,
    D);
  output [0:0]E;
  output [1:0]Q;
  output \Counter_Value_reg_reg[1]_0 ;
  input [1:0]\Counter_Value_reg_reg[2]_0 ;
  input [0:0]\Counter_Value_reg_reg[3]_0 ;
  input clk;
  input \Counter_Value_reg_reg[3]_1 ;
  input [1:0]D;

  wire [3:2]Counter_Value_Next;
  wire \Counter_Value_reg_reg[1]_0 ;
  wire [1:0]\Counter_Value_reg_reg[2]_0 ;
  wire [0:0]\Counter_Value_reg_reg[3]_0 ;
  wire \Counter_Value_reg_reg[3]_1 ;
  wire \Counter_Value_reg_reg_n_0_[2] ;
  wire \Counter_Value_reg_reg_n_0_[3] ;
  wire [1:0]D;
  wire [0:0]E;
  wire [1:0]Q;
  wire clk;

  LUT5 #(
    .INIT(32'h0EE0E0E0)) 
    \Counter_Value_reg[2]_i_1 
       (.I0(\Counter_Value_reg_reg[2]_0 [1]),
        .I1(\Counter_Value_reg_reg[2]_0 [0]),
        .I2(\Counter_Value_reg_reg_n_0_[2] ),
        .I3(Q[0]),
        .I4(Q[1]),
        .O(Counter_Value_Next[2]));
  LUT6 #(
    .INIT(64'h0EE0E0E0E0E0E0E0)) 
    \Counter_Value_reg[3]_i_2 
       (.I0(\Counter_Value_reg_reg[2]_0 [1]),
        .I1(\Counter_Value_reg_reg[2]_0 [0]),
        .I2(\Counter_Value_reg_reg_n_0_[3] ),
        .I3(\Counter_Value_reg_reg_n_0_[2] ),
        .I4(Q[1]),
        .I5(Q[0]),
        .O(Counter_Value_Next[3]));
  FDCE \Counter_Value_reg_reg[0] 
       (.C(clk),
        .CE(\Counter_Value_reg_reg[3]_0 ),
        .CLR(\Counter_Value_reg_reg[3]_1 ),
        .D(D[0]),
        .Q(Q[0]));
  FDCE \Counter_Value_reg_reg[1] 
       (.C(clk),
        .CE(\Counter_Value_reg_reg[3]_0 ),
        .CLR(\Counter_Value_reg_reg[3]_1 ),
        .D(D[1]),
        .Q(Q[1]));
  FDCE \Counter_Value_reg_reg[2] 
       (.C(clk),
        .CE(\Counter_Value_reg_reg[3]_0 ),
        .CLR(\Counter_Value_reg_reg[3]_1 ),
        .D(Counter_Value_Next[2]),
        .Q(\Counter_Value_reg_reg_n_0_[2] ));
  FDCE \Counter_Value_reg_reg[3] 
       (.C(clk),
        .CE(\Counter_Value_reg_reg[3]_0 ),
        .CLR(\Counter_Value_reg_reg[3]_1 ),
        .D(Counter_Value_Next[3]),
        .Q(\Counter_Value_reg_reg_n_0_[3] ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'hFFEF)) 
    \FSM_onehot_current_state[4]_i_2 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(\Counter_Value_reg_reg_n_0_[3] ),
        .I3(\Counter_Value_reg_reg_n_0_[2] ),
        .O(\Counter_Value_reg_reg[1]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT5 #(
    .INIT(32'hFFFB0000)) 
    \RX_Shift_Register_reg[7]_i_1 
       (.I0(\Counter_Value_reg_reg_n_0_[2] ),
        .I1(\Counter_Value_reg_reg_n_0_[3] ),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(\Counter_Value_reg_reg[2]_0 [1]),
        .O(E));
endmodule

(* ORIG_REF_NAME = "GENERAL_COUNTER" *) 
module design_2_UART_0_0_GENERAL_COUNTER__parameterized1
   (D,
    \FSM_onehot_current_state_reg[3] ,
    Q,
    \FSM_onehot_current_state_reg[2] ,
    \FSM_onehot_current_state_reg[2]_0 ,
    \FSM_onehot_current_state_reg[2]_1 ,
    \FSM_onehot_current_state_reg[2]_2 ,
    \FSM_onehot_current_state_reg[2]_3 ,
    \softlock_prevention_reg[0] ,
    \softlock_prevention_reg[0]_0 ,
    \softlock_prevention_reg[0]_1 ,
    softlock_prevention1,
    \softlock_prevention_reg[2] ,
    \softlock_prevention_reg[3] ,
    \softlock_prevention_reg[4] ,
    \softlock_prevention_reg[5] ,
    \softlock_prevention_reg[6] ,
    \softlock_prevention_reg[7] ,
    \softlock_prevention_reg[8] ,
    \softlock_prevention_reg[9] ,
    RX_Data_in,
    clk,
    \Counter_Value_reg_reg[4]_0 );
  output [1:0]D;
  output [9:0]\FSM_onehot_current_state_reg[3] ;
  input [4:0]Q;
  input \FSM_onehot_current_state_reg[2] ;
  input \FSM_onehot_current_state_reg[2]_0 ;
  input \FSM_onehot_current_state_reg[2]_1 ;
  input \FSM_onehot_current_state_reg[2]_2 ;
  input \FSM_onehot_current_state_reg[2]_3 ;
  input \softlock_prevention_reg[0] ;
  input \softlock_prevention_reg[0]_0 ;
  input [0:0]\softlock_prevention_reg[0]_1 ;
  input [0:0]softlock_prevention1;
  input \softlock_prevention_reg[2] ;
  input \softlock_prevention_reg[3] ;
  input \softlock_prevention_reg[4] ;
  input \softlock_prevention_reg[5] ;
  input \softlock_prevention_reg[6] ;
  input \softlock_prevention_reg[7] ;
  input \softlock_prevention_reg[8] ;
  input \softlock_prevention_reg[9] ;
  input RX_Data_in;
  input clk;
  input \Counter_Value_reg_reg[4]_0 ;

  wire [4:1]Counter_Value_Next;
  wire \Counter_Value_reg[0]_i_1__0_n_0 ;
  wire \Counter_Value_reg_reg[4]_0 ;
  wire \Counter_Value_reg_reg_n_0_[0] ;
  wire \Counter_Value_reg_reg_n_0_[1] ;
  wire \Counter_Value_reg_reg_n_0_[2] ;
  wire \Counter_Value_reg_reg_n_0_[3] ;
  wire \Counter_Value_reg_reg_n_0_[4] ;
  wire [1:0]D;
  wire \FSM_onehot_current_state[2]_i_3_n_0 ;
  wire \FSM_onehot_current_state_reg[2] ;
  wire \FSM_onehot_current_state_reg[2]_0 ;
  wire \FSM_onehot_current_state_reg[2]_1 ;
  wire \FSM_onehot_current_state_reg[2]_2 ;
  wire \FSM_onehot_current_state_reg[2]_3 ;
  wire [9:0]\FSM_onehot_current_state_reg[3] ;
  wire [4:0]Q;
  wire RX_Data_in;
  wire clk;
  wire [0:0]softlock_prevention1;
  wire \softlock_prevention[9]_i_2_n_0 ;
  wire \softlock_prevention_reg[0] ;
  wire \softlock_prevention_reg[0]_0 ;
  wire [0:0]\softlock_prevention_reg[0]_1 ;
  wire \softlock_prevention_reg[2] ;
  wire \softlock_prevention_reg[3] ;
  wire \softlock_prevention_reg[4] ;
  wire \softlock_prevention_reg[5] ;
  wire \softlock_prevention_reg[6] ;
  wire \softlock_prevention_reg[7] ;
  wire \softlock_prevention_reg[8] ;
  wire \softlock_prevention_reg[9] ;

  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \Counter_Value_reg[0]_i_1__0 
       (.I0(Q[1]),
        .I1(\Counter_Value_reg_reg_n_0_[0] ),
        .O(\Counter_Value_reg[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h60)) 
    \Counter_Value_reg[1]_i_1__0 
       (.I0(\Counter_Value_reg_reg_n_0_[1] ),
        .I1(\Counter_Value_reg_reg_n_0_[0] ),
        .I2(Q[1]),
        .O(Counter_Value_Next[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h6A00)) 
    \Counter_Value_reg[2]_i_1__0 
       (.I0(\Counter_Value_reg_reg_n_0_[2] ),
        .I1(\Counter_Value_reg_reg_n_0_[0] ),
        .I2(\Counter_Value_reg_reg_n_0_[1] ),
        .I3(Q[1]),
        .O(Counter_Value_Next[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h6AAA0000)) 
    \Counter_Value_reg[3]_i_1 
       (.I0(\Counter_Value_reg_reg_n_0_[3] ),
        .I1(\Counter_Value_reg_reg_n_0_[2] ),
        .I2(\Counter_Value_reg_reg_n_0_[1] ),
        .I3(\Counter_Value_reg_reg_n_0_[0] ),
        .I4(Q[1]),
        .O(Counter_Value_Next[3]));
  LUT6 #(
    .INIT(64'h6AAAAAAA00000000)) 
    \Counter_Value_reg[4]_i_1 
       (.I0(\Counter_Value_reg_reg_n_0_[4] ),
        .I1(\Counter_Value_reg_reg_n_0_[1] ),
        .I2(\Counter_Value_reg_reg_n_0_[0] ),
        .I3(\Counter_Value_reg_reg_n_0_[3] ),
        .I4(\Counter_Value_reg_reg_n_0_[2] ),
        .I5(Q[1]),
        .O(Counter_Value_Next[4]));
  FDCE \Counter_Value_reg_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4]_0 ),
        .D(\Counter_Value_reg[0]_i_1__0_n_0 ),
        .Q(\Counter_Value_reg_reg_n_0_[0] ));
  FDCE \Counter_Value_reg_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4]_0 ),
        .D(Counter_Value_Next[1]),
        .Q(\Counter_Value_reg_reg_n_0_[1] ));
  FDCE \Counter_Value_reg_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4]_0 ),
        .D(Counter_Value_Next[2]),
        .Q(\Counter_Value_reg_reg_n_0_[2] ));
  FDCE \Counter_Value_reg_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4]_0 ),
        .D(Counter_Value_Next[3]),
        .Q(\Counter_Value_reg_reg_n_0_[3] ));
  FDCE \Counter_Value_reg_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4]_0 ),
        .D(Counter_Value_Next[4]),
        .Q(\Counter_Value_reg_reg_n_0_[4] ));
  LUT5 #(
    .INIT(32'h0080F080)) 
    \FSM_onehot_current_state[1]_i_1__0 
       (.I0(Q[1]),
        .I1(\FSM_onehot_current_state[2]_i_3_n_0 ),
        .I2(\FSM_onehot_current_state_reg[2]_1 ),
        .I3(Q[0]),
        .I4(RX_Data_in),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hFF00F200F200F200)) 
    \FSM_onehot_current_state[2]_i_1 
       (.I0(\FSM_onehot_current_state_reg[2] ),
        .I1(\FSM_onehot_current_state[2]_i_3_n_0 ),
        .I2(\FSM_onehot_current_state_reg[2]_0 ),
        .I3(\FSM_onehot_current_state_reg[2]_1 ),
        .I4(\FSM_onehot_current_state_reg[2]_2 ),
        .I5(\FSM_onehot_current_state_reg[2]_3 ),
        .O(D[1]));
  LUT5 #(
    .INIT(32'hFFFFFFEF)) 
    \FSM_onehot_current_state[2]_i_3 
       (.I0(\Counter_Value_reg_reg_n_0_[0] ),
        .I1(\Counter_Value_reg_reg_n_0_[3] ),
        .I2(\Counter_Value_reg_reg_n_0_[4] ),
        .I3(\Counter_Value_reg_reg_n_0_[2] ),
        .I4(\Counter_Value_reg_reg_n_0_[1] ),
        .O(\FSM_onehot_current_state[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000011100001)) 
    \softlock_prevention[0]_i_1 
       (.I0(\softlock_prevention[9]_i_2_n_0 ),
        .I1(\softlock_prevention_reg[0] ),
        .I2(Q[2]),
        .I3(Q[3]),
        .I4(\softlock_prevention_reg[0]_0 ),
        .I5(\softlock_prevention_reg[0]_1 ),
        .O(\FSM_onehot_current_state_reg[3] [0]));
  LUT6 #(
    .INIT(64'h1110000100000000)) 
    \softlock_prevention[1]_i_1 
       (.I0(\softlock_prevention[9]_i_2_n_0 ),
        .I1(\softlock_prevention_reg[0] ),
        .I2(Q[2]),
        .I3(Q[3]),
        .I4(\softlock_prevention_reg[0]_0 ),
        .I5(softlock_prevention1),
        .O(\FSM_onehot_current_state_reg[3] [1]));
  LUT6 #(
    .INIT(64'h1110000100000000)) 
    \softlock_prevention[2]_i_1 
       (.I0(\softlock_prevention[9]_i_2_n_0 ),
        .I1(\softlock_prevention_reg[0] ),
        .I2(Q[2]),
        .I3(Q[3]),
        .I4(\softlock_prevention_reg[0]_0 ),
        .I5(\softlock_prevention_reg[2] ),
        .O(\FSM_onehot_current_state_reg[3] [2]));
  LUT6 #(
    .INIT(64'h1110000100000000)) 
    \softlock_prevention[3]_i_1 
       (.I0(\softlock_prevention[9]_i_2_n_0 ),
        .I1(\softlock_prevention_reg[0] ),
        .I2(Q[2]),
        .I3(Q[3]),
        .I4(\softlock_prevention_reg[0]_0 ),
        .I5(\softlock_prevention_reg[3] ),
        .O(\FSM_onehot_current_state_reg[3] [3]));
  LUT6 #(
    .INIT(64'h1110000100000000)) 
    \softlock_prevention[4]_i_1 
       (.I0(\softlock_prevention[9]_i_2_n_0 ),
        .I1(\softlock_prevention_reg[0] ),
        .I2(Q[2]),
        .I3(Q[3]),
        .I4(\softlock_prevention_reg[0]_0 ),
        .I5(\softlock_prevention_reg[4] ),
        .O(\FSM_onehot_current_state_reg[3] [4]));
  LUT6 #(
    .INIT(64'h1110000100000000)) 
    \softlock_prevention[5]_i_1 
       (.I0(\softlock_prevention[9]_i_2_n_0 ),
        .I1(\softlock_prevention_reg[0] ),
        .I2(Q[2]),
        .I3(Q[3]),
        .I4(\softlock_prevention_reg[0]_0 ),
        .I5(\softlock_prevention_reg[5] ),
        .O(\FSM_onehot_current_state_reg[3] [5]));
  LUT6 #(
    .INIT(64'h1110000100000000)) 
    \softlock_prevention[6]_i_1 
       (.I0(\softlock_prevention[9]_i_2_n_0 ),
        .I1(\softlock_prevention_reg[0] ),
        .I2(Q[2]),
        .I3(Q[3]),
        .I4(\softlock_prevention_reg[0]_0 ),
        .I5(\softlock_prevention_reg[6] ),
        .O(\FSM_onehot_current_state_reg[3] [6]));
  LUT6 #(
    .INIT(64'h1110000100000000)) 
    \softlock_prevention[7]_i_1 
       (.I0(\softlock_prevention[9]_i_2_n_0 ),
        .I1(\softlock_prevention_reg[0] ),
        .I2(Q[2]),
        .I3(Q[3]),
        .I4(\softlock_prevention_reg[0]_0 ),
        .I5(\softlock_prevention_reg[7] ),
        .O(\FSM_onehot_current_state_reg[3] [7]));
  LUT6 #(
    .INIT(64'h1110000100000000)) 
    \softlock_prevention[8]_i_1 
       (.I0(\softlock_prevention[9]_i_2_n_0 ),
        .I1(\softlock_prevention_reg[0] ),
        .I2(Q[2]),
        .I3(Q[3]),
        .I4(\softlock_prevention_reg[0]_0 ),
        .I5(\softlock_prevention_reg[8] ),
        .O(\FSM_onehot_current_state_reg[3] [8]));
  LUT6 #(
    .INIT(64'h1110000100000000)) 
    \softlock_prevention[9]_i_1 
       (.I0(\softlock_prevention[9]_i_2_n_0 ),
        .I1(\softlock_prevention_reg[0] ),
        .I2(Q[2]),
        .I3(Q[3]),
        .I4(\softlock_prevention_reg[0]_0 ),
        .I5(\softlock_prevention_reg[9] ),
        .O(\FSM_onehot_current_state_reg[3] [9]));
  LUT6 #(
    .INIT(64'h1015303F1015CFC0)) 
    \softlock_prevention[9]_i_2 
       (.I0(\FSM_onehot_current_state[2]_i_3_n_0 ),
        .I1(Q[3]),
        .I2(RX_Data_in),
        .I3(Q[0]),
        .I4(Q[1]),
        .I5(Q[4]),
        .O(\softlock_prevention[9]_i_2_n_0 ));
endmodule

(* ORIG_REF_NAME = "RX_SHIFT_REGISTER" *) 
module design_2_UART_0_0_RX_SHIFT_REGISTER
   (RX_Data_out,
    E,
    RX_Data_in,
    clk,
    \RX_Shift_Register_reg_reg[7]_0 );
  output [7:0]RX_Data_out;
  input [0:0]E;
  input RX_Data_in;
  input clk;
  input \RX_Shift_Register_reg_reg[7]_0 ;

  wire [0:0]E;
  wire RX_Data_in;
  wire [7:0]RX_Data_out;
  wire \RX_Shift_Register_reg_reg[7]_0 ;
  wire clk;

  FDPE \RX_Shift_Register_reg_reg[0] 
       (.C(clk),
        .CE(E),
        .D(RX_Data_out[1]),
        .PRE(\RX_Shift_Register_reg_reg[7]_0 ),
        .Q(RX_Data_out[0]));
  FDPE \RX_Shift_Register_reg_reg[1] 
       (.C(clk),
        .CE(E),
        .D(RX_Data_out[2]),
        .PRE(\RX_Shift_Register_reg_reg[7]_0 ),
        .Q(RX_Data_out[1]));
  FDPE \RX_Shift_Register_reg_reg[2] 
       (.C(clk),
        .CE(E),
        .D(RX_Data_out[3]),
        .PRE(\RX_Shift_Register_reg_reg[7]_0 ),
        .Q(RX_Data_out[2]));
  FDPE \RX_Shift_Register_reg_reg[3] 
       (.C(clk),
        .CE(E),
        .D(RX_Data_out[4]),
        .PRE(\RX_Shift_Register_reg_reg[7]_0 ),
        .Q(RX_Data_out[3]));
  FDPE \RX_Shift_Register_reg_reg[4] 
       (.C(clk),
        .CE(E),
        .D(RX_Data_out[5]),
        .PRE(\RX_Shift_Register_reg_reg[7]_0 ),
        .Q(RX_Data_out[4]));
  FDPE \RX_Shift_Register_reg_reg[5] 
       (.C(clk),
        .CE(E),
        .D(RX_Data_out[6]),
        .PRE(\RX_Shift_Register_reg_reg[7]_0 ),
        .Q(RX_Data_out[5]));
  FDPE \RX_Shift_Register_reg_reg[6] 
       (.C(clk),
        .CE(E),
        .D(RX_Data_out[7]),
        .PRE(\RX_Shift_Register_reg_reg[7]_0 ),
        .Q(RX_Data_out[6]));
  FDPE \RX_Shift_Register_reg_reg[7] 
       (.C(clk),
        .CE(E),
        .D(RX_Data_in),
        .PRE(\RX_Shift_Register_reg_reg[7]_0 ),
        .Q(RX_Data_out[7]));
endmodule

(* ORIG_REF_NAME = "UART" *) 
module design_2_UART_0_0_UART
   (RX_Data_Ready,
    RX_Data_out,
    TX_Data_out,
    TX_Ready_To_Send,
    clk,
    TX_en,
    TX_Data_in,
    UART_clk,
    RX_Data_in,
    reset_b,
    uart_aresetn);
  output RX_Data_Ready;
  output [7:0]RX_Data_out;
  output TX_Data_out;
  output TX_Ready_To_Send;
  input clk;
  input TX_en;
  input [7:0]TX_Data_in;
  input UART_clk;
  input RX_Data_in;
  input reset_b;
  input uart_aresetn;

  wire RX_Data_Ready;
  wire RX_Data_in;
  wire [7:0]RX_Data_out;
  wire [7:0]TX_Data_in;
  wire TX_Data_out;
  wire TX_Ready_To_Send;
  wire TX_en;
  wire UART_RX_inst_n_1;
  wire UART_clk;
  wire clk;
  wire reset_b;
  wire uart_aresetn;

  design_2_UART_0_0_UART_RX UART_RX_inst
       (.RX_Data_Ready(RX_Data_Ready),
        .RX_Data_in(RX_Data_in),
        .RX_Data_out(RX_Data_out),
        .clk(clk),
        .reset_b(reset_b),
        .rst(UART_RX_inst_n_1));
  design_2_UART_0_0_UART_TX UART_TX_inst
       (.TX_Data_in(TX_Data_in),
        .TX_Data_out(TX_Data_out),
        .TX_Ready_To_Send(TX_Ready_To_Send),
        .TX_en(TX_en),
        .UART_clk(UART_clk),
        .clk(clk),
        .rst(UART_RX_inst_n_1),
        .uart_aresetn(uart_aresetn));
endmodule

(* ORIG_REF_NAME = "UART_RX" *) 
module design_2_UART_0_0_UART_RX
   (RX_Data_Ready,
    rst,
    RX_Data_out,
    clk,
    RX_Data_in,
    reset_b);
  output RX_Data_Ready;
  output rst;
  output [7:0]RX_Data_out;
  input clk;
  input RX_Data_in;
  input reset_b;

  wire [1:0]\BIT_COUNTER/Counter_Value_Next ;
  wire [0:0]Baud_Counter_sel;
  wire [0:0]Counter_Value_reg;
  wire RX_Data_Ready;
  wire RX_Data_in;
  wire [7:0]RX_Data_out;
  wire UART_RX_CONTROLLER_inst_n_0;
  wire UART_RX_CONTROLLER_inst_n_2;
  wire UART_RX_CONTROLLER_inst_n_4;
  wire UART_RX_DATAPATH_inst_n_0;
  wire UART_RX_DATAPATH_inst_n_1;
  wire UART_RX_DATAPATH_inst_n_2;
  wire UART_RX_DATAPATH_inst_n_5;
  wire UART_RX_DATAPATH_inst_n_6;
  wire UART_RX_DATAPATH_inst_n_7;
  wire clk;
  wire reset_b;
  wire rst;

  design_2_UART_0_0_UART_RX_CONTROLLER UART_RX_CONTROLLER_inst
       (.Counter_Value_reg(Counter_Value_reg),
        .\Counter_Value_reg_reg[1] ({UART_RX_DATAPATH_inst_n_0,UART_RX_DATAPATH_inst_n_1}),
        .\Counter_Value_reg_reg[4] (rst),
        .D(\BIT_COUNTER/Counter_Value_Next ),
        .E(UART_RX_CONTROLLER_inst_n_0),
        .\FSM_onehot_current_state_reg[2]_0 (UART_RX_CONTROLLER_inst_n_4),
        .\FSM_onehot_current_state_reg[2]_1 (UART_RX_DATAPATH_inst_n_5),
        .\FSM_onehot_current_state_reg[4]_0 (UART_RX_DATAPATH_inst_n_2),
        .Q({RX_Data_Ready,UART_RX_CONTROLLER_inst_n_2,Baud_Counter_sel}),
        .RX_Data_in(RX_Data_in),
        .clk(clk),
        .\softlock_prevention_reg[0]_0 (UART_RX_DATAPATH_inst_n_6),
        .\softlock_prevention_reg[0]_1 (UART_RX_DATAPATH_inst_n_7));
  design_2_UART_0_0_UART_RX_DATAPATH UART_RX_DATAPATH_inst
       (.\Counter_Value_reg_reg[0] (Counter_Value_reg),
        .\Counter_Value_reg_reg[0]_0 (UART_RX_CONTROLLER_inst_n_4),
        .\Counter_Value_reg_reg[1] (UART_RX_DATAPATH_inst_n_2),
        .\Counter_Value_reg_reg[2] ({UART_RX_CONTROLLER_inst_n_2,Baud_Counter_sel}),
        .\Counter_Value_reg_reg[6] (UART_RX_DATAPATH_inst_n_7),
        .\Counter_Value_reg_reg[7] (UART_RX_DATAPATH_inst_n_6),
        .\Counter_Value_reg_reg[8] (UART_RX_DATAPATH_inst_n_5),
        .D(\BIT_COUNTER/Counter_Value_Next ),
        .E(UART_RX_CONTROLLER_inst_n_0),
        .Q({UART_RX_DATAPATH_inst_n_0,UART_RX_DATAPATH_inst_n_1}),
        .RX_Data_in(RX_Data_in),
        .RX_Data_out(RX_Data_out),
        .clk(clk),
        .reset_b(reset_b),
        .reset_b_0(rst));
endmodule

(* ORIG_REF_NAME = "UART_RX_CONTROLLER" *) 
module design_2_UART_0_0_UART_RX_CONTROLLER
   (E,
    Q,
    \FSM_onehot_current_state_reg[2]_0 ,
    D,
    Counter_Value_reg,
    \FSM_onehot_current_state_reg[2]_1 ,
    \FSM_onehot_current_state_reg[4]_0 ,
    \softlock_prevention_reg[0]_0 ,
    \softlock_prevention_reg[0]_1 ,
    RX_Data_in,
    \Counter_Value_reg_reg[1] ,
    clk,
    \Counter_Value_reg_reg[4] );
  output [0:0]E;
  output [2:0]Q;
  output \FSM_onehot_current_state_reg[2]_0 ;
  output [1:0]D;
  input [0:0]Counter_Value_reg;
  input \FSM_onehot_current_state_reg[2]_1 ;
  input \FSM_onehot_current_state_reg[4]_0 ;
  input \softlock_prevention_reg[0]_0 ;
  input \softlock_prevention_reg[0]_1 ;
  input RX_Data_in;
  input [1:0]\Counter_Value_reg_reg[1] ;
  input clk;
  input \Counter_Value_reg_reg[4] ;

  wire [0:0]Counter_Value_reg;
  wire [1:0]\Counter_Value_reg_reg[1] ;
  wire \Counter_Value_reg_reg[4] ;
  wire [1:0]D;
  wire [0:0]E;
  wire \FSM_onehot_current_state[0]_i_1__0_n_0 ;
  wire \FSM_onehot_current_state[2]_i_2_n_0 ;
  wire \FSM_onehot_current_state[2]_i_4_n_0 ;
  wire \FSM_onehot_current_state[2]_i_5_n_0 ;
  wire \FSM_onehot_current_state[3]_i_1__0_n_0 ;
  wire \FSM_onehot_current_state[4]_i_1_n_0 ;
  wire \FSM_onehot_current_state[4]_i_3_n_0 ;
  wire \FSM_onehot_current_state[4]_i_4_n_0 ;
  wire \FSM_onehot_current_state[5]_i_1_n_0 ;
  wire \FSM_onehot_current_state[5]_i_2_n_0 ;
  wire \FSM_onehot_current_state[5]_i_3_n_0 ;
  wire \FSM_onehot_current_state[5]_i_4_n_0 ;
  wire \FSM_onehot_current_state_reg[2]_0 ;
  wire \FSM_onehot_current_state_reg[2]_1 ;
  wire \FSM_onehot_current_state_reg[4]_0 ;
  wire \FSM_onehot_current_state_reg_n_0_[0] ;
  wire \FSM_onehot_current_state_reg_n_0_[1] ;
  wire \FSM_onehot_current_state_reg_n_0_[4] ;
  wire [2:0]Q;
  wire RX_Data_in;
  wire STALL_COUNTER_n_0;
  wire STALL_COUNTER_n_1;
  wire clk;
  wire [9:0]p_0_in__0;
  wire [1:1]softlock_prevention1;
  wire \softlock_prevention[2]_i_2_n_0 ;
  wire \softlock_prevention[3]_i_2_n_0 ;
  wire \softlock_prevention[4]_i_2_n_0 ;
  wire \softlock_prevention[5]_i_2_n_0 ;
  wire \softlock_prevention[6]_i_2_n_0 ;
  wire \softlock_prevention[7]_i_2_n_0 ;
  wire \softlock_prevention[8]_i_2_n_0 ;
  wire \softlock_prevention[9]_i_3_n_0 ;
  wire \softlock_prevention[9]_i_4_n_0 ;
  wire \softlock_prevention[9]_i_5_n_0 ;
  wire \softlock_prevention[9]_i_6_n_0 ;
  wire [9:0]softlock_prevention_reg;
  wire \softlock_prevention_reg[0]_0 ;
  wire \softlock_prevention_reg[0]_1 ;

  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \Counter_Value_reg[0]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(\Counter_Value_reg_reg[1] [0]),
        .O(D[0]));
  LUT2 #(
    .INIT(4'h2)) 
    \Counter_Value_reg[0]_i_1__1 
       (.I0(Q[0]),
        .I1(Counter_Value_reg),
        .O(\FSM_onehot_current_state_reg[2]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h0EE0)) 
    \Counter_Value_reg[1]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(\Counter_Value_reg_reg[1] [1]),
        .I3(\Counter_Value_reg_reg[1] [0]),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \Counter_Value_reg[3]_i_1__1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .O(E));
  LUT6 #(
    .INIT(64'hD5D5D5D5D5D5D5DF)) 
    \FSM_onehot_current_state[0]_i_1__0 
       (.I0(\FSM_onehot_current_state[5]_i_3_n_0 ),
        .I1(RX_Data_in),
        .I2(\FSM_onehot_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_current_state_reg_n_0_[1] ),
        .I4(\FSM_onehot_current_state[5]_i_2_n_0 ),
        .I5(\FSM_onehot_current_state_reg_n_0_[4] ),
        .O(\FSM_onehot_current_state[0]_i_1__0_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_onehot_current_state[2]_i_2 
       (.I0(\FSM_onehot_current_state_reg_n_0_[1] ),
        .I1(\FSM_onehot_current_state_reg_n_0_[0] ),
        .O(\FSM_onehot_current_state[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h00100000)) 
    \FSM_onehot_current_state[2]_i_4 
       (.I0(\FSM_onehot_current_state_reg_n_0_[0] ),
        .I1(\FSM_onehot_current_state_reg_n_0_[1] ),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(\FSM_onehot_current_state_reg[4]_0 ),
        .O(\FSM_onehot_current_state[2]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h10)) 
    \FSM_onehot_current_state[2]_i_5 
       (.I0(\FSM_onehot_current_state_reg_n_0_[1] ),
        .I1(\FSM_onehot_current_state_reg_n_0_[0] ),
        .I2(Q[0]),
        .O(\FSM_onehot_current_state[2]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h01000000)) 
    \FSM_onehot_current_state[3]_i_1__0 
       (.I0(\FSM_onehot_current_state_reg[2]_1 ),
        .I1(\FSM_onehot_current_state_reg_n_0_[1] ),
        .I2(\FSM_onehot_current_state_reg_n_0_[0] ),
        .I3(Q[0]),
        .I4(\FSM_onehot_current_state[5]_i_3_n_0 ),
        .O(\FSM_onehot_current_state[3]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h040C040000000000)) 
    \FSM_onehot_current_state[4]_i_1 
       (.I0(\FSM_onehot_current_state_reg[4]_0 ),
        .I1(\FSM_onehot_current_state[5]_i_3_n_0 ),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(\FSM_onehot_current_state[4]_i_3_n_0 ),
        .I5(\FSM_onehot_current_state[4]_i_4_n_0 ),
        .O(\FSM_onehot_current_state[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_onehot_current_state[4]_i_3 
       (.I0(\FSM_onehot_current_state_reg_n_0_[4] ),
        .I1(RX_Data_in),
        .O(\FSM_onehot_current_state[4]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \FSM_onehot_current_state[4]_i_4 
       (.I0(\FSM_onehot_current_state_reg_n_0_[0] ),
        .I1(\FSM_onehot_current_state_reg_n_0_[1] ),
        .O(\FSM_onehot_current_state[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000100000000000)) 
    \FSM_onehot_current_state[5]_i_1 
       (.I0(\FSM_onehot_current_state_reg_n_0_[0] ),
        .I1(\FSM_onehot_current_state_reg_n_0_[1] ),
        .I2(RX_Data_in),
        .I3(\FSM_onehot_current_state_reg_n_0_[4] ),
        .I4(\FSM_onehot_current_state[5]_i_2_n_0 ),
        .I5(\FSM_onehot_current_state[5]_i_3_n_0 ),
        .O(\FSM_onehot_current_state[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_onehot_current_state[5]_i_2 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\FSM_onehot_current_state[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hF7FFFFFF)) 
    \FSM_onehot_current_state[5]_i_3 
       (.I0(softlock_prevention_reg[8]),
        .I1(softlock_prevention_reg[6]),
        .I2(\FSM_onehot_current_state[5]_i_4_n_0 ),
        .I3(softlock_prevention_reg[7]),
        .I4(softlock_prevention_reg[9]),
        .O(\FSM_onehot_current_state[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \FSM_onehot_current_state[5]_i_4 
       (.I0(softlock_prevention_reg[4]),
        .I1(softlock_prevention_reg[2]),
        .I2(softlock_prevention_reg[0]),
        .I3(softlock_prevention_reg[1]),
        .I4(softlock_prevention_reg[3]),
        .I5(softlock_prevention_reg[5]),
        .O(\FSM_onehot_current_state[5]_i_4_n_0 ));
  (* FSM_ENCODED_STATES = "IDLE:000001,STALL_TEST:000010,SAMPLE:001000,COUNT_TO_54:000100,WAIT_FOR_STOP_BIT:010000,DATA_READY:100000" *) 
  FDPE #(
    .INIT(1'b1)) 
    \FSM_onehot_current_state_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\FSM_onehot_current_state[0]_i_1__0_n_0 ),
        .PRE(\Counter_Value_reg_reg[4] ),
        .Q(\FSM_onehot_current_state_reg_n_0_[0] ));
  (* FSM_ENCODED_STATES = "IDLE:000001,STALL_TEST:000010,SAMPLE:001000,COUNT_TO_54:000100,WAIT_FOR_STOP_BIT:010000,DATA_READY:100000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(STALL_COUNTER_n_1),
        .Q(\FSM_onehot_current_state_reg_n_0_[1] ));
  (* FSM_ENCODED_STATES = "IDLE:000001,STALL_TEST:000010,SAMPLE:001000,COUNT_TO_54:000100,WAIT_FOR_STOP_BIT:010000,DATA_READY:100000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(STALL_COUNTER_n_0),
        .Q(Q[0]));
  (* FSM_ENCODED_STATES = "IDLE:000001,STALL_TEST:000010,SAMPLE:001000,COUNT_TO_54:000100,WAIT_FOR_STOP_BIT:010000,DATA_READY:100000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(\FSM_onehot_current_state[3]_i_1__0_n_0 ),
        .Q(Q[1]));
  (* FSM_ENCODED_STATES = "IDLE:000001,STALL_TEST:000010,SAMPLE:001000,COUNT_TO_54:000100,WAIT_FOR_STOP_BIT:010000,DATA_READY:100000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(\FSM_onehot_current_state[4]_i_1_n_0 ),
        .Q(\FSM_onehot_current_state_reg_n_0_[4] ));
  (* FSM_ENCODED_STATES = "IDLE:000001,STALL_TEST:000010,SAMPLE:001000,COUNT_TO_54:000100,WAIT_FOR_STOP_BIT:010000,DATA_READY:100000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(\FSM_onehot_current_state[5]_i_1_n_0 ),
        .Q(Q[2]));
  design_2_UART_0_0_GENERAL_COUNTER__parameterized1 STALL_COUNTER
       (.\Counter_Value_reg_reg[4]_0 (\Counter_Value_reg_reg[4] ),
        .D({STALL_COUNTER_n_0,STALL_COUNTER_n_1}),
        .\FSM_onehot_current_state_reg[2] (\FSM_onehot_current_state[2]_i_2_n_0 ),
        .\FSM_onehot_current_state_reg[2]_0 (\FSM_onehot_current_state[2]_i_4_n_0 ),
        .\FSM_onehot_current_state_reg[2]_1 (\FSM_onehot_current_state[5]_i_3_n_0 ),
        .\FSM_onehot_current_state_reg[2]_2 (\FSM_onehot_current_state_reg[2]_1 ),
        .\FSM_onehot_current_state_reg[2]_3 (\FSM_onehot_current_state[2]_i_5_n_0 ),
        .\FSM_onehot_current_state_reg[3] (p_0_in__0),
        .Q({Q[2],\FSM_onehot_current_state_reg_n_0_[4] ,Q[1],\FSM_onehot_current_state_reg_n_0_[1] ,\FSM_onehot_current_state_reg_n_0_[0] }),
        .RX_Data_in(RX_Data_in),
        .clk(clk),
        .softlock_prevention1(softlock_prevention1),
        .\softlock_prevention_reg[0] (\softlock_prevention[9]_i_3_n_0 ),
        .\softlock_prevention_reg[0]_0 (\softlock_prevention[9]_i_4_n_0 ),
        .\softlock_prevention_reg[0]_1 (softlock_prevention_reg[0]),
        .\softlock_prevention_reg[2] (\softlock_prevention[2]_i_2_n_0 ),
        .\softlock_prevention_reg[3] (\softlock_prevention[3]_i_2_n_0 ),
        .\softlock_prevention_reg[4] (\softlock_prevention[4]_i_2_n_0 ),
        .\softlock_prevention_reg[5] (\softlock_prevention[5]_i_2_n_0 ),
        .\softlock_prevention_reg[6] (\softlock_prevention[6]_i_2_n_0 ),
        .\softlock_prevention_reg[7] (\softlock_prevention[7]_i_2_n_0 ),
        .\softlock_prevention_reg[8] (\softlock_prevention[8]_i_2_n_0 ),
        .\softlock_prevention_reg[9] (\softlock_prevention[9]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \softlock_prevention[1]_i_2 
       (.I0(softlock_prevention_reg[0]),
        .I1(softlock_prevention_reg[1]),
        .O(softlock_prevention1));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \softlock_prevention[2]_i_2 
       (.I0(softlock_prevention_reg[1]),
        .I1(softlock_prevention_reg[0]),
        .I2(softlock_prevention_reg[2]),
        .O(\softlock_prevention[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \softlock_prevention[3]_i_2 
       (.I0(softlock_prevention_reg[2]),
        .I1(softlock_prevention_reg[0]),
        .I2(softlock_prevention_reg[1]),
        .I3(softlock_prevention_reg[3]),
        .O(\softlock_prevention[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \softlock_prevention[4]_i_2 
       (.I0(softlock_prevention_reg[3]),
        .I1(softlock_prevention_reg[1]),
        .I2(softlock_prevention_reg[0]),
        .I3(softlock_prevention_reg[2]),
        .I4(softlock_prevention_reg[4]),
        .O(\softlock_prevention[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \softlock_prevention[5]_i_2 
       (.I0(softlock_prevention_reg[4]),
        .I1(softlock_prevention_reg[2]),
        .I2(softlock_prevention_reg[0]),
        .I3(softlock_prevention_reg[1]),
        .I4(softlock_prevention_reg[3]),
        .I5(softlock_prevention_reg[5]),
        .O(\softlock_prevention[5]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \softlock_prevention[6]_i_2 
       (.I0(\FSM_onehot_current_state[5]_i_4_n_0 ),
        .I1(softlock_prevention_reg[6]),
        .O(\softlock_prevention[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hD2)) 
    \softlock_prevention[7]_i_2 
       (.I0(softlock_prevention_reg[6]),
        .I1(\FSM_onehot_current_state[5]_i_4_n_0 ),
        .I2(softlock_prevention_reg[7]),
        .O(\softlock_prevention[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'hDF20)) 
    \softlock_prevention[8]_i_2 
       (.I0(softlock_prevention_reg[7]),
        .I1(\FSM_onehot_current_state[5]_i_4_n_0 ),
        .I2(softlock_prevention_reg[6]),
        .I3(softlock_prevention_reg[8]),
        .O(\softlock_prevention[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00010055000100AA)) 
    \softlock_prevention[9]_i_3 
       (.I0(\softlock_prevention[9]_i_6_n_0 ),
        .I1(\softlock_prevention_reg[0]_0 ),
        .I2(\softlock_prevention_reg[0]_1 ),
        .I3(\FSM_onehot_current_state_reg_n_0_[1] ),
        .I4(Q[0]),
        .I5(\FSM_onehot_current_state_reg_n_0_[4] ),
        .O(\softlock_prevention[9]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAEAEAEFFAEAEAEAE)) 
    \softlock_prevention[9]_i_4 
       (.I0(\FSM_onehot_current_state[4]_i_3_n_0 ),
        .I1(Q[1]),
        .I2(\FSM_onehot_current_state_reg[4]_0 ),
        .I3(\softlock_prevention_reg[0]_0 ),
        .I4(\softlock_prevention_reg[0]_1 ),
        .I5(Q[0]),
        .O(\softlock_prevention[9]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hF7FF0800)) 
    \softlock_prevention[9]_i_5 
       (.I0(softlock_prevention_reg[8]),
        .I1(softlock_prevention_reg[6]),
        .I2(\FSM_onehot_current_state[5]_i_4_n_0 ),
        .I3(softlock_prevention_reg[7]),
        .I4(softlock_prevention_reg[9]),
        .O(\softlock_prevention[9]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'hAFAE)) 
    \softlock_prevention[9]_i_6 
       (.I0(Q[1]),
        .I1(\FSM_onehot_current_state_reg_n_0_[4] ),
        .I2(RX_Data_in),
        .I3(\FSM_onehot_current_state_reg_n_0_[0] ),
        .O(\softlock_prevention[9]_i_6_n_0 ));
  FDCE \softlock_prevention_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(p_0_in__0[0]),
        .Q(softlock_prevention_reg[0]));
  FDCE \softlock_prevention_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(p_0_in__0[1]),
        .Q(softlock_prevention_reg[1]));
  FDCE \softlock_prevention_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(p_0_in__0[2]),
        .Q(softlock_prevention_reg[2]));
  FDCE \softlock_prevention_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(p_0_in__0[3]),
        .Q(softlock_prevention_reg[3]));
  FDCE \softlock_prevention_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(p_0_in__0[4]),
        .Q(softlock_prevention_reg[4]));
  FDCE \softlock_prevention_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(p_0_in__0[5]),
        .Q(softlock_prevention_reg[5]));
  FDCE \softlock_prevention_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(p_0_in__0[6]),
        .Q(softlock_prevention_reg[6]));
  FDCE \softlock_prevention_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(p_0_in__0[7]),
        .Q(softlock_prevention_reg[7]));
  FDCE \softlock_prevention_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(p_0_in__0[8]),
        .Q(softlock_prevention_reg[8]));
  FDCE \softlock_prevention_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .CLR(\Counter_Value_reg_reg[4] ),
        .D(p_0_in__0[9]),
        .Q(softlock_prevention_reg[9]));
endmodule

(* ORIG_REF_NAME = "UART_RX_DATAPATH" *) 
module design_2_UART_0_0_UART_RX_DATAPATH
   (Q,
    \Counter_Value_reg_reg[1] ,
    reset_b_0,
    \Counter_Value_reg_reg[0] ,
    \Counter_Value_reg_reg[8] ,
    \Counter_Value_reg_reg[7] ,
    \Counter_Value_reg_reg[6] ,
    RX_Data_out,
    \Counter_Value_reg_reg[2] ,
    reset_b,
    D,
    RX_Data_in,
    clk,
    \Counter_Value_reg_reg[0]_0 ,
    E);
  output [1:0]Q;
  output \Counter_Value_reg_reg[1] ;
  output reset_b_0;
  output [0:0]\Counter_Value_reg_reg[0] ;
  output \Counter_Value_reg_reg[8] ;
  output \Counter_Value_reg_reg[7] ;
  output \Counter_Value_reg_reg[6] ;
  output [7:0]RX_Data_out;
  input [1:0]\Counter_Value_reg_reg[2] ;
  input reset_b;
  input [1:0]D;
  input RX_Data_in;
  input clk;
  input \Counter_Value_reg_reg[0]_0 ;
  input [0:0]E;

  wire [0:0]\Counter_Value_reg_reg[0] ;
  wire \Counter_Value_reg_reg[0]_0 ;
  wire \Counter_Value_reg_reg[1] ;
  wire [1:0]\Counter_Value_reg_reg[2] ;
  wire \Counter_Value_reg_reg[6] ;
  wire \Counter_Value_reg_reg[7] ;
  wire \Counter_Value_reg_reg[8] ;
  wire [1:0]D;
  wire [0:0]E;
  wire [1:0]Q;
  wire RX_Data_in;
  wire [7:0]RX_Data_out;
  wire RX_Shift_Register_sel;
  wire clk;
  wire reset_b;
  wire reset_b_0;

  design_2_UART_0_0_GENERAL_COUNTER BAUD_COUNTER
       (.\Counter_Value_reg_reg[0]_0 (\Counter_Value_reg_reg[0] ),
        .\Counter_Value_reg_reg[0]_1 (\Counter_Value_reg_reg[0]_0 ),
        .\Counter_Value_reg_reg[1]_0 (\Counter_Value_reg_reg[2] [0]),
        .\Counter_Value_reg_reg[6]_0 (\Counter_Value_reg_reg[6] ),
        .\Counter_Value_reg_reg[7]_0 (\Counter_Value_reg_reg[7] ),
        .\Counter_Value_reg_reg[8]_0 (\Counter_Value_reg_reg[8] ),
        .clk(clk),
        .reset_b(reset_b),
        .reset_b_0(reset_b_0));
  design_2_UART_0_0_GENERAL_COUNTER__parameterized0 BIT_COUNTER
       (.\Counter_Value_reg_reg[1]_0 (\Counter_Value_reg_reg[1] ),
        .\Counter_Value_reg_reg[2]_0 (\Counter_Value_reg_reg[2] ),
        .\Counter_Value_reg_reg[3]_0 (E),
        .\Counter_Value_reg_reg[3]_1 (reset_b_0),
        .D(D),
        .E(RX_Shift_Register_sel),
        .Q(Q),
        .clk(clk));
  design_2_UART_0_0_RX_SHIFT_REGISTER RX_SHIFT_REGISTER_inst
       (.E(RX_Shift_Register_sel),
        .RX_Data_in(RX_Data_in),
        .RX_Data_out(RX_Data_out),
        .\RX_Shift_Register_reg_reg[7]_0 (reset_b_0),
        .clk(clk));
endmodule

(* ORIG_REF_NAME = "UART_TX" *) 
module design_2_UART_0_0_UART_TX
   (TX_Ready_To_Send,
    TX_Data_out,
    rst,
    clk,
    TX_en,
    TX_Data_in,
    UART_clk,
    uart_aresetn);
  output TX_Ready_To_Send;
  output TX_Data_out;
  input rst;
  input clk;
  input TX_en;
  input [7:0]TX_Data_in;
  input UART_clk;
  input uart_aresetn;

  wire Count_Reached;
  wire [2:1]TX_Bit_sel;
  wire [7:0]TX_Data_in;
  wire [7:0]TX_Data_in_576;
  wire TX_Data_out;
  wire TX_Ready_To_Send;
  wire TX_en;
  wire UART_TX_CONTROLLER_inst_n_4;
  wire UART_TX_DATAPATH_inst_n_2;
  wire UART_TX_DATAPATH_inst_n_4;
  wire UART_TX_DATAPATH_inst_n_8;
  wire UART_clk;
  wire clk;
  wire [1:0]count_val_register_reg;
  wire data_in_sel;
  wire empty;
  wire full;
  wire [1:0]p_0_in;
  wire rd_rst_busy;
  wire read_en;
  wire rst;
  wire [8:5]tx_bits_register;
  wire uart_aresetn;
  wire wr_rst_busy;
  wire NLW_MASTER_TO_UART_almost_empty_UNCONNECTED;
  wire NLW_MASTER_TO_UART_almost_full_UNCONNECTED;
  wire NLW_MASTER_TO_UART_data_valid_UNCONNECTED;
  wire NLW_MASTER_TO_UART_dbiterr_UNCONNECTED;
  wire NLW_MASTER_TO_UART_overflow_UNCONNECTED;
  wire NLW_MASTER_TO_UART_prog_empty_UNCONNECTED;
  wire NLW_MASTER_TO_UART_prog_full_UNCONNECTED;
  wire NLW_MASTER_TO_UART_sbiterr_UNCONNECTED;
  wire NLW_MASTER_TO_UART_underflow_UNCONNECTED;
  wire NLW_MASTER_TO_UART_wr_ack_UNCONNECTED;
  wire [0:0]NLW_MASTER_TO_UART_rd_data_count_UNCONNECTED;
  wire [0:0]NLW_MASTER_TO_UART_wr_data_count_UNCONNECTED;

  (* CASCADE_HEIGHT = "0" *) 
  (* CDC_SYNC_STAGES = "2" *) 
  (* DOUT_RESET_VALUE = "0" *) 
  (* ECC_MODE = "no_ecc" *) 
  (* EN_ADV_FEATURE_ASYNC = "16'b0000011100000111" *) 
  (* FIFO_MEMORY_TYPE = "auto" *) 
  (* FIFO_READ_LATENCY = "1" *) 
  (* FIFO_WRITE_DEPTH = "256" *) 
  (* FULL_RESET_VALUE = "0" *) 
  (* PROG_EMPTY_THRESH = "10" *) 
  (* PROG_FULL_THRESH = "10" *) 
  (* P_COMMON_CLOCK = "0" *) 
  (* P_ECC_MODE = "0" *) 
  (* P_FIFO_MEMORY_TYPE = "0" *) 
  (* P_READ_MODE = "0" *) 
  (* P_WAKEUP_TIME = "2" *) 
  (* RD_DATA_COUNT_WIDTH = "1" *) 
  (* READ_DATA_WIDTH = "8" *) 
  (* READ_MODE = "std" *) 
  (* RELATED_CLOCKS = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* USE_ADV_FEATURES = "0707" *) 
  (* WAKEUP_TIME = "0" *) 
  (* WRITE_DATA_WIDTH = "8" *) 
  (* WR_DATA_COUNT_WIDTH = "1" *) 
  (* XPM_MODULE = "TRUE" *) 
  design_2_UART_0_0_xpm_fifo_async MASTER_TO_UART
       (.almost_empty(NLW_MASTER_TO_UART_almost_empty_UNCONNECTED),
        .almost_full(NLW_MASTER_TO_UART_almost_full_UNCONNECTED),
        .data_valid(NLW_MASTER_TO_UART_data_valid_UNCONNECTED),
        .dbiterr(NLW_MASTER_TO_UART_dbiterr_UNCONNECTED),
        .din(TX_Data_in),
        .dout(TX_Data_in_576),
        .empty(empty),
        .full(full),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .overflow(NLW_MASTER_TO_UART_overflow_UNCONNECTED),
        .prog_empty(NLW_MASTER_TO_UART_prog_empty_UNCONNECTED),
        .prog_full(NLW_MASTER_TO_UART_prog_full_UNCONNECTED),
        .rd_clk(UART_clk),
        .rd_data_count(NLW_MASTER_TO_UART_rd_data_count_UNCONNECTED[0]),
        .rd_en(read_en),
        .rd_rst_busy(rd_rst_busy),
        .rst(rst),
        .sbiterr(NLW_MASTER_TO_UART_sbiterr_UNCONNECTED),
        .sleep(1'b0),
        .underflow(NLW_MASTER_TO_UART_underflow_UNCONNECTED),
        .wr_ack(NLW_MASTER_TO_UART_wr_ack_UNCONNECTED),
        .wr_clk(clk),
        .wr_data_count(NLW_MASTER_TO_UART_wr_data_count_UNCONNECTED[0]),
        .wr_en(TX_en),
        .wr_rst_busy(wr_rst_busy));
  LUT2 #(
    .INIT(4'h1)) 
    TX_Ready_To_Send_INST_0
       (.I0(wr_rst_busy),
        .I1(full),
        .O(TX_Ready_To_Send));
  design_2_UART_0_0_UART_TX_CONTROLLER UART_TX_CONTROLLER_inst
       (.Count_Reached(Count_Reached),
        .\FSM_onehot_current_state_reg[1]_0 (UART_TX_CONTROLLER_inst_n_4),
        .\FSM_onehot_current_state_reg[3]_0 (UART_TX_DATAPATH_inst_n_2),
        .\FSM_onehot_current_state_reg[7]_0 (TX_Bit_sel),
        .Q({data_in_sel,read_en}),
        .TX_Data_out(TX_Data_out),
        .TX_Data_out_0({tx_bits_register[8:7],tx_bits_register[5]}),
        .TX_Data_out_1(UART_TX_DATAPATH_inst_n_4),
        .TX_Data_out_2(UART_TX_DATAPATH_inst_n_8),
        .UART_clk(UART_clk),
        .count_val_register_reg(count_val_register_reg),
        .empty(empty),
        .p_0_in(p_0_in),
        .rd_rst_busy(rd_rst_busy));
  design_2_UART_0_0_UART_TX_DATAPATH UART_TX_DATAPATH_inst
       (.Count_Reached(Count_Reached),
        .D(TX_Data_in_576),
        .E(data_in_sel),
        .Q({tx_bits_register[8:7],tx_bits_register[5]}),
        .TX_Data_out(TX_Bit_sel),
        .UART_clk(UART_clk),
        .\count_val_register_reg[1]_0 (count_val_register_reg),
        .\count_val_register_reg[1]_1 (p_0_in),
        .\count_val_register_reg[2]_0 (UART_TX_CONTROLLER_inst_n_4),
        .\tx_bits_register_reg[1]_0 (UART_TX_DATAPATH_inst_n_8),
        .\tx_bits_register_reg[6]_0 (UART_TX_DATAPATH_inst_n_4),
        .uart_aresetn(uart_aresetn),
        .uart_aresetn_0(UART_TX_DATAPATH_inst_n_2));
endmodule

(* ORIG_REF_NAME = "UART_TX_CONTROLLER" *) 
module design_2_UART_0_0_UART_TX_CONTROLLER
   (Q,
    p_0_in,
    \FSM_onehot_current_state_reg[1]_0 ,
    TX_Data_out,
    \FSM_onehot_current_state_reg[7]_0 ,
    Count_Reached,
    empty,
    rd_rst_busy,
    count_val_register_reg,
    TX_Data_out_0,
    TX_Data_out_1,
    TX_Data_out_2,
    UART_clk,
    \FSM_onehot_current_state_reg[3]_0 );
  output [1:0]Q;
  output [1:0]p_0_in;
  output \FSM_onehot_current_state_reg[1]_0 ;
  output TX_Data_out;
  output [1:0]\FSM_onehot_current_state_reg[7]_0 ;
  input Count_Reached;
  input empty;
  input rd_rst_busy;
  input [1:0]count_val_register_reg;
  input [2:0]TX_Data_out_0;
  input TX_Data_out_1;
  input TX_Data_out_2;
  input UART_clk;
  input \FSM_onehot_current_state_reg[3]_0 ;

  wire Count_Reached;
  wire \FSM_onehot_current_state[0]_i_1_n_0 ;
  wire \FSM_onehot_current_state[1]_i_1_n_0 ;
  wire \FSM_onehot_current_state[3]_i_1_n_0 ;
  wire \FSM_onehot_current_state_reg[1]_0 ;
  wire \FSM_onehot_current_state_reg[3]_0 ;
  wire [1:0]\FSM_onehot_current_state_reg[7]_0 ;
  wire \FSM_onehot_current_state_reg_n_0_[0] ;
  wire \FSM_onehot_current_state_reg_n_0_[10] ;
  wire \FSM_onehot_current_state_reg_n_0_[11] ;
  wire \FSM_onehot_current_state_reg_n_0_[12] ;
  wire \FSM_onehot_current_state_reg_n_0_[3] ;
  wire \FSM_onehot_current_state_reg_n_0_[4] ;
  wire \FSM_onehot_current_state_reg_n_0_[5] ;
  wire \FSM_onehot_current_state_reg_n_0_[6] ;
  wire \FSM_onehot_current_state_reg_n_0_[7] ;
  wire \FSM_onehot_current_state_reg_n_0_[8] ;
  wire \FSM_onehot_current_state_reg_n_0_[9] ;
  wire [1:0]Q;
  wire [3:0]TX_Bit_sel;
  wire TX_Data_out;
  wire [2:0]TX_Data_out_0;
  wire TX_Data_out_1;
  wire TX_Data_out_2;
  wire TX_Data_out_INST_0_i_5_n_0;
  wire TX_Data_out_INST_0_i_8_n_0;
  wire UART_clk;
  wire [1:0]count_val_register_reg;
  wire empty;
  wire [1:0]p_0_in;
  wire rd_rst_busy;

  LUT5 #(
    .INIT(32'hF8F8F888)) 
    \FSM_onehot_current_state[0]_i_1 
       (.I0(Count_Reached),
        .I1(\FSM_onehot_current_state_reg_n_0_[12] ),
        .I2(\FSM_onehot_current_state_reg_n_0_[0] ),
        .I3(empty),
        .I4(rd_rst_busy),
        .O(\FSM_onehot_current_state[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h02)) 
    \FSM_onehot_current_state[1]_i_1 
       (.I0(\FSM_onehot_current_state_reg_n_0_[0] ),
        .I1(rd_rst_busy),
        .I2(empty),
        .O(\FSM_onehot_current_state[1]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hF4)) 
    \FSM_onehot_current_state[3]_i_1 
       (.I0(Count_Reached),
        .I1(\FSM_onehot_current_state_reg_n_0_[3] ),
        .I2(Q[1]),
        .O(\FSM_onehot_current_state[3]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "D1:0000000100000,D2:0000001000000,D0:0000000010000,WAIT:0000000000100,READ_EN:0000000000010,STOP:1000000000000,START:0000000001000,IDLE:0000000000001,D5:0001000000000,D7:0100000000000,D4:0000100000000,D6:0010000000000,D3:0000010000000" *) 
  FDPE #(
    .INIT(1'b1)) 
    \FSM_onehot_current_state_reg[0] 
       (.C(UART_clk),
        .CE(1'b1),
        .D(\FSM_onehot_current_state[0]_i_1_n_0 ),
        .PRE(\FSM_onehot_current_state_reg[3]_0 ),
        .Q(\FSM_onehot_current_state_reg_n_0_[0] ));
  (* FSM_ENCODED_STATES = "D1:0000000100000,D2:0000001000000,D0:0000000010000,WAIT:0000000000100,READ_EN:0000000000010,STOP:1000000000000,START:0000000001000,IDLE:0000000000001,D5:0001000000000,D7:0100000000000,D4:0000100000000,D6:0010000000000,D3:0000010000000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[10] 
       (.C(UART_clk),
        .CE(Count_Reached),
        .CLR(\FSM_onehot_current_state_reg[3]_0 ),
        .D(\FSM_onehot_current_state_reg_n_0_[9] ),
        .Q(\FSM_onehot_current_state_reg_n_0_[10] ));
  (* FSM_ENCODED_STATES = "D1:0000000100000,D2:0000001000000,D0:0000000010000,WAIT:0000000000100,READ_EN:0000000000010,STOP:1000000000000,START:0000000001000,IDLE:0000000000001,D5:0001000000000,D7:0100000000000,D4:0000100000000,D6:0010000000000,D3:0000010000000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[11] 
       (.C(UART_clk),
        .CE(Count_Reached),
        .CLR(\FSM_onehot_current_state_reg[3]_0 ),
        .D(\FSM_onehot_current_state_reg_n_0_[10] ),
        .Q(\FSM_onehot_current_state_reg_n_0_[11] ));
  (* FSM_ENCODED_STATES = "D1:0000000100000,D2:0000001000000,D0:0000000010000,WAIT:0000000000100,READ_EN:0000000000010,STOP:1000000000000,START:0000000001000,IDLE:0000000000001,D5:0001000000000,D7:0100000000000,D4:0000100000000,D6:0010000000000,D3:0000010000000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[12] 
       (.C(UART_clk),
        .CE(Count_Reached),
        .CLR(\FSM_onehot_current_state_reg[3]_0 ),
        .D(\FSM_onehot_current_state_reg_n_0_[11] ),
        .Q(\FSM_onehot_current_state_reg_n_0_[12] ));
  (* FSM_ENCODED_STATES = "D1:0000000100000,D2:0000001000000,D0:0000000010000,WAIT:0000000000100,READ_EN:0000000000010,STOP:1000000000000,START:0000000001000,IDLE:0000000000001,D5:0001000000000,D7:0100000000000,D4:0000100000000,D6:0010000000000,D3:0000010000000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[1] 
       (.C(UART_clk),
        .CE(1'b1),
        .CLR(\FSM_onehot_current_state_reg[3]_0 ),
        .D(\FSM_onehot_current_state[1]_i_1_n_0 ),
        .Q(Q[0]));
  (* FSM_ENCODED_STATES = "D1:0000000100000,D2:0000001000000,D0:0000000010000,WAIT:0000000000100,READ_EN:0000000000010,STOP:1000000000000,START:0000000001000,IDLE:0000000000001,D5:0001000000000,D7:0100000000000,D4:0000100000000,D6:0010000000000,D3:0000010000000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[2] 
       (.C(UART_clk),
        .CE(1'b1),
        .CLR(\FSM_onehot_current_state_reg[3]_0 ),
        .D(Q[0]),
        .Q(Q[1]));
  (* FSM_ENCODED_STATES = "D1:0000000100000,D2:0000001000000,D0:0000000010000,WAIT:0000000000100,READ_EN:0000000000010,STOP:1000000000000,START:0000000001000,IDLE:0000000000001,D5:0001000000000,D7:0100000000000,D4:0000100000000,D6:0010000000000,D3:0000010000000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[3] 
       (.C(UART_clk),
        .CE(1'b1),
        .CLR(\FSM_onehot_current_state_reg[3]_0 ),
        .D(\FSM_onehot_current_state[3]_i_1_n_0 ),
        .Q(\FSM_onehot_current_state_reg_n_0_[3] ));
  (* FSM_ENCODED_STATES = "D1:0000000100000,D2:0000001000000,D0:0000000010000,WAIT:0000000000100,READ_EN:0000000000010,STOP:1000000000000,START:0000000001000,IDLE:0000000000001,D5:0001000000000,D7:0100000000000,D4:0000100000000,D6:0010000000000,D3:0000010000000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[4] 
       (.C(UART_clk),
        .CE(Count_Reached),
        .CLR(\FSM_onehot_current_state_reg[3]_0 ),
        .D(\FSM_onehot_current_state_reg_n_0_[3] ),
        .Q(\FSM_onehot_current_state_reg_n_0_[4] ));
  (* FSM_ENCODED_STATES = "D1:0000000100000,D2:0000001000000,D0:0000000010000,WAIT:0000000000100,READ_EN:0000000000010,STOP:1000000000000,START:0000000001000,IDLE:0000000000001,D5:0001000000000,D7:0100000000000,D4:0000100000000,D6:0010000000000,D3:0000010000000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[5] 
       (.C(UART_clk),
        .CE(Count_Reached),
        .CLR(\FSM_onehot_current_state_reg[3]_0 ),
        .D(\FSM_onehot_current_state_reg_n_0_[4] ),
        .Q(\FSM_onehot_current_state_reg_n_0_[5] ));
  (* FSM_ENCODED_STATES = "D1:0000000100000,D2:0000001000000,D0:0000000010000,WAIT:0000000000100,READ_EN:0000000000010,STOP:1000000000000,START:0000000001000,IDLE:0000000000001,D5:0001000000000,D7:0100000000000,D4:0000100000000,D6:0010000000000,D3:0000010000000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[6] 
       (.C(UART_clk),
        .CE(Count_Reached),
        .CLR(\FSM_onehot_current_state_reg[3]_0 ),
        .D(\FSM_onehot_current_state_reg_n_0_[5] ),
        .Q(\FSM_onehot_current_state_reg_n_0_[6] ));
  (* FSM_ENCODED_STATES = "D1:0000000100000,D2:0000001000000,D0:0000000010000,WAIT:0000000000100,READ_EN:0000000000010,STOP:1000000000000,START:0000000001000,IDLE:0000000000001,D5:0001000000000,D7:0100000000000,D4:0000100000000,D6:0010000000000,D3:0000010000000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[7] 
       (.C(UART_clk),
        .CE(Count_Reached),
        .CLR(\FSM_onehot_current_state_reg[3]_0 ),
        .D(\FSM_onehot_current_state_reg_n_0_[6] ),
        .Q(\FSM_onehot_current_state_reg_n_0_[7] ));
  (* FSM_ENCODED_STATES = "D1:0000000100000,D2:0000001000000,D0:0000000010000,WAIT:0000000000100,READ_EN:0000000000010,STOP:1000000000000,START:0000000001000,IDLE:0000000000001,D5:0001000000000,D7:0100000000000,D4:0000100000000,D6:0010000000000,D3:0000010000000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[8] 
       (.C(UART_clk),
        .CE(Count_Reached),
        .CLR(\FSM_onehot_current_state_reg[3]_0 ),
        .D(\FSM_onehot_current_state_reg_n_0_[7] ),
        .Q(\FSM_onehot_current_state_reg_n_0_[8] ));
  (* FSM_ENCODED_STATES = "D1:0000000100000,D2:0000001000000,D0:0000000010000,WAIT:0000000000100,READ_EN:0000000000010,STOP:1000000000000,START:0000000001000,IDLE:0000000000001,D5:0001000000000,D7:0100000000000,D4:0000100000000,D6:0010000000000,D3:0000010000000" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_current_state_reg[9] 
       (.C(UART_clk),
        .CE(Count_Reached),
        .CLR(\FSM_onehot_current_state_reg[3]_0 ),
        .D(\FSM_onehot_current_state_reg_n_0_[8] ),
        .Q(\FSM_onehot_current_state_reg_n_0_[9] ));
  LUT6 #(
    .INIT(64'hFFFFD8D8FFAAD8D8)) 
    TX_Data_out_INST_0
       (.I0(TX_Bit_sel[3]),
        .I1(TX_Data_out_0[2]),
        .I2(TX_Data_out_1),
        .I3(TX_Data_out_2),
        .I4(TX_Bit_sel[0]),
        .I5(TX_Data_out_INST_0_i_5_n_0),
        .O(TX_Data_out));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    TX_Data_out_INST_0_i_1
       (.I0(\FSM_onehot_current_state_reg_n_0_[12] ),
        .I1(\FSM_onehot_current_state_reg_n_0_[11] ),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(\FSM_onehot_current_state_reg_n_0_[0] ),
        .O(TX_Bit_sel[3]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    TX_Data_out_INST_0_i_4
       (.I0(TX_Data_out_INST_0_i_8_n_0),
        .I1(\FSM_onehot_current_state_reg_n_0_[8] ),
        .I2(\FSM_onehot_current_state_reg_n_0_[6] ),
        .I3(\FSM_onehot_current_state_reg_n_0_[4] ),
        .I4(\FSM_onehot_current_state_reg_n_0_[10] ),
        .I5(\FSM_onehot_current_state_reg_n_0_[12] ),
        .O(TX_Bit_sel[0]));
  LUT4 #(
    .INIT(16'hA808)) 
    TX_Data_out_INST_0_i_5
       (.I0(\FSM_onehot_current_state_reg[7]_0 [1]),
        .I1(TX_Data_out_0[0]),
        .I2(\FSM_onehot_current_state_reg[7]_0 [0]),
        .I3(TX_Data_out_0[1]),
        .O(TX_Data_out_INST_0_i_5_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    TX_Data_out_INST_0_i_6
       (.I0(\FSM_onehot_current_state_reg_n_0_[7] ),
        .I1(\FSM_onehot_current_state_reg_n_0_[8] ),
        .I2(\FSM_onehot_current_state_reg_n_0_[10] ),
        .I3(\FSM_onehot_current_state_reg_n_0_[9] ),
        .O(\FSM_onehot_current_state_reg[7]_0 [1]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    TX_Data_out_INST_0_i_7
       (.I0(\FSM_onehot_current_state_reg_n_0_[10] ),
        .I1(\FSM_onehot_current_state_reg_n_0_[9] ),
        .I2(\FSM_onehot_current_state_reg_n_0_[5] ),
        .I3(\FSM_onehot_current_state_reg_n_0_[6] ),
        .O(\FSM_onehot_current_state_reg[7]_0 [0]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    TX_Data_out_INST_0_i_8
       (.I0(\FSM_onehot_current_state_reg_n_0_[0] ),
        .I1(Q[1]),
        .I2(Q[0]),
        .O(TX_Data_out_INST_0_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    \count_val_register[0]_i_1 
       (.I0(Count_Reached),
        .I1(\FSM_onehot_current_state_reg_n_0_[0] ),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(count_val_register_reg[0]),
        .O(p_0_in[0]));
  LUT6 #(
    .INIT(64'h0000000100010000)) 
    \count_val_register[1]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(\FSM_onehot_current_state_reg_n_0_[0] ),
        .I3(Count_Reached),
        .I4(count_val_register_reg[0]),
        .I5(count_val_register_reg[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \count_val_register[5]_i_3 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(\FSM_onehot_current_state_reg_n_0_[0] ),
        .I3(Count_Reached),
        .O(\FSM_onehot_current_state_reg[1]_0 ));
endmodule

(* ORIG_REF_NAME = "UART_TX_DATAPATH" *) 
module design_2_UART_0_0_UART_TX_DATAPATH
   (\count_val_register_reg[1]_0 ,
    uart_aresetn_0,
    Count_Reached,
    \tx_bits_register_reg[6]_0 ,
    Q,
    \tx_bits_register_reg[1]_0 ,
    \count_val_register_reg[1]_1 ,
    UART_clk,
    uart_aresetn,
    \count_val_register_reg[2]_0 ,
    TX_Data_out,
    E,
    D);
  output [1:0]\count_val_register_reg[1]_0 ;
  output uart_aresetn_0;
  output Count_Reached;
  output \tx_bits_register_reg[6]_0 ;
  output [2:0]Q;
  output \tx_bits_register_reg[1]_0 ;
  input [1:0]\count_val_register_reg[1]_1 ;
  input UART_clk;
  input uart_aresetn;
  input \count_val_register_reg[2]_0 ;
  input [1:0]TX_Data_out;
  input [0:0]E;
  input [7:0]D;

  wire Count_Reached;
  wire [7:0]D;
  wire [0:0]E;
  wire [2:0]Q;
  wire [1:0]TX_Data_out;
  wire UART_clk;
  wire \count_val_register[5]_i_2_n_0 ;
  wire [5:2]count_val_register_reg;
  wire [1:0]\count_val_register_reg[1]_0 ;
  wire [1:0]\count_val_register_reg[1]_1 ;
  wire \count_val_register_reg[2]_0 ;
  wire [5:2]p_0_in;
  wire [6:0]tx_bits_register;
  wire \tx_bits_register_reg[1]_0 ;
  wire \tx_bits_register_reg[6]_0 ;
  wire uart_aresetn;
  wire uart_aresetn_0;

  LUT6 #(
    .INIT(64'h0010000000000000)) 
    \FSM_onehot_current_state[12]_i_1 
       (.I0(count_val_register_reg[2]),
        .I1(count_val_register_reg[3]),
        .I2(\count_val_register_reg[1]_0 [0]),
        .I3(\count_val_register_reg[1]_0 [1]),
        .I4(count_val_register_reg[5]),
        .I5(count_val_register_reg[4]),
        .O(Count_Reached));
  LUT1 #(
    .INIT(2'h1)) 
    \FSM_onehot_current_state[3]_i_2__0 
       (.I0(uart_aresetn),
        .O(uart_aresetn_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    TX_Data_out_INST_0_i_2
       (.I0(tx_bits_register[6]),
        .I1(tx_bits_register[4]),
        .I2(TX_Data_out[1]),
        .I3(tx_bits_register[2]),
        .I4(TX_Data_out[0]),
        .I5(tx_bits_register[0]),
        .O(\tx_bits_register_reg[6]_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    TX_Data_out_INST_0_i_3
       (.I0(tx_bits_register[1]),
        .I1(TX_Data_out[0]),
        .I2(tx_bits_register[3]),
        .I3(TX_Data_out[1]),
        .O(\tx_bits_register_reg[1]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT4 #(
    .INIT(16'h2A80)) 
    \count_val_register[2]_i_1 
       (.I0(\count_val_register_reg[2]_0 ),
        .I1(\count_val_register_reg[1]_0 [0]),
        .I2(\count_val_register_reg[1]_0 [1]),
        .I3(count_val_register_reg[2]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT5 #(
    .INIT(32'h2AAA8000)) 
    \count_val_register[3]_i_1 
       (.I0(\count_val_register_reg[2]_0 ),
        .I1(\count_val_register_reg[1]_0 [1]),
        .I2(\count_val_register_reg[1]_0 [0]),
        .I3(count_val_register_reg[2]),
        .I4(count_val_register_reg[3]),
        .O(p_0_in[3]));
  LUT6 #(
    .INIT(64'h7FFF000080000000)) 
    \count_val_register[4]_i_1 
       (.I0(\count_val_register_reg[1]_0 [1]),
        .I1(\count_val_register_reg[1]_0 [0]),
        .I2(count_val_register_reg[2]),
        .I3(count_val_register_reg[3]),
        .I4(\count_val_register_reg[2]_0 ),
        .I5(count_val_register_reg[4]),
        .O(p_0_in[4]));
  LUT4 #(
    .INIT(16'hB040)) 
    \count_val_register[5]_i_1 
       (.I0(\count_val_register[5]_i_2_n_0 ),
        .I1(count_val_register_reg[4]),
        .I2(\count_val_register_reg[2]_0 ),
        .I3(count_val_register_reg[5]),
        .O(p_0_in[5]));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \count_val_register[5]_i_2 
       (.I0(\count_val_register_reg[1]_0 [1]),
        .I1(\count_val_register_reg[1]_0 [0]),
        .I2(count_val_register_reg[2]),
        .I3(count_val_register_reg[3]),
        .O(\count_val_register[5]_i_2_n_0 ));
  FDCE \count_val_register_reg[0] 
       (.C(UART_clk),
        .CE(1'b1),
        .CLR(uart_aresetn_0),
        .D(\count_val_register_reg[1]_1 [0]),
        .Q(\count_val_register_reg[1]_0 [0]));
  FDCE \count_val_register_reg[1] 
       (.C(UART_clk),
        .CE(1'b1),
        .CLR(uart_aresetn_0),
        .D(\count_val_register_reg[1]_1 [1]),
        .Q(\count_val_register_reg[1]_0 [1]));
  FDCE \count_val_register_reg[2] 
       (.C(UART_clk),
        .CE(1'b1),
        .CLR(uart_aresetn_0),
        .D(p_0_in[2]),
        .Q(count_val_register_reg[2]));
  FDCE \count_val_register_reg[3] 
       (.C(UART_clk),
        .CE(1'b1),
        .CLR(uart_aresetn_0),
        .D(p_0_in[3]),
        .Q(count_val_register_reg[3]));
  FDCE \count_val_register_reg[4] 
       (.C(UART_clk),
        .CE(1'b1),
        .CLR(uart_aresetn_0),
        .D(p_0_in[4]),
        .Q(count_val_register_reg[4]));
  FDCE \count_val_register_reg[5] 
       (.C(UART_clk),
        .CE(1'b1),
        .CLR(uart_aresetn_0),
        .D(p_0_in[5]),
        .Q(count_val_register_reg[5]));
  FDPE \tx_bits_register_reg[0] 
       (.C(UART_clk),
        .CE(E),
        .D(1'b0),
        .PRE(uart_aresetn_0),
        .Q(tx_bits_register[0]));
  FDPE \tx_bits_register_reg[1] 
       (.C(UART_clk),
        .CE(E),
        .D(D[0]),
        .PRE(uart_aresetn_0),
        .Q(tx_bits_register[1]));
  FDPE \tx_bits_register_reg[2] 
       (.C(UART_clk),
        .CE(E),
        .D(D[1]),
        .PRE(uart_aresetn_0),
        .Q(tx_bits_register[2]));
  FDPE \tx_bits_register_reg[3] 
       (.C(UART_clk),
        .CE(E),
        .D(D[2]),
        .PRE(uart_aresetn_0),
        .Q(tx_bits_register[3]));
  FDPE \tx_bits_register_reg[4] 
       (.C(UART_clk),
        .CE(E),
        .D(D[3]),
        .PRE(uart_aresetn_0),
        .Q(tx_bits_register[4]));
  FDPE \tx_bits_register_reg[5] 
       (.C(UART_clk),
        .CE(E),
        .D(D[4]),
        .PRE(uart_aresetn_0),
        .Q(Q[0]));
  FDPE \tx_bits_register_reg[6] 
       (.C(UART_clk),
        .CE(E),
        .D(D[5]),
        .PRE(uart_aresetn_0),
        .Q(tx_bits_register[6]));
  FDPE \tx_bits_register_reg[7] 
       (.C(UART_clk),
        .CE(E),
        .D(D[6]),
        .PRE(uart_aresetn_0),
        .Q(Q[1]));
  FDPE \tx_bits_register_reg[8] 
       (.C(UART_clk),
        .CE(E),
        .D(D[7]),
        .PRE(uart_aresetn_0),
        .Q(Q[2]));
endmodule

(* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "1" *) (* ORIG_REF_NAME = "xpm_cdc_gray" *) 
(* REG_OUTPUT = "0" *) (* SIM_ASSERT_CHK = "0" *) (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
(* VERSION = "0" *) (* WIDTH = "8" *) (* XPM_MODULE = "TRUE" *) 
(* keep_hierarchy = "true" *) (* xpm_cdc = "GRAY" *) 
module design_2_UART_0_0_xpm_cdc_gray
   (src_clk,
    src_in_bin,
    dest_clk,
    dest_out_bin);
  input src_clk;
  input [7:0]src_in_bin;
  input dest_clk;
  output [7:0]dest_out_bin;

  wire [7:0]async_path;
  wire dest_clk;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [7:0]\dest_graysync_ff[0] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [7:0]\dest_graysync_ff[1] ;
  wire [6:0]\^dest_out_bin ;
  wire [6:0]gray_enc;
  wire src_clk;
  wire [7:0]src_in_bin;

  assign dest_out_bin[7] = \dest_graysync_ff[1] [7];
  assign dest_out_bin[6:0] = \^dest_out_bin [6:0];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[0]),
        .Q(\dest_graysync_ff[0] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[1]),
        .Q(\dest_graysync_ff[0] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[2]),
        .Q(\dest_graysync_ff[0] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[3]),
        .Q(\dest_graysync_ff[0] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[4]),
        .Q(\dest_graysync_ff[0] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[5]),
        .Q(\dest_graysync_ff[0] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[6]),
        .Q(\dest_graysync_ff[0] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[7]),
        .Q(\dest_graysync_ff[0] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [0]),
        .Q(\dest_graysync_ff[1] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [1]),
        .Q(\dest_graysync_ff[1] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [2]),
        .Q(\dest_graysync_ff[1] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [3]),
        .Q(\dest_graysync_ff[1] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [4]),
        .Q(\dest_graysync_ff[1] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [5]),
        .Q(\dest_graysync_ff[1] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [6]),
        .Q(\dest_graysync_ff[1] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [7]),
        .Q(\dest_graysync_ff[1] [7]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin[0]_INST_0 
       (.I0(\dest_graysync_ff[1] [0]),
        .I1(\^dest_out_bin [2]),
        .I2(\dest_graysync_ff[1] [1]),
        .O(\^dest_out_bin [0]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin[1]_INST_0 
       (.I0(\dest_graysync_ff[1] [1]),
        .I1(\^dest_out_bin [2]),
        .O(\^dest_out_bin [1]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[2]_INST_0 
       (.I0(\dest_graysync_ff[1] [2]),
        .I1(\dest_graysync_ff[1] [4]),
        .I2(\dest_graysync_ff[1] [6]),
        .I3(\dest_graysync_ff[1] [7]),
        .I4(\dest_graysync_ff[1] [5]),
        .I5(\dest_graysync_ff[1] [3]),
        .O(\^dest_out_bin [2]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin[3]_INST_0 
       (.I0(\dest_graysync_ff[1] [3]),
        .I1(\dest_graysync_ff[1] [5]),
        .I2(\dest_graysync_ff[1] [7]),
        .I3(\dest_graysync_ff[1] [6]),
        .I4(\dest_graysync_ff[1] [4]),
        .O(\^dest_out_bin [3]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[4]_INST_0 
       (.I0(\dest_graysync_ff[1] [4]),
        .I1(\dest_graysync_ff[1] [6]),
        .I2(\dest_graysync_ff[1] [7]),
        .I3(\dest_graysync_ff[1] [5]),
        .O(\^dest_out_bin [4]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin[5]_INST_0 
       (.I0(\dest_graysync_ff[1] [5]),
        .I1(\dest_graysync_ff[1] [7]),
        .I2(\dest_graysync_ff[1] [6]),
        .O(\^dest_out_bin [5]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin[6]_INST_0 
       (.I0(\dest_graysync_ff[1] [6]),
        .I1(\dest_graysync_ff[1] [7]),
        .O(\^dest_out_bin [6]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[0]_i_1 
       (.I0(src_in_bin[1]),
        .I1(src_in_bin[0]),
        .O(gray_enc[0]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[1]_i_1 
       (.I0(src_in_bin[2]),
        .I1(src_in_bin[1]),
        .O(gray_enc[1]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[2]_i_1 
       (.I0(src_in_bin[3]),
        .I1(src_in_bin[2]),
        .O(gray_enc[2]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[3]_i_1 
       (.I0(src_in_bin[4]),
        .I1(src_in_bin[3]),
        .O(gray_enc[3]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[4]_i_1 
       (.I0(src_in_bin[5]),
        .I1(src_in_bin[4]),
        .O(gray_enc[4]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[5]_i_1 
       (.I0(src_in_bin[6]),
        .I1(src_in_bin[5]),
        .O(gray_enc[5]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[6]_i_1 
       (.I0(src_in_bin[7]),
        .I1(src_in_bin[6]),
        .O(gray_enc[6]));
  FDRE \src_gray_ff_reg[0] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[0]),
        .Q(async_path[0]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[1] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[1]),
        .Q(async_path[1]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[2] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[2]),
        .Q(async_path[2]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[3] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[3]),
        .Q(async_path[3]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[4] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[4]),
        .Q(async_path[4]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[5] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[5]),
        .Q(async_path[5]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[6] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[6]),
        .Q(async_path[6]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[7] 
       (.C(src_clk),
        .CE(1'b1),
        .D(src_in_bin[7]),
        .Q(async_path[7]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "1" *) (* ORIG_REF_NAME = "xpm_cdc_gray" *) 
(* REG_OUTPUT = "0" *) (* SIM_ASSERT_CHK = "0" *) (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
(* VERSION = "0" *) (* WIDTH = "8" *) (* XPM_MODULE = "TRUE" *) 
(* keep_hierarchy = "true" *) (* xpm_cdc = "GRAY" *) 
module design_2_UART_0_0_xpm_cdc_gray__2
   (src_clk,
    src_in_bin,
    dest_clk,
    dest_out_bin);
  input src_clk;
  input [7:0]src_in_bin;
  input dest_clk;
  output [7:0]dest_out_bin;

  wire [7:0]async_path;
  wire dest_clk;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [7:0]\dest_graysync_ff[0] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [7:0]\dest_graysync_ff[1] ;
  wire [6:0]\^dest_out_bin ;
  wire [6:0]gray_enc;
  wire src_clk;
  wire [7:0]src_in_bin;

  assign dest_out_bin[7] = \dest_graysync_ff[1] [7];
  assign dest_out_bin[6:0] = \^dest_out_bin [6:0];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[0]),
        .Q(\dest_graysync_ff[0] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[1]),
        .Q(\dest_graysync_ff[0] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[2]),
        .Q(\dest_graysync_ff[0] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[3]),
        .Q(\dest_graysync_ff[0] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[4]),
        .Q(\dest_graysync_ff[0] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[5]),
        .Q(\dest_graysync_ff[0] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[6]),
        .Q(\dest_graysync_ff[0] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[7]),
        .Q(\dest_graysync_ff[0] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [0]),
        .Q(\dest_graysync_ff[1] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [1]),
        .Q(\dest_graysync_ff[1] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [2]),
        .Q(\dest_graysync_ff[1] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [3]),
        .Q(\dest_graysync_ff[1] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [4]),
        .Q(\dest_graysync_ff[1] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [5]),
        .Q(\dest_graysync_ff[1] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [6]),
        .Q(\dest_graysync_ff[1] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [7]),
        .Q(\dest_graysync_ff[1] [7]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin[0]_INST_0 
       (.I0(\dest_graysync_ff[1] [0]),
        .I1(\^dest_out_bin [2]),
        .I2(\dest_graysync_ff[1] [1]),
        .O(\^dest_out_bin [0]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin[1]_INST_0 
       (.I0(\dest_graysync_ff[1] [1]),
        .I1(\^dest_out_bin [2]),
        .O(\^dest_out_bin [1]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[2]_INST_0 
       (.I0(\dest_graysync_ff[1] [2]),
        .I1(\dest_graysync_ff[1] [4]),
        .I2(\dest_graysync_ff[1] [6]),
        .I3(\dest_graysync_ff[1] [7]),
        .I4(\dest_graysync_ff[1] [5]),
        .I5(\dest_graysync_ff[1] [3]),
        .O(\^dest_out_bin [2]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin[3]_INST_0 
       (.I0(\dest_graysync_ff[1] [3]),
        .I1(\dest_graysync_ff[1] [5]),
        .I2(\dest_graysync_ff[1] [7]),
        .I3(\dest_graysync_ff[1] [6]),
        .I4(\dest_graysync_ff[1] [4]),
        .O(\^dest_out_bin [3]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[4]_INST_0 
       (.I0(\dest_graysync_ff[1] [4]),
        .I1(\dest_graysync_ff[1] [6]),
        .I2(\dest_graysync_ff[1] [7]),
        .I3(\dest_graysync_ff[1] [5]),
        .O(\^dest_out_bin [4]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin[5]_INST_0 
       (.I0(\dest_graysync_ff[1] [5]),
        .I1(\dest_graysync_ff[1] [7]),
        .I2(\dest_graysync_ff[1] [6]),
        .O(\^dest_out_bin [5]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin[6]_INST_0 
       (.I0(\dest_graysync_ff[1] [6]),
        .I1(\dest_graysync_ff[1] [7]),
        .O(\^dest_out_bin [6]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[0]_i_1 
       (.I0(src_in_bin[1]),
        .I1(src_in_bin[0]),
        .O(gray_enc[0]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[1]_i_1 
       (.I0(src_in_bin[2]),
        .I1(src_in_bin[1]),
        .O(gray_enc[1]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[2]_i_1 
       (.I0(src_in_bin[3]),
        .I1(src_in_bin[2]),
        .O(gray_enc[2]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[3]_i_1 
       (.I0(src_in_bin[4]),
        .I1(src_in_bin[3]),
        .O(gray_enc[3]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[4]_i_1 
       (.I0(src_in_bin[5]),
        .I1(src_in_bin[4]),
        .O(gray_enc[4]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[5]_i_1 
       (.I0(src_in_bin[6]),
        .I1(src_in_bin[5]),
        .O(gray_enc[5]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[6]_i_1 
       (.I0(src_in_bin[7]),
        .I1(src_in_bin[6]),
        .O(gray_enc[6]));
  FDRE \src_gray_ff_reg[0] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[0]),
        .Q(async_path[0]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[1] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[1]),
        .Q(async_path[1]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[2] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[2]),
        .Q(async_path[2]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[3] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[3]),
        .Q(async_path[3]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[4] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[4]),
        .Q(async_path[4]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[5] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[5]),
        .Q(async_path[5]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[6] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[6]),
        .Q(async_path[6]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[7] 
       (.C(src_clk),
        .CE(1'b1),
        .D(src_in_bin[7]),
        .Q(async_path[7]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "1" *) (* ORIG_REF_NAME = "xpm_cdc_gray" *) 
(* REG_OUTPUT = "0" *) (* SIM_ASSERT_CHK = "0" *) (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
(* VERSION = "0" *) (* WIDTH = "9" *) (* XPM_MODULE = "TRUE" *) 
(* keep_hierarchy = "true" *) (* xpm_cdc = "GRAY" *) 
module design_2_UART_0_0_xpm_cdc_gray__parameterized0
   (src_clk,
    src_in_bin,
    dest_clk,
    dest_out_bin);
  input src_clk;
  input [8:0]src_in_bin;
  input dest_clk;
  output [8:0]dest_out_bin;

  wire [8:0]async_path;
  wire dest_clk;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [8:0]\dest_graysync_ff[0] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [8:0]\dest_graysync_ff[1] ;
  wire [7:0]\^dest_out_bin ;
  wire [7:0]gray_enc;
  wire src_clk;
  wire [8:0]src_in_bin;

  assign dest_out_bin[8] = \dest_graysync_ff[1] [8];
  assign dest_out_bin[7:0] = \^dest_out_bin [7:0];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[0]),
        .Q(\dest_graysync_ff[0] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[1]),
        .Q(\dest_graysync_ff[0] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[2]),
        .Q(\dest_graysync_ff[0] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[3]),
        .Q(\dest_graysync_ff[0] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[4]),
        .Q(\dest_graysync_ff[0] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[5]),
        .Q(\dest_graysync_ff[0] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[6]),
        .Q(\dest_graysync_ff[0] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[7]),
        .Q(\dest_graysync_ff[0] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[8]),
        .Q(\dest_graysync_ff[0] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [0]),
        .Q(\dest_graysync_ff[1] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [1]),
        .Q(\dest_graysync_ff[1] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [2]),
        .Q(\dest_graysync_ff[1] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [3]),
        .Q(\dest_graysync_ff[1] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [4]),
        .Q(\dest_graysync_ff[1] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [5]),
        .Q(\dest_graysync_ff[1] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [6]),
        .Q(\dest_graysync_ff[1] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [7]),
        .Q(\dest_graysync_ff[1] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [8]),
        .Q(\dest_graysync_ff[1] [8]),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[0]_INST_0 
       (.I0(\dest_graysync_ff[1] [0]),
        .I1(\dest_graysync_ff[1] [2]),
        .I2(\^dest_out_bin [3]),
        .I3(\dest_graysync_ff[1] [1]),
        .O(\^dest_out_bin [0]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin[1]_INST_0 
       (.I0(\dest_graysync_ff[1] [1]),
        .I1(\^dest_out_bin [3]),
        .I2(\dest_graysync_ff[1] [2]),
        .O(\^dest_out_bin [1]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin[2]_INST_0 
       (.I0(\dest_graysync_ff[1] [2]),
        .I1(\^dest_out_bin [3]),
        .O(\^dest_out_bin [2]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[3]_INST_0 
       (.I0(\dest_graysync_ff[1] [3]),
        .I1(\dest_graysync_ff[1] [5]),
        .I2(\dest_graysync_ff[1] [7]),
        .I3(\dest_graysync_ff[1] [8]),
        .I4(\dest_graysync_ff[1] [6]),
        .I5(\dest_graysync_ff[1] [4]),
        .O(\^dest_out_bin [3]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin[4]_INST_0 
       (.I0(\dest_graysync_ff[1] [4]),
        .I1(\dest_graysync_ff[1] [6]),
        .I2(\dest_graysync_ff[1] [8]),
        .I3(\dest_graysync_ff[1] [7]),
        .I4(\dest_graysync_ff[1] [5]),
        .O(\^dest_out_bin [4]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[5]_INST_0 
       (.I0(\dest_graysync_ff[1] [5]),
        .I1(\dest_graysync_ff[1] [7]),
        .I2(\dest_graysync_ff[1] [8]),
        .I3(\dest_graysync_ff[1] [6]),
        .O(\^dest_out_bin [5]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin[6]_INST_0 
       (.I0(\dest_graysync_ff[1] [6]),
        .I1(\dest_graysync_ff[1] [8]),
        .I2(\dest_graysync_ff[1] [7]),
        .O(\^dest_out_bin [6]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin[7]_INST_0 
       (.I0(\dest_graysync_ff[1] [7]),
        .I1(\dest_graysync_ff[1] [8]),
        .O(\^dest_out_bin [7]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[0]_i_1 
       (.I0(src_in_bin[1]),
        .I1(src_in_bin[0]),
        .O(gray_enc[0]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[1]_i_1 
       (.I0(src_in_bin[2]),
        .I1(src_in_bin[1]),
        .O(gray_enc[1]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[2]_i_1 
       (.I0(src_in_bin[3]),
        .I1(src_in_bin[2]),
        .O(gray_enc[2]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[3]_i_1 
       (.I0(src_in_bin[4]),
        .I1(src_in_bin[3]),
        .O(gray_enc[3]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[4]_i_1 
       (.I0(src_in_bin[5]),
        .I1(src_in_bin[4]),
        .O(gray_enc[4]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[5]_i_1 
       (.I0(src_in_bin[6]),
        .I1(src_in_bin[5]),
        .O(gray_enc[5]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[6]_i_1 
       (.I0(src_in_bin[7]),
        .I1(src_in_bin[6]),
        .O(gray_enc[6]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[7]_i_1 
       (.I0(src_in_bin[8]),
        .I1(src_in_bin[7]),
        .O(gray_enc[7]));
  FDRE \src_gray_ff_reg[0] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[0]),
        .Q(async_path[0]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[1] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[1]),
        .Q(async_path[1]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[2] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[2]),
        .Q(async_path[2]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[3] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[3]),
        .Q(async_path[3]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[4] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[4]),
        .Q(async_path[4]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[5] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[5]),
        .Q(async_path[5]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[6] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[6]),
        .Q(async_path[6]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[7] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[7]),
        .Q(async_path[7]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[8] 
       (.C(src_clk),
        .CE(1'b1),
        .D(src_in_bin[8]),
        .Q(async_path[8]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "1" *) (* ORIG_REF_NAME = "xpm_cdc_gray" *) 
(* REG_OUTPUT = "0" *) (* SIM_ASSERT_CHK = "0" *) (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
(* VERSION = "0" *) (* WIDTH = "9" *) (* XPM_MODULE = "TRUE" *) 
(* keep_hierarchy = "true" *) (* xpm_cdc = "GRAY" *) 
module design_2_UART_0_0_xpm_cdc_gray__parameterized0__2
   (src_clk,
    src_in_bin,
    dest_clk,
    dest_out_bin);
  input src_clk;
  input [8:0]src_in_bin;
  input dest_clk;
  output [8:0]dest_out_bin;

  wire [8:0]async_path;
  wire dest_clk;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [8:0]\dest_graysync_ff[0] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [8:0]\dest_graysync_ff[1] ;
  wire [7:0]\^dest_out_bin ;
  wire [7:0]gray_enc;
  wire src_clk;
  wire [8:0]src_in_bin;

  assign dest_out_bin[8] = \dest_graysync_ff[1] [8];
  assign dest_out_bin[7:0] = \^dest_out_bin [7:0];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[0]),
        .Q(\dest_graysync_ff[0] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[1]),
        .Q(\dest_graysync_ff[0] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[2]),
        .Q(\dest_graysync_ff[0] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[3]),
        .Q(\dest_graysync_ff[0] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[4]),
        .Q(\dest_graysync_ff[0] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[5]),
        .Q(\dest_graysync_ff[0] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[6]),
        .Q(\dest_graysync_ff[0] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[7]),
        .Q(\dest_graysync_ff[0] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[8]),
        .Q(\dest_graysync_ff[0] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [0]),
        .Q(\dest_graysync_ff[1] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [1]),
        .Q(\dest_graysync_ff[1] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [2]),
        .Q(\dest_graysync_ff[1] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [3]),
        .Q(\dest_graysync_ff[1] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [4]),
        .Q(\dest_graysync_ff[1] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [5]),
        .Q(\dest_graysync_ff[1] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [6]),
        .Q(\dest_graysync_ff[1] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [7]),
        .Q(\dest_graysync_ff[1] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [8]),
        .Q(\dest_graysync_ff[1] [8]),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[0]_INST_0 
       (.I0(\dest_graysync_ff[1] [0]),
        .I1(\dest_graysync_ff[1] [2]),
        .I2(\^dest_out_bin [3]),
        .I3(\dest_graysync_ff[1] [1]),
        .O(\^dest_out_bin [0]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin[1]_INST_0 
       (.I0(\dest_graysync_ff[1] [1]),
        .I1(\^dest_out_bin [3]),
        .I2(\dest_graysync_ff[1] [2]),
        .O(\^dest_out_bin [1]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin[2]_INST_0 
       (.I0(\dest_graysync_ff[1] [2]),
        .I1(\^dest_out_bin [3]),
        .O(\^dest_out_bin [2]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[3]_INST_0 
       (.I0(\dest_graysync_ff[1] [3]),
        .I1(\dest_graysync_ff[1] [5]),
        .I2(\dest_graysync_ff[1] [7]),
        .I3(\dest_graysync_ff[1] [8]),
        .I4(\dest_graysync_ff[1] [6]),
        .I5(\dest_graysync_ff[1] [4]),
        .O(\^dest_out_bin [3]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin[4]_INST_0 
       (.I0(\dest_graysync_ff[1] [4]),
        .I1(\dest_graysync_ff[1] [6]),
        .I2(\dest_graysync_ff[1] [8]),
        .I3(\dest_graysync_ff[1] [7]),
        .I4(\dest_graysync_ff[1] [5]),
        .O(\^dest_out_bin [4]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[5]_INST_0 
       (.I0(\dest_graysync_ff[1] [5]),
        .I1(\dest_graysync_ff[1] [7]),
        .I2(\dest_graysync_ff[1] [8]),
        .I3(\dest_graysync_ff[1] [6]),
        .O(\^dest_out_bin [5]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin[6]_INST_0 
       (.I0(\dest_graysync_ff[1] [6]),
        .I1(\dest_graysync_ff[1] [8]),
        .I2(\dest_graysync_ff[1] [7]),
        .O(\^dest_out_bin [6]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin[7]_INST_0 
       (.I0(\dest_graysync_ff[1] [7]),
        .I1(\dest_graysync_ff[1] [8]),
        .O(\^dest_out_bin [7]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[0]_i_1 
       (.I0(src_in_bin[1]),
        .I1(src_in_bin[0]),
        .O(gray_enc[0]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[1]_i_1 
       (.I0(src_in_bin[2]),
        .I1(src_in_bin[1]),
        .O(gray_enc[1]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[2]_i_1 
       (.I0(src_in_bin[3]),
        .I1(src_in_bin[2]),
        .O(gray_enc[2]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[3]_i_1 
       (.I0(src_in_bin[4]),
        .I1(src_in_bin[3]),
        .O(gray_enc[3]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[4]_i_1 
       (.I0(src_in_bin[5]),
        .I1(src_in_bin[4]),
        .O(gray_enc[4]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[5]_i_1 
       (.I0(src_in_bin[6]),
        .I1(src_in_bin[5]),
        .O(gray_enc[5]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[6]_i_1 
       (.I0(src_in_bin[7]),
        .I1(src_in_bin[6]),
        .O(gray_enc[6]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[7]_i_1 
       (.I0(src_in_bin[8]),
        .I1(src_in_bin[7]),
        .O(gray_enc[7]));
  FDRE \src_gray_ff_reg[0] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[0]),
        .Q(async_path[0]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[1] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[1]),
        .Q(async_path[1]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[2] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[2]),
        .Q(async_path[2]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[3] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[3]),
        .Q(async_path[3]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[4] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[4]),
        .Q(async_path[4]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[5] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[5]),
        .Q(async_path[5]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[6] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[6]),
        .Q(async_path[6]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[7] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[7]),
        .Q(async_path[7]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[8] 
       (.C(src_clk),
        .CE(1'b1),
        .D(src_in_bin[8]),
        .Q(async_path[8]),
        .R(1'b0));
endmodule

(* DEF_VAL = "1'b0" *) (* DEST_SYNC_FF = "2" *) (* INIT = "0" *) 
(* INIT_SYNC_FF = "1" *) (* ORIG_REF_NAME = "xpm_cdc_sync_rst" *) (* SIM_ASSERT_CHK = "0" *) 
(* VERSION = "0" *) (* XPM_MODULE = "TRUE" *) (* keep_hierarchy = "true" *) 
(* xpm_cdc = "SYNC_RST" *) 
module design_2_UART_0_0_xpm_cdc_sync_rst
   (src_rst,
    dest_clk,
    dest_rst);
  input src_rst;
  input dest_clk;
  output dest_rst;

  wire dest_clk;
  wire src_rst;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SYNC_RST" *) wire [1:0]syncstages_ff;

  assign dest_rst = syncstages_ff[1];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_rst),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
endmodule

(* DEF_VAL = "1'b0" *) (* DEST_SYNC_FF = "2" *) (* INIT = "0" *) 
(* INIT_SYNC_FF = "1" *) (* ORIG_REF_NAME = "xpm_cdc_sync_rst" *) (* SIM_ASSERT_CHK = "0" *) 
(* VERSION = "0" *) (* XPM_MODULE = "TRUE" *) (* keep_hierarchy = "true" *) 
(* xpm_cdc = "SYNC_RST" *) 
module design_2_UART_0_0_xpm_cdc_sync_rst__2
   (src_rst,
    dest_clk,
    dest_rst);
  input src_rst;
  input dest_clk;
  output dest_rst;

  wire dest_clk;
  wire src_rst;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SYNC_RST" *) wire [1:0]syncstages_ff;

  assign dest_rst = syncstages_ff[1];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_rst),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module design_2_UART_0_0_xpm_counter_updn
   (Q,
    E,
    \count_value_i_reg[7]_0 ,
    S,
    rd_en,
    \count_value_i_reg[0]_0 ,
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] ,
    \count_value_i_reg[8]_0 ,
    rd_clk);
  output [8:0]Q;
  output [0:0]E;
  output [3:0]\count_value_i_reg[7]_0 ;
  output [3:0]S;
  input rd_en;
  input \count_value_i_reg[0]_0 ;
  input [6:0]\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] ;
  input \count_value_i_reg[8]_0 ;
  input rd_clk;

  wire [0:0]E;
  wire [8:0]Q;
  wire [3:0]S;
  wire \count_value_i[0]_i_1__3_n_0 ;
  wire \count_value_i[1]_i_1__3_n_0 ;
  wire \count_value_i[2]_i_1__3_n_0 ;
  wire \count_value_i[3]_i_1__3_n_0 ;
  wire \count_value_i[4]_i_1__3_n_0 ;
  wire \count_value_i[5]_i_1__3_n_0 ;
  wire \count_value_i[6]_i_1__3_n_0 ;
  wire \count_value_i[7]_i_1__3_n_0 ;
  wire \count_value_i[8]_i_1__0_n_0 ;
  wire \count_value_i[8]_i_2__0_n_0 ;
  wire \count_value_i_reg[0]_0 ;
  wire [3:0]\count_value_i_reg[7]_0 ;
  wire \count_value_i_reg[8]_0 ;
  wire [6:0]\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] ;
  wire rd_clk;
  wire rd_en;

  LUT3 #(
    .INIT(8'hB4)) 
    \count_value_i[0]_i_1__3 
       (.I0(\count_value_i_reg[0]_0 ),
        .I1(rd_en),
        .I2(Q[0]),
        .O(\count_value_i[0]_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count_value_i[1]_i_1__3 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\count_value_i[1]_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \count_value_i[2]_i_1__3 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .O(\count_value_i[2]_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[3]_i_1__3 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(\count_value_i[3]_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[4]_i_1__3 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[3]),
        .I4(Q[4]),
        .O(\count_value_i[4]_i_1__3_n_0 ));
  LUT3 #(
    .INIT(8'h78)) 
    \count_value_i[5]_i_1__3 
       (.I0(\count_value_i[8]_i_2__0_n_0 ),
        .I1(Q[4]),
        .I2(Q[5]),
        .O(\count_value_i[5]_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[6]_i_1__3 
       (.I0(Q[4]),
        .I1(\count_value_i[8]_i_2__0_n_0 ),
        .I2(Q[5]),
        .I3(Q[6]),
        .O(\count_value_i[6]_i_1__3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[7]_i_1__3 
       (.I0(Q[5]),
        .I1(\count_value_i[8]_i_2__0_n_0 ),
        .I2(Q[4]),
        .I3(Q[6]),
        .I4(Q[7]),
        .O(\count_value_i[7]_i_1__3_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \count_value_i[8]_i_1__0 
       (.I0(Q[6]),
        .I1(Q[4]),
        .I2(\count_value_i[8]_i_2__0_n_0 ),
        .I3(Q[5]),
        .I4(Q[7]),
        .I5(Q[8]),
        .O(\count_value_i[8]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    \count_value_i[8]_i_2__0 
       (.I0(Q[3]),
        .I1(Q[1]),
        .I2(rd_en),
        .I3(\count_value_i_reg[0]_0 ),
        .I4(Q[0]),
        .I5(Q[2]),
        .O(\count_value_i[8]_i_2__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[0] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[0]_i_1__3_n_0 ),
        .Q(Q[0]),
        .R(\count_value_i_reg[8]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[1] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[1]_i_1__3_n_0 ),
        .Q(Q[1]),
        .R(\count_value_i_reg[8]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[2]_i_1__3_n_0 ),
        .Q(Q[2]),
        .R(\count_value_i_reg[8]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[3]_i_1__3_n_0 ),
        .Q(Q[3]),
        .R(\count_value_i_reg[8]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[4]_i_1__3_n_0 ),
        .Q(Q[4]),
        .R(\count_value_i_reg[8]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[5]_i_1__3_n_0 ),
        .Q(Q[5]),
        .R(\count_value_i_reg[8]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[6] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[6]_i_1__3_n_0 ),
        .Q(Q[6]),
        .R(\count_value_i_reg[8]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[7] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[7]_i_1__3_n_0 ),
        .Q(Q[7]),
        .R(\count_value_i_reg[8]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[8] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[8]_i_1__0_n_0 ),
        .Q(Q[8]),
        .R(\count_value_i_reg[8]_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_3 
       (.I0(Q[3]),
        .I1(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] [2]),
        .O(S[3]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_4 
       (.I0(Q[2]),
        .I1(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] [1]),
        .O(S[2]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_5 
       (.I0(Q[1]),
        .I1(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] [0]),
        .O(S[1]));
  LUT3 #(
    .INIT(8'hB4)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_6 
       (.I0(\count_value_i_reg[0]_0 ),
        .I1(rd_en),
        .I2(Q[0]),
        .O(S[0]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[7]_i_2 
       (.I0(Q[7]),
        .I1(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] [6]),
        .O(\count_value_i_reg[7]_0 [3]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[7]_i_3 
       (.I0(Q[6]),
        .I1(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] [5]),
        .O(\count_value_i_reg[7]_0 [2]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[7]_i_4 
       (.I0(Q[5]),
        .I1(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] [4]),
        .O(\count_value_i_reg[7]_0 [1]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[7]_i_5 
       (.I0(Q[4]),
        .I1(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] [3]),
        .O(\count_value_i_reg[7]_0 [0]));
  LUT2 #(
    .INIT(4'h2)) 
    \gen_sdpram.xpm_memory_base_inst_i_2 
       (.I0(rd_en),
        .I1(\count_value_i_reg[0]_0 ),
        .O(E));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module design_2_UART_0_0_xpm_counter_updn_2
   (Q,
    O,
    wr_pntr_plus1_pf_carry,
    wr_en,
    \count_value_i_reg[6]_0 ,
    wrst_busy,
    rst_d1,
    \gwdc.wr_data_count_i_reg[8] ,
    wr_clk);
  output [8:0]Q;
  output [0:0]O;
  input wr_pntr_plus1_pf_carry;
  input wr_en;
  input \count_value_i_reg[6]_0 ;
  input wrst_busy;
  input rst_d1;
  input [8:0]\gwdc.wr_data_count_i_reg[8] ;
  input wr_clk;

  wire [0:0]O;
  wire [8:0]Q;
  wire \count_value_i[0]_i_1__1_n_0 ;
  wire \count_value_i[1]_i_1__1_n_0 ;
  wire \count_value_i[2]_i_1__1_n_0 ;
  wire \count_value_i[3]_i_1__1_n_0 ;
  wire \count_value_i[4]_i_1__1_n_0 ;
  wire \count_value_i[5]_i_1__1_n_0 ;
  wire \count_value_i[6]_i_1__1_n_0 ;
  wire \count_value_i[6]_i_2__1_n_0 ;
  wire \count_value_i[7]_i_1__1_n_0 ;
  wire \count_value_i[8]_i_1_n_0 ;
  wire \count_value_i[8]_i_2_n_0 ;
  wire \count_value_i_reg[6]_0 ;
  wire \gwdc.wr_data_count_i[8]_i_10_n_0 ;
  wire \gwdc.wr_data_count_i[8]_i_11_n_0 ;
  wire \gwdc.wr_data_count_i[8]_i_12_n_0 ;
  wire \gwdc.wr_data_count_i[8]_i_3_n_0 ;
  wire \gwdc.wr_data_count_i[8]_i_5_n_0 ;
  wire \gwdc.wr_data_count_i[8]_i_6_n_0 ;
  wire \gwdc.wr_data_count_i[8]_i_7_n_0 ;
  wire \gwdc.wr_data_count_i[8]_i_8_n_0 ;
  wire \gwdc.wr_data_count_i[8]_i_9_n_0 ;
  wire [8:0]\gwdc.wr_data_count_i_reg[8] ;
  wire \gwdc.wr_data_count_i_reg[8]_i_2_n_0 ;
  wire \gwdc.wr_data_count_i_reg[8]_i_2_n_1 ;
  wire \gwdc.wr_data_count_i_reg[8]_i_2_n_2 ;
  wire \gwdc.wr_data_count_i_reg[8]_i_2_n_3 ;
  wire \gwdc.wr_data_count_i_reg[8]_i_4_n_0 ;
  wire \gwdc.wr_data_count_i_reg[8]_i_4_n_1 ;
  wire \gwdc.wr_data_count_i_reg[8]_i_4_n_2 ;
  wire \gwdc.wr_data_count_i_reg[8]_i_4_n_3 ;
  wire rst_d1;
  wire wr_clk;
  wire wr_en;
  wire wr_pntr_plus1_pf_carry;
  wire wrst_busy;
  wire [3:0]\NLW_gwdc.wr_data_count_i_reg[8]_i_1_CO_UNCONNECTED ;
  wire [3:1]\NLW_gwdc.wr_data_count_i_reg[8]_i_1_O_UNCONNECTED ;
  wire [3:0]\NLW_gwdc.wr_data_count_i_reg[8]_i_2_O_UNCONNECTED ;
  wire [3:0]\NLW_gwdc.wr_data_count_i_reg[8]_i_4_O_UNCONNECTED ;

  LUT1 #(
    .INIT(2'h1)) 
    \count_value_i[0]_i_1__1 
       (.I0(Q[0]),
        .O(\count_value_i[0]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count_value_i[1]_i_1__1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\count_value_i[1]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \count_value_i[2]_i_1__1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .O(\count_value_i[2]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[3]_i_1__1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(\count_value_i[3]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[4]_i_1__1 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[3]),
        .I4(Q[4]),
        .O(\count_value_i[4]_i_1__1_n_0 ));
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[5]_i_1__1 
       (.I0(Q[3]),
        .I1(\count_value_i[6]_i_2__1_n_0 ),
        .I2(Q[2]),
        .I3(Q[4]),
        .I4(Q[5]),
        .O(\count_value_i[5]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \count_value_i[6]_i_1__1 
       (.I0(Q[4]),
        .I1(Q[2]),
        .I2(\count_value_i[6]_i_2__1_n_0 ),
        .I3(Q[3]),
        .I4(Q[5]),
        .I5(Q[6]),
        .O(\count_value_i[6]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000800000000)) 
    \count_value_i[6]_i_2__1 
       (.I0(Q[1]),
        .I1(wr_en),
        .I2(\count_value_i_reg[6]_0 ),
        .I3(wrst_busy),
        .I4(rst_d1),
        .I5(Q[0]),
        .O(\count_value_i[6]_i_2__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[7]_i_1__1 
       (.I0(Q[5]),
        .I1(\count_value_i[8]_i_2_n_0 ),
        .I2(Q[6]),
        .I3(Q[7]),
        .O(\count_value_i[7]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[8]_i_1 
       (.I0(Q[6]),
        .I1(\count_value_i[8]_i_2_n_0 ),
        .I2(Q[5]),
        .I3(Q[7]),
        .I4(Q[8]),
        .O(\count_value_i[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \count_value_i[8]_i_2 
       (.I0(Q[4]),
        .I1(Q[2]),
        .I2(Q[0]),
        .I3(wr_pntr_plus1_pf_carry),
        .I4(Q[1]),
        .I5(Q[3]),
        .O(\count_value_i[8]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[0] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[0]_i_1__1_n_0 ),
        .Q(Q[0]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[1] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[1]_i_1__1_n_0 ),
        .Q(Q[1]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[2]_i_1__1_n_0 ),
        .Q(Q[2]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[3]_i_1__1_n_0 ),
        .Q(Q[3]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[4]_i_1__1_n_0 ),
        .Q(Q[4]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[5]_i_1__1_n_0 ),
        .Q(Q[5]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[6] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[6]_i_1__1_n_0 ),
        .Q(Q[6]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[7] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[7]_i_1__1_n_0 ),
        .Q(Q[7]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[8] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[8]_i_1_n_0 ),
        .Q(Q[8]),
        .R(wrst_busy));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[8]_i_10 
       (.I0(Q[2]),
        .I1(\gwdc.wr_data_count_i_reg[8] [2]),
        .O(\gwdc.wr_data_count_i[8]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[8]_i_11 
       (.I0(Q[1]),
        .I1(\gwdc.wr_data_count_i_reg[8] [1]),
        .O(\gwdc.wr_data_count_i[8]_i_11_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[8]_i_12 
       (.I0(Q[0]),
        .I1(\gwdc.wr_data_count_i_reg[8] [0]),
        .O(\gwdc.wr_data_count_i[8]_i_12_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[8]_i_3 
       (.I0(Q[8]),
        .I1(\gwdc.wr_data_count_i_reg[8] [8]),
        .O(\gwdc.wr_data_count_i[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[8]_i_5 
       (.I0(Q[7]),
        .I1(\gwdc.wr_data_count_i_reg[8] [7]),
        .O(\gwdc.wr_data_count_i[8]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[8]_i_6 
       (.I0(Q[6]),
        .I1(\gwdc.wr_data_count_i_reg[8] [6]),
        .O(\gwdc.wr_data_count_i[8]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[8]_i_7 
       (.I0(Q[5]),
        .I1(\gwdc.wr_data_count_i_reg[8] [5]),
        .O(\gwdc.wr_data_count_i[8]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[8]_i_8 
       (.I0(Q[4]),
        .I1(\gwdc.wr_data_count_i_reg[8] [4]),
        .O(\gwdc.wr_data_count_i[8]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[8]_i_9 
       (.I0(Q[3]),
        .I1(\gwdc.wr_data_count_i_reg[8] [3]),
        .O(\gwdc.wr_data_count_i[8]_i_9_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \gwdc.wr_data_count_i_reg[8]_i_1 
       (.CI(\gwdc.wr_data_count_i_reg[8]_i_2_n_0 ),
        .CO(\NLW_gwdc.wr_data_count_i_reg[8]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_gwdc.wr_data_count_i_reg[8]_i_1_O_UNCONNECTED [3:1],O}),
        .S({1'b0,1'b0,1'b0,\gwdc.wr_data_count_i[8]_i_3_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \gwdc.wr_data_count_i_reg[8]_i_2 
       (.CI(\gwdc.wr_data_count_i_reg[8]_i_4_n_0 ),
        .CO({\gwdc.wr_data_count_i_reg[8]_i_2_n_0 ,\gwdc.wr_data_count_i_reg[8]_i_2_n_1 ,\gwdc.wr_data_count_i_reg[8]_i_2_n_2 ,\gwdc.wr_data_count_i_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(Q[7:4]),
        .O(\NLW_gwdc.wr_data_count_i_reg[8]_i_2_O_UNCONNECTED [3:0]),
        .S({\gwdc.wr_data_count_i[8]_i_5_n_0 ,\gwdc.wr_data_count_i[8]_i_6_n_0 ,\gwdc.wr_data_count_i[8]_i_7_n_0 ,\gwdc.wr_data_count_i[8]_i_8_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \gwdc.wr_data_count_i_reg[8]_i_4 
       (.CI(1'b0),
        .CO({\gwdc.wr_data_count_i_reg[8]_i_4_n_0 ,\gwdc.wr_data_count_i_reg[8]_i_4_n_1 ,\gwdc.wr_data_count_i_reg[8]_i_4_n_2 ,\gwdc.wr_data_count_i_reg[8]_i_4_n_3 }),
        .CYINIT(1'b1),
        .DI(Q[3:0]),
        .O(\NLW_gwdc.wr_data_count_i_reg[8]_i_4_O_UNCONNECTED [3:0]),
        .S({\gwdc.wr_data_count_i[8]_i_9_n_0 ,\gwdc.wr_data_count_i[8]_i_10_n_0 ,\gwdc.wr_data_count_i[8]_i_11_n_0 ,\gwdc.wr_data_count_i[8]_i_12_n_0 }));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module design_2_UART_0_0_xpm_counter_updn__parameterized0
   (Q,
    rd_en,
    \count_value_i_reg[7]_0 ,
    \count_value_i_reg[0]_0 ,
    E,
    rd_clk);
  output [7:0]Q;
  input rd_en;
  input \count_value_i_reg[7]_0 ;
  input \count_value_i_reg[0]_0 ;
  input [0:0]E;
  input rd_clk;

  wire [0:0]E;
  wire [7:0]Q;
  wire \count_value_i[0]_i_1__2_n_0 ;
  wire \count_value_i[1]_i_1__2_n_0 ;
  wire \count_value_i[2]_i_1__2_n_0 ;
  wire \count_value_i[3]_i_1__2_n_0 ;
  wire \count_value_i[4]_i_1__2_n_0 ;
  wire \count_value_i[5]_i_1__2_n_0 ;
  wire \count_value_i[6]_i_1__2_n_0 ;
  wire \count_value_i[7]_i_1__2_n_0 ;
  wire \count_value_i[7]_i_2__1_n_0 ;
  wire \count_value_i_reg[0]_0 ;
  wire \count_value_i_reg[7]_0 ;
  wire rd_clk;
  wire rd_en;

  LUT1 #(
    .INIT(2'h1)) 
    \count_value_i[0]_i_1__2 
       (.I0(Q[0]),
        .O(\count_value_i[0]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count_value_i[1]_i_1__2 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\count_value_i[1]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \count_value_i[2]_i_1__2 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .O(\count_value_i[2]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[3]_i_1__2 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(\count_value_i[3]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[4]_i_1__2 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[3]),
        .I4(Q[4]),
        .O(\count_value_i[4]_i_1__2_n_0 ));
  LUT3 #(
    .INIT(8'h78)) 
    \count_value_i[5]_i_1__2 
       (.I0(\count_value_i[7]_i_2__1_n_0 ),
        .I1(Q[4]),
        .I2(Q[5]),
        .O(\count_value_i[5]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[6]_i_1__2 
       (.I0(Q[4]),
        .I1(\count_value_i[7]_i_2__1_n_0 ),
        .I2(Q[5]),
        .I3(Q[6]),
        .O(\count_value_i[6]_i_1__2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[7]_i_1__2 
       (.I0(Q[5]),
        .I1(\count_value_i[7]_i_2__1_n_0 ),
        .I2(Q[4]),
        .I3(Q[6]),
        .I4(Q[7]),
        .O(\count_value_i[7]_i_1__2_n_0 ));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    \count_value_i[7]_i_2__1 
       (.I0(Q[3]),
        .I1(Q[1]),
        .I2(rd_en),
        .I3(\count_value_i_reg[7]_0 ),
        .I4(Q[0]),
        .I5(Q[2]),
        .O(\count_value_i[7]_i_2__1_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \count_value_i_reg[0] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[0]_i_1__2_n_0 ),
        .Q(Q[0]),
        .S(\count_value_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[1] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[1]_i_1__2_n_0 ),
        .Q(Q[1]),
        .R(\count_value_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[2]_i_1__2_n_0 ),
        .Q(Q[2]),
        .R(\count_value_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[3]_i_1__2_n_0 ),
        .Q(Q[3]),
        .R(\count_value_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[4]_i_1__2_n_0 ),
        .Q(Q[4]),
        .R(\count_value_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[5]_i_1__2_n_0 ),
        .Q(Q[5]),
        .R(\count_value_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[6] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[6]_i_1__2_n_0 ),
        .Q(Q[6]),
        .R(\count_value_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[7] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i[7]_i_1__2_n_0 ),
        .Q(Q[7]),
        .R(\count_value_i_reg[0]_0 ));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module design_2_UART_0_0_xpm_counter_updn__parameterized0_3
   (Q,
    D,
    wr_pntr_plus1_pf_carry,
    wr_en,
    \count_value_i_reg[6]_0 ,
    wrst_busy,
    rst_d1,
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8] ,
    wr_clk);
  output [7:0]Q;
  output [6:0]D;
  input wr_pntr_plus1_pf_carry;
  input wr_en;
  input \count_value_i_reg[6]_0 ;
  input wrst_busy;
  input rst_d1;
  input [7:0]\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8] ;
  input wr_clk;

  wire [6:0]D;
  wire [7:0]Q;
  wire \count_value_i[0]_i_1__0_n_0 ;
  wire \count_value_i[1]_i_1__0_n_0 ;
  wire \count_value_i[2]_i_1__0_n_0 ;
  wire \count_value_i[3]_i_1__0_n_0 ;
  wire \count_value_i[4]_i_1__0_n_0 ;
  wire \count_value_i[5]_i_1__0_n_0 ;
  wire \count_value_i[6]_i_1__0_n_0 ;
  wire \count_value_i[6]_i_2__0_n_0 ;
  wire \count_value_i[7]_i_1__0_n_0 ;
  wire \count_value_i[7]_i_2__0_n_0 ;
  wire \count_value_i_reg[6]_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_2_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_3_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_4_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_5_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_2_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_3_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_4_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_5_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_1 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_2 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_3 ;
  wire [7:0]\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8] ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_1 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_2 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_3 ;
  wire rst_d1;
  wire wr_clk;
  wire wr_en;
  wire wr_pntr_plus1_pf_carry;
  wire wrst_busy;
  wire [0:0]\NLW_gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_O_UNCONNECTED ;
  wire [3:3]\NLW_gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_CO_UNCONNECTED ;

  LUT1 #(
    .INIT(2'h1)) 
    \count_value_i[0]_i_1__0 
       (.I0(Q[0]),
        .O(\count_value_i[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count_value_i[1]_i_1__0 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\count_value_i[1]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \count_value_i[2]_i_1__0 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .O(\count_value_i[2]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[3]_i_1__0 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(\count_value_i[3]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[4]_i_1__0 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[3]),
        .I4(Q[4]),
        .O(\count_value_i[4]_i_1__0_n_0 ));
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[5]_i_1__0 
       (.I0(Q[3]),
        .I1(\count_value_i[6]_i_2__0_n_0 ),
        .I2(Q[2]),
        .I3(Q[4]),
        .I4(Q[5]),
        .O(\count_value_i[5]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \count_value_i[6]_i_1__0 
       (.I0(Q[4]),
        .I1(Q[2]),
        .I2(\count_value_i[6]_i_2__0_n_0 ),
        .I3(Q[3]),
        .I4(Q[5]),
        .I5(Q[6]),
        .O(\count_value_i[6]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000000800000000)) 
    \count_value_i[6]_i_2__0 
       (.I0(Q[1]),
        .I1(wr_en),
        .I2(\count_value_i_reg[6]_0 ),
        .I3(wrst_busy),
        .I4(rst_d1),
        .I5(Q[0]),
        .O(\count_value_i[6]_i_2__0_n_0 ));
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[7]_i_1__0 
       (.I0(Q[5]),
        .I1(\count_value_i[7]_i_2__0_n_0 ),
        .I2(Q[6]),
        .I3(Q[7]),
        .O(\count_value_i[7]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \count_value_i[7]_i_2__0 
       (.I0(Q[4]),
        .I1(Q[2]),
        .I2(Q[0]),
        .I3(wr_pntr_plus1_pf_carry),
        .I4(Q[1]),
        .I5(Q[3]),
        .O(\count_value_i[7]_i_2__0_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \count_value_i_reg[0] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[0]_i_1__0_n_0 ),
        .Q(Q[0]),
        .S(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[1] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[1]_i_1__0_n_0 ),
        .Q(Q[1]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[2]_i_1__0_n_0 ),
        .Q(Q[2]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[3]_i_1__0_n_0 ),
        .Q(Q[3]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[4]_i_1__0_n_0 ),
        .Q(Q[4]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[5]_i_1__0_n_0 ),
        .Q(Q[5]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[6] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[6]_i_1__0_n_0 ),
        .Q(Q[6]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[7] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[7]_i_1__0_n_0 ),
        .Q(Q[7]),
        .R(wrst_busy));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_2 
       (.I0(Q[3]),
        .I1(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8] [3]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_3 
       (.I0(Q[2]),
        .I1(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8] [2]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_4 
       (.I0(Q[1]),
        .I1(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8] [1]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_5 
       (.I0(Q[0]),
        .I1(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8] [0]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_2 
       (.I0(Q[7]),
        .I1(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8] [7]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_3 
       (.I0(Q[6]),
        .I1(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8] [6]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_4 
       (.I0(Q[5]),
        .I1(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8] [5]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_5 
       (.I0(Q[4]),
        .I1(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8] [4]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_5_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1 
       (.CI(1'b0),
        .CO({\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_1 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_2 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_3 }),
        .CYINIT(wr_pntr_plus1_pf_carry),
        .DI(Q[3:0]),
        .O({D[2:0],\NLW_gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_O_UNCONNECTED [0]}),
        .S({\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_2_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_3_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_4_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_5_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1 
       (.CI(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_0 ),
        .CO({\NLW_gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_CO_UNCONNECTED [3],\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_1 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_2 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,Q[6:4]}),
        .O(D[6:3]),
        .S({\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_2_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_3_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_4_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_5_n_0 }));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module design_2_UART_0_0_xpm_counter_updn__parameterized1
   (Q,
    wr_pntr_plus1_pf_carry,
    wr_en,
    \count_value_i_reg[6]_0 ,
    wrst_busy,
    rst_d1,
    wr_clk);
  output [7:0]Q;
  input wr_pntr_plus1_pf_carry;
  input wr_en;
  input \count_value_i_reg[6]_0 ;
  input wrst_busy;
  input rst_d1;
  input wr_clk;

  wire [7:0]Q;
  wire \count_value_i[0]_i_1_n_0 ;
  wire \count_value_i[1]_i_1_n_0 ;
  wire \count_value_i[2]_i_1_n_0 ;
  wire \count_value_i[3]_i_1_n_0 ;
  wire \count_value_i[4]_i_1_n_0 ;
  wire \count_value_i[5]_i_1_n_0 ;
  wire \count_value_i[6]_i_1_n_0 ;
  wire \count_value_i[6]_i_2_n_0 ;
  wire \count_value_i[7]_i_1_n_0 ;
  wire \count_value_i[7]_i_2_n_0 ;
  wire \count_value_i_reg[6]_0 ;
  wire rst_d1;
  wire wr_clk;
  wire wr_en;
  wire wr_pntr_plus1_pf_carry;
  wire wrst_busy;

  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \count_value_i[0]_i_1 
       (.I0(Q[0]),
        .O(\count_value_i[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \count_value_i[1]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\count_value_i[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \count_value_i[2]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .O(\count_value_i[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[3]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(\count_value_i[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[4]_i_1 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[3]),
        .I4(Q[4]),
        .O(\count_value_i[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count_value_i[5]_i_1 
       (.I0(Q[3]),
        .I1(\count_value_i[6]_i_2_n_0 ),
        .I2(Q[2]),
        .I3(Q[4]),
        .I4(Q[5]),
        .O(\count_value_i[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \count_value_i[6]_i_1 
       (.I0(Q[4]),
        .I1(Q[2]),
        .I2(\count_value_i[6]_i_2_n_0 ),
        .I3(Q[3]),
        .I4(Q[5]),
        .I5(Q[6]),
        .O(\count_value_i[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000800000000)) 
    \count_value_i[6]_i_2 
       (.I0(Q[1]),
        .I1(wr_en),
        .I2(\count_value_i_reg[6]_0 ),
        .I3(wrst_busy),
        .I4(rst_d1),
        .I5(Q[0]),
        .O(\count_value_i[6]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h7F80)) 
    \count_value_i[7]_i_1 
       (.I0(Q[5]),
        .I1(\count_value_i[7]_i_2_n_0 ),
        .I2(Q[6]),
        .I3(Q[7]),
        .O(\count_value_i[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \count_value_i[7]_i_2 
       (.I0(Q[4]),
        .I1(Q[2]),
        .I2(Q[0]),
        .I3(wr_pntr_plus1_pf_carry),
        .I4(Q[1]),
        .I5(Q[3]),
        .O(\count_value_i[7]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[0] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[0]_i_1_n_0 ),
        .Q(Q[0]),
        .R(wrst_busy));
  FDSE #(
    .INIT(1'b1)) 
    \count_value_i_reg[1] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[1]_i_1_n_0 ),
        .Q(Q[1]),
        .S(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[2]_i_1_n_0 ),
        .Q(Q[2]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[3]_i_1_n_0 ),
        .Q(Q[3]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[4]_i_1_n_0 ),
        .Q(Q[4]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[5]_i_1_n_0 ),
        .Q(Q[5]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[6] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[6]_i_1_n_0 ),
        .Q(Q[6]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[7] 
       (.C(wr_clk),
        .CE(wr_pntr_plus1_pf_carry),
        .D(\count_value_i[7]_i_1_n_0 ),
        .Q(Q[7]),
        .R(wrst_busy));
endmodule

(* CASCADE_HEIGHT = "0" *) (* CDC_SYNC_STAGES = "2" *) (* DOUT_RESET_VALUE = "0" *) 
(* ECC_MODE = "no_ecc" *) (* EN_ADV_FEATURE_ASYNC = "16'b0000011100000111" *) (* FIFO_MEMORY_TYPE = "auto" *) 
(* FIFO_READ_LATENCY = "1" *) (* FIFO_WRITE_DEPTH = "256" *) (* FULL_RESET_VALUE = "0" *) 
(* ORIG_REF_NAME = "xpm_fifo_async" *) (* PROG_EMPTY_THRESH = "10" *) (* PROG_FULL_THRESH = "10" *) 
(* P_COMMON_CLOCK = "0" *) (* P_ECC_MODE = "0" *) (* P_FIFO_MEMORY_TYPE = "0" *) 
(* P_READ_MODE = "0" *) (* P_WAKEUP_TIME = "2" *) (* RD_DATA_COUNT_WIDTH = "1" *) 
(* READ_DATA_WIDTH = "8" *) (* READ_MODE = "std" *) (* RELATED_CLOCKS = "0" *) 
(* SIM_ASSERT_CHK = "0" *) (* USE_ADV_FEATURES = "0707" *) (* WAKEUP_TIME = "0" *) 
(* WRITE_DATA_WIDTH = "8" *) (* WR_DATA_COUNT_WIDTH = "1" *) (* XPM_MODULE = "TRUE" *) 
(* dont_touch = "true" *) 
module design_2_UART_0_0_xpm_fifo_async
   (sleep,
    rst,
    wr_clk,
    wr_en,
    din,
    full,
    prog_full,
    wr_data_count,
    overflow,
    wr_rst_busy,
    almost_full,
    wr_ack,
    rd_clk,
    rd_en,
    dout,
    empty,
    prog_empty,
    rd_data_count,
    underflow,
    rd_rst_busy,
    almost_empty,
    data_valid,
    injectsbiterr,
    injectdbiterr,
    sbiterr,
    dbiterr);
  input sleep;
  input rst;
  input wr_clk;
  input wr_en;
  input [7:0]din;
  output full;
  output prog_full;
  output [0:0]wr_data_count;
  output overflow;
  output wr_rst_busy;
  output almost_full;
  output wr_ack;
  input rd_clk;
  input rd_en;
  output [7:0]dout;
  output empty;
  output prog_empty;
  output [0:0]rd_data_count;
  output underflow;
  output rd_rst_busy;
  output almost_empty;
  output data_valid;
  input injectsbiterr;
  input injectdbiterr;
  output sbiterr;
  output dbiterr;

  wire \<const0> ;
  wire [7:0]din;
  wire [7:0]dout;
  wire empty;
  wire full;
  wire overflow;
  wire prog_empty;
  wire prog_full;
  wire rd_clk;
  wire [0:0]rd_data_count;
  wire rd_en;
  wire rd_rst_busy;
  wire rst;
  wire sleep;
  wire underflow;
  wire wr_clk;
  wire [0:0]wr_data_count;
  wire wr_en;
  wire wr_rst_busy;
  wire \NLW_gnuram_async_fifo.xpm_fifo_base_inst_almost_empty_UNCONNECTED ;
  wire \NLW_gnuram_async_fifo.xpm_fifo_base_inst_almost_full_UNCONNECTED ;
  wire \NLW_gnuram_async_fifo.xpm_fifo_base_inst_data_valid_UNCONNECTED ;
  wire \NLW_gnuram_async_fifo.xpm_fifo_base_inst_dbiterr_UNCONNECTED ;
  wire \NLW_gnuram_async_fifo.xpm_fifo_base_inst_full_n_UNCONNECTED ;
  wire \NLW_gnuram_async_fifo.xpm_fifo_base_inst_sbiterr_UNCONNECTED ;
  wire \NLW_gnuram_async_fifo.xpm_fifo_base_inst_wr_ack_UNCONNECTED ;

  assign almost_empty = \<const0> ;
  assign almost_full = \<const0> ;
  assign data_valid = \<const0> ;
  assign dbiterr = \<const0> ;
  assign sbiterr = \<const0> ;
  assign wr_ack = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* CASCADE_HEIGHT = "0" *) 
  (* CDC_DEST_SYNC_FF = "2" *) 
  (* COMMON_CLOCK = "0" *) 
  (* DOUT_RESET_VALUE = "0" *) 
  (* ECC_MODE = "0" *) 
  (* ENABLE_ECC = "0" *) 
  (* EN_ADV_FEATURE = "16'b0000011100000111" *) 
  (* EN_AE = "1'b0" *) 
  (* EN_AF = "1'b0" *) 
  (* EN_DVLD = "1'b0" *) 
  (* EN_OF = "1'b1" *) 
  (* EN_PE = "1'b1" *) 
  (* EN_PF = "1'b1" *) 
  (* EN_RDC = "1'b1" *) 
  (* EN_UF = "1'b1" *) 
  (* EN_WACK = "1'b0" *) 
  (* EN_WDC = "1'b1" *) 
  (* FG_EQ_ASYM_DOUT = "1'b0" *) 
  (* FIFO_MEMORY_TYPE = "0" *) 
  (* FIFO_MEM_TYPE = "0" *) 
  (* FIFO_READ_DEPTH = "256" *) 
  (* FIFO_READ_LATENCY = "1" *) 
  (* FIFO_SIZE = "2048" *) 
  (* FIFO_WRITE_DEPTH = "256" *) 
  (* FULL_RESET_VALUE = "0" *) 
  (* FULL_RST_VAL = "1'b0" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* PE_THRESH_ADJ = "10" *) 
  (* PE_THRESH_MAX = "253" *) 
  (* PE_THRESH_MIN = "3" *) 
  (* PF_THRESH_ADJ = "10" *) 
  (* PF_THRESH_MAX = "253" *) 
  (* PF_THRESH_MIN = "5" *) 
  (* PROG_EMPTY_THRESH = "10" *) 
  (* PROG_FULL_THRESH = "10" *) 
  (* RD_DATA_COUNT_WIDTH = "1" *) 
  (* RD_DC_WIDTH_EXT = "9" *) 
  (* RD_LATENCY = "1" *) 
  (* RD_MODE = "0" *) 
  (* RD_PNTR_WIDTH = "8" *) 
  (* READ_DATA_WIDTH = "8" *) 
  (* READ_MODE = "0" *) 
  (* READ_MODE_LL = "0" *) 
  (* RELATED_CLOCKS = "0" *) 
  (* REMOVE_WR_RD_PROT_LOGIC = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* USE_ADV_FEATURES = "0707" *) 
  (* VERSION = "0" *) 
  (* WAKEUP_TIME = "0" *) 
  (* WIDTH_RATIO = "1" *) 
  (* WRITE_DATA_WIDTH = "8" *) 
  (* WR_DATA_COUNT_WIDTH = "1" *) 
  (* WR_DC_WIDTH_EXT = "9" *) 
  (* WR_DEPTH_LOG = "8" *) 
  (* WR_PNTR_WIDTH = "8" *) 
  (* WR_RD_RATIO = "0" *) 
  (* WR_WIDTH_LOG = "3" *) 
  (* XPM_MODULE = "TRUE" *) 
  (* both_stages_valid = "3" *) 
  (* invalid = "0" *) 
  (* stage1_valid = "2" *) 
  (* stage2_valid = "1" *) 
  design_2_UART_0_0_xpm_fifo_base \gnuram_async_fifo.xpm_fifo_base_inst 
       (.almost_empty(\NLW_gnuram_async_fifo.xpm_fifo_base_inst_almost_empty_UNCONNECTED ),
        .almost_full(\NLW_gnuram_async_fifo.xpm_fifo_base_inst_almost_full_UNCONNECTED ),
        .data_valid(\NLW_gnuram_async_fifo.xpm_fifo_base_inst_data_valid_UNCONNECTED ),
        .dbiterr(\NLW_gnuram_async_fifo.xpm_fifo_base_inst_dbiterr_UNCONNECTED ),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .full_n(\NLW_gnuram_async_fifo.xpm_fifo_base_inst_full_n_UNCONNECTED ),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .overflow(overflow),
        .prog_empty(prog_empty),
        .prog_full(prog_full),
        .rd_clk(rd_clk),
        .rd_data_count(rd_data_count),
        .rd_en(rd_en),
        .rd_rst_busy(rd_rst_busy),
        .rst(rst),
        .sbiterr(\NLW_gnuram_async_fifo.xpm_fifo_base_inst_sbiterr_UNCONNECTED ),
        .sleep(sleep),
        .underflow(underflow),
        .wr_ack(\NLW_gnuram_async_fifo.xpm_fifo_base_inst_wr_ack_UNCONNECTED ),
        .wr_clk(wr_clk),
        .wr_data_count(wr_data_count),
        .wr_en(wr_en),
        .wr_rst_busy(wr_rst_busy));
endmodule

(* CASCADE_HEIGHT = "0" *) (* CDC_DEST_SYNC_FF = "2" *) (* COMMON_CLOCK = "0" *) 
(* DOUT_RESET_VALUE = "0" *) (* ECC_MODE = "0" *) (* ENABLE_ECC = "0" *) 
(* EN_ADV_FEATURE = "16'b0000011100000111" *) (* EN_AE = "1'b0" *) (* EN_AF = "1'b0" *) 
(* EN_DVLD = "1'b0" *) (* EN_OF = "1'b1" *) (* EN_PE = "1'b1" *) 
(* EN_PF = "1'b1" *) (* EN_RDC = "1'b1" *) (* EN_UF = "1'b1" *) 
(* EN_WACK = "1'b0" *) (* EN_WDC = "1'b1" *) (* FG_EQ_ASYM_DOUT = "1'b0" *) 
(* FIFO_MEMORY_TYPE = "0" *) (* FIFO_MEM_TYPE = "0" *) (* FIFO_READ_DEPTH = "256" *) 
(* FIFO_READ_LATENCY = "1" *) (* FIFO_SIZE = "2048" *) (* FIFO_WRITE_DEPTH = "256" *) 
(* FULL_RESET_VALUE = "0" *) (* FULL_RST_VAL = "1'b0" *) (* ORIG_REF_NAME = "xpm_fifo_base" *) 
(* PE_THRESH_ADJ = "10" *) (* PE_THRESH_MAX = "253" *) (* PE_THRESH_MIN = "3" *) 
(* PF_THRESH_ADJ = "10" *) (* PF_THRESH_MAX = "253" *) (* PF_THRESH_MIN = "5" *) 
(* PROG_EMPTY_THRESH = "10" *) (* PROG_FULL_THRESH = "10" *) (* RD_DATA_COUNT_WIDTH = "1" *) 
(* RD_DC_WIDTH_EXT = "9" *) (* RD_LATENCY = "1" *) (* RD_MODE = "0" *) 
(* RD_PNTR_WIDTH = "8" *) (* READ_DATA_WIDTH = "8" *) (* READ_MODE = "0" *) 
(* READ_MODE_LL = "0" *) (* RELATED_CLOCKS = "0" *) (* REMOVE_WR_RD_PROT_LOGIC = "0" *) 
(* SIM_ASSERT_CHK = "0" *) (* USE_ADV_FEATURES = "0707" *) (* VERSION = "0" *) 
(* WAKEUP_TIME = "0" *) (* WIDTH_RATIO = "1" *) (* WRITE_DATA_WIDTH = "8" *) 
(* WR_DATA_COUNT_WIDTH = "1" *) (* WR_DC_WIDTH_EXT = "9" *) (* WR_DEPTH_LOG = "8" *) 
(* WR_PNTR_WIDTH = "8" *) (* WR_RD_RATIO = "0" *) (* WR_WIDTH_LOG = "3" *) 
(* XPM_MODULE = "TRUE" *) (* both_stages_valid = "3" *) (* invalid = "0" *) 
(* keep_hierarchy = "soft" *) (* stage1_valid = "2" *) (* stage2_valid = "1" *) 
module design_2_UART_0_0_xpm_fifo_base
   (sleep,
    rst,
    wr_clk,
    wr_en,
    din,
    full,
    full_n,
    prog_full,
    wr_data_count,
    overflow,
    wr_rst_busy,
    almost_full,
    wr_ack,
    rd_clk,
    rd_en,
    dout,
    empty,
    prog_empty,
    rd_data_count,
    underflow,
    rd_rst_busy,
    almost_empty,
    data_valid,
    injectsbiterr,
    injectdbiterr,
    sbiterr,
    dbiterr);
  input sleep;
  input rst;
  input wr_clk;
  input wr_en;
  input [7:0]din;
  output full;
  output full_n;
  output prog_full;
  output [0:0]wr_data_count;
  output overflow;
  output wr_rst_busy;
  output almost_full;
  output wr_ack;
  input rd_clk;
  input rd_en;
  output [7:0]dout;
  output empty;
  output prog_empty;
  output [0:0]rd_data_count;
  output underflow;
  output rd_rst_busy;
  output almost_empty;
  output data_valid;
  input injectsbiterr;
  input injectdbiterr;
  output sbiterr;
  output dbiterr;

  wire \<const0> ;
  wire [7:0]diff_pntr_pe;
  wire [8:2]diff_pntr_pf_q;
  wire [8:2]diff_pntr_pf_q0;
  wire [7:0]din;
  wire [7:0]dout;
  wire empty;
  wire empty_i0;
  wire full;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_0 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_1 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_2 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_3 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_4 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_5 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_6 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_7 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_8 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_1 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_2 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_3 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_4 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_5 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_6 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_7 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_2_n_0 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[0] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[1] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[2] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[3] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[4] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[5] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[6] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[7] ;
  wire \gen_pf_ic_rc.gpe_ic.prog_empty_i_i_1_n_0 ;
  wire \gen_pf_ic_rc.gpe_ic.prog_empty_i_i_2_n_0 ;
  wire \gen_pf_ic_rc.gpe_ic.prog_empty_i_i_3_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.prog_full_i_i_2_n_0 ;
  wire [8:8]\grdc.diff_wr_rd_pntr_rdc0_out ;
  wire [8:8]\gwdc.diff_wr_rd_pntr1_out ;
  wire overflow;
  wire overflow_i0;
  wire prog_empty;
  wire prog_full;
  wire ram_full_i0;
  wire rd_clk;
  wire [0:0]rd_data_count;
  wire rd_en;
  wire [8:0]rd_pntr_ext;
  wire [7:0]rd_pntr_wr;
  wire [7:0]rd_pntr_wr_cdc;
  wire [8:0]rd_pntr_wr_cdc_dc;
  wire rd_rst_busy;
  wire rdp_inst_n_10;
  wire rdp_inst_n_11;
  wire rdp_inst_n_12;
  wire rdp_inst_n_13;
  wire rdp_inst_n_14;
  wire rdp_inst_n_15;
  wire rdp_inst_n_16;
  wire rdp_inst_n_17;
  wire rdp_inst_n_9;
  wire rdpp1_inst_n_0;
  wire rdpp1_inst_n_1;
  wire rdpp1_inst_n_2;
  wire rdpp1_inst_n_3;
  wire rdpp1_inst_n_4;
  wire rdpp1_inst_n_5;
  wire rdpp1_inst_n_6;
  wire rdpp1_inst_n_7;
  wire rst;
  wire rst_d1;
  wire sleep;
  wire underflow;
  wire underflow_i0;
  wire wr_clk;
  wire [0:0]wr_data_count;
  wire wr_en;
  wire [8:0]wr_pntr_ext;
  wire [8:1]wr_pntr_plus1_pf;
  wire wr_pntr_plus1_pf_carry;
  wire [7:0]wr_pntr_rd_cdc;
  wire [8:0]wr_pntr_rd_cdc_dc;
  wire wr_rst_busy;
  wire wrpp2_inst_n_0;
  wire wrpp2_inst_n_1;
  wire wrpp2_inst_n_2;
  wire wrpp2_inst_n_3;
  wire wrpp2_inst_n_4;
  wire wrpp2_inst_n_5;
  wire wrpp2_inst_n_6;
  wire wrpp2_inst_n_7;
  wire wrst_busy;
  wire xpm_fifo_rst_inst_n_2;
  wire \NLW_gen_sdpram.xpm_memory_base_inst_dbiterra_UNCONNECTED ;
  wire \NLW_gen_sdpram.xpm_memory_base_inst_dbiterrb_UNCONNECTED ;
  wire \NLW_gen_sdpram.xpm_memory_base_inst_sbiterra_UNCONNECTED ;
  wire \NLW_gen_sdpram.xpm_memory_base_inst_sbiterrb_UNCONNECTED ;
  wire [7:0]\NLW_gen_sdpram.xpm_memory_base_inst_douta_UNCONNECTED ;

  assign almost_empty = \<const0> ;
  assign almost_full = \<const0> ;
  assign data_valid = \<const0> ;
  assign dbiterr = \<const0> ;
  assign full_n = \<const0> ;
  assign sbiterr = \<const0> ;
  assign wr_ack = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* DEST_SYNC_FF = "2" *) 
  (* INIT_SYNC_FF = "1" *) 
  (* REG_OUTPUT = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* WIDTH = "9" *) 
  (* XPM_CDC = "GRAY" *) 
  (* XPM_MODULE = "TRUE" *) 
  design_2_UART_0_0_xpm_cdc_gray__parameterized0 \gen_cdc_pntr.rd_pntr_cdc_dc_inst 
       (.dest_clk(wr_clk),
        .dest_out_bin(rd_pntr_wr_cdc_dc),
        .src_clk(rd_clk),
        .src_in_bin(rd_pntr_ext));
  (* DEST_SYNC_FF = "2" *) 
  (* INIT_SYNC_FF = "1" *) 
  (* REG_OUTPUT = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* WIDTH = "8" *) 
  (* XPM_CDC = "GRAY" *) 
  (* XPM_MODULE = "TRUE" *) 
  design_2_UART_0_0_xpm_cdc_gray \gen_cdc_pntr.rd_pntr_cdc_inst 
       (.dest_clk(wr_clk),
        .dest_out_bin(rd_pntr_wr_cdc),
        .src_clk(rd_clk),
        .src_in_bin(rd_pntr_ext[7:0]));
  design_2_UART_0_0_xpm_fifo_reg_vec \gen_cdc_pntr.rpw_gray_reg 
       (.D(rd_pntr_wr_cdc),
        .Q(wr_pntr_plus1_pf),
        .\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg ({wrpp2_inst_n_0,wrpp2_inst_n_1,wrpp2_inst_n_2,wrpp2_inst_n_3,wrpp2_inst_n_4,wrpp2_inst_n_5,wrpp2_inst_n_6,wrpp2_inst_n_7}),
        .\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg_0 (full),
        .ram_full_i0(ram_full_i0),
        .\reg_out_i_reg[7]_0 (rd_pntr_wr),
        .rst_d1(rst_d1),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wrst_busy(wrst_busy));
  design_2_UART_0_0_xpm_fifo_reg_vec__parameterized0 \gen_cdc_pntr.rpw_gray_reg_dc 
       (.D(rd_pntr_wr_cdc_dc),
        .Q({\gen_cdc_pntr.rpw_gray_reg_dc_n_0 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_1 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_2 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_3 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_4 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_5 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_6 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_7 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_8 }),
        .wr_clk(wr_clk),
        .wrst_busy(wrst_busy));
  design_2_UART_0_0_xpm_fifo_reg_vec_0 \gen_cdc_pntr.wpr_gray_reg 
       (.D(diff_pntr_pe),
        .DI(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_2_n_0 ),
        .Q(rd_pntr_ext[7:0]),
        .S({rdp_inst_n_14,rdp_inst_n_15,rdp_inst_n_16,rdp_inst_n_17}),
        .empty_i0(empty_i0),
        .\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] ({rdp_inst_n_10,rdp_inst_n_11,rdp_inst_n_12,rdp_inst_n_13}),
        .\gen_pf_ic_rc.ram_empty_i_reg (empty),
        .\gen_pf_ic_rc.ram_empty_i_reg_0 ({rdpp1_inst_n_0,rdpp1_inst_n_1,rdpp1_inst_n_2,rdpp1_inst_n_3,rdpp1_inst_n_4,rdpp1_inst_n_5,rdpp1_inst_n_6,rdpp1_inst_n_7}),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .\reg_out_i_reg[0]_0 (rd_rst_busy),
        .\reg_out_i_reg[7]_0 ({\gen_cdc_pntr.wpr_gray_reg_n_1 ,\gen_cdc_pntr.wpr_gray_reg_n_2 ,\gen_cdc_pntr.wpr_gray_reg_n_3 ,\gen_cdc_pntr.wpr_gray_reg_n_4 ,\gen_cdc_pntr.wpr_gray_reg_n_5 ,\gen_cdc_pntr.wpr_gray_reg_n_6 ,\gen_cdc_pntr.wpr_gray_reg_n_7 }),
        .\reg_out_i_reg[7]_1 (wr_pntr_rd_cdc));
  design_2_UART_0_0_xpm_fifo_reg_vec__parameterized0_1 \gen_cdc_pntr.wpr_gray_reg_dc 
       (.D(wr_pntr_rd_cdc_dc),
        .O(\grdc.diff_wr_rd_pntr_rdc0_out ),
        .Q(rd_pntr_ext),
        .rd_clk(rd_clk),
        .\reg_out_i_reg[0]_0 (rd_rst_busy));
  (* DEST_SYNC_FF = "2" *) 
  (* INIT_SYNC_FF = "1" *) 
  (* REG_OUTPUT = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* WIDTH = "9" *) 
  (* XPM_CDC = "GRAY" *) 
  (* XPM_MODULE = "TRUE" *) 
  design_2_UART_0_0_xpm_cdc_gray__parameterized0__2 \gen_cdc_pntr.wr_pntr_cdc_dc_inst 
       (.dest_clk(rd_clk),
        .dest_out_bin(wr_pntr_rd_cdc_dc),
        .src_clk(wr_clk),
        .src_in_bin(wr_pntr_ext));
  (* DEST_SYNC_FF = "2" *) 
  (* INIT_SYNC_FF = "1" *) 
  (* REG_OUTPUT = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* WIDTH = "8" *) 
  (* XPM_CDC = "GRAY" *) 
  (* XPM_MODULE = "TRUE" *) 
  design_2_UART_0_0_xpm_cdc_gray__2 \gen_cdc_pntr.wr_pntr_cdc_inst 
       (.dest_clk(rd_clk),
        .dest_out_bin(wr_pntr_rd_cdc),
        .src_clk(wr_clk),
        .src_in_bin(wr_pntr_ext[7:0]));
  LUT2 #(
    .INIT(4'hB)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_2 
       (.I0(empty),
        .I1(rd_en),
        .O(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[0]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[0] ),
        .R(rd_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[1]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[1] ),
        .R(rd_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[2]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[2] ),
        .R(rd_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[3]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[3] ),
        .R(rd_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[4]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[4] ),
        .R(rd_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[5]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[5] ),
        .R(rd_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[6]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[6] ),
        .R(rd_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[7]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[7] ),
        .R(rd_rst_busy));
  LUT4 #(
    .INIT(16'h88B8)) 
    \gen_pf_ic_rc.gpe_ic.prog_empty_i_i_1 
       (.I0(prog_empty),
        .I1(empty),
        .I2(\gen_pf_ic_rc.gpe_ic.prog_empty_i_i_2_n_0 ),
        .I3(\gen_pf_ic_rc.gpe_ic.prog_empty_i_i_3_n_0 ),
        .O(\gen_pf_ic_rc.gpe_ic.prog_empty_i_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h15FF)) 
    \gen_pf_ic_rc.gpe_ic.prog_empty_i_i_2 
       (.I0(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[2] ),
        .I1(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[1] ),
        .I2(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[0] ),
        .I3(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[3] ),
        .O(\gen_pf_ic_rc.gpe_ic.prog_empty_i_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \gen_pf_ic_rc.gpe_ic.prog_empty_i_i_3 
       (.I0(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[5] ),
        .I1(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[4] ),
        .I2(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[7] ),
        .I3(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[6] ),
        .O(\gen_pf_ic_rc.gpe_ic.prog_empty_i_i_3_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \gen_pf_ic_rc.gpe_ic.prog_empty_i_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\gen_pf_ic_rc.gpe_ic.prog_empty_i_i_1_n_0 ),
        .Q(prog_empty),
        .S(rd_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[2]),
        .Q(diff_pntr_pf_q[2]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[3]),
        .Q(diff_pntr_pf_q[3]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[4]),
        .Q(diff_pntr_pf_q[4]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[5]),
        .Q(diff_pntr_pf_q[5]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[6]),
        .Q(diff_pntr_pf_q[6]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[7] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[7]),
        .Q(diff_pntr_pf_q[7]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[8]),
        .Q(diff_pntr_pf_q[8]),
        .R(wrst_busy));
  LUT6 #(
    .INIT(64'hFFFFFFFFFEFEFEEE)) 
    \gen_pf_ic_rc.gpf_ic.prog_full_i_i_2 
       (.I0(diff_pntr_pf_q[7]),
        .I1(diff_pntr_pf_q[6]),
        .I2(diff_pntr_pf_q[4]),
        .I3(diff_pntr_pf_q[2]),
        .I4(diff_pntr_pf_q[3]),
        .I5(diff_pntr_pf_q[8]),
        .O(\gen_pf_ic_rc.gpf_ic.prog_full_i_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.prog_full_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(xpm_fifo_rst_inst_n_2),
        .Q(prog_full),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(ram_full_i0),
        .Q(full),
        .R(wrst_busy));
  FDSE #(
    .INIT(1'b1)) 
    \gen_pf_ic_rc.ram_empty_i_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(empty_i0),
        .Q(empty),
        .S(rd_rst_busy));
  (* ADDR_WIDTH_A = "8" *) 
  (* ADDR_WIDTH_B = "8" *) 
  (* AUTO_SLEEP_TIME = "0" *) 
  (* BYTE_WRITE_WIDTH_A = "8" *) 
  (* BYTE_WRITE_WIDTH_B = "8" *) 
  (* CASCADE_HEIGHT = "0" *) 
  (* CLOCKING_MODE = "1" *) 
  (* ECC_BIT_RANGE = "[7:0]" *) 
  (* ECC_MODE = "0" *) 
  (* ECC_TYPE = "NONE" *) 
  (* IGNORE_INIT_SYNTH = "0" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* MAX_NUM_CHAR = "0" *) 
  (* \MEM.ADDRESS_SPACE  *) 
  (* \MEM.ADDRESS_SPACE_BEGIN  = "0" *) 
  (* \MEM.ADDRESS_SPACE_DATA_LSB  = "0" *) 
  (* \MEM.ADDRESS_SPACE_DATA_MSB  = "7" *) 
  (* \MEM.ADDRESS_SPACE_END  = "1023" *) 
  (* \MEM.CORE_MEMORY_WIDTH  = "8" *) 
  (* MEMORY_INIT_FILE = "none" *) 
  (* MEMORY_INIT_PARAM = "" *) 
  (* MEMORY_OPTIMIZATION = "true" *) 
  (* MEMORY_PRIMITIVE = "0" *) 
  (* MEMORY_SIZE = "2048" *) 
  (* MEMORY_TYPE = "1" *) 
  (* MESSAGE_CONTROL = "0" *) 
  (* NUM_CHAR_LOC = "0" *) 
  (* P_ECC_MODE = "no_ecc" *) 
  (* P_ENABLE_BYTE_WRITE_A = "0" *) 
  (* P_ENABLE_BYTE_WRITE_B = "0" *) 
  (* P_MAX_DEPTH_DATA = "256" *) 
  (* P_MEMORY_OPT = "yes" *) 
  (* P_MEMORY_PRIMITIVE = "auto" *) 
  (* P_MIN_WIDTH_DATA = "8" *) 
  (* P_MIN_WIDTH_DATA_A = "8" *) 
  (* P_MIN_WIDTH_DATA_B = "8" *) 
  (* P_MIN_WIDTH_DATA_ECC = "8" *) 
  (* P_MIN_WIDTH_DATA_LDW = "4" *) 
  (* P_MIN_WIDTH_DATA_SHFT = "8" *) 
  (* P_NUM_COLS_WRITE_A = "1" *) 
  (* P_NUM_COLS_WRITE_B = "1" *) 
  (* P_NUM_ROWS_READ_A = "1" *) 
  (* P_NUM_ROWS_READ_B = "1" *) 
  (* P_NUM_ROWS_WRITE_A = "1" *) 
  (* P_NUM_ROWS_WRITE_B = "1" *) 
  (* P_SDP_WRITE_MODE = "yes" *) 
  (* P_WIDTH_ADDR_LSB_READ_A = "0" *) 
  (* P_WIDTH_ADDR_LSB_READ_B = "0" *) 
  (* P_WIDTH_ADDR_LSB_WRITE_A = "0" *) 
  (* P_WIDTH_ADDR_LSB_WRITE_B = "0" *) 
  (* P_WIDTH_ADDR_READ_A = "8" *) 
  (* P_WIDTH_ADDR_READ_B = "8" *) 
  (* P_WIDTH_ADDR_WRITE_A = "8" *) 
  (* P_WIDTH_ADDR_WRITE_B = "8" *) 
  (* P_WIDTH_COL_WRITE_A = "8" *) 
  (* P_WIDTH_COL_WRITE_B = "8" *) 
  (* READ_DATA_WIDTH_A = "8" *) 
  (* READ_DATA_WIDTH_B = "8" *) 
  (* READ_LATENCY_A = "2" *) 
  (* READ_LATENCY_B = "1" *) 
  (* READ_RESET_VALUE_A = "0" *) 
  (* READ_RESET_VALUE_B = "0" *) 
  (* RST_MODE_A = "SYNC" *) 
  (* RST_MODE_B = "SYNC" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* USE_EMBEDDED_CONSTRAINT = "0" *) 
  (* USE_MEM_INIT = "0" *) 
  (* USE_MEM_INIT_MMI = "0" *) 
  (* VERSION = "0" *) 
  (* WAKEUP_TIME = "0" *) 
  (* WRITE_DATA_WIDTH_A = "8" *) 
  (* WRITE_DATA_WIDTH_B = "8" *) 
  (* WRITE_MODE_A = "2" *) 
  (* WRITE_MODE_B = "2" *) 
  (* WRITE_PROTECT = "1" *) 
  (* XPM_MODULE = "TRUE" *) 
  (* rsta_loop_iter = "8" *) 
  (* rstb_loop_iter = "8" *) 
  design_2_UART_0_0_xpm_memory_base \gen_sdpram.xpm_memory_base_inst 
       (.addra(wr_pntr_ext[7:0]),
        .addrb(rd_pntr_ext[7:0]),
        .clka(wr_clk),
        .clkb(rd_clk),
        .dbiterra(\NLW_gen_sdpram.xpm_memory_base_inst_dbiterra_UNCONNECTED ),
        .dbiterrb(\NLW_gen_sdpram.xpm_memory_base_inst_dbiterrb_UNCONNECTED ),
        .dina(din),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(\NLW_gen_sdpram.xpm_memory_base_inst_douta_UNCONNECTED [7:0]),
        .doutb(dout),
        .ena(1'b0),
        .enb(rdp_inst_n_9),
        .injectdbiterra(1'b0),
        .injectdbiterrb(1'b0),
        .injectsbiterra(1'b0),
        .injectsbiterrb(1'b0),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rstb(rd_rst_busy),
        .sbiterra(\NLW_gen_sdpram.xpm_memory_base_inst_sbiterra_UNCONNECTED ),
        .sbiterrb(\NLW_gen_sdpram.xpm_memory_base_inst_sbiterrb_UNCONNECTED ),
        .sleep(sleep),
        .wea(wr_pntr_plus1_pf_carry),
        .web(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \gof.overflow_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(overflow_i0),
        .Q(overflow),
        .R(1'b0));
  FDRE \grdc.rd_data_count_i_reg[8] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\grdc.diff_wr_rd_pntr_rdc0_out ),
        .Q(rd_data_count),
        .R(rd_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \guf.underflow_i_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(underflow_i0),
        .Q(underflow),
        .R(1'b0));
  FDRE \gwdc.wr_data_count_i_reg[8] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gwdc.diff_wr_rd_pntr1_out ),
        .Q(wr_data_count),
        .R(wrst_busy));
  design_2_UART_0_0_xpm_counter_updn rdp_inst
       (.E(rdp_inst_n_9),
        .Q(rd_pntr_ext),
        .S({rdp_inst_n_14,rdp_inst_n_15,rdp_inst_n_16,rdp_inst_n_17}),
        .\count_value_i_reg[0]_0 (empty),
        .\count_value_i_reg[7]_0 ({rdp_inst_n_10,rdp_inst_n_11,rdp_inst_n_12,rdp_inst_n_13}),
        .\count_value_i_reg[8]_0 (rd_rst_busy),
        .\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] ({\gen_cdc_pntr.wpr_gray_reg_n_1 ,\gen_cdc_pntr.wpr_gray_reg_n_2 ,\gen_cdc_pntr.wpr_gray_reg_n_3 ,\gen_cdc_pntr.wpr_gray_reg_n_4 ,\gen_cdc_pntr.wpr_gray_reg_n_5 ,\gen_cdc_pntr.wpr_gray_reg_n_6 ,\gen_cdc_pntr.wpr_gray_reg_n_7 }),
        .rd_clk(rd_clk),
        .rd_en(rd_en));
  design_2_UART_0_0_xpm_counter_updn__parameterized0 rdpp1_inst
       (.E(rdp_inst_n_9),
        .Q({rdpp1_inst_n_0,rdpp1_inst_n_1,rdpp1_inst_n_2,rdpp1_inst_n_3,rdpp1_inst_n_4,rdpp1_inst_n_5,rdpp1_inst_n_6,rdpp1_inst_n_7}),
        .\count_value_i_reg[0]_0 (rd_rst_busy),
        .\count_value_i_reg[7]_0 (empty),
        .rd_clk(rd_clk),
        .rd_en(rd_en));
  design_2_UART_0_0_xpm_fifo_reg_bit rst_d1_inst
       (.\gof.overflow_i_reg (full),
        .overflow_i0(overflow_i0),
        .rst_d1(rst_d1),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wrst_busy(wrst_busy));
  design_2_UART_0_0_xpm_counter_updn_2 wrp_inst
       (.O(\gwdc.diff_wr_rd_pntr1_out ),
        .Q(wr_pntr_ext),
        .\count_value_i_reg[6]_0 (full),
        .\gwdc.wr_data_count_i_reg[8] ({\gen_cdc_pntr.rpw_gray_reg_dc_n_0 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_1 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_2 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_3 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_4 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_5 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_6 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_7 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_8 }),
        .rst_d1(rst_d1),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wr_pntr_plus1_pf_carry(wr_pntr_plus1_pf_carry),
        .wrst_busy(wrst_busy));
  design_2_UART_0_0_xpm_counter_updn__parameterized0_3 wrpp1_inst
       (.D(diff_pntr_pf_q0),
        .Q(wr_pntr_plus1_pf),
        .\count_value_i_reg[6]_0 (full),
        .\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8] (rd_pntr_wr),
        .rst_d1(rst_d1),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wr_pntr_plus1_pf_carry(wr_pntr_plus1_pf_carry),
        .wrst_busy(wrst_busy));
  design_2_UART_0_0_xpm_counter_updn__parameterized1 wrpp2_inst
       (.Q({wrpp2_inst_n_0,wrpp2_inst_n_1,wrpp2_inst_n_2,wrpp2_inst_n_3,wrpp2_inst_n_4,wrpp2_inst_n_5,wrpp2_inst_n_6,wrpp2_inst_n_7}),
        .\count_value_i_reg[6]_0 (full),
        .rst_d1(rst_d1),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wr_pntr_plus1_pf_carry(wr_pntr_plus1_pf_carry),
        .wrst_busy(wrst_busy));
  design_2_UART_0_0_xpm_fifo_rst xpm_fifo_rst_inst
       (.Q(diff_pntr_pf_q[5]),
        .\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[5] (xpm_fifo_rst_inst_n_2),
        .\gen_pf_ic_rc.gpf_ic.prog_full_i_reg (\gen_pf_ic_rc.gpf_ic.prog_full_i_i_2_n_0 ),
        .\gen_pf_ic_rc.gpf_ic.prog_full_i_reg_0 (full),
        .\gen_rst_ic.fifo_rd_rst_ic_reg_0 (rd_rst_busy),
        .\guf.underflow_i_reg (empty),
        .prog_full(prog_full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .rst_d1(rst_d1),
        .underflow_i0(underflow_i0),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wr_pntr_plus1_pf_carry(wr_pntr_plus1_pf_carry),
        .wr_rst_busy(wr_rst_busy),
        .wrst_busy(wrst_busy));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_reg_bit" *) 
module design_2_UART_0_0_xpm_fifo_reg_bit
   (rst_d1,
    overflow_i0,
    wrst_busy,
    wr_clk,
    \gof.overflow_i_reg ,
    wr_en);
  output rst_d1;
  output overflow_i0;
  input wrst_busy;
  input wr_clk;
  input \gof.overflow_i_reg ;
  input wr_en;

  wire \gof.overflow_i_reg ;
  wire overflow_i0;
  wire rst_d1;
  wire wr_clk;
  wire wr_en;
  wire wrst_busy;

  FDRE #(
    .INIT(1'b0)) 
    d_out_int_reg
       (.C(wr_clk),
        .CE(1'b1),
        .D(wrst_busy),
        .Q(rst_d1),
        .R(1'b0));
  LUT4 #(
    .INIT(16'hFE00)) 
    \gof.overflow_i_i_1 
       (.I0(rst_d1),
        .I1(wrst_busy),
        .I2(\gof.overflow_i_reg ),
        .I3(wr_en),
        .O(overflow_i0));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_reg_vec" *) 
module design_2_UART_0_0_xpm_fifo_reg_vec
   (\reg_out_i_reg[7]_0 ,
    ram_full_i0,
    Q,
    \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg ,
    wr_en,
    \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg_0 ,
    rst_d1,
    wrst_busy,
    D,
    wr_clk);
  output [7:0]\reg_out_i_reg[7]_0 ;
  output ram_full_i0;
  input [7:0]Q;
  input [7:0]\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg ;
  input wr_en;
  input \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg_0 ;
  input rst_d1;
  input wrst_busy;
  input [7:0]D;
  input wr_clk;

  wire [7:0]D;
  wire [7:0]Q;
  wire \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_4_n_0 ;
  wire \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_5_n_0 ;
  wire \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_6_n_0 ;
  wire \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_7_n_0 ;
  wire [7:0]\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg ;
  wire \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg_0 ;
  wire going_full0;
  wire leaving_full;
  wire ram_full_i0;
  wire [7:0]\reg_out_i_reg[7]_0 ;
  wire rst_d1;
  wire wr_clk;
  wire wr_en;
  wire wrst_busy;

  LUT5 #(
    .INIT(32'hFFFF0200)) 
    \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_1 
       (.I0(wr_en),
        .I1(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg_0 ),
        .I2(rst_d1),
        .I3(going_full0),
        .I4(leaving_full),
        .O(ram_full_i0));
  LUT6 #(
    .INIT(64'h9009000000000000)) 
    \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_2 
       (.I0(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg [7]),
        .I1(\reg_out_i_reg[7]_0 [7]),
        .I2(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg [6]),
        .I3(\reg_out_i_reg[7]_0 [6]),
        .I4(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_4_n_0 ),
        .I5(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_5_n_0 ),
        .O(going_full0));
  LUT6 #(
    .INIT(64'h9009000000000000)) 
    \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_3 
       (.I0(Q[7]),
        .I1(\reg_out_i_reg[7]_0 [7]),
        .I2(Q[6]),
        .I3(\reg_out_i_reg[7]_0 [6]),
        .I4(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_6_n_0 ),
        .I5(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_7_n_0 ),
        .O(leaving_full));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_4 
       (.I0(\reg_out_i_reg[7]_0 [3]),
        .I1(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg [3]),
        .I2(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg [5]),
        .I3(\reg_out_i_reg[7]_0 [5]),
        .I4(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg [4]),
        .I5(\reg_out_i_reg[7]_0 [4]),
        .O(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_5 
       (.I0(\reg_out_i_reg[7]_0 [0]),
        .I1(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg [0]),
        .I2(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg [2]),
        .I3(\reg_out_i_reg[7]_0 [2]),
        .I4(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_reg [1]),
        .I5(\reg_out_i_reg[7]_0 [1]),
        .O(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_6 
       (.I0(\reg_out_i_reg[7]_0 [3]),
        .I1(Q[3]),
        .I2(Q[5]),
        .I3(\reg_out_i_reg[7]_0 [5]),
        .I4(Q[4]),
        .I5(\reg_out_i_reg[7]_0 [4]),
        .O(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_7 
       (.I0(\reg_out_i_reg[7]_0 [0]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(\reg_out_i_reg[7]_0 [2]),
        .I4(Q[1]),
        .I5(\reg_out_i_reg[7]_0 [1]),
        .O(\gen_pf_ic_rc.ngen_full_rst_val.ram_full_i_i_7_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[0]),
        .Q(\reg_out_i_reg[7]_0 [0]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[1]),
        .Q(\reg_out_i_reg[7]_0 [1]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[2]),
        .Q(\reg_out_i_reg[7]_0 [2]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[3]),
        .Q(\reg_out_i_reg[7]_0 [3]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[4]),
        .Q(\reg_out_i_reg[7]_0 [4]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[5]),
        .Q(\reg_out_i_reg[7]_0 [5]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[6]),
        .Q(\reg_out_i_reg[7]_0 [6]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[7] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[7]),
        .Q(\reg_out_i_reg[7]_0 [7]),
        .R(wrst_busy));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_reg_vec" *) 
module design_2_UART_0_0_xpm_fifo_reg_vec_0
   (empty_i0,
    \reg_out_i_reg[7]_0 ,
    D,
    rd_en,
    \gen_pf_ic_rc.ram_empty_i_reg ,
    Q,
    \gen_pf_ic_rc.ram_empty_i_reg_0 ,
    DI,
    S,
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] ,
    \reg_out_i_reg[0]_0 ,
    \reg_out_i_reg[7]_1 ,
    rd_clk);
  output empty_i0;
  output [6:0]\reg_out_i_reg[7]_0 ;
  output [7:0]D;
  input rd_en;
  input \gen_pf_ic_rc.ram_empty_i_reg ;
  input [7:0]Q;
  input [7:0]\gen_pf_ic_rc.ram_empty_i_reg_0 ;
  input [0:0]DI;
  input [3:0]S;
  input [3:0]\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] ;
  input \reg_out_i_reg[0]_0 ;
  input [7:0]\reg_out_i_reg[7]_1 ;
  input rd_clk;

  wire [7:0]D;
  wire [0:0]DI;
  wire [7:0]Q;
  wire [3:0]S;
  wire empty_i0;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_0 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_1 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_2 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_3 ;
  wire [3:0]\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_1 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_2 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_3 ;
  wire \gen_pf_ic_rc.ram_empty_i_i_4_n_0 ;
  wire \gen_pf_ic_rc.ram_empty_i_i_5_n_0 ;
  wire \gen_pf_ic_rc.ram_empty_i_i_6_n_0 ;
  wire \gen_pf_ic_rc.ram_empty_i_i_7_n_0 ;
  wire \gen_pf_ic_rc.ram_empty_i_reg ;
  wire [7:0]\gen_pf_ic_rc.ram_empty_i_reg_0 ;
  wire going_empty0;
  wire leaving_empty;
  wire rd_clk;
  wire rd_en;
  wire \reg_out_i_reg[0]_0 ;
  wire [6:0]\reg_out_i_reg[7]_0 ;
  wire [7:0]\reg_out_i_reg[7]_1 ;
  wire \reg_out_i_reg_n_0_[0] ;
  wire [3:3]\NLW_gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_CO_UNCONNECTED ;

  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_0 ,\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_1 ,\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_2 ,\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_3 }),
        .CYINIT(\reg_out_i_reg_n_0_[0] ),
        .DI({\reg_out_i_reg[7]_0 [2:0],DI}),
        .O(D[3:0]),
        .S(S));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1 
       (.CI(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_0 ),
        .CO({\NLW_gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_CO_UNCONNECTED [3],\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_1 ,\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_2 ,\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\reg_out_i_reg[7]_0 [5:3]}),
        .O(D[7:4]),
        .S(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] ));
  LUT4 #(
    .INIT(16'hFF20)) 
    \gen_pf_ic_rc.ram_empty_i_i_1 
       (.I0(rd_en),
        .I1(\gen_pf_ic_rc.ram_empty_i_reg ),
        .I2(going_empty0),
        .I3(leaving_empty),
        .O(empty_i0));
  LUT6 #(
    .INIT(64'h9009000000000000)) 
    \gen_pf_ic_rc.ram_empty_i_i_2 
       (.I0(\gen_pf_ic_rc.ram_empty_i_reg_0 [7]),
        .I1(\reg_out_i_reg[7]_0 [6]),
        .I2(\gen_pf_ic_rc.ram_empty_i_reg_0 [6]),
        .I3(\reg_out_i_reg[7]_0 [5]),
        .I4(\gen_pf_ic_rc.ram_empty_i_i_4_n_0 ),
        .I5(\gen_pf_ic_rc.ram_empty_i_i_5_n_0 ),
        .O(going_empty0));
  LUT6 #(
    .INIT(64'h9009000000000000)) 
    \gen_pf_ic_rc.ram_empty_i_i_3 
       (.I0(Q[7]),
        .I1(\reg_out_i_reg[7]_0 [6]),
        .I2(Q[6]),
        .I3(\reg_out_i_reg[7]_0 [5]),
        .I4(\gen_pf_ic_rc.ram_empty_i_i_6_n_0 ),
        .I5(\gen_pf_ic_rc.ram_empty_i_i_7_n_0 ),
        .O(leaving_empty));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.ram_empty_i_i_4 
       (.I0(\reg_out_i_reg[7]_0 [2]),
        .I1(\gen_pf_ic_rc.ram_empty_i_reg_0 [3]),
        .I2(\gen_pf_ic_rc.ram_empty_i_reg_0 [5]),
        .I3(\reg_out_i_reg[7]_0 [4]),
        .I4(\gen_pf_ic_rc.ram_empty_i_reg_0 [4]),
        .I5(\reg_out_i_reg[7]_0 [3]),
        .O(\gen_pf_ic_rc.ram_empty_i_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.ram_empty_i_i_5 
       (.I0(\reg_out_i_reg_n_0_[0] ),
        .I1(\gen_pf_ic_rc.ram_empty_i_reg_0 [0]),
        .I2(\gen_pf_ic_rc.ram_empty_i_reg_0 [2]),
        .I3(\reg_out_i_reg[7]_0 [1]),
        .I4(\gen_pf_ic_rc.ram_empty_i_reg_0 [1]),
        .I5(\reg_out_i_reg[7]_0 [0]),
        .O(\gen_pf_ic_rc.ram_empty_i_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.ram_empty_i_i_6 
       (.I0(\reg_out_i_reg[7]_0 [2]),
        .I1(Q[3]),
        .I2(Q[5]),
        .I3(\reg_out_i_reg[7]_0 [4]),
        .I4(Q[4]),
        .I5(\reg_out_i_reg[7]_0 [3]),
        .O(\gen_pf_ic_rc.ram_empty_i_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.ram_empty_i_i_7 
       (.I0(\reg_out_i_reg_n_0_[0] ),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(\reg_out_i_reg[7]_0 [1]),
        .I4(Q[1]),
        .I5(\reg_out_i_reg[7]_0 [0]),
        .O(\gen_pf_ic_rc.ram_empty_i_i_7_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\reg_out_i_reg[7]_1 [0]),
        .Q(\reg_out_i_reg_n_0_[0] ),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\reg_out_i_reg[7]_1 [1]),
        .Q(\reg_out_i_reg[7]_0 [0]),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\reg_out_i_reg[7]_1 [2]),
        .Q(\reg_out_i_reg[7]_0 [1]),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\reg_out_i_reg[7]_1 [3]),
        .Q(\reg_out_i_reg[7]_0 [2]),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\reg_out_i_reg[7]_1 [4]),
        .Q(\reg_out_i_reg[7]_0 [3]),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\reg_out_i_reg[7]_1 [5]),
        .Q(\reg_out_i_reg[7]_0 [4]),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\reg_out_i_reg[7]_1 [6]),
        .Q(\reg_out_i_reg[7]_0 [5]),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[7] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\reg_out_i_reg[7]_1 [7]),
        .Q(\reg_out_i_reg[7]_0 [6]),
        .R(\reg_out_i_reg[0]_0 ));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_reg_vec" *) 
module design_2_UART_0_0_xpm_fifo_reg_vec__parameterized0
   (Q,
    wrst_busy,
    D,
    wr_clk);
  output [8:0]Q;
  input wrst_busy;
  input [8:0]D;
  input wr_clk;

  wire [8:0]D;
  wire [8:0]Q;
  wire wr_clk;
  wire wrst_busy;

  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[0]),
        .Q(Q[0]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[1]),
        .Q(Q[1]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[2]),
        .Q(Q[2]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[3]),
        .Q(Q[3]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[4]),
        .Q(Q[4]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[5]),
        .Q(Q[5]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[6]),
        .Q(Q[6]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[7] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[7]),
        .Q(Q[7]),
        .R(wrst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[8] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[8]),
        .Q(Q[8]),
        .R(wrst_busy));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_reg_vec" *) 
module design_2_UART_0_0_xpm_fifo_reg_vec__parameterized0_1
   (O,
    Q,
    \reg_out_i_reg[0]_0 ,
    D,
    rd_clk);
  output [0:0]O;
  input [8:0]Q;
  input \reg_out_i_reg[0]_0 ;
  input [8:0]D;
  input rd_clk;

  wire [8:0]D;
  wire [0:0]O;
  wire [8:0]Q;
  wire \grdc.rd_data_count_i[8]_i_10_n_0 ;
  wire \grdc.rd_data_count_i[8]_i_11_n_0 ;
  wire \grdc.rd_data_count_i[8]_i_12_n_0 ;
  wire \grdc.rd_data_count_i[8]_i_3_n_0 ;
  wire \grdc.rd_data_count_i[8]_i_5_n_0 ;
  wire \grdc.rd_data_count_i[8]_i_6_n_0 ;
  wire \grdc.rd_data_count_i[8]_i_7_n_0 ;
  wire \grdc.rd_data_count_i[8]_i_8_n_0 ;
  wire \grdc.rd_data_count_i[8]_i_9_n_0 ;
  wire \grdc.rd_data_count_i_reg[8]_i_2_n_0 ;
  wire \grdc.rd_data_count_i_reg[8]_i_2_n_1 ;
  wire \grdc.rd_data_count_i_reg[8]_i_2_n_2 ;
  wire \grdc.rd_data_count_i_reg[8]_i_2_n_3 ;
  wire \grdc.rd_data_count_i_reg[8]_i_4_n_0 ;
  wire \grdc.rd_data_count_i_reg[8]_i_4_n_1 ;
  wire \grdc.rd_data_count_i_reg[8]_i_4_n_2 ;
  wire \grdc.rd_data_count_i_reg[8]_i_4_n_3 ;
  wire rd_clk;
  wire \reg_out_i_reg[0]_0 ;
  wire \reg_out_i_reg_n_0_[0] ;
  wire \reg_out_i_reg_n_0_[1] ;
  wire \reg_out_i_reg_n_0_[2] ;
  wire \reg_out_i_reg_n_0_[3] ;
  wire \reg_out_i_reg_n_0_[4] ;
  wire \reg_out_i_reg_n_0_[5] ;
  wire \reg_out_i_reg_n_0_[6] ;
  wire \reg_out_i_reg_n_0_[7] ;
  wire \reg_out_i_reg_n_0_[8] ;
  wire [3:0]\NLW_grdc.rd_data_count_i_reg[8]_i_1_CO_UNCONNECTED ;
  wire [3:1]\NLW_grdc.rd_data_count_i_reg[8]_i_1_O_UNCONNECTED ;
  wire [3:0]\NLW_grdc.rd_data_count_i_reg[8]_i_2_O_UNCONNECTED ;
  wire [3:0]\NLW_grdc.rd_data_count_i_reg[8]_i_4_O_UNCONNECTED ;

  LUT2 #(
    .INIT(4'h9)) 
    \grdc.rd_data_count_i[8]_i_10 
       (.I0(\reg_out_i_reg_n_0_[2] ),
        .I1(Q[2]),
        .O(\grdc.rd_data_count_i[8]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \grdc.rd_data_count_i[8]_i_11 
       (.I0(\reg_out_i_reg_n_0_[1] ),
        .I1(Q[1]),
        .O(\grdc.rd_data_count_i[8]_i_11_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \grdc.rd_data_count_i[8]_i_12 
       (.I0(\reg_out_i_reg_n_0_[0] ),
        .I1(Q[0]),
        .O(\grdc.rd_data_count_i[8]_i_12_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \grdc.rd_data_count_i[8]_i_3 
       (.I0(\reg_out_i_reg_n_0_[8] ),
        .I1(Q[8]),
        .O(\grdc.rd_data_count_i[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \grdc.rd_data_count_i[8]_i_5 
       (.I0(\reg_out_i_reg_n_0_[7] ),
        .I1(Q[7]),
        .O(\grdc.rd_data_count_i[8]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \grdc.rd_data_count_i[8]_i_6 
       (.I0(\reg_out_i_reg_n_0_[6] ),
        .I1(Q[6]),
        .O(\grdc.rd_data_count_i[8]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \grdc.rd_data_count_i[8]_i_7 
       (.I0(\reg_out_i_reg_n_0_[5] ),
        .I1(Q[5]),
        .O(\grdc.rd_data_count_i[8]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \grdc.rd_data_count_i[8]_i_8 
       (.I0(\reg_out_i_reg_n_0_[4] ),
        .I1(Q[4]),
        .O(\grdc.rd_data_count_i[8]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \grdc.rd_data_count_i[8]_i_9 
       (.I0(\reg_out_i_reg_n_0_[3] ),
        .I1(Q[3]),
        .O(\grdc.rd_data_count_i[8]_i_9_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \grdc.rd_data_count_i_reg[8]_i_1 
       (.CI(\grdc.rd_data_count_i_reg[8]_i_2_n_0 ),
        .CO(\NLW_grdc.rd_data_count_i_reg[8]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_grdc.rd_data_count_i_reg[8]_i_1_O_UNCONNECTED [3:1],O}),
        .S({1'b0,1'b0,1'b0,\grdc.rd_data_count_i[8]_i_3_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \grdc.rd_data_count_i_reg[8]_i_2 
       (.CI(\grdc.rd_data_count_i_reg[8]_i_4_n_0 ),
        .CO({\grdc.rd_data_count_i_reg[8]_i_2_n_0 ,\grdc.rd_data_count_i_reg[8]_i_2_n_1 ,\grdc.rd_data_count_i_reg[8]_i_2_n_2 ,\grdc.rd_data_count_i_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({\reg_out_i_reg_n_0_[7] ,\reg_out_i_reg_n_0_[6] ,\reg_out_i_reg_n_0_[5] ,\reg_out_i_reg_n_0_[4] }),
        .O(\NLW_grdc.rd_data_count_i_reg[8]_i_2_O_UNCONNECTED [3:0]),
        .S({\grdc.rd_data_count_i[8]_i_5_n_0 ,\grdc.rd_data_count_i[8]_i_6_n_0 ,\grdc.rd_data_count_i[8]_i_7_n_0 ,\grdc.rd_data_count_i[8]_i_8_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \grdc.rd_data_count_i_reg[8]_i_4 
       (.CI(1'b0),
        .CO({\grdc.rd_data_count_i_reg[8]_i_4_n_0 ,\grdc.rd_data_count_i_reg[8]_i_4_n_1 ,\grdc.rd_data_count_i_reg[8]_i_4_n_2 ,\grdc.rd_data_count_i_reg[8]_i_4_n_3 }),
        .CYINIT(1'b1),
        .DI({\reg_out_i_reg_n_0_[3] ,\reg_out_i_reg_n_0_[2] ,\reg_out_i_reg_n_0_[1] ,\reg_out_i_reg_n_0_[0] }),
        .O(\NLW_grdc.rd_data_count_i_reg[8]_i_4_O_UNCONNECTED [3:0]),
        .S({\grdc.rd_data_count_i[8]_i_9_n_0 ,\grdc.rd_data_count_i[8]_i_10_n_0 ,\grdc.rd_data_count_i[8]_i_11_n_0 ,\grdc.rd_data_count_i[8]_i_12_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(D[0]),
        .Q(\reg_out_i_reg_n_0_[0] ),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(D[1]),
        .Q(\reg_out_i_reg_n_0_[1] ),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(D[2]),
        .Q(\reg_out_i_reg_n_0_[2] ),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(D[3]),
        .Q(\reg_out_i_reg_n_0_[3] ),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(D[4]),
        .Q(\reg_out_i_reg_n_0_[4] ),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(D[5]),
        .Q(\reg_out_i_reg_n_0_[5] ),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(D[6]),
        .Q(\reg_out_i_reg_n_0_[6] ),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[7] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(D[7]),
        .Q(\reg_out_i_reg_n_0_[7] ),
        .R(\reg_out_i_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[8] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(D[8]),
        .Q(\reg_out_i_reg_n_0_[8] ),
        .R(\reg_out_i_reg[0]_0 ));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_rst" *) 
module design_2_UART_0_0_xpm_fifo_rst
   (\gen_rst_ic.fifo_rd_rst_ic_reg_0 ,
    wrst_busy,
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[5] ,
    wr_pntr_plus1_pf_carry,
    wr_rst_busy,
    underflow_i0,
    rd_clk,
    wr_clk,
    \gen_pf_ic_rc.gpf_ic.prog_full_i_reg ,
    Q,
    \gen_pf_ic_rc.gpf_ic.prog_full_i_reg_0 ,
    prog_full,
    rst,
    wr_en,
    rst_d1,
    \guf.underflow_i_reg ,
    rd_en);
  output \gen_rst_ic.fifo_rd_rst_ic_reg_0 ;
  output wrst_busy;
  output \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[5] ;
  output wr_pntr_plus1_pf_carry;
  output wr_rst_busy;
  output underflow_i0;
  input rd_clk;
  input wr_clk;
  input \gen_pf_ic_rc.gpf_ic.prog_full_i_reg ;
  input [0:0]Q;
  input \gen_pf_ic_rc.gpf_ic.prog_full_i_reg_0 ;
  input prog_full;
  input rst;
  input wr_en;
  input rst_d1;
  input \guf.underflow_i_reg ;
  input rd_en;

  wire \/i__n_0 ;
  wire \FSM_onehot_gen_rst_ic.curr_wrst_state[0]_i_1_n_0 ;
  wire \FSM_onehot_gen_rst_ic.curr_wrst_state[1]_i_1_n_0 ;
  wire \FSM_onehot_gen_rst_ic.curr_wrst_state[1]_i_2_n_0 ;
  wire \FSM_onehot_gen_rst_ic.curr_wrst_state[2]_i_1_n_0 ;
  wire \FSM_onehot_gen_rst_ic.curr_wrst_state[3]_i_1_n_0 ;
  wire \FSM_onehot_gen_rst_ic.curr_wrst_state[4]_i_1_n_0 ;
  wire \FSM_onehot_gen_rst_ic.curr_wrst_state[4]_i_2_n_0 ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[0] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[1] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[2] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[3] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[4] ;
  wire [0:0]Q;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[5] ;
  wire \gen_pf_ic_rc.gpf_ic.prog_full_i_i_3_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.prog_full_i_reg ;
  wire \gen_pf_ic_rc.gpf_ic.prog_full_i_reg_0 ;
  (* RTL_KEEP = "yes" *) wire [1:0]\gen_rst_ic.curr_rrst_state ;
  wire \gen_rst_ic.fifo_rd_rst_i ;
  wire \gen_rst_ic.fifo_rd_rst_ic_reg_0 ;
  wire \gen_rst_ic.fifo_rd_rst_wr_i ;
  wire \gen_rst_ic.fifo_wr_rst_ic ;
  wire \gen_rst_ic.fifo_wr_rst_ic_i_1_n_0 ;
  wire \gen_rst_ic.fifo_wr_rst_ic_i_3_n_0 ;
  wire \gen_rst_ic.fifo_wr_rst_rd ;
  wire [1:0]\gen_rst_ic.next_rrst_state ;
  wire \gen_rst_ic.rst_seq_reentered_i_1_n_0 ;
  wire \gen_rst_ic.rst_seq_reentered_i_2_n_0 ;
  wire \gen_rst_ic.rst_seq_reentered_reg_n_0 ;
  wire \gen_rst_ic.wr_rst_busy_ic_i_1_n_0 ;
  wire \gen_rst_ic.wr_rst_busy_ic_i_2_n_0 ;
  wire \guf.underflow_i_reg ;
  wire p_0_in;
  wire \power_on_rst_reg_n_0_[0] ;
  wire prog_full;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire rst_d1;
  wire rst_i__0;
  wire underflow_i0;
  wire wr_clk;
  wire wr_en;
  wire wr_pntr_plus1_pf_carry;
  wire wr_rst_busy;
  wire wrst_busy;

  LUT5 #(
    .INIT(32'h00010116)) 
    \/i_ 
       (.I0(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[0] ),
        .I1(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[1] ),
        .I2(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[3] ),
        .I4(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[4] ),
        .O(\/i__n_0 ));
  LUT6 #(
    .INIT(64'h03030200FFFFFFFF)) 
    \FSM_onehot_gen_rst_ic.curr_wrst_state[0]_i_1 
       (.I0(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[3] ),
        .I1(p_0_in),
        .I2(rst),
        .I3(\gen_rst_ic.rst_seq_reentered_reg_n_0 ),
        .I4(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[0] ),
        .I5(\/i__n_0 ),
        .O(\FSM_onehot_gen_rst_ic.curr_wrst_state[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFEFEFEEE)) 
    \FSM_onehot_gen_rst_ic.curr_wrst_state[1]_i_1 
       (.I0(\FSM_onehot_gen_rst_ic.curr_wrst_state[1]_i_2_n_0 ),
        .I1(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[3] ),
        .I3(rst),
        .I4(p_0_in),
        .O(\FSM_onehot_gen_rst_ic.curr_wrst_state[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF0EEE0FFFFEEE0)) 
    \FSM_onehot_gen_rst_ic.curr_wrst_state[1]_i_2 
       (.I0(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[0] ),
        .I1(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[2] ),
        .I2(rst),
        .I3(p_0_in),
        .I4(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[1] ),
        .I5(\gen_rst_ic.fifo_rd_rst_wr_i ),
        .O(\FSM_onehot_gen_rst_ic.curr_wrst_state[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h000C0008)) 
    \FSM_onehot_gen_rst_ic.curr_wrst_state[2]_i_1 
       (.I0(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[1] ),
        .I1(\gen_rst_ic.fifo_rd_rst_wr_i ),
        .I2(rst),
        .I3(p_0_in),
        .I4(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[2] ),
        .O(\FSM_onehot_gen_rst_ic.curr_wrst_state[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000004400000044)) 
    \FSM_onehot_gen_rst_ic.curr_wrst_state[3]_i_1 
       (.I0(\gen_rst_ic.fifo_rd_rst_wr_i ),
        .I1(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[2] ),
        .I2(\gen_rst_ic.rst_seq_reentered_reg_n_0 ),
        .I3(rst),
        .I4(p_0_in),
        .I5(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[3] ),
        .O(\FSM_onehot_gen_rst_ic.curr_wrst_state[3]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \FSM_onehot_gen_rst_ic.curr_wrst_state[4]_i_1 
       (.I0(\/i__n_0 ),
        .O(\FSM_onehot_gen_rst_ic.curr_wrst_state[4]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0002)) 
    \FSM_onehot_gen_rst_ic.curr_wrst_state[4]_i_2 
       (.I0(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[3] ),
        .I1(p_0_in),
        .I2(rst),
        .I3(\gen_rst_ic.rst_seq_reentered_reg_n_0 ),
        .O(\FSM_onehot_gen_rst_ic.curr_wrst_state[4]_i_2_n_0 ));
  (* FSM_ENCODED_STATES = "WRST_OUT:00100,WRST_IN:00010,WRST_GO2IDLE:10000,WRST_EXIT:01000,WRST_IDLE:00001" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b1)) 
    \FSM_onehot_gen_rst_ic.curr_wrst_state_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\FSM_onehot_gen_rst_ic.curr_wrst_state[0]_i_1_n_0 ),
        .Q(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[0] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "WRST_OUT:00100,WRST_IN:00010,WRST_GO2IDLE:10000,WRST_EXIT:01000,WRST_IDLE:00001" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_gen_rst_ic.curr_wrst_state_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\FSM_onehot_gen_rst_ic.curr_wrst_state[1]_i_1_n_0 ),
        .Q(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[1] ),
        .R(\FSM_onehot_gen_rst_ic.curr_wrst_state[4]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "WRST_OUT:00100,WRST_IN:00010,WRST_GO2IDLE:10000,WRST_EXIT:01000,WRST_IDLE:00001" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_gen_rst_ic.curr_wrst_state_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\FSM_onehot_gen_rst_ic.curr_wrst_state[2]_i_1_n_0 ),
        .Q(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[2] ),
        .R(\FSM_onehot_gen_rst_ic.curr_wrst_state[4]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "WRST_OUT:00100,WRST_IN:00010,WRST_GO2IDLE:10000,WRST_EXIT:01000,WRST_IDLE:00001" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_gen_rst_ic.curr_wrst_state_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\FSM_onehot_gen_rst_ic.curr_wrst_state[3]_i_1_n_0 ),
        .Q(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[3] ),
        .R(\FSM_onehot_gen_rst_ic.curr_wrst_state[4]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "WRST_OUT:00100,WRST_IN:00010,WRST_GO2IDLE:10000,WRST_EXIT:01000,WRST_IDLE:00001" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_gen_rst_ic.curr_wrst_state_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\FSM_onehot_gen_rst_ic.curr_wrst_state[4]_i_2_n_0 ),
        .Q(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[4] ),
        .R(\FSM_onehot_gen_rst_ic.curr_wrst_state[4]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \FSM_sequential_gen_rst_ic.curr_rrst_state[1]_i_1 
       (.I0(\gen_rst_ic.curr_rrst_state [0]),
        .I1(\gen_rst_ic.curr_rrst_state [1]),
        .O(\gen_rst_ic.next_rrst_state [1]));
  (* FSM_ENCODED_STATES = "RRST_IDLE:00,RRST_IN:01,RRST_OUT:10,RRST_EXIT:11" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_gen_rst_ic.curr_rrst_state_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\gen_rst_ic.next_rrst_state [0]),
        .Q(\gen_rst_ic.curr_rrst_state [0]),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "RRST_IDLE:00,RRST_IN:01,RRST_OUT:10,RRST_EXIT:11" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_gen_rst_ic.curr_rrst_state_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\gen_rst_ic.next_rrst_state [1]),
        .Q(\gen_rst_ic.curr_rrst_state [1]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h06)) 
    \__0/i_ 
       (.I0(\gen_rst_ic.fifo_wr_rst_rd ),
        .I1(\gen_rst_ic.curr_rrst_state [1]),
        .I2(\gen_rst_ic.curr_rrst_state [0]),
        .O(\gen_rst_ic.next_rrst_state [0]));
  LUT5 #(
    .INIT(32'h0000FE0E)) 
    \gen_pf_ic_rc.gpf_ic.prog_full_i_i_1 
       (.I0(\gen_pf_ic_rc.gpf_ic.prog_full_i_reg ),
        .I1(Q),
        .I2(\gen_pf_ic_rc.gpf_ic.prog_full_i_reg_0 ),
        .I3(prog_full),
        .I4(\gen_pf_ic_rc.gpf_ic.prog_full_i_i_3_n_0 ),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[5] ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hAE)) 
    \gen_pf_ic_rc.gpf_ic.prog_full_i_i_3 
       (.I0(wrst_busy),
        .I1(rst_d1),
        .I2(rst),
        .O(\gen_pf_ic_rc.gpf_ic.prog_full_i_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h3E)) 
    \gen_rst_ic.fifo_rd_rst_ic_i_1 
       (.I0(\gen_rst_ic.fifo_wr_rst_rd ),
        .I1(\gen_rst_ic.curr_rrst_state [1]),
        .I2(\gen_rst_ic.curr_rrst_state [0]),
        .O(\gen_rst_ic.fifo_rd_rst_i ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rst_ic.fifo_rd_rst_ic_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\gen_rst_ic.fifo_rd_rst_i ),
        .Q(\gen_rst_ic.fifo_rd_rst_ic_reg_0 ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFEAFFFFFFEA0000)) 
    \gen_rst_ic.fifo_wr_rst_ic_i_1 
       (.I0(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[4] ),
        .I1(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[0] ),
        .I2(rst_i__0),
        .I3(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[1] ),
        .I4(\gen_rst_ic.fifo_wr_rst_ic_i_3_n_0 ),
        .I5(\gen_rst_ic.fifo_wr_rst_ic ),
        .O(\gen_rst_ic.fifo_wr_rst_ic_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \gen_rst_ic.fifo_wr_rst_ic_i_2 
       (.I0(p_0_in),
        .I1(rst),
        .O(rst_i__0));
  LUT5 #(
    .INIT(32'h00010116)) 
    \gen_rst_ic.fifo_wr_rst_ic_i_3 
       (.I0(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[0] ),
        .I1(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[1] ),
        .I2(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[3] ),
        .I4(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[4] ),
        .O(\gen_rst_ic.fifo_wr_rst_ic_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rst_ic.fifo_wr_rst_ic_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gen_rst_ic.fifo_wr_rst_ic_i_1_n_0 ),
        .Q(\gen_rst_ic.fifo_wr_rst_ic ),
        .R(1'b0));
  (* DEF_VAL = "1'b0" *) 
  (* DEST_SYNC_FF = "2" *) 
  (* INIT = "0" *) 
  (* INIT_SYNC_FF = "1" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  (* XPM_MODULE = "TRUE" *) 
  design_2_UART_0_0_xpm_cdc_sync_rst \gen_rst_ic.rrst_wr_inst 
       (.dest_clk(wr_clk),
        .dest_rst(\gen_rst_ic.fifo_rd_rst_wr_i ),
        .src_rst(\gen_rst_ic.fifo_rd_rst_ic_reg_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \gen_rst_ic.rst_seq_reentered_i_1 
       (.I0(\gen_rst_ic.rst_seq_reentered_i_2_n_0 ),
        .I1(rst),
        .I2(p_0_in),
        .O(\gen_rst_ic.rst_seq_reentered_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00010000)) 
    \gen_rst_ic.rst_seq_reentered_i_2 
       (.I0(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[0] ),
        .I1(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[2] ),
        .I4(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[4] ),
        .I5(\gen_rst_ic.rst_seq_reentered_reg_n_0 ),
        .O(\gen_rst_ic.rst_seq_reentered_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rst_ic.rst_seq_reentered_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gen_rst_ic.rst_seq_reentered_i_1_n_0 ),
        .Q(\gen_rst_ic.rst_seq_reentered_reg_n_0 ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hEFFFEF00)) 
    \gen_rst_ic.wr_rst_busy_ic_i_1 
       (.I0(rst),
        .I1(p_0_in),
        .I2(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[0] ),
        .I3(\gen_rst_ic.wr_rst_busy_ic_i_2_n_0 ),
        .I4(wrst_busy),
        .O(\gen_rst_ic.wr_rst_busy_ic_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000116)) 
    \gen_rst_ic.wr_rst_busy_ic_i_2 
       (.I0(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[3] ),
        .I1(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[2] ),
        .I2(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_gen_rst_ic.curr_wrst_state_reg_n_0_[4] ),
        .O(\gen_rst_ic.wr_rst_busy_ic_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rst_ic.wr_rst_busy_ic_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gen_rst_ic.wr_rst_busy_ic_i_1_n_0 ),
        .Q(wrst_busy),
        .R(1'b0));
  (* DEF_VAL = "1'b0" *) 
  (* DEST_SYNC_FF = "2" *) 
  (* INIT = "0" *) 
  (* INIT_SYNC_FF = "1" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  (* XPM_MODULE = "TRUE" *) 
  design_2_UART_0_0_xpm_cdc_sync_rst__2 \gen_rst_ic.wrst_rd_inst 
       (.dest_clk(rd_clk),
        .dest_rst(\gen_rst_ic.fifo_wr_rst_rd ),
        .src_rst(\gen_rst_ic.fifo_wr_rst_ic ));
  LUT4 #(
    .INIT(16'h0002)) 
    \gen_sdpram.xpm_memory_base_inst_i_1 
       (.I0(wr_en),
        .I1(\gen_pf_ic_rc.gpf_ic.prog_full_i_reg_0 ),
        .I2(wrst_busy),
        .I3(rst_d1),
        .O(wr_pntr_plus1_pf_carry));
  LUT3 #(
    .INIT(8'hE0)) 
    \guf.underflow_i_i_1 
       (.I0(\guf.underflow_i_reg ),
        .I1(\gen_rst_ic.fifo_rd_rst_ic_reg_0 ),
        .I2(rd_en),
        .O(underflow_i0));
  FDRE #(
    .INIT(1'b1)) 
    \power_on_rst_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(1'b0),
        .Q(\power_on_rst_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \power_on_rst_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\power_on_rst_reg_n_0_[0] ),
        .Q(p_0_in),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT2 #(
    .INIT(4'hE)) 
    wr_rst_busy_INST_0
       (.I0(wrst_busy),
        .I1(rst_d1),
        .O(wr_rst_busy));
endmodule

(* ADDR_WIDTH_A = "8" *) (* ADDR_WIDTH_B = "8" *) (* AUTO_SLEEP_TIME = "0" *) 
(* BYTE_WRITE_WIDTH_A = "8" *) (* BYTE_WRITE_WIDTH_B = "8" *) (* CASCADE_HEIGHT = "0" *) 
(* CLOCKING_MODE = "1" *) (* ECC_BIT_RANGE = "[7:0]" *) (* ECC_MODE = "0" *) 
(* ECC_TYPE = "NONE" *) (* IGNORE_INIT_SYNTH = "0" *) (* MAX_NUM_CHAR = "0" *) 
(* MEMORY_INIT_FILE = "none" *) (* MEMORY_INIT_PARAM = "" *) (* MEMORY_OPTIMIZATION = "true" *) 
(* MEMORY_PRIMITIVE = "0" *) (* MEMORY_SIZE = "2048" *) (* MEMORY_TYPE = "1" *) 
(* MESSAGE_CONTROL = "0" *) (* NUM_CHAR_LOC = "0" *) (* ORIG_REF_NAME = "xpm_memory_base" *) 
(* P_ECC_MODE = "no_ecc" *) (* P_ENABLE_BYTE_WRITE_A = "0" *) (* P_ENABLE_BYTE_WRITE_B = "0" *) 
(* P_MAX_DEPTH_DATA = "256" *) (* P_MEMORY_OPT = "yes" *) (* P_MEMORY_PRIMITIVE = "auto" *) 
(* P_MIN_WIDTH_DATA = "8" *) (* P_MIN_WIDTH_DATA_A = "8" *) (* P_MIN_WIDTH_DATA_B = "8" *) 
(* P_MIN_WIDTH_DATA_ECC = "8" *) (* P_MIN_WIDTH_DATA_LDW = "4" *) (* P_MIN_WIDTH_DATA_SHFT = "8" *) 
(* P_NUM_COLS_WRITE_A = "1" *) (* P_NUM_COLS_WRITE_B = "1" *) (* P_NUM_ROWS_READ_A = "1" *) 
(* P_NUM_ROWS_READ_B = "1" *) (* P_NUM_ROWS_WRITE_A = "1" *) (* P_NUM_ROWS_WRITE_B = "1" *) 
(* P_SDP_WRITE_MODE = "yes" *) (* P_WIDTH_ADDR_LSB_READ_A = "0" *) (* P_WIDTH_ADDR_LSB_READ_B = "0" *) 
(* P_WIDTH_ADDR_LSB_WRITE_A = "0" *) (* P_WIDTH_ADDR_LSB_WRITE_B = "0" *) (* P_WIDTH_ADDR_READ_A = "8" *) 
(* P_WIDTH_ADDR_READ_B = "8" *) (* P_WIDTH_ADDR_WRITE_A = "8" *) (* P_WIDTH_ADDR_WRITE_B = "8" *) 
(* P_WIDTH_COL_WRITE_A = "8" *) (* P_WIDTH_COL_WRITE_B = "8" *) (* READ_DATA_WIDTH_A = "8" *) 
(* READ_DATA_WIDTH_B = "8" *) (* READ_LATENCY_A = "2" *) (* READ_LATENCY_B = "1" *) 
(* READ_RESET_VALUE_A = "0" *) (* READ_RESET_VALUE_B = "0" *) (* RST_MODE_A = "SYNC" *) 
(* RST_MODE_B = "SYNC" *) (* SIM_ASSERT_CHK = "0" *) (* USE_EMBEDDED_CONSTRAINT = "0" *) 
(* USE_MEM_INIT = "0" *) (* USE_MEM_INIT_MMI = "0" *) (* VERSION = "0" *) 
(* WAKEUP_TIME = "0" *) (* WRITE_DATA_WIDTH_A = "8" *) (* WRITE_DATA_WIDTH_B = "8" *) 
(* WRITE_MODE_A = "2" *) (* WRITE_MODE_B = "2" *) (* WRITE_PROTECT = "1" *) 
(* XPM_MODULE = "TRUE" *) (* keep_hierarchy = "soft" *) (* rsta_loop_iter = "8" *) 
(* rstb_loop_iter = "8" *) 
module design_2_UART_0_0_xpm_memory_base
   (sleep,
    clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    injectsbiterra,
    injectdbiterra,
    douta,
    sbiterra,
    dbiterra,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    injectsbiterrb,
    injectdbiterrb,
    doutb,
    sbiterrb,
    dbiterrb);
  input sleep;
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [0:0]wea;
  input [7:0]addra;
  input [7:0]dina;
  input injectsbiterra;
  input injectdbiterra;
  output [7:0]douta;
  output sbiterra;
  output dbiterra;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [7:0]addrb;
  input [7:0]dinb;
  input injectsbiterrb;
  input injectdbiterrb;
  output [7:0]doutb;
  output sbiterrb;
  output dbiterrb;

  wire \<const0> ;
  wire [7:0]addra;
  wire [7:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]doutb;
  wire enb;
  wire \gen_wr_a.gen_word_narrow.mem_reg_i_1_n_0 ;
  wire rstb;
  wire sleep;
  wire [0:0]wea;
  wire [15:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_DOADO_UNCONNECTED ;
  wire [15:8]\NLW_gen_wr_a.gen_word_narrow.mem_reg_DOBDO_UNCONNECTED ;
  wire [1:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_DOPADOP_UNCONNECTED ;
  wire [1:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_DOPBDOP_UNCONNECTED ;

  assign dbiterra = \<const0> ;
  assign dbiterrb = \<const0> ;
  assign douta[7] = \<const0> ;
  assign douta[6] = \<const0> ;
  assign douta[5] = \<const0> ;
  assign douta[4] = \<const0> ;
  assign douta[3] = \<const0> ;
  assign douta[2] = \<const0> ;
  assign douta[1] = \<const0> ;
  assign douta[0] = \<const0> ;
  assign sbiterra = \<const0> ;
  assign sbiterrb = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* \MEM.PORTA.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTA.ADDRESS_END  = "1023" *) 
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d8" *) 
  (* \MEM.PORTA.DATA_LSB  = "0" *) 
  (* \MEM.PORTA.DATA_MSB  = "7" *) 
  (* \MEM.PORTB.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTB.ADDRESS_END  = "1023" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d8" *) 
  (* \MEM.PORTB.DATA_LSB  = "0" *) 
  (* \MEM.PORTB.DATA_MSB  = "7" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "2048" *) 
  (* RTL_RAM_NAME = "inst/UART_TX_inst/MASTER_TO_UART/gnuram_async_fifo.xpm_fifo_base_inst/gen_sdpram.xpm_memory_base_inst/gen_wr_a.gen_word_narrow.mem_reg" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "7" *) 
  RAMB18E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(18),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(18)) 
    \gen_wr_a.gen_word_narrow.mem_reg 
       (.ADDRARDADDR({1'b0,1'b0,addra,1'b0,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({1'b0,1'b0,addrb,1'b0,1'b0,1'b0,1'b0}),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clkb),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .DIPADIP({1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0}),
        .DOADO(\NLW_gen_wr_a.gen_word_narrow.mem_reg_DOADO_UNCONNECTED [15:0]),
        .DOBDO({\NLW_gen_wr_a.gen_word_narrow.mem_reg_DOBDO_UNCONNECTED [15:8],doutb}),
        .DOPADOP(\NLW_gen_wr_a.gen_word_narrow.mem_reg_DOPADOP_UNCONNECTED [1:0]),
        .DOPBDOP(\NLW_gen_wr_a.gen_word_narrow.mem_reg_DOPBDOP_UNCONNECTED [1:0]),
        .ENARDEN(wea),
        .ENBWREN(\gen_wr_a.gen_word_narrow.mem_reg_i_1_n_0 ),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(rstb),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .WEA({1'b1,1'b1}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0}));
  LUT2 #(
    .INIT(4'hE)) 
    \gen_wr_a.gen_word_narrow.mem_reg_i_1 
       (.I0(rstb),
        .I1(enb),
        .O(\gen_wr_a.gen_word_narrow.mem_reg_i_1_n_0 ));
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
