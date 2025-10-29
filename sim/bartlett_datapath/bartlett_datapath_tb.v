`timescale 1ns / 1ps

`define MATRIX_SIZE 4

`define THETA_COUNT 19

`define COLUMNS 256

`define NUM_SIZE 32

`define HYDRO_PATH		"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_11_32_60_5/data.hex"
`define ALL_HEX_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_11_32_60_5/all_result_hex.txt"
`define MAX_HEX_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_11_32_60_5/max_result_hex.txt"
`define ALL_DEC_PATH  	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_11_32_60_5/all_result_dec.txt"
`define MAX_DEC_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_11_32_60_5/max_result_dec.txt"

`define ALL_DEC_CSV_PATH "C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_11_32_60_5/all_result_dec.csv"

`define RXX_HEX_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_11_32_60_5/rxx_hex.txt"
`define RXX_DEC_PATH  	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_11_32_60_5/rxx_dec.txt"

`define RAW_FFT_HEX_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_11_32_60_5/raw_fft_hex.txt"
`define RAW_FFT_DEC_PATH  	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_11_32_60_5/raw_fft_dec.txt"

`define FILTERED_FFT_HEX_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_11_32_60_5/post_fft_hex.txt"
`define FILTERED_FFT_DEC_PATH  	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_11_32_60_5/post_fft_dec.txt"


module bartlett_datapath_tb();

reg clk, reset_n;

reg[`NUM_SIZE * `MATRIX_SIZE - 1: 0] x_s_axis_data_tdata;
reg[`NUM_SIZE * `MATRIX_SIZE - 1: 0] hydro_data[`COLUMNS-1:0];

wire x_s_axis_data_tready;
reg x_s_axis_data_tvalid, x_s_axis_data_tlast;
reg[31:0] index;
wire[`NUM_SIZE * 19 - 1:0] m_axis_all_tdata;
wire [$clog2(`THETA_COUNT) - 1: 0] m_axis_max_tdata;
reg m_axis_all_tready, m_axis_max_tready;

wire [`MATRIX_SIZE * `MATRIX_SIZE * `NUM_SIZE - 1:0] debug_rxx;
wire debug_rxx_valid;

wire[`NUM_SIZE * 4 - 1:0] debug_fft, debug_filtered_fft;
reg[`NUM_SIZE * 4 - 1:0] fft_buffer[`COLUMNS - 1:0];
reg[`NUM_SIZE * 4 - 1:0] filtered_fft_buffer[`COLUMNS - 1:0];
	
bartlett_datapath #(
	.NUM_SIZE(`NUM_SIZE)
	) dut (
	.clk(clk),
	.reset_b(reset_n),
	
	.x_s_axis_data_tdata(x_s_axis_data_tdata),
	.x_s_axis_data_tvalid(x_s_axis_data_tvalid),
	.x_s_axis_data_tready(x_s_axis_data_tready),
	.x_s_axis_data_tlast(x_s_axis_data_tlast),
	
	
	.m_axis_max_tdata(m_axis_max_tdata),
    .m_axis_max_tvalid(m_axis_max_tvalid),
    .m_axis_max_tuser(m_axis_max_tuser),
    .m_axis_max_tlast(m_axis_max_tlast),
    .m_axis_max_tready(m_axis_max_tready),

	.m_axis_all_tdata(m_axis_all_tdata),
    .m_axis_all_tvalid(m_axis_all_tvalid),
    .m_axis_all_tuser(m_axis_all_tuser),
    .m_axis_all_tlast(m_axis_all_tlast),
    .m_axis_all_tready(m_axis_all_tready),
	
			
		.debug_rxx(debug_rxx),
		.debug_rxx_valid(debug_rxx_valid),
		
		.debug_fft(debug_fft),
		.debug_filtered_fft(debug_filtered_fft),
		.debug_fft_valid(debug_fft_valid),
		.debug_filtered_fft_valid(debug_filtered_fft_valid)

	);



task initMemory;
begin
	$readmemh(`HYDRO_PATH,hydro_data);
end
endtask


integer i;
task sendMemory;
	for(i = 0; i < `COLUMNS + 1; i = i + 1)begin
		#10 index = index + 1;
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



integer resultFile, csvFile;
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
	csvFile = $fopen(`ALL_DEC_CSV_PATH,"w");
	for(i = 0; i < `THETA_COUNT; i = i + 1)begin
		$fwrite(csvFile," %d%s",$signed(m_axis_all_tdata[i * `NUM_SIZE +: `NUM_SIZE]), i == `THETA_COUNT - 1 ? "" : ",");
		$fwrite(resultFile,"%d: %d\n",i, $signed(m_axis_all_tdata[i * `NUM_SIZE +: `NUM_SIZE]));
	end
	$fclose(resultFile);
	$fclose(csvFile);
	resultFile = $fopen(`MAX_DEC_PATH,"w");
	$fwrite(resultFile,"Theta: %h\nValue: %d",m_axis_max_tdata,$signed(m_axis_all_tdata[m_axis_max_tdata * `NUM_SIZE +: `NUM_SIZE]));
	$fclose(resultFile);
	
end
endtask

integer j;
task saveRawFFT;
begin
	resultFile = $fopen(`RAW_FFT_DEC_PATH,"w");
	for(i = 0; i < `COLUMNS; i = i + 1)begin
		for(j = 0; j <`MATRIX_SIZE; j = j + 1)begin
			$fwrite(resultFile,"%d + j %d\t", $signed(fft_buffer[i][j * `NUM_SIZE +: `NUM_SIZE/2]),$signed(fft_buffer[i][j * `NUM_SIZE + `NUM_SIZE/2 +: `NUM_SIZE/2]));			
		end
		$fwrite(resultFile,"\n");
	end
	$fclose(resultFile);

	resultFile = $fopen(`RAW_FFT_HEX_PATH,"w");
	for(i = 0; i < `COLUMNS; i = i + 1)begin
		for(j = 0; j < `MATRIX_SIZE; j = j + 1)begin
			$fwrite(resultFile,"%h ", fft_buffer[i][j * `NUM_SIZE +: `NUM_SIZE]);
		end
		$fwrite(resultFile,"\n");
	end
	$fclose(resultFile);
end
endtask


task saveFilteredFFT;
begin
	resultFile = $fopen(`FILTERED_FFT_DEC_PATH,"w");
	for(i = 0; i < `COLUMNS; i = i + 1)begin
		for(j = 0; j < `MATRIX_SIZE; j = j + 1)begin
			$fwrite(resultFile,"%d + j %d\t", $signed(filtered_fft_buffer[i][j * `NUM_SIZE +: `NUM_SIZE/2]),$signed(filtered_fft_buffer[i][j * `NUM_SIZE + `NUM_SIZE/2 +: `NUM_SIZE/2]));			
		end
		$fwrite(resultFile,"\n");
	end
	$fclose(resultFile);

	resultFile = $fopen(`FILTERED_FFT_HEX_PATH,"w");
	for(i = 0; i < `COLUMNS; i = i + 1)begin
		for(j = 0; j < `MATRIX_SIZE; j = j + 1)begin
			$fwrite(resultFile,"%h ", filtered_fft_buffer[i][j * `NUM_SIZE +: `NUM_SIZE]);
		end
		$fwrite(resultFile,"\n");
	end
	$fclose(resultFile);
end
endtask






reg inc, save;
reg rxx_saved;
integer fft_index, filtered_fft_index;

always #5 clk = ~clk;

always #10 begin
	if(debug_fft_valid)begin
		fft_buffer[fft_index] = debug_fft;
		fft_index = fft_index + 1;
	end
	if(debug_filtered_fft_valid)begin
		filtered_fft_buffer[filtered_fft_index] = debug_filtered_fft;
		filtered_fft_index = filtered_fft_index + 1;
	end
end

always@(*)begin

	if(debug_rxx_valid && !rxx_saved)begin
		rxx_saved = 1;
		saveRxx();
	end
	
	if(fft_index == `COLUMNS) saveRawFFT();
	if(filtered_fft_index ==`COLUMNS) saveFilteredFFT();
	
	x_s_axis_data_tdata <= hydro_data[index];
	
	if(m_axis_all_tvalid & !save) begin
		save = 1;
	end
	if(save) begin
		saveResults();
	end
	if(index == `COLUMNS - 1) x_s_axis_data_tlast = 1;
	if(index == `COLUMNS) begin 
		index = 0;
		x_s_axis_data_tlast = 0; x_s_axis_data_tvalid = 0; 
	end

		
end



initial begin
rxx_saved = 0;
fft_index = 0;
filtered_fft_index = 0;
clk = 0; reset_n = 0; index = 0; x_s_axis_data_tlast = 0; x_s_axis_data_tvalid = 0; 
m_axis_all_tready = 1; m_axis_max_tready = 1;
save = 0;
inc = 0; 
#150 reset_n = 1;
#110 initMemory(); x_s_axis_data_tvalid = 1; 
#10 sendMemory();

end

	


endmodule
	
	


