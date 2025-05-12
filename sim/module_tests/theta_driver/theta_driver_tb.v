`timescale 1ns/1ps



module theta_driver_tb();

reg  clk, reset_n, enable;
wire m_axis_theta_tlast, m_axis_theta_tuser, m_axis_theta_tvalid;
wire[4:0] m_axis_theta_tdata;
	
theta_driver theta_driver_inst(
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable),
	
	.m_axis_theta_tdata(m_axis_theta_tdata),
	.m_axis_theta_tlast(m_axis_theta_tlast),
	.m_axis_theta_tvalid(m_axis_theta_tvalid),
	.m_axis_theta_tuser(m_axis_theta_tuser)
	);


always #5 clk = ~clk;


initial begin
clk = 0; reset_n = 0; enable = 0;
#10 reset_n = 1;
#20 enable = 1;
#10 enable = 0;

end

	


endmodule
	
	


