`timescale 1ns/1ps



`define ROWS 4

`define RESULT_PATH  	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/rxx/test_3/verilog_result.txt"
`define READABLE_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/rxx/test_3/readable_result.txt"



module matrix_accumulator_no_latency_tb();
localparam NUM_SIZE = 64;
	
matrix_accumulator_no_latency #(
	.NUM_SIZE(NUM_SIZE)
	) 
matrix_accumulator_no_latency_inst (
	.clk(clk),
	.reset_n(reset_n),
	
	.s_axis_tdata(s_axis_tdata),
	.s_axis_tvalid(s_axis_tvalid),
	.s_axis_tlast(s_axis_tlast),
	.s_axis_tuser(s_axis_tuser),
	.s_axis_tready(s_axis_tready),
	
	
	.m_axis_tdata(m_axis_tdata),
	.m_axis_tvalid(m_axis_tvalid),
	.m_axis_tlast(m_axis_tlast),
	.m_axis_tuser(m_axis_tuser),
	.m_axis_tready(m_axis_tready)
	);

integer index;
reg  clk, reset_n, clken, s_axis_tvalid, s_axis_tlast, s_axis_tuser, m_axis_tready;
wire s_axis_tready, m_axis_tlast, m_axis_tvalid;
wire[1:0] m_axis_tuser;
reg[NUM_SIZE * `ROWS * `ROWS - 1:0] s_axis_tdata;
wire[NUM_SIZE - 1:0] m_axis_tdata;



reg[NUM_SIZE-1:0] i;
task initMemory;
begin
	s_axis_tdata = 1024'h0000000000514a00fffc8c00ff254400fffb0c0000d12e0000032e00ff2f280000037400ff254400000000000042ec000003fc00ff970e00ffff9400ff58b8000004f40000d12e00fffc0400ff970e0000000000ff9a8e00000bbc0000612e00fffcd200008f280000006c00ff58b800fff4440000612e0000000000ff045800;

end
endtask



task sendMemory;

endtask


integer resultCount = 0;
integer resultFile;
task saveResults;
begin

end
endtask


always #5 clk = ~clk;

always #10 s_axis_tuser = s_axis_tuser + 1;



always@(*)begin
	if(m_axis_tvalid) saveResults();

end



initial begin
clk = 0; clken = 1; reset_n = 0; index = 0; s_axis_tlast = 0; s_axis_tvalid = 0; s_axis_tuser = 0;

#50 m_axis_tready = 1;
#50 reset_n = 1; 
#100 initMemory(); s_axis_tvalid = 1;
#10 sendMemory();

end

	


endmodule
	
	


