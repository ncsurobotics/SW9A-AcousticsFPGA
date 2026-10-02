`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2026 04:32:51 PM
// Design Name: 
// Module Name: dot_product_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dot_product_tb();

localparam NUM_SIZE = 32;
localparam TUSER_SIZE = 17;
localparam TEST_COUNT = 1000;
localparam INPUT_RANGE = 5000;


logic clk;
logic reset_n;
logic [2*NUM_SIZE-1:0] s_axis_tdata;
logic s_axis_tvalid;
logic s_axis_tlast;
logic [TUSER_SIZE-1:0] s_axis_tuser;
logic [2*NUM_SIZE-1:0] m_axis_tdata;
logic [NUM_SIZE-1:0] m_axis_tdata_real, m_axis_tdata_imag;
logic m_axis_tvalid;
logic [TUSER_SIZE-1:0] m_axis_tuser;

assign m_axis_tdata_imag = m_axis_tdata[2*NUM_SIZE-1:NUM_SIZE];
assign m_axis_tdata_real = m_axis_tdata[NUM_SIZE-1:0];



complex_dot_product #(
	.NUM_SIZE(NUM_SIZE),
	.TUSER_SIZE(TUSER_SIZE)
	) dut(
	.clk(clk),
	.reset_n(reset_n),
	.s_axis_tdata(s_axis_tdata), // A*B, both operands in this field. {imag_a,real_a,imag_b,real_b}
	.s_axis_tvalid(s_axis_tvalid),
	.s_axis_tlast(s_axis_tlast), // end of vector
	.s_axis_tuser(s_axis_tuser), // passthrough data
	
	.m_axis_tdata(m_axis_tdata), 
	.m_axis_tvalid(m_axis_tvalid),
	.m_axis_tuser(m_axis_tuser) // passthrough data
	);
	

always #5 clk = ~clk;

logic signed [NUM_SIZE-1:0] real_correct_response;
logic signed [NUM_SIZE-1:0] imag_correct_response;

logic signed [NUM_SIZE-1:0] real_error[TEST_COUNT];
real real_percent_error[TEST_COUNT];
logic signed [NUM_SIZE-1:0] imag_error[TEST_COUNT];
real imag_percent_error[TEST_COUNT];
logic signed [NUM_SIZE-1:0] real_correct[TEST_COUNT];
logic signed [NUM_SIZE-1:0] imag_correct[TEST_COUNT];
logic signed [NUM_SIZE-1:0] real_dut[TEST_COUNT];
logic signed [NUM_SIZE-1:0] imag_dut[TEST_COUNT];
logic [7:0] vector_size[TEST_COUNT];

function automatic signed [NUM_SIZE*2-1:0] cmpy(
    input signed [NUM_SIZE/2-1:0] real_a,
    input signed [NUM_SIZE/2-1:0] imag_a,
    input signed [NUM_SIZE/2-1:0] real_b,
    input signed [NUM_SIZE/2-1:0] imag_b
);

    logic signed [NUM_SIZE-1:0] real_mult;
    logic signed [NUM_SIZE-1:0] imag_mult;
    logic signed [NUM_SIZE-1:0] real_result;
    logic signed [NUM_SIZE-1:0] imag_result;

    real_mult = (real_a * real_b - imag_a * imag_b); // halve the result bc we truncate by 1 bit here in the dut, essentially rshift 1.
	$display("%d * %d - %d * %d = %d",real_a,real_b,imag_a,imag_b,real_mult);
    imag_mult = (real_a * imag_b + imag_a * real_b); // halve the result bc we truncate by 1 bit here in the dut, essentially rshift 1.
	$display("%d * %d + %d * %d = %d",real_a,imag_b,imag_a,real_b,imag_mult);

    real_result = real_mult;
    imag_result = imag_mult;

    cmpy = {imag_result, real_result};

endfunction

task automatic send_random_element(
    input logic last,
    input logic [TUSER_SIZE-1:0] user
);
begin
    logic signed [NUM_SIZE/2-1:0] real_a;
    logic signed [NUM_SIZE/2-1:0] imag_a;
    logic signed [NUM_SIZE/2-1:0] real_b;
    logic signed [NUM_SIZE/2-1:0] imag_b;
	logic signed [NUM_SIZE-1:0] real_result;
	logic signed [NUM_SIZE-1:0] imag_result;

    real_a = ($random()%INPUT_RANGE);
    imag_a = ($random()%INPUT_RANGE);
    real_b = ($random()%INPUT_RANGE);
    imag_b = ($random()%INPUT_RANGE);

    @(posedge clk);

    s_axis_tdata = {
        imag_a,
        real_a,
        imag_b,
        real_b
    };

    s_axis_tvalid = 1'b1;
    s_axis_tlast  = last;
    s_axis_tuser  = user;

    {imag_result,real_result} = cmpy(real_a, imag_a, real_b, imag_b);

    $display(
        "OpA(%0d + j%0d) * OpB(%0d + j%0d) = Ans(%0d + j%0d)",
        real_a,
        imag_a,
        real_b,
        imag_b,
        real_result,
        imag_result
    );

	$display("OldRes(%0d + j%0d) + Ans(%0d + j%0d) = NewRes(%0d + j%0d)",
		real_correct_response, imag_correct_response, 
		real_result, imag_result, 
		real_correct_response + real_result, imag_correct_response + imag_result
		);
		
    real_correct_response = real_correct_response + real_result;
	imag_correct_response = imag_correct_response + imag_result;

    @(posedge clk);

    s_axis_tvalid = 1'b0;
    s_axis_tlast  = 1'b0;
    s_axis_tdata  = '0;

end
endtask
int test_index = 0;
int vector_index = 0;
int vmax = 0;
integer file;
initial begin 
 clk = 1;
 reset_n = 0;
 s_axis_tdata = 0;
 s_axis_tvalid = 0;
 s_axis_tlast = 0;
 s_axis_tuser = 0;
 m_axis_tdata = 0;
 m_axis_tvalid = 0;
 m_axis_tuser = 0;
 repeat(10) @(posedge clk);
 reset_n = 1;
 @(posedge clk);
 for(test_index = 0; test_index < TEST_COUNT; test_index =test_index + 1)begin
	real_correct_response = 0;
	imag_correct_response = 0;
	vmax = $urandom_range(1,36);
	vector_size[test_index] = vmax;
	for(vector_index = 0; vector_index <= vmax; vector_index = vector_index+1) begin
		@(posedge clk);
		send_random_element(vector_index==vmax ? 1 : 0,vector_index);
	end
	$display("Correct Response: %d + j%d",real_correct_response,imag_correct_response);
	wait(m_axis_tvalid);
	real_correct_response = real_correct_response/2;
	imag_correct_response = imag_correct_response/2;
real_error[test_index] = m_axis_tdata_real - real_correct_response;
imag_error[test_index] = m_axis_tdata_imag - imag_correct_response;

real_percent_error[test_index] =
    real'(real_error[test_index]) / real'(real_correct_response) * 100.0;

imag_percent_error[test_index] =
    real'(imag_error[test_index]) / real'(imag_correct_response) * 100.0;
	real_correct[test_index] = real_correct_response;
	imag_correct[test_index] = imag_correct_response;
	real_dut[test_index] = m_axis_tdata_real;
	imag_dut[test_index] = m_axis_tdata_imag;
	
 end
 
 file = $fopen("dot_product_stats.csv","w");
 $fwrite(file,"VectorLength,DUT-Real,DUT-Imag,GOLD-Real,GOLD-Imag,RealError,RealPercentError,ImagError,ImagPercentError\n");
 for(test_index = 0; test_index < TEST_COUNT; test_index =test_index + 1)begin
	$fwrite(file,"%d,%d,%d,%d,%d,%d,%f,%d,%f\n",
		vector_size[test_index],
		real_dut[test_index],
		imag_dut[test_index],
		real_correct[test_index],
		imag_correct[test_index],
		real_error[test_index],
		real_percent_error[test_index],
		imag_error[test_index],
		imag_percent_error[test_index]
		);
 end
 $fclose(file);
 $finish();
 
end
endmodule