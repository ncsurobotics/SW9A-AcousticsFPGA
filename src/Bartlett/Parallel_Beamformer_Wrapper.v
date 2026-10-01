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
	parameter NUM_SIZE = 32,
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
	
	wire [NUM_SIZE*`HYDROPHONE_COUNT-1:0] fifo_in;
    wire [NUM_SIZE*`HYDROPHONE_COUNT-1:0] fifo_out;
    wire [NUM_SIZE*`HYDROPHONE_COUNT-1:0] beamformer_packed_data;
    wire beamformer_ready;
    wire data_valid;
    wire [16:0] re0, re1, re2, re3, re4, re5;
    wire [16:0] im0, im1, im2, im3, im4, im5;
    wire delayed_tlast;
	
	shift_register #(
		.SIZE(2),
		.STAGES(LATENCY)
		) axis_sr(
		.clk(clk),
		.reset_n(reset_n),
		.enable(beamformer_ready),
		.din({s_axis_theta_tvalid && beamformer_ready, s_axis_theta_tlast && s_axis_theta_tvalid && beamformer_ready}),
		.dout({data_valid,delayed_tlast})
		);
	assign s_axis_theta_tready = beamformer_ready;
	
	
	axis_data_fifo_0 fifo(
	  .s_axis_aresetn(reset_n),
      .s_axis_aclk(clk),
      .s_axis_tvalid(data_valid),
      .s_axis_tready(beamformer_ready),
      .s_axis_tdata(fifo_in),
      .s_axis_tlast(delayed_tlast),
      .m_axis_tvalid(m_axis_tvalid),
      .m_axis_tready(m_axis_tready),
      .m_axis_tdata(fifo_out),
      .m_axis_tlast(m_axis_tlast)
	);
	
	Parallel_Beamformer Parallel_Beamformer_inst (
		   .clk(clk),
           .reset(reset_n),
           .clk_enable(beamformer_ready),
           .Theta(s_axis_theta_tdata),
           .Frequency({6'b0, beam_freq}),
           .ce_out(),
           .Array_Value_re_0(re0),
           .Array_Value_re_1(re1),
           .Array_Value_re_2(re2),
           .Array_Value_re_3(re3),
           .Array_Value_re_4(re4),
           .Array_Value_re_5(re5),
           .Array_Value_im_0(im0),
           .Array_Value_im_1(im1),
           .Array_Value_im_2(im2),
           .Array_Value_im_3(im3),
           .Array_Value_im_4(im4),
           .Array_Value_im_5(im5)
		   );

    assign beamformer_packed_data = {
        im5[16:1], re5[16:1],
        im4[16:1], re4[16:1],
        im3[16:1], re3[16:1],
        im2[16:1], re2[16:1],
        im1[16:1], re1[16:1],
        im0[16:1], re0[16:1]
    };
    
    assign fifo_in = beamformer_packed_data;
    assign m_axis_tdata = fifo_out;

endmodule
