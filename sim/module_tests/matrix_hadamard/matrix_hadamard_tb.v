`timescale 1ns/1ps



`define MATRIX_SIZE 4

`define MATRIX_1_PATH 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/matrix_hadamard/test_5/matrix_1.txt"
`define MATRIX_2_PATH 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/matrix_hadamard/test_5/matrix_2.txt"
`define RESULT_PATH  	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/matrix_hadamard/test_5/verilog_result.txt"
`define READABLE_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/matrix_hadamard/test_5/readable_result.txt"



module complex_matrix_hadamard_tb();
localparam NUM_SIZE = 32;
	

complex_matrix_hadamard #(
	.NUM_SIZE(NUM_SIZE),
	.WIDTH(`MATRIX_SIZE),
	.HEIGHT(`MATRIX_SIZE)
	) 
complex_matrix_hadamard_inst (
	.clk(clk),
	.reset_n(reset_n),
	.clken(clken),
	
	.s_axis_a_tdata(s_axis_r_tdata),
	.s_axis_a_tvalid(s_axis_r_tvalid),
	.s_axis_a_tlast(s_axis_r_tlast),
	.s_axis_a_tuser(s_axis_r_tuser),
	.s_axis_a_tready(s_axis_r_tready),
	
	.s_axis_b_tdata(s_axis_theta_tdata),
	.s_axis_b_tvalid(s_axis_theta_tvalid),
	.s_axis_b_tlast(s_axis_theta_tlast),
	.s_axis_b_tuser(s_axis_theta_tuser),
	.s_axis_b_tready(s_axis_theta_tready),

	
	.m_axis_tdata(m_axis_tdata),
	.m_axis_tvalid(m_axis_tvalid),
	.m_axis_tlast(m_axis_tlast),
	.m_axis_tuser(m_axis_tuser),
	.m_axis_tready(m_axis_tready)
	);
	
	
	
	

integer index;
reg clk, reset_n, clken;


reg s_axis_r_tvalid, s_axis_r_tlast, s_axis_r_tuser;
wire s_axis_r_tready;

reg s_axis_theta_tvalid, s_axis_theta_tlast, s_axis_theta_tuser;
wire s_axis_theta_tready;

reg m_axis_tready;
wire m_axis_tlast, m_axis_tvalid;
wire[1:0] m_axis_tuser;

reg[NUM_SIZE - 1:0] matrix_1[`MATRIX_SIZE * `MATRIX_SIZE - 1:0], matrix_2[`MATRIX_SIZE * `MATRIX_SIZE - 1:0];
reg[NUM_SIZE * `MATRIX_SIZE * `MATRIX_SIZE - 1:0] s_axis_r_tdata, s_axis_theta_tdata;
wire[2 * NUM_SIZE * `MATRIX_SIZE * `MATRIX_SIZE - 1:0] m_axis_tdata;



task initMemory;
begin
	s_axis_r_tdata = 512'h0000822c05decf690036ac5c0197b86cfa22cf690000cd4701fe3479027a6897ffcaac5cfe02347900002176fe466d5efe69686cfd86689701ba6d5e000028a5; 
	s_axis_theta_tdata = 512'h000004000000FC00000004000000FC000000FC00000004000000FC0000000400000004000000FC00000004000000FC000000FC00000004000000FC0000000400;
end
endtask


integer i;
task sendMemory;

endtask


integer resultCount = 0;
integer resultFile;
task saveResults;
begin
	resultFile = $fopen(`RESULT_PATH,"w");
	$fwrite(resultFile, "%h %h %h %h\n", m_axis_tdata[2 * NUM_SIZE * (0 * `MATRIX_SIZE + 0)+: 2 * NUM_SIZE], m_axis_tdata[2 * NUM_SIZE * (0 * `MATRIX_SIZE + 1)+: 2 * NUM_SIZE], m_axis_tdata[2 * NUM_SIZE * (0 * `MATRIX_SIZE + 2)+: 2 * NUM_SIZE], m_axis_tdata[2 * NUM_SIZE * (0 * `MATRIX_SIZE + 3)+: 2 * NUM_SIZE]);
	$fwrite(resultFile,"%h %h %h %h\n",  m_axis_tdata[2 * NUM_SIZE * (1 * `MATRIX_SIZE + 0)+: 2 * NUM_SIZE], m_axis_tdata[2 * NUM_SIZE * (1 * `MATRIX_SIZE + 1)+: 2 * NUM_SIZE], m_axis_tdata[2 * NUM_SIZE * (1 * `MATRIX_SIZE + 2)+: 2 * NUM_SIZE], m_axis_tdata[2 * NUM_SIZE * (1 * `MATRIX_SIZE + 3)+: 2 * NUM_SIZE]);
	$fwrite(resultFile,"%h %h %h %h\n",  m_axis_tdata[2 * NUM_SIZE * (2 * `MATRIX_SIZE + 0)+: 2 * NUM_SIZE], m_axis_tdata[2 * NUM_SIZE * (2 * `MATRIX_SIZE + 1)+: 2 * NUM_SIZE], m_axis_tdata[2 * NUM_SIZE * (2 * `MATRIX_SIZE + 2)+: 2 * NUM_SIZE], m_axis_tdata[2 * NUM_SIZE * (2 * `MATRIX_SIZE + 3)+: 2 * NUM_SIZE]);
	$fwrite(resultFile,"%h %h %h %h\n",  m_axis_tdata[2 * NUM_SIZE * (3 * `MATRIX_SIZE + 0)+: 2 * NUM_SIZE], m_axis_tdata[2 * NUM_SIZE * (3 * `MATRIX_SIZE + 1)+: 2 * NUM_SIZE], m_axis_tdata[2 * NUM_SIZE * (3 * `MATRIX_SIZE + 2)+: 2 * NUM_SIZE], m_axis_tdata[2 * NUM_SIZE * (3 * `MATRIX_SIZE + 3)+: 2 * NUM_SIZE]);
	$fclose(resultFile);
	resultFile = $fopen(`READABLE_PATH,"w");
	$fwrite(resultFile, "%d + j%d \t %d + j%d \t %d + j%d \t %d + j%d \n", 	$signed(m_axis_tdata[2 * NUM_SIZE * (0 * `MATRIX_SIZE + 0)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (0 * `MATRIX_SIZE + 0) + NUM_SIZE +: NUM_SIZE]), 
																			$signed(m_axis_tdata[2 * NUM_SIZE * (0 * `MATRIX_SIZE + 1)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (0 * `MATRIX_SIZE + 1) + NUM_SIZE +: NUM_SIZE]), 
																			$signed(m_axis_tdata[2 * NUM_SIZE * (0 * `MATRIX_SIZE + 2)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (0 * `MATRIX_SIZE + 2) + NUM_SIZE +: NUM_SIZE]), 
																			$signed(m_axis_tdata[2 * NUM_SIZE * (0 * `MATRIX_SIZE + 3)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (0 * `MATRIX_SIZE + 3) + NUM_SIZE +: NUM_SIZE]));
	$fwrite(resultFile, "%d + j%d \t %d + j%d \t %d + j%d \t %d + j%d \n", 	$signed(m_axis_tdata[2 * NUM_SIZE * (1 * `MATRIX_SIZE + 0)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (1 * `MATRIX_SIZE + 0) + NUM_SIZE +: NUM_SIZE]), 
																			$signed(m_axis_tdata[2 * NUM_SIZE * (1 * `MATRIX_SIZE + 1)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (1 * `MATRIX_SIZE + 1) + NUM_SIZE +: NUM_SIZE]), 
																			$signed(m_axis_tdata[2 * NUM_SIZE * (1 * `MATRIX_SIZE + 2)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (1 * `MATRIX_SIZE + 2) + NUM_SIZE +: NUM_SIZE]), 
																			$signed(m_axis_tdata[2 * NUM_SIZE * (1 * `MATRIX_SIZE + 3)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (1 * `MATRIX_SIZE + 3) + NUM_SIZE +: NUM_SIZE]));
	$fwrite(resultFile, "%d + j%d \t %d + j%d \t %d + j%d \t %d + j%d \n", 	$signed(m_axis_tdata[2 * NUM_SIZE * (2 * `MATRIX_SIZE + 0)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (2 * `MATRIX_SIZE + 0) + NUM_SIZE +: NUM_SIZE]), 
																			$signed(m_axis_tdata[2 * NUM_SIZE * (2 * `MATRIX_SIZE + 1)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (2 * `MATRIX_SIZE + 1) + NUM_SIZE +: NUM_SIZE]), 
																			$signed(m_axis_tdata[2 * NUM_SIZE * (2 * `MATRIX_SIZE + 2)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (2 * `MATRIX_SIZE + 2) + NUM_SIZE +: NUM_SIZE]), 
																			$signed(m_axis_tdata[2 * NUM_SIZE * (2 * `MATRIX_SIZE + 3)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (2 * `MATRIX_SIZE + 3) + NUM_SIZE +: NUM_SIZE]));
	$fwrite(resultFile, "%d + j%d \t %d + j%d \t %d + j%d \t %d + j%d \n", 	$signed(m_axis_tdata[2 * NUM_SIZE * (3 * `MATRIX_SIZE + 0)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (3 * `MATRIX_SIZE + 0) + NUM_SIZE +: NUM_SIZE]), 
																			$signed(m_axis_tdata[2 * NUM_SIZE * (3 * `MATRIX_SIZE + 1)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (3 * `MATRIX_SIZE + 1) + NUM_SIZE +: NUM_SIZE]), 
																			$signed(m_axis_tdata[2 * NUM_SIZE * (3 * `MATRIX_SIZE + 2)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (3 * `MATRIX_SIZE + 2) + NUM_SIZE +: NUM_SIZE]), 
																			$signed(m_axis_tdata[2 * NUM_SIZE * (3 * `MATRIX_SIZE + 3)  +: NUM_SIZE] ), $signed(m_axis_tdata[2 * NUM_SIZE * (3 * `MATRIX_SIZE + 3) + NUM_SIZE +: NUM_SIZE]));																			

	$fclose(resultFile);
end
endtask


always #5 clk = ~clk;


always@(*)begin
	if(m_axis_tvalid) #10 saveResults();
end

initial begin
clk = 0; clken = 1; reset_n = 0; index = 0; s_axis_r_tvalid = 0;  s_axis_theta_tvalid = 0; 

#50 m_axis_tready = 1;
#50 reset_n = 1; 
#100 initMemory();
#10 sendMemory(); s_axis_r_tvalid = 1;  s_axis_theta_tvalid = 1; 

end

	


endmodule
	
	

