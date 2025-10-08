//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
//Date        : Mon Sep 15 17:37:35 2025
//Host        : AustinsPC running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module Hilbert_imp_QP5DCK
   (M_AXIS_DATA_tdata,
    M_AXIS_DATA_tlast,
    M_AXIS_DATA_tready,
    M_AXIS_DATA_tvalid,
    S_AXIS_DATA_0_tdata,
    S_AXIS_DATA_0_tlast,
    S_AXIS_DATA_0_tready,
    S_AXIS_DATA_0_tvalid,
    aclk_0,
    reset_b_0);
  output [31:0]M_AXIS_DATA_tdata;
  output M_AXIS_DATA_tlast;
  input M_AXIS_DATA_tready;
  output M_AXIS_DATA_tvalid;
  input [31:0]S_AXIS_DATA_0_tdata;
  input S_AXIS_DATA_0_tlast;
  output S_AXIS_DATA_0_tready;
  input S_AXIS_DATA_0_tvalid;
  input aclk_0;
  input reset_b_0;

  wire DATA_CORRECTOR_0_ifft_s_axis_data_TLAST;
  wire DATA_CORRECTOR_0_ifft_s_axis_data_TREADY;
  wire DATA_CORRECTOR_0_ifft_s_axis_data_TVALID;
  wire Net;
  wire [31:0]S_AXIS_DATA_0_1_TDATA;
  wire S_AXIS_DATA_0_1_TLAST;
  wire S_AXIS_DATA_0_1_TREADY;
  wire S_AXIS_DATA_0_1_TVALID;
  wire aclk_0_1;
  wire xfft_0_M_AXIS_DATA_TLAST;
  wire xfft_0_M_AXIS_DATA_TREADY;
  wire xfft_0_M_AXIS_DATA_TVALID;
  wire [31:0]xfft_1_M_AXIS_DATA_TDATA;
  wire xfft_1_M_AXIS_DATA_TLAST;
  wire xfft_1_M_AXIS_DATA_TREADY;
  wire xfft_1_M_AXIS_DATA_TVALID;
  wire [15:0]xlconstant_0_dout;
  wire [15:0]xlconstant_1_dout;

  assign M_AXIS_DATA_tdata[31:0] = xfft_1_M_AXIS_DATA_TDATA;
  assign M_AXIS_DATA_tlast = xfft_1_M_AXIS_DATA_TLAST;
  assign M_AXIS_DATA_tvalid = xfft_1_M_AXIS_DATA_TVALID;
  assign Net = reset_b_0;
  assign S_AXIS_DATA_0_1_TDATA = S_AXIS_DATA_0_tdata[31:0];
  assign S_AXIS_DATA_0_1_TLAST = S_AXIS_DATA_0_tlast;
  assign S_AXIS_DATA_0_1_TVALID = S_AXIS_DATA_0_tvalid;
  assign S_AXIS_DATA_0_tready = S_AXIS_DATA_0_1_TREADY;
  assign aclk_0_1 = aclk_0;
  assign xfft_1_M_AXIS_DATA_TREADY = M_AXIS_DATA_tready;
  design_1_DATA_CORRECTOR_0_0 DATA_CORRECTOR_0
       (.clk(aclk_0_1),
        .data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ifft_s_axis_data_tlast(DATA_CORRECTOR_0_ifft_s_axis_data_TLAST),
        .ifft_s_axis_data_tready(DATA_CORRECTOR_0_ifft_s_axis_data_TREADY),
        .ifft_s_axis_data_tvalid(DATA_CORRECTOR_0_ifft_s_axis_data_TVALID),
        .reset_b(Net),
        .x_m_axis_data_tlast(xfft_0_M_AXIS_DATA_TLAST),
        .x_m_axis_data_tready(xfft_0_M_AXIS_DATA_TREADY),
        .x_m_axis_data_tvalid(xfft_0_M_AXIS_DATA_TVALID));
  design_1_xfft_0_0 xfft_0
       (.aclk(aclk_0_1),
        .m_axis_data_tlast(xfft_0_M_AXIS_DATA_TLAST),
        .m_axis_data_tready(xfft_0_M_AXIS_DATA_TREADY),
        .m_axis_data_tvalid(xfft_0_M_AXIS_DATA_TVALID),
        .s_axis_config_tdata(xlconstant_0_dout),
        .s_axis_config_tvalid(1'b0),
        .s_axis_data_tdata(S_AXIS_DATA_0_1_TDATA),
        .s_axis_data_tlast(S_AXIS_DATA_0_1_TLAST),
        .s_axis_data_tready(S_AXIS_DATA_0_1_TREADY),
        .s_axis_data_tvalid(S_AXIS_DATA_0_1_TVALID));
  design_1_xfft_0_1 xfft_1
       (.aclk(aclk_0_1),
        .m_axis_data_tdata(xfft_1_M_AXIS_DATA_TDATA),
        .m_axis_data_tlast(xfft_1_M_AXIS_DATA_TLAST),
        .m_axis_data_tready(xfft_1_M_AXIS_DATA_TREADY),
        .m_axis_data_tvalid(xfft_1_M_AXIS_DATA_TVALID),
        .s_axis_config_tdata(xlconstant_1_dout),
        .s_axis_config_tvalid(1'b0),
        .s_axis_data_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_data_tlast(DATA_CORRECTOR_0_ifft_s_axis_data_TLAST),
        .s_axis_data_tready(DATA_CORRECTOR_0_ifft_s_axis_data_TREADY),
        .s_axis_data_tvalid(DATA_CORRECTOR_0_ifft_s_axis_data_TVALID));
  design_1_xlconstant_0_1 xlconstant_0
       (.dout(xlconstant_0_dout));
  design_1_xlconstant_0_2 xlconstant_1
       (.dout(xlconstant_1_dout));
endmodule

module P_theta_imp_OCDHGX
   (M00_AXIS_tdata,
    M00_AXIS_tlast,
    M00_AXIS_tready,
    M00_AXIS_tuser,
    M00_AXIS_tvalid,
    M01_AXIS1_tlast,
    M01_AXIS1_tuser,
    M01_AXIS1_tvalid,
    M01_AXIS_tdata,
    M01_AXIS_tlast,
    M01_AXIS_tready,
    M01_AXIS_tuser,
    M01_AXIS_tvalid,
    M02_AXIS_tlast,
    M02_AXIS_tuser,
    M02_AXIS_tvalid,
    aclk_0,
    enable_0,
    reset_b_0,
    s_axis_a_tdata,
    s_axis_a_tlast,
    s_axis_a_tready,
    s_axis_a_tuser,
    s_axis_a_tvalid);
  output [15:0]M00_AXIS_tdata;
  output [0:0]M00_AXIS_tlast;
  input [0:0]M00_AXIS_tready;
  output [4:0]M00_AXIS_tuser;
  output [0:0]M00_AXIS_tvalid;
  output [0:0]M01_AXIS1_tlast;
  output [0:0]M01_AXIS1_tuser;
  output [0:0]M01_AXIS1_tvalid;
  output [15:0]M01_AXIS_tdata;
  output [0:0]M01_AXIS_tlast;
  input [0:0]M01_AXIS_tready;
  output [4:0]M01_AXIS_tuser;
  output [0:0]M01_AXIS_tvalid;
  output [0:0]M02_AXIS_tlast;
  output [0:0]M02_AXIS_tuser;
  output [0:0]M02_AXIS_tvalid;
  input aclk_0;
  input enable_0;
  input reset_b_0;
  input [255:0]s_axis_a_tdata;
  input s_axis_a_tlast;
  output s_axis_a_tready;
  input [4:0]s_axis_a_tuser;
  input s_axis_a_tvalid;

  wire Net;
  wire aclk_0_1;
  wire [15:0]axis_broadcaster_0_M00_AXIS_TDATA;
  wire [0:0]axis_broadcaster_0_M00_AXIS_TLAST;
  wire [0:0]axis_broadcaster_0_M00_AXIS_TREADY;
  wire [4:0]axis_broadcaster_0_M00_AXIS_TUSER;
  wire [0:0]axis_broadcaster_0_M00_AXIS_TVALID;
  wire [31:16]axis_broadcaster_0_M01_AXIS_TDATA;
  wire [1:1]axis_broadcaster_0_M01_AXIS_TLAST;
  wire [0:0]axis_broadcaster_0_M01_AXIS_TREADY;
  wire [9:5]axis_broadcaster_0_M01_AXIS_TUSER;
  wire [1:1]axis_broadcaster_0_M01_AXIS_TVALID;
  wire [0:0]axis_broadcaster_1_M00_AXIS_TLAST;
  wire [0:0]axis_broadcaster_1_M00_AXIS_TUSER;
  wire [0:0]axis_broadcaster_1_M00_AXIS_TVALID;
  wire [1:1]axis_broadcaster_1_M01_AXIS_TLAST;
  wire [1:1]axis_broadcaster_1_M01_AXIS_TUSER;
  wire [1:1]axis_broadcaster_1_M01_AXIS_TVALID;
  wire [2:2]axis_broadcaster_1_M02_AXIS_TLAST;
  wire [2:2]axis_broadcaster_1_M02_AXIS_TUSER;
  wire [2:2]axis_broadcaster_1_M02_AXIS_TVALID;
  wire [1023:0]complex_matrix_hadam_0_m_axis_TDATA;
  wire complex_matrix_hadam_0_m_axis_TLAST;
  wire complex_matrix_hadam_0_m_axis_TREADY;
  wire [9:0]complex_matrix_hadam_0_m_axis_TUSER;
  wire complex_matrix_hadam_0_m_axis_TVALID;
  wire enable_0_1;
  wire [15:0]matrix_accumulator_n_0_m_axis_TDATA;
  wire matrix_accumulator_n_0_m_axis_TLAST;
  wire matrix_accumulator_n_0_m_axis_TREADY;
  wire [4:0]matrix_accumulator_n_0_m_axis_TUSER;
  wire matrix_accumulator_n_0_m_axis_TVALID;
  wire [1023:0]s_theta_32_0_s_sh_theta;
  wire [255:0]scalar_divide_const_0_m_axis_TDATA;
  wire scalar_divide_const_0_m_axis_TLAST;
  wire scalar_divide_const_0_m_axis_TREADY;
  wire [4:0]scalar_divide_const_0_m_axis_TUSER;
  wire scalar_divide_const_0_m_axis_TVALID;
  wire theta_driver_0_m_axis_theta_TLAST;
  wire theta_driver_0_m_axis_theta_TUSER;
  wire theta_driver_0_m_axis_theta_TVALID;
  wire [4:0]theta_driver_0_m_axis_theta_tdata;

  assign M00_AXIS_tdata[15:0] = axis_broadcaster_0_M00_AXIS_TDATA;
  assign M00_AXIS_tlast[0] = axis_broadcaster_0_M00_AXIS_TLAST;
  assign M00_AXIS_tuser[4:0] = axis_broadcaster_0_M00_AXIS_TUSER;
  assign M00_AXIS_tvalid[0] = axis_broadcaster_0_M00_AXIS_TVALID;
  assign M01_AXIS1_tlast[0] = axis_broadcaster_1_M01_AXIS_TLAST;
  assign M01_AXIS1_tuser[0] = axis_broadcaster_1_M01_AXIS_TUSER;
  assign M01_AXIS1_tvalid[0] = axis_broadcaster_1_M01_AXIS_TVALID;
  assign M01_AXIS_tdata[15:0] = axis_broadcaster_0_M01_AXIS_TDATA;
  assign M01_AXIS_tlast[0] = axis_broadcaster_0_M01_AXIS_TLAST;
  assign M01_AXIS_tuser[4:0] = axis_broadcaster_0_M01_AXIS_TUSER;
  assign M01_AXIS_tvalid[0] = axis_broadcaster_0_M01_AXIS_TVALID;
  assign M02_AXIS_tlast[0] = axis_broadcaster_1_M02_AXIS_TLAST;
  assign M02_AXIS_tuser[0] = axis_broadcaster_1_M02_AXIS_TUSER;
  assign M02_AXIS_tvalid[0] = axis_broadcaster_1_M02_AXIS_TVALID;
  assign Net = reset_b_0;
  assign aclk_0_1 = aclk_0;
  assign axis_broadcaster_0_M00_AXIS_TREADY = M00_AXIS_tready[0];
  assign axis_broadcaster_0_M01_AXIS_TREADY = M01_AXIS_tready[0];
  assign enable_0_1 = enable_0;
  assign s_axis_a_tready = scalar_divide_const_0_m_axis_TREADY;
  assign scalar_divide_const_0_m_axis_TDATA = s_axis_a_tdata[255:0];
  assign scalar_divide_const_0_m_axis_TLAST = s_axis_a_tlast;
  assign scalar_divide_const_0_m_axis_TUSER = s_axis_a_tuser[4:0];
  assign scalar_divide_const_0_m_axis_TVALID = s_axis_a_tvalid;
  design_1_axis_broadcaster_0_0 axis_broadcaster_0
       (.aclk(aclk_0_1),
        .aresetn(Net),
        .m_axis_tdata({axis_broadcaster_0_M01_AXIS_TDATA,axis_broadcaster_0_M00_AXIS_TDATA}),
        .m_axis_tlast({axis_broadcaster_0_M01_AXIS_TLAST,axis_broadcaster_0_M00_AXIS_TLAST}),
        .m_axis_tready({axis_broadcaster_0_M01_AXIS_TREADY,axis_broadcaster_0_M00_AXIS_TREADY}),
        .m_axis_tuser({axis_broadcaster_0_M01_AXIS_TUSER,axis_broadcaster_0_M00_AXIS_TUSER}),
        .m_axis_tvalid({axis_broadcaster_0_M01_AXIS_TVALID,axis_broadcaster_0_M00_AXIS_TVALID}),
        .s_axis_tdata(matrix_accumulator_n_0_m_axis_TDATA),
        .s_axis_tlast(matrix_accumulator_n_0_m_axis_TLAST),
        .s_axis_tready(matrix_accumulator_n_0_m_axis_TREADY),
        .s_axis_tuser(matrix_accumulator_n_0_m_axis_TUSER),
        .s_axis_tvalid(matrix_accumulator_n_0_m_axis_TVALID));
  design_1_axis_broadcaster_1_0 axis_broadcaster_1
       (.aclk(aclk_0_1),
        .aresetn(Net),
        .m_axis_tlast({axis_broadcaster_1_M02_AXIS_TLAST,axis_broadcaster_1_M01_AXIS_TLAST,axis_broadcaster_1_M00_AXIS_TLAST}),
        .m_axis_tuser({axis_broadcaster_1_M02_AXIS_TUSER,axis_broadcaster_1_M01_AXIS_TUSER,axis_broadcaster_1_M00_AXIS_TUSER}),
        .m_axis_tvalid({axis_broadcaster_1_M02_AXIS_TVALID,axis_broadcaster_1_M01_AXIS_TVALID,axis_broadcaster_1_M00_AXIS_TVALID}),
        .s_axis_tlast(theta_driver_0_m_axis_theta_TLAST),
        .s_axis_tuser(theta_driver_0_m_axis_theta_TUSER),
        .s_axis_tvalid(theta_driver_0_m_axis_theta_TVALID));
  design_1_complex_matrix_hadam_0_0 complex_matrix_hadam_0
       (.clk(aclk_0_1),
        .clken(enable_0_1),
        .m_axis_tdata(complex_matrix_hadam_0_m_axis_TDATA),
        .m_axis_tlast(complex_matrix_hadam_0_m_axis_TLAST),
        .m_axis_tready(complex_matrix_hadam_0_m_axis_TREADY),
        .m_axis_tuser(complex_matrix_hadam_0_m_axis_TUSER),
        .m_axis_tvalid(complex_matrix_hadam_0_m_axis_TVALID),
        .reset_n(Net),
        .s_axis_a_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,scalar_divide_const_0_m_axis_TDATA}),
        .s_axis_a_tlast(scalar_divide_const_0_m_axis_TLAST),
        .s_axis_a_tready(scalar_divide_const_0_m_axis_TREADY),
        .s_axis_a_tuser(scalar_divide_const_0_m_axis_TUSER),
        .s_axis_a_tvalid(scalar_divide_const_0_m_axis_TVALID),
        .s_axis_b_tdata(s_theta_32_0_s_sh_theta[511:0]),
        .s_axis_b_tlast(axis_broadcaster_1_M00_AXIS_TLAST),
        .s_axis_b_tuser({1'b0,1'b0,1'b0,1'b0,axis_broadcaster_1_M00_AXIS_TUSER}),
        .s_axis_b_tvalid(axis_broadcaster_1_M00_AXIS_TVALID));
  design_1_matrix_accumulator_n_0_0 matrix_accumulator_n_0
       (.clk(aclk_0_1),
        .m_axis_tdata(matrix_accumulator_n_0_m_axis_TDATA),
        .m_axis_tlast(matrix_accumulator_n_0_m_axis_TLAST),
        .m_axis_tready(matrix_accumulator_n_0_m_axis_TREADY),
        .m_axis_tuser(matrix_accumulator_n_0_m_axis_TUSER),
        .m_axis_tvalid(matrix_accumulator_n_0_m_axis_TVALID),
        .reset_n(Net),
        .s_axis_tdata(complex_matrix_hadam_0_m_axis_TDATA[511:0]),
        .s_axis_tlast(complex_matrix_hadam_0_m_axis_TLAST),
        .s_axis_tready(complex_matrix_hadam_0_m_axis_TREADY),
        .s_axis_tuser(complex_matrix_hadam_0_m_axis_TUSER[4:0]),
        .s_axis_tvalid(complex_matrix_hadam_0_m_axis_TVALID));
  design_1_s_theta_32_0_0 s_theta_32_0
       (.s_sh_theta(s_theta_32_0_s_sh_theta),
        .theta(theta_driver_0_m_axis_theta_tdata));
  design_1_theta_driver_0_0 theta_driver_0
       (.clk(aclk_0_1),
        .enable(enable_0_1),
        .m_axis_theta_tdata(theta_driver_0_m_axis_theta_tdata),
        .m_axis_theta_tlast(theta_driver_0_m_axis_theta_TLAST),
        .m_axis_theta_tuser(theta_driver_0_m_axis_theta_TUSER),
        .m_axis_theta_tvalid(theta_driver_0_m_axis_theta_TVALID),
        .reset_n(Net));
endmodule

module RXX_imp_LNXWA8
   (aclk_0,
    channel_3_base,
    enable_0,
    m_axis_tdata,
    m_axis_tlast,
    m_axis_tready,
    m_axis_tuser,
    m_axis_tvalid,
    reset_b_0,
    s_axis_tlast,
    s_axis_tready,
    s_axis_tuser,
    s_axis_tvalid);
  input aclk_0;
  input [255:0]channel_3_base;
  input enable_0;
  output [255:0]m_axis_tdata;
  output m_axis_tlast;
  input m_axis_tready;
  output [4:0]m_axis_tuser;
  output m_axis_tvalid;
  input reset_b_0;
  input s_axis_tlast;
  output s_axis_tready;
  input [0:0]s_axis_tuser;
  input s_axis_tvalid;

  wire Net;
  wire aclk_0_1;
  wire axis_register_slice_0_M_AXIS_TLAST;
  wire axis_register_slice_0_M_AXIS_TREADY;
  wire [0:0]axis_register_slice_0_M_AXIS_TUSER;
  wire axis_register_slice_0_M_AXIS_TVALID;
  wire [255:0]axis_register_slice_0_m_axis_tdata;
  wire complex_matrix_multi_0_m_axis_dout_TLAST;
  wire complex_matrix_multi_0_m_axis_dout_TREADY;
  wire [4:0]complex_matrix_multi_0_m_axis_dout_TUSER;
  wire complex_matrix_multi_0_m_axis_dout_TVALID;
  wire [63:0]complex_matrix_multi_0_result_matrix_0_0;
  wire [63:0]complex_matrix_multi_0_result_matrix_0_1;
  wire [63:0]complex_matrix_multi_0_result_matrix_0_2;
  wire [63:0]complex_matrix_multi_0_result_matrix_0_3;
  wire [63:0]complex_matrix_multi_0_result_matrix_1_0;
  wire [63:0]complex_matrix_multi_0_result_matrix_1_1;
  wire [63:0]complex_matrix_multi_0_result_matrix_1_2;
  wire [63:0]complex_matrix_multi_0_result_matrix_1_3;
  wire [63:0]complex_matrix_multi_0_result_matrix_2_0;
  wire [63:0]complex_matrix_multi_0_result_matrix_2_1;
  wire [63:0]complex_matrix_multi_0_result_matrix_2_2;
  wire [63:0]complex_matrix_multi_0_result_matrix_2_3;
  wire [63:0]complex_matrix_multi_0_result_matrix_3_0;
  wire [63:0]complex_matrix_multi_0_result_matrix_3_1;
  wire [63:0]complex_matrix_multi_0_result_matrix_3_2;
  wire [63:0]complex_matrix_multi_0_result_matrix_3_3;
  wire enable_0_1;
  wire [255:0]scalar_divide_const_0_m_axis_TDATA;
  wire scalar_divide_const_0_m_axis_TLAST;
  wire scalar_divide_const_0_m_axis_TREADY;
  wire [4:0]scalar_divide_const_0_m_axis_TUSER;
  wire scalar_divide_const_0_m_axis_TVALID;
  wire [1023:0]xlconcat_0_dout;

  assign Net = reset_b_0;
  assign aclk_0_1 = aclk_0;
  assign axis_register_slice_0_M_AXIS_TLAST = s_axis_tlast;
  assign axis_register_slice_0_M_AXIS_TUSER = s_axis_tuser[0];
  assign axis_register_slice_0_M_AXIS_TVALID = s_axis_tvalid;
  assign axis_register_slice_0_m_axis_tdata = channel_3_base[255:0];
  assign enable_0_1 = enable_0;
  assign m_axis_tdata[255:0] = scalar_divide_const_0_m_axis_TDATA;
  assign m_axis_tlast = scalar_divide_const_0_m_axis_TLAST;
  assign m_axis_tuser[4:0] = scalar_divide_const_0_m_axis_TUSER;
  assign m_axis_tvalid = scalar_divide_const_0_m_axis_TVALID;
  assign s_axis_tready = axis_register_slice_0_M_AXIS_TREADY;
  assign scalar_divide_const_0_m_axis_TREADY = m_axis_tready;
  design_1_complex_matrix_multi_0_0 complex_matrix_multi_0
       (.channel_0_base(axis_register_slice_0_m_axis_tdata[31:0]),
        .channel_1_base(axis_register_slice_0_m_axis_tdata[31:0]),
        .channel_2_base(axis_register_slice_0_m_axis_tdata[31:0]),
        .channel_3_base(axis_register_slice_0_m_axis_tdata[31:0]),
        .clk(aclk_0_1),
        .clken(enable_0_1),
        .m_axis_dout_tlast(complex_matrix_multi_0_m_axis_dout_TLAST),
        .m_axis_dout_tready(complex_matrix_multi_0_m_axis_dout_TREADY),
        .m_axis_dout_tuser(complex_matrix_multi_0_m_axis_dout_TUSER),
        .m_axis_dout_tvalid(complex_matrix_multi_0_m_axis_dout_TVALID),
        .reset_n(Net),
        .result_matrix_0_0(complex_matrix_multi_0_result_matrix_0_0),
        .result_matrix_0_1(complex_matrix_multi_0_result_matrix_0_1),
        .result_matrix_0_2(complex_matrix_multi_0_result_matrix_0_2),
        .result_matrix_0_3(complex_matrix_multi_0_result_matrix_0_3),
        .result_matrix_1_0(complex_matrix_multi_0_result_matrix_1_0),
        .result_matrix_1_1(complex_matrix_multi_0_result_matrix_1_1),
        .result_matrix_1_2(complex_matrix_multi_0_result_matrix_1_2),
        .result_matrix_1_3(complex_matrix_multi_0_result_matrix_1_3),
        .result_matrix_2_0(complex_matrix_multi_0_result_matrix_2_0),
        .result_matrix_2_1(complex_matrix_multi_0_result_matrix_2_1),
        .result_matrix_2_2(complex_matrix_multi_0_result_matrix_2_2),
        .result_matrix_2_3(complex_matrix_multi_0_result_matrix_2_3),
        .result_matrix_3_0(complex_matrix_multi_0_result_matrix_3_0),
        .result_matrix_3_1(complex_matrix_multi_0_result_matrix_3_1),
        .result_matrix_3_2(complex_matrix_multi_0_result_matrix_3_2),
        .result_matrix_3_3(complex_matrix_multi_0_result_matrix_3_3),
        .s_axis_tlast(axis_register_slice_0_M_AXIS_TLAST),
        .s_axis_tready(axis_register_slice_0_M_AXIS_TREADY),
        .s_axis_tuser({1'b0,1'b0,1'b0,1'b0,axis_register_slice_0_M_AXIS_TUSER}),
        .s_axis_tvalid(axis_register_slice_0_M_AXIS_TVALID));
  design_1_scalar_divide_const_0_0 scalar_divide_const_0
       (.clk(aclk_0_1),
        .m_axis_tdata(scalar_divide_const_0_m_axis_TDATA),
        .m_axis_tlast(scalar_divide_const_0_m_axis_TLAST),
        .m_axis_tready(scalar_divide_const_0_m_axis_TREADY),
        .m_axis_tuser(scalar_divide_const_0_m_axis_TUSER),
        .m_axis_tvalid(scalar_divide_const_0_m_axis_TVALID),
        .reset_n(Net),
        .s_axis_tdata(xlconcat_0_dout[511:0]),
        .s_axis_tlast(complex_matrix_multi_0_m_axis_dout_TLAST),
        .s_axis_tready(complex_matrix_multi_0_m_axis_dout_TREADY),
        .s_axis_tuser(complex_matrix_multi_0_m_axis_dout_TUSER),
        .s_axis_tvalid(complex_matrix_multi_0_m_axis_dout_TVALID));
  design_1_xlconcat_0_0 xlconcat_0
       (.In0(complex_matrix_multi_0_result_matrix_0_0),
        .In1(complex_matrix_multi_0_result_matrix_0_1),
        .In10(complex_matrix_multi_0_result_matrix_2_2),
        .In11(complex_matrix_multi_0_result_matrix_2_3),
        .In12(complex_matrix_multi_0_result_matrix_3_0),
        .In13(complex_matrix_multi_0_result_matrix_3_1),
        .In14(complex_matrix_multi_0_result_matrix_3_2),
        .In15(complex_matrix_multi_0_result_matrix_3_3),
        .In2(complex_matrix_multi_0_result_matrix_0_2),
        .In3(complex_matrix_multi_0_result_matrix_0_3),
        .In4(complex_matrix_multi_0_result_matrix_1_0),
        .In5(complex_matrix_multi_0_result_matrix_1_1),
        .In6(complex_matrix_multi_0_result_matrix_1_2),
        .In7(complex_matrix_multi_0_result_matrix_1_3),
        .In8(complex_matrix_multi_0_result_matrix_2_0),
        .In9(complex_matrix_multi_0_result_matrix_2_1),
        .dout(xlconcat_0_dout));
endmodule

(* HW_HANDOFF = "design_1.hwdef" *) (* core_generation_info = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=21,numReposBlks=18,numNonXlnxBlks=0,numHierBlks=3,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=10,numPkgbdBlks=0,bdsource=USER,da_clkrst_cnt=10,synth_mode=OOC_per_IP}" *) 
module design_1
   (S_AXIS_DATA_0_tdata,
    S_AXIS_DATA_0_tlast,
    S_AXIS_DATA_0_tready,
    S_AXIS_DATA_0_tvalid,
    aclk_0,
    enable_0,
    m_axis_all_0_tdata,
    m_axis_all_0_tlast,
    m_axis_all_0_tready,
    m_axis_all_0_tuser,
    m_axis_all_0_tvalid,
    m_axis_max_0_tdata,
    m_axis_max_0_tlast,
    m_axis_max_0_tready,
    m_axis_max_0_tuser,
    m_axis_max_0_tvalid,
    reset_b_0);
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_DATA_0 TDATA" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXIS_DATA_0, CLK_DOMAIN design_1_aclk_0, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [31:0]S_AXIS_DATA_0_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_DATA_0 TLAST" *) input S_AXIS_DATA_0_tlast;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_DATA_0 TREADY" *) output S_AXIS_DATA_0_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_DATA_0 TVALID" *) input S_AXIS_DATA_0_tvalid;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.ACLK_0 CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.ACLK_0, ASSOCIATED_BUSIF S_AXIS_DATA_0:m_axis_all_0:m_axis_max_0, ASSOCIATED_RESET reset_b_0, CLK_DOMAIN design_1_aclk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input aclk_0;
  input enable_0;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_all_0 TDATA" *) (* x_interface_parameter = "XIL_INTERFACENAME m_axis_all_0, CLK_DOMAIN design_1_aclk_0, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 76, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1" *) output [607:0]m_axis_all_0_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_all_0 TLAST" *) output m_axis_all_0_tlast;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_all_0 TREADY" *) input m_axis_all_0_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_all_0 TUSER" *) output m_axis_all_0_tuser;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_all_0 TVALID" *) output m_axis_all_0_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_max_0 TDATA" *) (* x_interface_parameter = "XIL_INTERFACENAME m_axis_max_0, CLK_DOMAIN design_1_aclk_0, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 0, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1" *) output [4:0]m_axis_max_0_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_max_0 TLAST" *) output m_axis_max_0_tlast;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_max_0 TREADY" *) input m_axis_max_0_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_max_0 TUSER" *) output m_axis_max_0_tuser;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_max_0 TVALID" *) output m_axis_max_0_tvalid;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.RESET_B_0 RST" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.RESET_B_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_b_0;

  wire Net;
  wire [31:0]S_AXIS_DATA_0_1_TDATA;
  wire S_AXIS_DATA_0_1_TLAST;
  wire S_AXIS_DATA_0_1_TREADY;
  wire S_AXIS_DATA_0_1_TVALID;
  wire aclk_0_1;
  wire [15:0]axis_broadcaster_0_M00_AXIS_TDATA;
  wire [0:0]axis_broadcaster_0_M00_AXIS_TLAST;
  wire axis_broadcaster_0_M00_AXIS_TREADY;
  wire [4:0]axis_broadcaster_0_M00_AXIS_TUSER;
  wire [0:0]axis_broadcaster_0_M00_AXIS_TVALID;
  wire [15:0]axis_broadcaster_0_M01_AXIS_TDATA;
  wire [0:0]axis_broadcaster_0_M01_AXIS_TLAST;
  wire axis_broadcaster_0_M01_AXIS_TREADY;
  wire [4:0]axis_broadcaster_0_M01_AXIS_TUSER;
  wire [0:0]axis_broadcaster_0_M01_AXIS_TVALID;
  wire [0:0]axis_broadcaster_1_M01_AXIS_TLAST;
  wire [0:0]axis_broadcaster_1_M01_AXIS_TUSER;
  wire [0:0]axis_broadcaster_1_M01_AXIS_TVALID;
  wire [0:0]axis_broadcaster_1_M02_AXIS_TLAST;
  wire [0:0]axis_broadcaster_1_M02_AXIS_TUSER;
  wire [0:0]axis_broadcaster_1_M02_AXIS_TVALID;
  wire axis_register_slice_0_M_AXIS_TLAST;
  wire axis_register_slice_0_M_AXIS_TREADY;
  wire [0:0]axis_register_slice_0_M_AXIS_TUSER;
  wire axis_register_slice_0_M_AXIS_TVALID;
  wire [255:0]axis_register_slice_0_m_axis_tdata;
  wire enable_0_1;
  wire [4:0]max_0_m_axis_max_TDATA;
  wire max_0_m_axis_max_TLAST;
  wire max_0_m_axis_max_TREADY;
  wire max_0_m_axis_max_TUSER;
  wire max_0_m_axis_max_TVALID;
  wire [607:0]output_store_0_m_axis_all_TDATA;
  wire output_store_0_m_axis_all_TLAST;
  wire output_store_0_m_axis_all_TREADY;
  wire output_store_0_m_axis_all_TUSER;
  wire output_store_0_m_axis_all_TVALID;
  wire [255:0]scalar_divide_const_0_m_axis_TDATA;
  wire scalar_divide_const_0_m_axis_TLAST;
  wire scalar_divide_const_0_m_axis_TREADY;
  wire [4:0]scalar_divide_const_0_m_axis_TUSER;
  wire scalar_divide_const_0_m_axis_TVALID;
  wire [255:0]type_converter_0_m_axis_TDATA;
  wire type_converter_0_m_axis_TLAST;
  wire type_converter_0_m_axis_TREADY;
  wire type_converter_0_m_axis_TUSER;
  wire type_converter_0_m_axis_TVALID;
  wire [31:0]xfft_1_M_AXIS_DATA_TDATA;
  wire xfft_1_M_AXIS_DATA_TLAST;
  wire xfft_1_M_AXIS_DATA_TREADY;
  wire xfft_1_M_AXIS_DATA_TVALID;

  assign Net = reset_b_0;
  assign S_AXIS_DATA_0_1_TDATA = S_AXIS_DATA_0_tdata[31:0];
  assign S_AXIS_DATA_0_1_TLAST = S_AXIS_DATA_0_tlast;
  assign S_AXIS_DATA_0_1_TVALID = S_AXIS_DATA_0_tvalid;
  assign S_AXIS_DATA_0_tready = S_AXIS_DATA_0_1_TREADY;
  assign aclk_0_1 = aclk_0;
  assign enable_0_1 = enable_0;
  assign m_axis_all_0_tdata[607:0] = output_store_0_m_axis_all_TDATA;
  assign m_axis_all_0_tlast = output_store_0_m_axis_all_TLAST;
  assign m_axis_all_0_tuser = output_store_0_m_axis_all_TUSER;
  assign m_axis_all_0_tvalid = output_store_0_m_axis_all_TVALID;
  assign m_axis_max_0_tdata[4:0] = max_0_m_axis_max_TDATA;
  assign m_axis_max_0_tlast = max_0_m_axis_max_TLAST;
  assign m_axis_max_0_tuser = max_0_m_axis_max_TUSER;
  assign m_axis_max_0_tvalid = max_0_m_axis_max_TVALID;
  assign max_0_m_axis_max_TREADY = m_axis_max_0_tready;
  assign output_store_0_m_axis_all_TREADY = m_axis_all_0_tready;
  Hilbert_imp_QP5DCK Hilbert
       (.M_AXIS_DATA_tdata(xfft_1_M_AXIS_DATA_TDATA),
        .M_AXIS_DATA_tlast(xfft_1_M_AXIS_DATA_TLAST),
        .M_AXIS_DATA_tready(xfft_1_M_AXIS_DATA_TREADY),
        .M_AXIS_DATA_tvalid(xfft_1_M_AXIS_DATA_TVALID),
        .S_AXIS_DATA_0_tdata(S_AXIS_DATA_0_1_TDATA),
        .S_AXIS_DATA_0_tlast(S_AXIS_DATA_0_1_TLAST),
        .S_AXIS_DATA_0_tready(S_AXIS_DATA_0_1_TREADY),
        .S_AXIS_DATA_0_tvalid(S_AXIS_DATA_0_1_TVALID),
        .aclk_0(aclk_0_1),
        .reset_b_0(Net));
  P_theta_imp_OCDHGX P_theta
       (.M00_AXIS_tdata(axis_broadcaster_0_M00_AXIS_TDATA),
        .M00_AXIS_tlast(axis_broadcaster_0_M00_AXIS_TLAST),
        .M00_AXIS_tready(axis_broadcaster_0_M00_AXIS_TREADY),
        .M00_AXIS_tuser(axis_broadcaster_0_M00_AXIS_TUSER),
        .M00_AXIS_tvalid(axis_broadcaster_0_M00_AXIS_TVALID),
        .M01_AXIS1_tlast(axis_broadcaster_1_M01_AXIS_TLAST),
        .M01_AXIS1_tuser(axis_broadcaster_1_M01_AXIS_TUSER),
        .M01_AXIS1_tvalid(axis_broadcaster_1_M01_AXIS_TVALID),
        .M01_AXIS_tdata(axis_broadcaster_0_M01_AXIS_TDATA),
        .M01_AXIS_tlast(axis_broadcaster_0_M01_AXIS_TLAST),
        .M01_AXIS_tready(axis_broadcaster_0_M01_AXIS_TREADY),
        .M01_AXIS_tuser(axis_broadcaster_0_M01_AXIS_TUSER),
        .M01_AXIS_tvalid(axis_broadcaster_0_M01_AXIS_TVALID),
        .M02_AXIS_tlast(axis_broadcaster_1_M02_AXIS_TLAST),
        .M02_AXIS_tuser(axis_broadcaster_1_M02_AXIS_TUSER),
        .M02_AXIS_tvalid(axis_broadcaster_1_M02_AXIS_TVALID),
        .aclk_0(aclk_0_1),
        .enable_0(enable_0_1),
        .reset_b_0(Net),
        .s_axis_a_tdata(scalar_divide_const_0_m_axis_TDATA),
        .s_axis_a_tlast(scalar_divide_const_0_m_axis_TLAST),
        .s_axis_a_tready(scalar_divide_const_0_m_axis_TREADY),
        .s_axis_a_tuser(scalar_divide_const_0_m_axis_TUSER),
        .s_axis_a_tvalid(scalar_divide_const_0_m_axis_TVALID));
  RXX_imp_LNXWA8 RXX
       (.aclk_0(aclk_0_1),
        .channel_3_base(axis_register_slice_0_m_axis_tdata),
        .enable_0(enable_0_1),
        .m_axis_tdata(scalar_divide_const_0_m_axis_TDATA),
        .m_axis_tlast(scalar_divide_const_0_m_axis_TLAST),
        .m_axis_tready(scalar_divide_const_0_m_axis_TREADY),
        .m_axis_tuser(scalar_divide_const_0_m_axis_TUSER),
        .m_axis_tvalid(scalar_divide_const_0_m_axis_TVALID),
        .reset_b_0(Net),
        .s_axis_tlast(axis_register_slice_0_M_AXIS_TLAST),
        .s_axis_tready(axis_register_slice_0_M_AXIS_TREADY),
        .s_axis_tuser(axis_register_slice_0_M_AXIS_TUSER),
        .s_axis_tvalid(axis_register_slice_0_M_AXIS_TVALID));
  design_1_axis_register_slice_0_1 axis_register_slice_0
       (.aclk(aclk_0_1),
        .aresetn(Net),
        .m_axis_tdata(axis_register_slice_0_m_axis_tdata),
        .m_axis_tlast(axis_register_slice_0_M_AXIS_TLAST),
        .m_axis_tready(axis_register_slice_0_M_AXIS_TREADY),
        .m_axis_tuser(axis_register_slice_0_M_AXIS_TUSER),
        .m_axis_tvalid(axis_register_slice_0_M_AXIS_TVALID),
        .s_axis_tdata(type_converter_0_m_axis_TDATA),
        .s_axis_tlast(type_converter_0_m_axis_TLAST),
        .s_axis_tready(type_converter_0_m_axis_TREADY),
        .s_axis_tuser(type_converter_0_m_axis_TUSER),
        .s_axis_tvalid(type_converter_0_m_axis_TVALID));
  design_1_max_0_0 max_0
       (.clk(aclk_0_1),
        .m_axis_max_tdata(max_0_m_axis_max_TDATA),
        .m_axis_max_tlast(max_0_m_axis_max_TLAST),
        .m_axis_max_tready(max_0_m_axis_max_TREADY),
        .m_axis_max_tuser(max_0_m_axis_max_TUSER),
        .m_axis_max_tvalid(max_0_m_axis_max_TVALID),
        .reset_n(Net),
        .s_axis_theta_tdata({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_theta_tlast(axis_broadcaster_1_M02_AXIS_TLAST),
        .s_axis_theta_tuser(axis_broadcaster_1_M02_AXIS_TUSER),
        .s_axis_theta_tvalid(axis_broadcaster_1_M02_AXIS_TVALID),
        .s_axis_weight_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,axis_broadcaster_0_M01_AXIS_TDATA}),
        .s_axis_weight_tlast(axis_broadcaster_0_M01_AXIS_TLAST),
        .s_axis_weight_tready(axis_broadcaster_0_M01_AXIS_TREADY),
        .s_axis_weight_tuser(axis_broadcaster_0_M01_AXIS_TUSER[0]),
        .s_axis_weight_tvalid(axis_broadcaster_0_M01_AXIS_TVALID));
  design_1_output_store_0_0 output_store_0
       (.clk(aclk_0_1),
        .m_axis_all_tdata(output_store_0_m_axis_all_TDATA),
        .m_axis_all_tlast(output_store_0_m_axis_all_TLAST),
        .m_axis_all_tready(output_store_0_m_axis_all_TREADY),
        .m_axis_all_tuser(output_store_0_m_axis_all_TUSER),
        .m_axis_all_tvalid(output_store_0_m_axis_all_TVALID),
        .reset_n(Net),
        .s_axis_theta_tdata({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_theta_tlast(axis_broadcaster_1_M01_AXIS_TLAST),
        .s_axis_theta_tuser(axis_broadcaster_1_M01_AXIS_TUSER),
        .s_axis_theta_tvalid(axis_broadcaster_1_M01_AXIS_TVALID),
        .s_axis_weight_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,axis_broadcaster_0_M00_AXIS_TDATA}),
        .s_axis_weight_tlast(axis_broadcaster_0_M00_AXIS_TLAST),
        .s_axis_weight_tready(axis_broadcaster_0_M00_AXIS_TREADY),
        .s_axis_weight_tuser(axis_broadcaster_0_M00_AXIS_TUSER[0]),
        .s_axis_weight_tvalid(axis_broadcaster_0_M00_AXIS_TVALID));
  design_1_type_converter_0_0 type_converter_0
       (.clk(aclk_0_1),
        .m_axis_tdata(type_converter_0_m_axis_TDATA),
        .m_axis_tlast(type_converter_0_m_axis_TLAST),
        .m_axis_tready(type_converter_0_m_axis_TREADY),
        .m_axis_tuser(type_converter_0_m_axis_TUSER),
        .m_axis_tvalid(type_converter_0_m_axis_TVALID),
        .reset_n(Net),
        .s_axis_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,xfft_1_M_AXIS_DATA_TDATA}),
        .s_axis_tlast(xfft_1_M_AXIS_DATA_TLAST),
        .s_axis_tready(xfft_1_M_AXIS_DATA_TREADY),
        .s_axis_tuser(1'b0),
        .s_axis_tvalid(xfft_1_M_AXIS_DATA_TVALID));
endmodule
