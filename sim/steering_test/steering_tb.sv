`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/17/2026 05:22:57 PM
// Design Name: 
// Module Name: steering_tb
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


module steering_tb();

logic clk, reset_n;
logic svalid, sready;
logic[15:0] sdata;

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
steering_vector_generator dut (
  .clk(clk),                                // input wire aclk
  .reset_n(reset_n),                          // input wire aresetn
  
  .s_axis_theta_tvalid(svalid),  // input wire s_axis_phase_tvalid
  .s_axis_theta_tready(sready),  // output wire s_axis_phase_tready
  .s_axis_theta_tdata(sdata),    // input wire [15 : 0] s_axis_phase_tdata
  
  .m_axis_tvalid(),    // output wire m_axis_data_tvalid
  .m_axis_tready(1),    // input wire m_axis_data_tready
  .m_axis_tdata()      // output wire [15 : 0] m_axis_data_tdata
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

always #5 clk = ~clk;
	
task Init();
	clk = 1;
	reset_n = 0;
	svalid = 0; sdata = 0;
	#100
	reset_n = 1;
endtask
	
initial begin
	Init();
	while(sdata!=16'hFFFF)begin
		#10;
		svalid = 1;
		if(sready) sdata=sdata+1;
	end
	$finish();
	
end




endmodule
