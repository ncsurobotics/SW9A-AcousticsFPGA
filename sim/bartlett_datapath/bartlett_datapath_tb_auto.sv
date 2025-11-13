`timescale 1ns / 1ps

`define MATRIX_SIZE 4

`define THETA_COUNT 19

`define COLUMNS 256

`define NUM_SIZE 32


module bartlett_datapath_tb_auto();
localparam BASE_PATH  = "C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/auto_tests/"
string HYDRO_PATH		= BASE_PATH + "$TEST_NAME$/data.hex";
string ALL_HEX_PATH	= BASE_PATH + "$TEST_NAME$/all_result_hex.txt";
string MAX_HEX_PATH	= BASE_PATH + "$TEST_NAME$/max_result_hex.txt";
string ALL_DEC_PATH  	= BASE_PATH + "$TEST_NAME$/all_result_dec.txt";
string MAX_DEC_PATH	= BASE_PATH + "$TEST_NAME$/max_result_dec.txt";
string ALL_DEC_CSV_PATH = BASE_PATH + "$TEST_NAME$/all_result_dec.csv";
string RXX_HEX_PATH	= BASE_PATH + "$TEST_NAME$/rxx_hex.txt";
string RXX_DEC_PATH  	= BASE_PATH + "$TEST_NAME$/rxx_dec.txt";
string RXX_CSV_PATH  	= BASE_PATH + "$TEST_NAME$/rxx_dec.csv";
string RAW_FFT_HEX_PATH	= BASE_PATH + "$TEST_NAME$/raw_fft_hex.txt";
string MAG_FFT_DEC_PATH  	= BASE_PATH + "$TEST_NAME$/mag_fft_dec.csv";
string RAW_FFT_DEC_PATH  	= BASE_PATH + "$TEST_NAME$/raw_fft_dec.csv";
string FFT_MAX_INDEX_PATH	= BASE_PATH + "$TEST_NAME$/fft_max_index.txt";
string MAX_FREQ_VEC_PATH = BASE_PATH + "$TEST_NAME$/max_freq_vec.csv";
string MID_MATRIX_PATH = BASE_PATH + "$TEST_NAME$/mid_matrix.csv";




reg clk, reset_n;

reg[`NUM_SIZE * `MATRIX_SIZE - 1: 0] s_axis_tdata;
reg[`NUM_SIZE * `MATRIX_SIZE - 1: 0] hydro_data[`COLUMNS-1:0];

wire s_axis_tready;
reg s_axis_tvalid, s_axis_tlast;
reg[31:0] index;
wire[`NUM_SIZE * 19 - 1:0] m_axis_all_tdata;
wire [$clog2(`THETA_COUNT) - 1: 0] m_axis_max_tdata;
reg m_axis_all_tready, m_axis_max_tready;

wire [`MATRIX_SIZE * `MATRIX_SIZE * `NUM_SIZE - 1:0] debug_rxx;
wire debug_rxx_valid;

wire[`NUM_SIZE * 4 - 1:0] debug_fft;
wire[7:0] debug_fft_max_index;
reg[`NUM_SIZE * 4 - 1:0] fft_buffer[`COLUMNS - 1:0];
reg[ 7:0] debug_fft_max_index_buffer[`COLUMNS - 1:0];
wire[33 :0] debug_current_magnitude;
wire debug_current_magnitude_valid;
reg[33 :0] debug_current_magnitude_buffer[`COLUMNS -1  : 0];
	
wire[`NUM_SIZE * 4 - 1 :0] max_freq_vec;
wire max_freq_vec_valid;

wire [`MATRIX_SIZE * `MATRIX_SIZE * `NUM_SIZE * 2 - 1:0] mid_data;
wire mid_valid;

bartlett_datapath #(
	.NUM_SIZE(`NUM_SIZE)
	) dut (
	.clk(clk),
	.reset_b(reset_n),
	
	.s_axis_tdata(s_axis_tdata),
	.s_axis_tvalid(s_axis_tvalid),
	.s_axis_tready(s_axis_tready),
	.s_axis_tlast(s_axis_tlast),
	
	
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
		.debug_fft_max_index(debug_fft_max_index),
		.debug_fft_valid(debug_fft_valid),
		.debug_fft_max_index_valid(debug_fft_max_index_valid),
		.debug_current_magnitude(debug_current_magnitude),
	 .debug_current_magnitude_valid(debug_current_magnitude_valid),
	 .debug_max_freq_vec(max_freq_vec),
	 .debug_max_freq_vec_valid(max_freq_vec_valid),
	 
	 .debug_mid(mid_data),
	 .debug_mid_valid(mid_valid)

	);



task initMemory;
begin
	$readmemh(`HYDRO_PATH,hydro_data);
end
endtask


integer i;
task sendMemory;
	s_axis_tvalid = 1;  
	#10
	for(i = 0; i < `COLUMNS + 1; i = i + 1)begin
		#10 index = index + 1;
	end
endtask
reg [`NUM_SIZE -1 :0] real_values[15:0], imag_values[15:0];


task saveRxx;
begin
	resultFile = $fopen(`RXX_CSV_PATH,"w");
	for(i = 0; i < `MATRIX_SIZE * `MATRIX_SIZE; i = i + 1)begin
			real_values[i] = debug_rxx[i * `NUM_SIZE +: `NUM_SIZE/2];
			imag_values[i] = debug_rxx[i * `NUM_SIZE + `NUM_SIZE/2 +: `NUM_SIZE/2];
			$fwrite(resultFile,"%d,%d\n", $signed(debug_rxx[i * `NUM_SIZE +: `NUM_SIZE/2]),$signed(debug_rxx[i * `NUM_SIZE + `NUM_SIZE/2 +: `NUM_SIZE/2]));
	end
	$fclose(resultFile);


	resultFile = $fopen(`RXX_DEC_PATH,"w");
	for(i = 0; i < `MATRIX_SIZE * `MATRIX_SIZE; i = i + 1)begin
			$fwrite(resultFile,"%d, + %dj\n", $signed(debug_rxx[i * `NUM_SIZE +: `NUM_SIZE/2]),$signed(debug_rxx[i * `NUM_SIZE + `NUM_SIZE/2 +: `NUM_SIZE/2]));
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

integer j, z;
task saveRawFFT;
begin
	resultFile = $fopen(`MAG_FFT_DEC_PATH,"w");
	for(i = 0; i < `COLUMNS; i = i + 1)begin
		$fwrite(resultFile,"%d,", $signed(debug_current_magnitude_buffer[i]));
								
	end
	$fclose(resultFile);
	
	resultFile = $fopen(`RAW_FFT_DEC_PATH,"w");
	for(j = 0; j <`MATRIX_SIZE; j = j + 1)begin
		for(z = 0; z < 2; z = z + 1)begin
			for(i = 0; i < `COLUMNS; i = i + 1)begin
			
				$fwrite(resultFile,"%d,", $signed(fft_buffer[i][j * `NUM_SIZE + z * `NUM_SIZE/2 +: `NUM_SIZE/2]));
			end
			$fwrite(resultFile,"\n");
		end
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
	resultFile = $fopen(`FFT_MAX_INDEX_PATH,"w");
	for(i = 0; i < `COLUMNS; i = i + 1)begin
		$fwrite(resultFile,"%h\n", debug_fft_max_index_buffer[i]);
	end
	$fclose(resultFile);
end
endtask


task saveMaxFreq;
begin
	resultFile = $fopen(`MAX_FREQ_VEC_PATH,"w");
	for(i = 0; i < `MATRIX_SIZE; i = i + 1)begin
		$fwrite(resultFile,"%d,%d\n",  $signed(max_freq_vec[i * `NUM_SIZE +: `NUM_SIZE/2]),$signed(max_freq_vec[i * `NUM_SIZE + `NUM_SIZE/2 +: `NUM_SIZE/2]));
	end
	$fclose(resultFile);
end
endtask

task saveMid;
begin
	resultFile = $fopen(`MID_MATRIX_PATH,"w");
	for(i = 0; i < `MATRIX_SIZE * `MATRIX_SIZE; i = i + 1)begin
		$fwrite(resultFile,"%d,%d\n",  $signed(mid_data[i * `NUM_SIZE * 2 +: `NUM_SIZE]),$signed(mid_data[i * `NUM_SIZE * 2 + `NUM_SIZE +: `NUM_SIZE]));
	end
	$fclose(resultFile);
end
endtask

task initTB;
begin
rxx_saved = 0;
fft_index = 0;
filtered_fft_index = 0;
current_mag_index = 0;
max_freq_saved = 0;
clk = 0; reset_n = 0; index = 0; s_axis_tlast = 0; s_axis_tvalid = 0; 
m_axis_all_tready = 1; m_axis_max_tready = 1;
save = 0;
inc = 0; 
#50 reset_n = 1;
end
endtask


reg inc, save;
reg rxx_saved, max_freq_saved, mid_saved;
integer fft_index, filtered_fft_index, current_mag_index;

always #5 clk = ~clk;

always #10 begin
	if(debug_fft_valid)begin
		fft_buffer[fft_index] = debug_fft;
		fft_index = fft_index + 1;
	end
	if(debug_fft_max_index)begin
		debug_fft_max_index_buffer[filtered_fft_index] = debug_fft_max_index;
		filtered_fft_index = filtered_fft_index + 1;
	end
	
	if(debug_current_magnitude_valid)begin
		debug_current_magnitude_buffer[current_mag_index] = debug_current_magnitude;
		current_mag_index = current_mag_index + 1;
	end
	

end

wire [15:0] real_part[3:0], imag_part[3:0];

assign real_part[0] = debug_fft[`NUM_SIZE * 0 +: `NUM_SIZE/2];
assign imag_part[0] = debug_fft[`NUM_SIZE * 0 + `NUM_SIZE/2 +: `NUM_SIZE/2];
assign real_part[1] = debug_fft[`NUM_SIZE * 1 +: `NUM_SIZE/2];
assign imag_part[1] = debug_fft[`NUM_SIZE * 1 + `NUM_SIZE/2 +: `NUM_SIZE/2];
assign real_part[2] = debug_fft[`NUM_SIZE * 2 +: `NUM_SIZE/2];
assign imag_part[2] = debug_fft[`NUM_SIZE * 2 + `NUM_SIZE/2 +: `NUM_SIZE/2 ];
assign real_part[3] = debug_fft[`NUM_SIZE * 3 +: `NUM_SIZE/2];
assign imag_part[3] = debug_fft[`NUM_SIZE * 3 + `NUM_SIZE/2+: `NUM_SIZE/2];

always@(*)begin

	if(debug_rxx_valid && !rxx_saved)begin
		rxx_saved = 1;
		saveRxx();
	end
		
	if(mid_valid)begin
		saveMid();
		mid_saved = 1;
	end
	if(max_freq_vec_valid)begin
		max_freq_saved = 1;
		saveMaxFreq();
	end
	
	if(fft_index == `COLUMNS) saveRawFFT();
	if(filtered_fft_index ==`COLUMNS) saveFilteredFFT();
	
	s_axis_tdata <= hydro_data[index];
	
	if(m_axis_all_tvalid & !save) begin
		save = 1;
	end
	if(save) begin
		saveResults();
	end
	if(index == `COLUMNS - 1) s_axis_tlast = 1;
	if(index == `COLUMNS) begin 
		index = 0;
		s_axis_tlast = 0; s_axis_tvalid = 0; 
	end

		
end



initial begin
initTB();
#10 initMemory();
#10 sendMemory();

end

	


endmodule
	
	


