`timescale 1ns / 1ps

`define COLUMNS 256
`define ROWS 4

`define NUM_SIZE 32

`define CHANNELPATH0 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_1/channel1.txt"
`define CHANNELPATH1 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_1/channel2.txt"
`define CHANNELPATH2 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_1/channel3.txt"
`define CHANNELPATH3 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_1/channel4.txt"
`define RESULT_PATH  	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_1/verilog_result.txt"
`define READABLE_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_1/readable_result.txt"


module bartlett_time_domain_tb();


wire[`NUM_SIZE-1:0] channel_0_base, channel_1_base, channel_2_base, channel_3_base;
reg  clk, reset_n;
wire[`MATRIX_SIZE * `NUM_SIZE - 1 : 0] s_axis_fft_data = {channel_3_base,channel_2_base,channel_1_base,channel_0_base};
reg s_axis_fft_tvalid, s_axis_fft_tlast, s_axis_fft_tuser;
reg [$clog2(`THETA_COUNT) - 1: 0] s_axis_theta_tdata;
reg s_axis_theta_tvalid, s_axis_theta_tlast, s_axis_theta_tuser;


bartlett_time_domain #(.NUM_SIZE(`NUM_SIZE))
bartlett_time_domain_inst(
 .clk(clk),           //input
 .reset_n(reset_n),   //input
 .clken(clken),       //input
 
    .s_axis_fft_tdata(s_axis_fft_tdata),
    .s_axis_fft_tvalid(s_axis_fft_tvalid),
    .s_axis_fft_tlast(s_axis_fft_tlast),
    .s_axis_fft_tuser(s_axis_fft_tuser),
    .s_axis_fft_tready(s_axis_fft_tready),	
	
	.s_axis_theta_tdata(s_axis_theta_tdata),
    .s_axis_theta_tvalid(s_axis_theta_tvalid),
    .s_axis_theta_tlast(s_axis_theta_tlast),
    .s_axis_theta_tuser(s_axis_theta_tuser),
    .s_axis_theta_tready(s_axis_theta_tready)
 );

integer index;
reg[`NUM_SIZE - 1:0] channel_0[`COLUMNS:0], channel_1[`COLUMNS:0], channel_2[`COLUMNS:0], channel_3[`COLUMNS:0];

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

end
endtask


always #5 clk = ~clk;

always@(*)begin

	channel_0_base = channel_0[index]; 
	channel_1_base = channel_1[index]; 
	channel_2_base = channel_2[index]; 
	channel_3_base = channel_3[index]; 
	
	if(index == `COLUMNS - 1) s_axis_tlast = 1;
	if(index == `COLUMNS) begin s_axis_tlast = 0; s_axis_tvalid = 0; end
	if(m_axis_dout_tvalid) saveResults();
	
end



initial begin
clk = 0; clken = 1; reset_n = 0; index = 0; s_axis_tlast = 0; s_axis_tvalid = 0; s_axis_tuser = 0;
#10 m_axis_dout_tready = 1;
#150 reset_n = 1;
#10 initMemory(); s_axis_tvalid = 1; 
#10 sendMemory();

end

	


endmodule
	
	


