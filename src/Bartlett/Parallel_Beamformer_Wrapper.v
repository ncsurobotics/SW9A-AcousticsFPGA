`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2026 03:12:26 PM
// Design Name: 
// Module Name: Parallel_Beamformer_Wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "constants.vh"
// generates the steering vector for angle theta
module Parallel_Beamformer_Wrapper #(
	parameter THETA_WIDTH = 16,
	parameter NUM_SIZE = 16,
	parameter LATENCY = 7
)(
	input clk,
	input reset_n,
	
	input[THETA_WIDTH-1:0] s_axis_theta_tdata, 
	input s_axis_theta_tvalid, s_axis_theta_tlast,
	output s_axis_theta_tready,
	
	input[1:0] beam_freq,
	
	output[NUM_SIZE*`HYDROPHONE_COUNT-1:0] m_axis_tdata,
	output[THETA_WIDTH -1 : 0] m_axis_tuser,
	output m_axis_tvalid, m_axis_tlast,
	input m_axis_tready
	
    );
	assign m_axis_tuser = 0;
	
	shift_register #(
		.SIZE(2),
		.STAGES(LATENCY)
		) axis_sr(
		.clk(clk),
		.reset_n(reset_n),
		.enable(1),
		.din({s_axis_theta_tvalid,s_axis_theta_tlast}),
		.dout({m_axis_tvalid,m_axis_tlast})
		);
	assign s_axis_theta_tready = m_axis_tready;

	  Parallel_Beamformer Parallel_Beamformer_inst (
		   .clk(clk),
           .reset(reset_n),
           .clk_enable(1),
           .Theta(0),
           .Frequency(0),
           .ce_out(),
           .Array_Value_re_0(m_axis_tdata[ NUM_SIZE*0 +: NUM_SIZE/2]),
           .Array_Value_re_1(m_axis_tdata[ NUM_SIZE*1 +: NUM_SIZE/2]),
           .Array_Value_re_2(m_axis_tdata[ NUM_SIZE*2 +: NUM_SIZE/2]),
           .Array_Value_re_3(m_axis_tdata[ NUM_SIZE*3 +: NUM_SIZE/2]),
           .Array_Value_re_4(m_axis_tdata[ NUM_SIZE*4 +: NUM_SIZE/2]),
           .Array_Value_re_5(m_axis_tdata[ NUM_SIZE*5 +: NUM_SIZE/2]),
           .Array_Value_im_0(m_axis_tdata[NUM_SIZE/2 + NUM_SIZE*0 +: NUM_SIZE/2]),
           .Array_Value_im_1(m_axis_tdata[NUM_SIZE/2 + NUM_SIZE*1 +: NUM_SIZE/2]),
           .Array_Value_im_2(m_axis_tdata[NUM_SIZE/2 + NUM_SIZE*2 +: NUM_SIZE/2]),
           .Array_Value_im_3(m_axis_tdata[NUM_SIZE/2 + NUM_SIZE*3 +: NUM_SIZE/2]),
           .Array_Value_im_4(m_axis_tdata[NUM_SIZE/2 + NUM_SIZE*4 +: NUM_SIZE/2]),
           .Array_Value_im_5(m_axis_tdata[NUM_SIZE/2 + NUM_SIZE*5 +: NUM_SIZE/2])
		   );

endmodule
