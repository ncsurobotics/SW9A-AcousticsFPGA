`timescale 1ns/1ps

`define RXX_MEMORY_PATH "C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/ptheta/test_1/rxx.txt"


module ptheta_tb_2();
localparam NUM_SIZE = 64;

	

integer index;
reg  clk, reset_n, clken;
reg[4 * 4 * NUM_SIZE - 1 : 0] rxx_data;
reg rxx_valid, rxx_last, rxx_user;
wire rxx_ready;

reg[5: 0] theta_data;
reg theta_valid, theta_last, theta_user;
wire theta_ready;

wire[NUM_SIZE * 2 - 1:0] weight_data;
wire weight_last, weight_valid;
wire[5:0] weight_user;
reg weight_ready;


p_theta #(
	.NUM_SIZE(NUM_SIZE)
	) uut(
	.clk(clk),
	.reset_n(reset_n),
	.clken(clken),

    .s_axis_r_tdata(rxx_data),
    .s_axis_r_tvalid(rxx_valid),
    .s_axis_r_tlast(rxx_last),
    .s_axis_r_tuser(rxx_user),
    .s_axis_r_tready(rxx_ready),

    .s_axis_theta_tdata(theta_data),
    .s_axis_theta_tvalid(theta_valid),
    .s_axis_theta_tlast(theta_last),
    .s_axis_theta_tuser(theta_user),
    .s_axis_theta_tready(theta_ready),

    .m_axis_tdata(weight_data),
    .m_axis_tvalid(weight_valid),
    .m_axis_tuser(weight_user),
    .m_axis_tlast(weight_last),
    .m_axis_tready(weight_ready)
	);

always #5 clk = ~clk;


reg inc;

always #10 if(inc) theta_data = (theta_data + 1) % 19;


always@(*)begin

end



initial begin
clk = 0; clken = 1; theta_data = 0; reset_n = 0; index = 0;  rxx_valid = 0; theta_valid = 0; theta_last = 0; rxx_last = 0; rxx_user = 0; theta_user = 0;
rxx_data = 1024'hFFFFFD8100000276FFFFFC720000032C000001BFFFFFFD16FFFFFECF0000033B0000014100000109FFFFFF18FFFFFCDB000000FFFFFFFE45FFFFFC430000005E000003360000039300000259000003A2000001ECFFFFFD5300000273000003AEFFFFFF1600000393000000EBFFFFFFE300000097000002590000003CFFFFFD33; 
inc = 0;

theta_data = 0;
#50 reset_n = 1; 
#50 weight_ready = 1; theta_valid = 1; rxx_valid = 1; 
#10 theta_data = 5'h0;



end

	


endmodule
	
	


