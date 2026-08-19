`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/17/2026 05:12:27 PM
// Design Name: 
// Module Name: steering_vector_generator
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


module steering_vector_generator(
	input clk,
	input reset_n,
	
	input[15:0] s_axis_theta_tdata,
	input s_axis_theta_tvalid,
	input s_axis_theta_tlast,
	output s_axis_theta_tready,
	
	input[15:0] s_axis_freq_tdata,
	input s_axis_freq_tvalid,
	output s_axis_freq_tready,
	
	output[15:0] m_axis_tdata,
	output m_axis_tvalid,
	input m_axis_tready

    );
	
	
	reg [15:0] max_freq;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			max_freq<=0;
		end else begin
			if(s_axis_freq_tvalid) max_freq<=s_axis_freq_tdata;
		end
	end
	
	
//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
//complex_exponential your_instance_name (
//  .aclk(aclk),                                // input wire aclk
//  .aresetn(aresetn),                          // input wire aresetn
//  
//  .s_axis_phase_tvalid(s_axis_phase_tvalid),  // input wire s_axis_phase_tvalid
//  .s_axis_phase_tready(s_axis_phase_tready),  // output wire s_axis_phase_tready
//  .s_axis_phase_tdata(s_axis_phase_tdata),    // input wire [15 : 0] s_axis_phase_tdata
//  .s_axis_phase_tlast(s_axis_phase_tlast),    // input wire s_axis_phase_tlast
//  
//  .m_axis_data_tvalid(m_axis_data_tvalid),    // output wire m_axis_data_tvalid
//  .m_axis_data_tready(m_axis_data_tready),    // input wire m_axis_data_tready
//  .m_axis_data_tdata(m_axis_data_tdata),      // output wire [31 : 0] m_axis_data_tdata
//  .m_axis_data_tlast(m_axis_data_tlast)      // output wire m_axis_data_tlast
//);
// INST_TAG_END ------ End INSTANTIATION Template ---------

	
//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
cosine_generator your_instance_name (
  .aclk(clk),                                // input wire aclk
  .aresetn(reset_n),                          // input wire aresetn
  
  .s_axis_phase_tvalid(s_axis_theta_tvalid),  // input wire s_axis_phase_tvalid
  .s_axis_phase_tready(s_axis_theta_tready),  // output wire s_axis_phase_tready
  .s_axis_phase_tdata(s_axis_theta_tdata),    // input wire [15 : 0] s_axis_phase_tdata
  
  .m_axis_data_tvalid(m_axis_tvalid),    // output wire m_axis_data_tvalid
  .m_axis_data_tready(m_axis_tready),    // input wire m_axis_data_tready
  .m_axis_data_tdata(m_axis_tdata)      // output wire [15 : 0] m_axis_data_tdata
);
// INST_TAG_END ------ End INSTANTIATION Template ---------
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
endmodule
