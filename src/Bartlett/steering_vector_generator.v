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






// Generates the steering vector for angle theta with the last inputted frequency. 
// Based on the frequency being used, the size of the cone that is searched should change.That is external to this module
// The formula is e^jkd, where k = 2pi*f_signal/c, and d = cos(theta)*h_x + sin(theta)*h_y
// h_x,h_y are the coordinates for that hydrophone
// c is the constant propagation speed of sound in water (1480 meters/second)
// k units are: dd [meters] * j * cos(theta) * freq [1/second] * 2pi [radians] / c [meters/second] == radians
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
	
	// stores the frequency used to compute other constants
	
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

	
// With 16 bit theta, divide theta by 0.0055 to get its fixed point equivalent.
// Ex: 90 degrees -> 90/0.0055 == 16,364. 
// 16,364 * 0.0055 == 90.0020. Small error, negligible.
// This value comes from 360 degrees divided by 65536 range.
// 1 degree -> 181.8182
// range of theta values: 0=0, 65536=2pi
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
// m_axis valid range from -1 = -32,768, 1 = 32,768
// 
	
	
	
	
	
	// TODO figure out how to get fixed point stuff to work
	// Easiest solution: create LUT for all of the frequency/dd constants
	
	
	
	
	
	
	
endmodule
