`timescale 1ns/1ps



`define ROWS 4

`define RESULT_PATH  	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/rxx/test_3/verilog_result.txt"
`define READABLE_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/rxx/test_3/readable_result.txt"



module type_converter_tb();
localparam INT_SIZE = 32;
localparam INT_COUNT = 31;
	

type_converter #(
	.INT_SIZE(INT_SIZE),
	.INT_COUNT(INT_COUNT)
	) dut(
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
reg[INT_SIZE * INT_COUNT - 1:0] s_axis_tdata;
wire[INT_SIZE * INT_COUNT - 1:0] m_axis_tdata;

reg[INT_SIZE - 1:0] fractions[INT_COUNT - 1:0];
reg[INT_SIZE - 1:0] expected[INT_COUNT - 1:0];
reg[INT_SIZE - 1:0] converted[INT_COUNT - 1:0];

integer i;
task initMemory;
begin
	for(i = 0; i < INT_COUNT; i = i + 1)begin
		fractions[i] = {1'b0,{31'd1}<<i}; // each bit combination
		expected[i] = (2**(INT_SIZE - i));
	end
end
endtask

task negativeMemory;
begin
	for(i = 0; i < INT_COUNT; i = i + 1)begin
		fractions[i] = {1'b1,{31'd1}<<i}; // each bit combination
		expected[i] = -(2**(INT_SIZE - i));
	end
end
endtask



always #5 clk = ~clk;

always #10 s_axis_tuser = s_axis_tuser + 1;



always@(*)begin
	for(i = 0; i < INT_COUNT; i = i + 1)begin
		s_axis_tdata[i * INT_SIZE +: INT_SIZE] = fractions[i];
		converted[i] = m_axis_tdata[i * INT_SIZE +: INT_SIZE];
	end
end



initial begin
clk = 0; clken = 1; reset_n = 0; index = 0; s_axis_tlast = 0; s_axis_tvalid = 0; s_axis_tuser = 0;
#50 m_axis_tready = 1;
#50 reset_n = 1; 
#100 initMemory(); s_axis_tvalid = 1;
#10 negativeMemory();

end

	


endmodule
	
	


