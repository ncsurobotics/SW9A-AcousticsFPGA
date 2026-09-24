`timescale 1ns/1ps



`define COLUMNS 19
`define ROWS 4

`define RXX_MEMORY_PATH "C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/ptheta/test_1/rxx.txt"
`define RESULT_PATH  	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/ptheta/test_1/verilog_result.txt"
`define READABLE_PATH	"C:/Users/Aweso/Verilog/Aquapack/bartlett/sim/module_tests/ptheta/test_1/readable_result.txt"



module ptheta_tb();
localparam NUM_SIZE = 64;

	

integer index;
reg  clk, reset_n, clken;
wire[4 * 4 *NUM_SIZE - 1 : 0] rxx_data;
reg rxx_valid, rxx_last, rxx_user;
wire rxx_ready;

reg[$clog2(`COLUMNS) - 1: 0] theta_data;
reg theta_valid, theta_last, theta_user;
wire theta_ready;

wire[NUM_SIZE * 2 - 1:0] weight_data;
wire weight_last, weight_valid;
wire[5:0] weight_user;
reg weight_ready;

reg[NUM_SIZE - 1 : 0] rxx_memory[15:0];

p_theta #(
	.NUM_SIZE(NUM_SIZE)
	) dut(
	.clk(clk),
	.reset_n(reset_n),
	.clken(clken),

    .s_axis_r_tdata(rxx_data),
    .s_axis_r_tvalid(rxx_valid),
    .s_axis_r_tlast(rxx_last),
    .s_axis_r_tuser(rxx_user),
    .s_axis_r_tready(rxx_ready),

    .s_axis_theta_tdata(theta_data),
    .s_axis_theta_tvalid(theta_valid),
    .s_axis_theta_tlast(theta_last),
    .s_axis_theta_tuser(theta_user),
    .s_axis_theta_tready(theta_ready),

    .m_axis_tdata(weight_data),
    .m_axis_tvalid(weight_valid),
    .m_axis_tuser(weight_user),
    .m_axis_tlast(weight_last),
    .m_axis_tready(weight_ready)
	);
	
genvar j;
generate
  for(j = 0; j < 16; j = j + 1) begin : flatten_rxx
	assign rxx_data[j * NUM_SIZE +: NUM_SIZE] = rxx_memory[j];
  end
endgenerate



task initMemory;
begin
	$readmemh(`RXX_MEMORY_PATH,rxx_memory);
end
endtask


integer i;
task sendMemory;
	for(i = 0; i < `COLUMNS; i = i + 1)begin
		$display("%d before ic\n",theta_data);
		#10 theta_data = theta_data + 1;
		$display("%d after ic\n",theta_data);
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
	if(theta_data == 18)begin
		theta_last = 1;
	end
	if(weight_valid) begin
		$display("%d before save\n",index);
		saveResults();
		$display("%d after save\n",index);
	end
	
end



initial begin
clk = 0; clken = 1; theta_data = 0; reset_n = 0; index = 0;  rxx_valid = 0; theta_valid = 0; theta_last = 0; rxx_last = 0; rxx_user = 0; theta_user = 0;
#50 reset_n = 1; 
#50 weight_ready = 1; initMemory();
#1000  rxx_valid = 1; theta_valid = 1;
#10 sendMemory();

end

	


endmodule
	
	


