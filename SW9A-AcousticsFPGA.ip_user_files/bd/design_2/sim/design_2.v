//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
//Date        : Wed Nov  4 23:28:17 2026
//Host        : JokeJet running 64-bit major release  (build 9200)
//Command     : generate_target design_2.bd
//Design      : design_2
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_2,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_2,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=10,numReposBlks=10,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_2.hwdef" *) 
module design_2
   (RX_data_in,
    Tx_data_out,
    Vaux13_0_v_n,
    Vaux13_0_v_p,
    Vaux14_0_v_n,
    Vaux14_0_v_p,
    Vaux15_0_v_n,
    Vaux15_0_v_p,
    Vaux5_0_v_n,
    Vaux5_0_v_p,
    Vaux6_0_v_n,
    Vaux6_0_v_p,
    Vaux7_0_v_n,
    Vaux7_0_v_p,
    clk_12MHz,
    reset);
  input RX_data_in;
  output Tx_data_out;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 Vaux13_0 V_N" *) input Vaux13_0_v_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 Vaux13_0 V_P" *) input Vaux13_0_v_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 Vaux14_0 V_N" *) input Vaux14_0_v_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 Vaux14_0 V_P" *) input Vaux14_0_v_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 Vaux15_0 V_N" *) input Vaux15_0_v_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 Vaux15_0 V_P" *) input Vaux15_0_v_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 Vaux5_0 V_N" *) input Vaux5_0_v_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 Vaux5_0 V_P" *) input Vaux5_0_v_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 Vaux6_0 V_N" *) input Vaux6_0_v_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 Vaux6_0 V_P" *) input Vaux6_0_v_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 Vaux7_0 V_N" *) input Vaux7_0_v_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 Vaux7_0 V_P" *) input Vaux7_0_v_p;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_12MHZ CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_12MHZ, CLK_DOMAIN design_2_clk_12MHz, FREQ_HZ 12000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input clk_12MHz;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) input reset;

  wire RX_data_in_1;
  wire UART_0_RX_Data_Ready;
  wire [7:0]UART_0_RX_Data_out;
  wire UART_0_TX_Data_out;
  wire UART_0_TX_Ready_To_Send;
  wire [7:0]UART_TRANSACTION_HAN_0_Word_To_Send;
  wire UART_TRANSACTION_HAN_0_Word_To_Send_en;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE ARADDR" *) (* DONT_TOUCH *) wire [31:0]UART_TRANSACTION_HAN_0_m_axi_ARADDR;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE ARREADY" *) (* DONT_TOUCH *) wire UART_TRANSACTION_HAN_0_m_axi_ARREADY;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE ARVALID" *) (* DONT_TOUCH *) wire UART_TRANSACTION_HAN_0_m_axi_ARVALID;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE AWADDR" *) (* DONT_TOUCH *) wire [31:0]UART_TRANSACTION_HAN_0_m_axi_AWADDR;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE AWREADY" *) (* DONT_TOUCH *) wire UART_TRANSACTION_HAN_0_m_axi_AWREADY;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE AWVALID" *) (* DONT_TOUCH *) wire UART_TRANSACTION_HAN_0_m_axi_AWVALID;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE BREADY" *) (* DONT_TOUCH *) wire UART_TRANSACTION_HAN_0_m_axi_BREADY;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE BRESP" *) (* DONT_TOUCH *) wire [1:0]UART_TRANSACTION_HAN_0_m_axi_BRESP;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE BVALID" *) (* DONT_TOUCH *) wire UART_TRANSACTION_HAN_0_m_axi_BVALID;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE RDATA" *) (* DONT_TOUCH *) wire [31:0]UART_TRANSACTION_HAN_0_m_axi_RDATA;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE RREADY" *) (* DONT_TOUCH *) wire UART_TRANSACTION_HAN_0_m_axi_RREADY;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE RRESP" *) (* DONT_TOUCH *) wire [1:0]UART_TRANSACTION_HAN_0_m_axi_RRESP;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE RVALID" *) (* DONT_TOUCH *) wire UART_TRANSACTION_HAN_0_m_axi_RVALID;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE WDATA" *) (* DONT_TOUCH *) wire [31:0]UART_TRANSACTION_HAN_0_m_axi_WDATA;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE WREADY" *) (* DONT_TOUCH *) wire UART_TRANSACTION_HAN_0_m_axi_WREADY;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE WSTRB" *) (* DONT_TOUCH *) wire [3:0]UART_TRANSACTION_HAN_0_m_axi_WSTRB;
  (* CONN_BUS_INFO = "UART_TRANSACTION_HAN_0_m_axi xilinx.com:interface:aximm:1.0 AXI4LITE WVALID" *) (* DONT_TOUCH *) wire UART_TRANSACTION_HAN_0_m_axi_WVALID;
  wire Vaux13_0_1_V_N;
  wire Vaux13_0_1_V_P;
  wire Vaux14_0_1_V_N;
  wire Vaux14_0_1_V_P;
  wire Vaux15_0_1_V_N;
  wire Vaux15_0_1_V_P;
  wire Vaux5_0_1_V_N;
  wire Vaux5_0_1_V_P;
  wire Vaux6_0_1_V_N;
  wire Vaux6_0_1_V_P;
  wire Vaux7_0_1_V_N;
  wire Vaux7_0_1_V_P;
  wire clk_12MHz_1;
  wire clk_wiz_0_UART_clk;
  wire clk_wiz_0_clk_100MHz;
  wire reset_1;
  wire [0:0]util_vector_logic_0_Res;
  (* CONN_BUS_INFO = "xadc_wiz_0_M_AXIS xilinx.com:interface:axis:1.0 None TDATA" *) (* DONT_TOUCH *) wire [15:0]xadc_wiz_0_M_AXIS_TDATA;
  (* CONN_BUS_INFO = "xadc_wiz_0_M_AXIS xilinx.com:interface:axis:1.0 None TID" *) (* DONT_TOUCH *) wire [4:0]xadc_wiz_0_M_AXIS_TID;
  (* CONN_BUS_INFO = "xadc_wiz_0_M_AXIS xilinx.com:interface:axis:1.0 None TVALID" *) (* DONT_TOUCH *) wire xadc_wiz_0_M_AXIS_TVALID;
  wire [31:0]xlconstant_0_dout;
  wire [0:0]xlconstant_1_dout;
  wire [0:0]xlconstant_2_dout;

  assign RX_data_in_1 = RX_data_in;
  assign Tx_data_out = UART_0_TX_Data_out;
  assign Vaux13_0_1_V_N = Vaux13_0_v_n;
  assign Vaux13_0_1_V_P = Vaux13_0_v_p;
  assign Vaux14_0_1_V_N = Vaux14_0_v_n;
  assign Vaux14_0_1_V_P = Vaux14_0_v_p;
  assign Vaux15_0_1_V_N = Vaux15_0_v_n;
  assign Vaux15_0_1_V_P = Vaux15_0_v_p;
  assign Vaux5_0_1_V_N = Vaux5_0_v_n;
  assign Vaux5_0_1_V_P = Vaux5_0_v_p;
  assign Vaux6_0_1_V_N = Vaux6_0_v_n;
  assign Vaux6_0_1_V_P = Vaux6_0_v_p;
  assign Vaux7_0_1_V_N = Vaux7_0_v_n;
  assign Vaux7_0_1_V_P = Vaux7_0_v_p;
  assign clk_12MHz_1 = clk_12MHz;
  assign reset_1 = reset;
  design_2_UART_0_0 UART_0
       (.RX_Data_Ready(UART_0_RX_Data_Ready),
        .RX_Data_in(RX_data_in_1),
        .RX_Data_out(UART_0_RX_Data_out),
        .TX_Data_in(UART_TRANSACTION_HAN_0_Word_To_Send),
        .TX_Data_out(UART_0_TX_Data_out),
        .TX_Ready_To_Send(UART_0_TX_Ready_To_Send),
        .TX_en(UART_TRANSACTION_HAN_0_Word_To_Send_en),
        .UART_clk(clk_wiz_0_UART_clk),
        .clk(clk_wiz_0_clk_100MHz),
        .reset_b(util_vector_logic_0_Res),
        .uart_aresetn(util_vector_logic_0_Res));
  design_2_UART_TRANSACTION_HAN_0_0 UART_TRANSACTION_HAN_0
       (.Word_To_Send(UART_TRANSACTION_HAN_0_Word_To_Send),
        .Word_To_Send_en(UART_TRANSACTION_HAN_0_Word_To_Send_en),
        .clk(clk_wiz_0_clk_100MHz),
        .m_axi_araddr(UART_TRANSACTION_HAN_0_m_axi_ARADDR),
        .m_axi_arready(UART_TRANSACTION_HAN_0_m_axi_ARREADY),
        .m_axi_arvalid(UART_TRANSACTION_HAN_0_m_axi_ARVALID),
        .m_axi_awaddr(UART_TRANSACTION_HAN_0_m_axi_AWADDR),
        .m_axi_awready(UART_TRANSACTION_HAN_0_m_axi_AWREADY),
        .m_axi_awvalid(UART_TRANSACTION_HAN_0_m_axi_AWVALID),
        .m_axi_bready(UART_TRANSACTION_HAN_0_m_axi_BREADY),
        .m_axi_bresp(UART_TRANSACTION_HAN_0_m_axi_BRESP),
        .m_axi_bvalid(UART_TRANSACTION_HAN_0_m_axi_BVALID),
        .m_axi_rdata(UART_TRANSACTION_HAN_0_m_axi_RDATA),
        .m_axi_rready(UART_TRANSACTION_HAN_0_m_axi_RREADY),
        .m_axi_rresp(UART_TRANSACTION_HAN_0_m_axi_RRESP),
        .m_axi_rvalid(UART_TRANSACTION_HAN_0_m_axi_RVALID),
        .m_axi_wdata(UART_TRANSACTION_HAN_0_m_axi_WDATA),
        .m_axi_wready(UART_TRANSACTION_HAN_0_m_axi_WREADY),
        .m_axi_wstrb(UART_TRANSACTION_HAN_0_m_axi_WSTRB),
        .m_axi_wvalid(UART_TRANSACTION_HAN_0_m_axi_WVALID),
        .max_angle(xlconstant_0_dout),
        .reset_n(util_vector_logic_0_Res),
        .rx_data(UART_0_RX_Data_out),
        .rx_ready(UART_0_RX_Data_Ready),
        .uart_tx_ready(UART_0_TX_Ready_To_Send));
  design_2_clk_wiz_0_0 clk_wiz_0
       (.UART_clk(clk_wiz_0_UART_clk),
        .clk_100MHz(clk_wiz_0_clk_100MHz),
        .clk_in1(clk_12MHz_1),
        .reset(reset_1));
  design_2_system_ila_0_0 system_ila_0
       (.SLOT_0_AXIS_tdata(xadc_wiz_0_M_AXIS_TDATA),
        .SLOT_0_AXIS_tid(xadc_wiz_0_M_AXIS_TID),
        .SLOT_0_AXIS_tlast(1'b0),
        .SLOT_0_AXIS_tready(1'b1),
        .SLOT_0_AXIS_tvalid(xadc_wiz_0_M_AXIS_TVALID),
        .clk(clk_wiz_0_clk_100MHz),
        .resetn(util_vector_logic_0_Res));
  design_2_system_ila_1_0 system_ila_1
       (.SLOT_0_AXI_araddr(UART_TRANSACTION_HAN_0_m_axi_ARADDR),
        .SLOT_0_AXI_arready(UART_TRANSACTION_HAN_0_m_axi_ARREADY),
        .SLOT_0_AXI_arvalid(UART_TRANSACTION_HAN_0_m_axi_ARVALID),
        .SLOT_0_AXI_awaddr(UART_TRANSACTION_HAN_0_m_axi_AWADDR),
        .SLOT_0_AXI_awready(UART_TRANSACTION_HAN_0_m_axi_AWREADY),
        .SLOT_0_AXI_awvalid(UART_TRANSACTION_HAN_0_m_axi_AWVALID),
        .SLOT_0_AXI_bready(UART_TRANSACTION_HAN_0_m_axi_BREADY),
        .SLOT_0_AXI_bresp(UART_TRANSACTION_HAN_0_m_axi_BRESP),
        .SLOT_0_AXI_bvalid(UART_TRANSACTION_HAN_0_m_axi_BVALID),
        .SLOT_0_AXI_rdata(UART_TRANSACTION_HAN_0_m_axi_RDATA),
        .SLOT_0_AXI_rready(UART_TRANSACTION_HAN_0_m_axi_RREADY),
        .SLOT_0_AXI_rresp(UART_TRANSACTION_HAN_0_m_axi_RRESP),
        .SLOT_0_AXI_rvalid(UART_TRANSACTION_HAN_0_m_axi_RVALID),
        .SLOT_0_AXI_wdata(UART_TRANSACTION_HAN_0_m_axi_WDATA),
        .SLOT_0_AXI_wready(UART_TRANSACTION_HAN_0_m_axi_WREADY),
        .SLOT_0_AXI_wstrb(UART_TRANSACTION_HAN_0_m_axi_WSTRB),
        .SLOT_0_AXI_wvalid(UART_TRANSACTION_HAN_0_m_axi_WVALID),
        .clk(clk_wiz_0_clk_100MHz),
        .resetn(util_vector_logic_0_Res));
  design_2_util_vector_logic_0_0 util_vector_logic_0
       (.Op1(reset_1),
        .Res(util_vector_logic_0_Res));
  design_2_xadc_wiz_0_0 xadc_wiz_0
       (.m_axis_tdata(xadc_wiz_0_M_AXIS_TDATA),
        .m_axis_tid(xadc_wiz_0_M_AXIS_TID),
        .m_axis_tready(xlconstant_1_dout),
        .m_axis_tvalid(xadc_wiz_0_M_AXIS_TVALID),
        .s_axi_aclk(clk_wiz_0_clk_100MHz),
        .s_axi_araddr(UART_TRANSACTION_HAN_0_m_axi_ARADDR[10:0]),
        .s_axi_aresetn(xlconstant_2_dout),
        .s_axi_arready(UART_TRANSACTION_HAN_0_m_axi_ARREADY),
        .s_axi_arvalid(UART_TRANSACTION_HAN_0_m_axi_ARVALID),
        .s_axi_awaddr(UART_TRANSACTION_HAN_0_m_axi_AWADDR[10:0]),
        .s_axi_awready(UART_TRANSACTION_HAN_0_m_axi_AWREADY),
        .s_axi_awvalid(UART_TRANSACTION_HAN_0_m_axi_AWVALID),
        .s_axi_bready(UART_TRANSACTION_HAN_0_m_axi_BREADY),
        .s_axi_bresp(UART_TRANSACTION_HAN_0_m_axi_BRESP),
        .s_axi_bvalid(UART_TRANSACTION_HAN_0_m_axi_BVALID),
        .s_axi_rdata(UART_TRANSACTION_HAN_0_m_axi_RDATA),
        .s_axi_rready(UART_TRANSACTION_HAN_0_m_axi_RREADY),
        .s_axi_rresp(UART_TRANSACTION_HAN_0_m_axi_RRESP),
        .s_axi_rvalid(UART_TRANSACTION_HAN_0_m_axi_RVALID),
        .s_axi_wdata(UART_TRANSACTION_HAN_0_m_axi_WDATA),
        .s_axi_wready(UART_TRANSACTION_HAN_0_m_axi_WREADY),
        .s_axi_wstrb(UART_TRANSACTION_HAN_0_m_axi_WSTRB),
        .s_axi_wvalid(UART_TRANSACTION_HAN_0_m_axi_WVALID),
        .s_axis_aclk(clk_wiz_0_clk_100MHz),
        .vauxn13(Vaux13_0_1_V_N),
        .vauxn14(Vaux14_0_1_V_N),
        .vauxn15(Vaux15_0_1_V_N),
        .vauxn5(Vaux5_0_1_V_N),
        .vauxn6(Vaux6_0_1_V_N),
        .vauxn7(Vaux7_0_1_V_N),
        .vauxp13(Vaux13_0_1_V_P),
        .vauxp14(Vaux14_0_1_V_P),
        .vauxp15(Vaux15_0_1_V_P),
        .vauxp5(Vaux5_0_1_V_P),
        .vauxp6(Vaux6_0_1_V_P),
        .vauxp7(Vaux7_0_1_V_P),
        .vn_in(1'b0),
        .vp_in(1'b0));
  design_2_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
  design_2_xlconstant_1_0 xlconstant_1
       (.dout(xlconstant_1_dout));
  design_2_xlconstant_2_0 xlconstant_2
       (.dout(xlconstant_2_dout));
endmodule
