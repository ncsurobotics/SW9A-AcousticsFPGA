`timescale 1ns/1ps


`define INPUT_PATH	 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/scalar_divide/test_2/input.txt"
`define OUTPUT_PATH 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/scalar_divide/test_2/output.txt"
																									  



module scalar_divide_tb();
localparam NUM_SIZE = 32;
	


scalar_divide_const #(
	.MAT_HEIGHT(4),
	.MAT_WIDTH(4),
	.NUM_SIZE(NUM_SIZE * 2),
	.SCALAR(256)
	) dut(
	.clk(clk),
	.reset_n(reset_n),
	.s_axis_tdata(s_axis_tdata),
	.m_axis_tdata(m_axis_tdata),
	.s_axis_tvalid(1),
	.m_axis_tready(1)
	);
	
	
reg  clk, reset_n, clken, s_axis_tvalid, s_axis_tlast, s_axis_tuser, m_axis_tready;
wire s_axis_tready, m_axis_tlast, m_axis_tvalid;
wire[1:0] m_axis_tuser;
reg[NUM_SIZE * 2- 1:0] memory[15:0];
reg[NUM_SIZE * 2 * 16 - 1:0] s_axis_tdata;
wire[NUM_SIZE * 16 - 1:0] m_axis_tdata;




task initMemory;
begin
	$readmemh(`INPUT_PATH,memory);
end
endtask


integer i;
integer resultFile;
task saveResults;
begin
	resultFile = $fopen(`OUTPUT_PATH,"w");
	for(i = 0; i < 16; i = i + 1)begin
		$fwrite(resultFile,"%h\n",m_axis_tdata[NUM_SIZE * i +: NUM_SIZE]);
	end	
	$fclose(resultFile);

end
endtask


always #5 clk = ~clk;

always #10 s_axis_tuser = s_axis_tuser + 1;



always@(*)begin
	for(i = 0; i < 16; i = i + 1)begin
		s_axis_tdata[NUM_SIZE * 2 * i +: NUM_SIZE * 2] = memory[i];
	end	
end



initial begin
clk = 0; reset_n = 0;
#10 reset_n = 1; 
#10 initMemory(); 
#20 saveResults();

end

	


endmodule
	
	


