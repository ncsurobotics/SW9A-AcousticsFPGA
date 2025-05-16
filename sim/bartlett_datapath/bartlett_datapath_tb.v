`timescale 1ns / 1ps

`define MATRIX_SIZE 4

`define THETA_COUNT 19

`define COLUMNS 256

`define NUM_SIZE 64

`define HYDRO_PATH		"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_1/data.hex"
`define ALL_HEX_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_1/all_result_hex.txt"
`define MAX_HEX_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_1/max_result_hex.txt"
`define ALL_DEC_PATH  	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_1/all_result_dec.txt"
`define MAX_DEC_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/bartlett_datapath/test_1/max_result_dec.txt"



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
    .m_axis_all_tready(m_axis_all_tready)
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



reg inc, save;

always #5 clk = ~clk;


always@(*)begin

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
clk = 0; reset_n = 0; index = 0; x_s_axis_data_tlast = 0; x_s_axis_data_tvalid = 0; 
m_axis_all_tready = 1; m_axis_max_tready = 1;
save = 0;
inc = 0; 
#150 reset_n = 1;
#100 initMemory(); x_s_axis_data_tvalid = 1; 
#10 sendMemory();

end

	


endmodule
	
	


