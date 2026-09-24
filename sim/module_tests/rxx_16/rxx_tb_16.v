`timescale 1ns/1ps



`define COLUMNS 256
`define ROWS 4

`define CHANNELPATH0 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/rxx_16/test_5/channel1.txt"
`define CHANNELPATH1 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/rxx_16/test_5/channel2.txt"
`define CHANNELPATH2 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/rxx_16/test_5/channel3.txt"
`define CHANNELPATH3 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/rxx_16/test_5/channel4.txt"
`define RESULT_PATH  	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/rxx_16/test_5/verilog_result.txt"
`define READABLE_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/rxx_16/test_5/readable_result.txt"



module rxx_tb_16();
localparam NUM_SIZE = 32;
	


rxx #(
.NUM_SIZE(NUM_SIZE)
) dut(
.clk(clk),
.reset_n(reset_n),
.clken(clken),

.s_axis_tdata(s_axis_tdata),
.s_axis_tvalid(s_axis_tvalid),
.s_axis_tuser(s_axis_tuser),
.s_axis_tready(s_axis_tready),
.s_axis_tlast(s_axis_tlast),

.m_axis_tready(m_axis_tready),
.m_axis_tuser(m_axis_tuser),
.m_axis_tvalid(m_axis_tvalid),
.m_axis_tdata(m_axis_tdata),
.m_axis_tlast(m_axis_tlast)
);
	
	
	

integer index;
reg clk, reset_n, clken;
reg  clk, reset_n, clken, s_axis_tvalid, s_axis_tlast, s_axis_tuser, m_axis_tready;
wire s_axis_tready, m_axis_tlast, m_axis_tvalid;
wire[1:0] m_axis_tuser;
reg[NUM_SIZE - 1:0] channel_0[`COLUMNS:0], channel_1[`COLUMNS:0], channel_2[`COLUMNS:0], channel_3[`COLUMNS:0];
reg[NUM_SIZE * `ROWS - 1:0] s_axis_tdata;
wire[NUM_SIZE * 2 * `ROWS * `ROWS - 1:0] m_axis_tdata;




task initMemory;
begin
	$readmemh(`CHANNELPATH0,channel_0);
	$readmemh(`CHANNELPATH1,channel_1);
	$readmemh(`CHANNELPATH2,channel_2);
	$readmemh(`CHANNELPATH3,channel_3);
end
endtask


integer i;
task sendMemory;
	for(i = 0; i < `COLUMNS + 1; i = i + 1)begin
		#10 index = index + 1;
	end
endtask


integer resultCount = 0;
integer resultFile;
task saveResults;
begin
	resultFile = $fopen(`RESULT_PATH,"w");
	$fwrite(resultFile, "%h %h %h %h\n", m_axis_tdata[NUM_SIZE * 2 * (0 * `ROWS + 0)+: NUM_SIZE * 2], m_axis_tdata[NUM_SIZE * 2 * (0 * `ROWS + 1)+: NUM_SIZE * 2], m_axis_tdata[NUM_SIZE * 2 * (0 * `ROWS + 2)+: NUM_SIZE * 2], m_axis_tdata[NUM_SIZE * 2 * (0 * `ROWS + 3)+: NUM_SIZE * 2]);
	$fwrite(resultFile,"%h %h %h %h\n", m_axis_tdata[NUM_SIZE * 2 * (1 * `ROWS + 0)+: NUM_SIZE * 2], m_axis_tdata[NUM_SIZE * 2 * (1 * `ROWS + 1)+: NUM_SIZE * 2], m_axis_tdata[NUM_SIZE * 2 * (1 * `ROWS + 2)+: NUM_SIZE * 2], m_axis_tdata[NUM_SIZE * 2 * (1 * `ROWS + 3)+: NUM_SIZE * 2]);
	$fwrite(resultFile,"%h %h %h %h\n", m_axis_tdata[NUM_SIZE * 2 * (2 * `ROWS + 0)+: NUM_SIZE * 2], m_axis_tdata[NUM_SIZE * 2 * (2 * `ROWS + 1)+: NUM_SIZE * 2], m_axis_tdata[NUM_SIZE * 2 * (2 * `ROWS + 2)+: NUM_SIZE * 2], m_axis_tdata[NUM_SIZE * 2 * (2 * `ROWS + 3)+: NUM_SIZE * 2]);
	$fwrite(resultFile,"%h %h %h %h\n", m_axis_tdata[NUM_SIZE * 2 * (3 * `ROWS + 0)+: NUM_SIZE * 2], m_axis_tdata[NUM_SIZE * 2 * (3 * `ROWS + 1)+: NUM_SIZE * 2], m_axis_tdata[NUM_SIZE * 2 * (3 * `ROWS + 2)+: NUM_SIZE * 2], m_axis_tdata[NUM_SIZE * 2 * (3 * `ROWS + 3)+: NUM_SIZE * 2]);
	$fclose(resultFile);
	resultFile = $fopen(`READABLE_PATH,"w");
	$fwrite(resultFile, "%d + j%d \t %d + j%d \t %d + j%d \t %d + j%d \n", 	$signed(m_axis_tdata[NUM_SIZE * 2 * (0 * `ROWS + 0)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (0 * `ROWS + 0) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]), 
																			$signed(m_axis_tdata[NUM_SIZE * 2 * (0 * `ROWS + 1)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (0 * `ROWS + 1) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]), 
																			$signed(m_axis_tdata[NUM_SIZE * 2 * (0 * `ROWS + 2)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (0 * `ROWS + 2) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]), 
																			$signed(m_axis_tdata[NUM_SIZE * 2 * (0 * `ROWS + 3)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (0 * `ROWS + 3) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]));
	$fwrite(resultFile, "%d + j%d \t %d + j%d \t %d + j%d \t %d + j%d \n", 	$signed(m_axis_tdata[NUM_SIZE * 2 * (1 * `ROWS + 0)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (1 * `ROWS + 0) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]), 
																			$signed(m_axis_tdata[NUM_SIZE * 2 * (1 * `ROWS + 1)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (1 * `ROWS + 1) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]), 
																			$signed(m_axis_tdata[NUM_SIZE * 2 * (1 * `ROWS + 2)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (1 * `ROWS + 2) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]), 
																			$signed(m_axis_tdata[NUM_SIZE * 2 * (1 * `ROWS + 3)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (1 * `ROWS + 3) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]));
	$fwrite(resultFile, "%d + j%d \t %d + j%d \t %d + j%d \t %d + j%d \n", 	$signed(m_axis_tdata[NUM_SIZE * 2 * (2 * `ROWS + 0)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (2 * `ROWS + 0) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]), 
																			$signed(m_axis_tdata[NUM_SIZE * 2 * (2 * `ROWS + 1)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (2 * `ROWS + 1) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]), 
																			$signed(m_axis_tdata[NUM_SIZE * 2 * (2 * `ROWS + 2)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (2 * `ROWS + 2) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]), 
																			$signed(m_axis_tdata[NUM_SIZE * 2 * (2 * `ROWS + 3)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (2 * `ROWS + 3) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]));
	$fwrite(resultFile, "%d + j%d \t %d + j%d \t %d + j%d \t %d + j%d \n", 	$signed(m_axis_tdata[NUM_SIZE * 2 * (3 * `ROWS + 0)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (3 * `ROWS + 0) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]), 
																			$signed(m_axis_tdata[NUM_SIZE * 2 * (3 * `ROWS + 1)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (3 * `ROWS + 1) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]), 
																			$signed(m_axis_tdata[NUM_SIZE * 2 * (3 * `ROWS + 2)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (3 * `ROWS + 2) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]), 
																			$signed(m_axis_tdata[NUM_SIZE * 2 * (3 * `ROWS + 3)  +: NUM_SIZE * 2/2] ), $signed(m_axis_tdata[NUM_SIZE * 2 * (3 * `ROWS + 3) + NUM_SIZE * 2/2 +: NUM_SIZE * 2/2]));																			

	$fclose(resultFile);
end
endtask


always #5 clk = ~clk;

always #10 s_axis_tuser = s_axis_tuser + 1;



always@(*)begin
	s_axis_tdata = {channel_3[index], channel_2[index], channel_1[index], channel_0[index]};
	if(index == `COLUMNS - 1) s_axis_tlast = 1;
	if(index == `COLUMNS) begin s_axis_tlast = 0; s_axis_tvalid = 0; end
	if(m_axis_tvalid) saveResults();
	
end



initial begin
clk = 0; clken = 1; reset_n = 0; index = 0; s_axis_tlast = 0; s_axis_tvalid = 0; s_axis_tuser = 0;
channel_3[0] = 0;
channel_2[0] = 0;
channel_1[0] = 0;
channel_0[0] = 0;
#50 m_axis_tready = 1;
#50 reset_n = 1; 
#100 initMemory(); s_axis_tvalid = 1;
#10 sendMemory();

end

	


endmodule
	
	


