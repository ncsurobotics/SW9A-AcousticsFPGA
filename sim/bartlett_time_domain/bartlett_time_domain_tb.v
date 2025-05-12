`timescale 1ns / 1ps

`define MATRIX_SIZE 4

`define THETA_COUNT 19

`define COLUMNS 256
`define ROWS 4

`define NUM_SIZE 64

`define CHANNELPATH0 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_big_numbers/channel1.txt"
`define CHANNELPATH1 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_big_numbers/channel2.txt"
`define CHANNELPATH2 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_big_numbers/channel3.txt"
`define CHANNELPATH3 	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_big_numbers/channel4.txt"
`define ALL_HEX_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_big_numbers/all_result_hex.txt"
`define MAX_HEX_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_big_numbers/max_result_hex.txt"
`define ALL_DEC_PATH  	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_big_numbers/all_result_dec.txt"
`define MAX_DEC_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_big_numbers/max_result_dec.txt"
`define RXX_HEX_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_big_numbers/rxx_hex.txt"
`define RXX_DEC_PATH  	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_time_domain/test_big_numbers/rxx_dec.txt"



module bartlett_time_domain_tb();


reg[`NUM_SIZE-1:0] channel_0_base, channel_1_base, channel_2_base, channel_3_base;
reg  clk, reset_n, clken;
wire[`MATRIX_SIZE * `NUM_SIZE - 1 : 0] s_axis_fft_tdata = {channel_3_base,channel_2_base,channel_1_base,channel_0_base};
reg s_axis_fft_tvalid, s_axis_fft_tlast, s_axis_fft_tuser;
reg [$clog2(`THETA_COUNT) - 1: 0] s_axis_theta_tdata;
reg s_axis_theta_tvalid, s_axis_theta_tlast, s_axis_theta_tuser;


wire[`NUM_SIZE * 19 - 1:0] m_axis_all_tdata;
wire [$clog2(`THETA_COUNT) - 1: 0] m_axis_max_tdata;
wire [`MATRIX_SIZE * `MATRIX_SIZE * `NUM_SIZE - 1:0] debug_rxx;

bartlett_time_domain #(.NUM_SIZE(`NUM_SIZE))
bartlett_time_domain_inst(
 .clk(clk),           //input
 .reset_n(reset_n),   //input
 
    .s_axis_fft_tdata(s_axis_fft_tdata),
    .s_axis_fft_tvalid(s_axis_fft_tvalid),
    .s_axis_fft_tlast(s_axis_fft_tlast),
    .s_axis_fft_tuser(s_axis_fft_tuser),
    .s_axis_fft_tready(s_axis_fft_tready),	
	
	.s_axis_theta_tdata(s_axis_theta_tdata),
    .s_axis_theta_tvalid(s_axis_theta_tvalid),
    .s_axis_theta_tlast(s_axis_theta_tlast),
    .s_axis_theta_tuser(s_axis_theta_tuser),
    .s_axis_theta_tready(s_axis_theta_tready),
	
	.m_axis_all_tready(1),
	.m_axis_max_tready(1),
	.m_axis_all_tvalid(m_axis_all_tvalid),
	
	.m_axis_all_tdata(m_axis_all_tdata),
	.m_axis_max_tdata(m_axis_max_tdata),
	
	.debug_rxx(debug_rxx)
 );

integer index;
reg[`NUM_SIZE - 1:0] channel_0[`COLUMNS - 1:0], channel_1[`COLUMNS - 1:0], channel_2[`COLUMNS - 1:0], channel_3[`COLUMNS - 1:0];

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



integer resultFile;
task saveResults;
begin
	resultFile = $fopen(`ALL_HEX_PATH,"w");
	for(i = 0; i < `THETA_COUNT; i = i + 1)begin
		$fwrite(resultFile,"%d: %h\n",i, m_axis_all_tdata[i * `NUM_SIZE +: `NUM_SIZE]);
	end
	$fclose(resultFile);
	resultFile = $fopen(`MAX_HEX_PATH,"w");
	$fwrite(resultFile,"Theta: %h\nValue: %h",m_axis_max_tdata,m_axis_all_tdata[m_axis_max_tdata * `NUM_SIZE +: `NUM_SIZE]);
	$fclose(resultFile);
	
	resultFile = $fopen(`ALL_DEC_PATH,"w");
	for(i = 0; i < `THETA_COUNT; i = i + 1)begin
			$fwrite(resultFile,"%d: %d\n",i, $signed(m_axis_all_tdata[i * `NUM_SIZE +: `NUM_SIZE]));
	end
	$fclose(resultFile);
	resultFile = $fopen(`MAX_DEC_PATH,"w");
	$fwrite(resultFile,"Theta: %h\nValue: %d",m_axis_max_tdata,$signed(m_axis_all_tdata[m_axis_max_tdata * `NUM_SIZE +: `NUM_SIZE]));
	$fclose(resultFile);
	
end
endtask

task saveRxx;
begin
	resultFile = $fopen(`RXX_DEC_PATH,"w");
	for(i = 0; i < `MATRIX_SIZE * `MATRIX_SIZE; i = i + 1)begin
			$fwrite(resultFile,"%d + j %d\n", $signed(debug_rxx[i * `NUM_SIZE +: `NUM_SIZE/2]),$signed(debug_rxx[i * `NUM_SIZE + `NUM_SIZE/2 +: `NUM_SIZE/2]));
	end
	$fclose(resultFile);

	resultFile = $fopen(`RXX_HEX_PATH,"w");
	for(i = 0; i < `MATRIX_SIZE * `MATRIX_SIZE; i = i + 1)begin
			$fwrite(resultFile,"%h\n", $signed(debug_rxx[i * `NUM_SIZE +: `NUM_SIZE]));
	end
	$fclose(resultFile);
end
endtask

reg inc, save;

always #5 clk = ~clk;
always #10 begin
	if(inc) s_axis_theta_tdata = (s_axis_theta_tdata + 1);
end


always@(*)begin

	channel_0_base = channel_0[index]; 
	channel_1_base = channel_1[index]; 
	channel_2_base = channel_2[index]; 
	channel_3_base = channel_3[index]; 
	if(m_axis_all_tvalid & !save) begin
		save = 1;
	end
	if(save) begin
		saveResults();
	end
	if(index == `COLUMNS - 1) s_axis_fft_tlast = 1;
	if(s_axis_theta_tready) begin
		inc = 1;
		s_axis_theta_tvalid = 1;
		saveRxx();
	end
	if(index == `COLUMNS) begin 
		index = 0;
		s_axis_fft_tlast = 0; s_axis_fft_tvalid = 0; 
	end
	if(s_axis_theta_tdata == `THETA_COUNT - 1)begin		
		s_axis_theta_tlast = 1;		
	end
	if(s_axis_theta_tdata == `THETA_COUNT)begin
		inc = 0;
		s_axis_theta_tvalid = 0;
	end
		
end



initial begin
clk = 0; clken = 1; reset_n = 0; index = 0; s_axis_fft_tlast = 0; s_axis_fft_tvalid = 0; s_axis_fft_tuser = 0;
s_axis_theta_tdata = -1; s_axis_theta_tlast = 0; s_axis_theta_tuser = 0; s_axis_theta_tvalid = 0; 
save = 0;
inc = 0; 
#150 reset_n = 1;
#100 initMemory(); s_axis_fft_tvalid = 1; 
#10 sendMemory();

end

	


endmodule
	
	


