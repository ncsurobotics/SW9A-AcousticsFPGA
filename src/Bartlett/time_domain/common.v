`timescale 1ns/1ps




module complex_multiplier #(
	parameter NUM_SIZE = 32
	) (
	input clk, reset_n,
	input s_axis_a_tvalid, s_axis_a_tlast, s_axis_a_tuser,
	input [NUM_SIZE - 1 : 0] s_axis_a_tdata,
	output s_axis_a_tready,
	
	// Input matrix B
	input s_axis_b_tvalid, s_axis_b_tlast, s_axis_b_tuser,
	input [NUM_SIZE - 1 : 0] s_axis_b_tdata,
	output s_axis_b_tready,
	
	//Output matrix 
	output m_axis_dout_tvalid, m_axis_dout_tlast,
	output[1:0]	m_axis_dout_tuser,
	output reg[2 * NUM_SIZE - 1 : 0] m_axis_dout_tdata,
	input m_axis_dout_tready
	);
	
	
	wire input_enable = s_axis_a_tvalid & s_axis_b_tvalid;
	wire output_enable = m_axis_dout_tready;
	
	wire[NUM_SIZE/2 - 1:0] real_a = s_axis_a_tdata[NUM_SIZE/2 - 1:0];
	wire[NUM_SIZE - 1:NUM_SIZE/2] imag_a = s_axis_a_tdata[NUM_SIZE - 1:NUM_SIZE/2];
	
	wire[NUM_SIZE/2 - 1:0] real_b = s_axis_b_tdata[NUM_SIZE/2 - 1:0];
	wire[NUM_SIZE - 1:NUM_SIZE/2] imag_b = s_axis_b_tdata[NUM_SIZE - 1:NUM_SIZE/2];
	
	wire[NUM_SIZE/2 - 1:0] real_result = real_a * real_b - imag_a * imag_b;
	wire[NUM_SIZE/2 - 1:0] imag_result = real_a * imag_b + imag_a * real_b;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_dout_tdata <= 0;
		end else begin
			if(input_enable) m_axis_dout_tdata <= {imag_result,real_result};
			else m_axis_dout_tdata <= m_axis_dout_tdata;
		end
	end
	
shift_register #(
	.SIZE(2), .STAGES(1)
	) tuser_sr (
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable),
	.din({s_axis_a_tuser,s_axis_b_tuser}),
	.dout(m_axis_dout_tuser)
	);
	
shift_register_n #(
	.SIZE(1), .STAGES(1)
	)  s_axis_tready_sr (
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable),
	.din(m_axis_dout_tready),
	.dout(s_axis_a_tready)
	);
	
	assign s_axis_b_tready = s_axis_a_tready;
	
shift_register #(
	.SIZE(1), .STAGES(1)
	) tlast_sr (
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable),
	.din(s_axis_a_tlast),
	.dout(m_axis_dout_tlast)
	);
	
shift_register #(
	.SIZE(1), .STAGES(1)
	) tvalid_sr (
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable),
	.din(s_axis_a_tvalid & s_axis_b_tvalid),
	.dout(m_axis_dout_tvalid)
	);
	
	
	
	
endmodule



module complex_adder #(ELEMENT_SIZE = 16)(
	input[ELEMENT_SIZE-1:0] a, b,
	output reg[ELEMENT_SIZE-1:0] sum
	);
	
	always@(*)begin
		sum = {
		a[ELEMENT_SIZE-1:ELEMENT_SIZE/2] + b[ELEMENT_SIZE-1:ELEMENT_SIZE/2],
		a[ELEMENT_SIZE/2 - 1:0] + b[ELEMENT_SIZE/2 - 1:0]};
	end
	
endmodule

module complex_adder_saturate #(
    parameter ELEMENT_SIZE = 32 // total bits (e.g. 2x16-bit fixed-point)
)(
    input  [ELEMENT_SIZE-1:0] a, b,
    output [ELEMENT_SIZE-1:0] sum
);

    localparam HALF = ELEMENT_SIZE / 2;

    // Split inputs into real and imaginary parts
    wire signed [HALF-1:0] a_real = a[HALF-1:0];
    wire signed [HALF-1:0] a_imag = a[ELEMENT_SIZE-1:HALF];

    wire signed [HALF-1:0] b_real = b[HALF-1:0];
    wire signed [HALF-1:0] b_imag = b[ELEMENT_SIZE-1:HALF];

    // Add with extra bit for overflow detection
    wire signed [HALF:0] real_sum_ext = a_real + b_real;
    wire signed [HALF:0] imag_sum_ext = a_imag + b_imag;

    // Saturation logic
    function [HALF-1:0] saturate;
        input signed [HALF:0] val;
        begin
            if (val >  $signed({1'b0, {(HALF-1){1'b1}}})) // max
                saturate = $signed({1'b0, {(HALF-1){1'b1}}});
            else if (val < $signed({1'b1, {(HALF-1){1'b0}}})) // min
                saturate = $signed({1'b1, {(HALF-1){1'b0}}});
            else
                saturate = val[HALF-1:0];
        end
    endfunction

    wire [HALF-1:0] real_sat = saturate(real_sum_ext);
    wire [HALF-1:0] imag_sat = saturate(imag_sum_ext);

    assign sum = {imag_sat, real_sat};

endmodule



module real_adder_saturate #(
    parameter ELEMENT_SIZE = 32 
)(
    input signed [ELEMENT_SIZE-1:0] a, b,
    output [ELEMENT_SIZE-1:0] sum
);


    // Add with extra bit for overflow detection
    wire signed [ELEMENT_SIZE:0] sum_ex = a+b;

    // Saturation logic
    function [ELEMENT_SIZE-1:0] saturate;
        input signed [ELEMENT_SIZE:0] val;
        begin
            if (val >  $signed({1'b0, {(ELEMENT_SIZE-1){1'b1}}})) // max
                saturate = $signed({1'b0, {(ELEMENT_SIZE-1){1'b1}}});
            else if (val < $signed({1'b1, {(ELEMENT_SIZE-1){1'b0}}})) // min
                saturate = $signed({1'b1, {(ELEMENT_SIZE-1){1'b0}}});
            else
                saturate = val[ELEMENT_SIZE-1:0];
        end
    endfunction

    assign sum = saturate(sum_ex);

endmodule




module shift_register #(
	parameter SIZE = 32, //size of each stage/word
	parameter STAGES = 3 // how many stages
	)(
	input clk, reset_n, enable,
	input[SIZE-1:0] din,
	output reg[SIZE-1:0] dout
	);
	
	reg[SIZE-1:0] buffer[STAGES-1:0];
	
	integer i;
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			for(i = 0; i < STAGES; i = i + 1)begin
				buffer[i] <= 0;
			end
		end else begin
			for(i = 0; i < STAGES; i = i + 1)begin
				if(enable)begin
					if(i == 0) buffer[i] <= din;
					else buffer[i] <= buffer[i-1];
				end else buffer[i] <= buffer[i];
			end
		end
	end
	
	always@(*)begin
		dout <= buffer[STAGES-1];
	end
	
endmodule

module shift_register_n #(
	parameter SIZE = 32,
	parameter STAGES = 3
	)(
	input clk, reset_n, enable,
	input[SIZE-1:0] din,
	output reg[SIZE-1:0] dout
	);
	
	reg[SIZE-1:0] buffer[STAGES-1:0];
	
	integer i;
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			for(i = 0; i < STAGES; i = i + 1)begin
				buffer[i] <= 1;
			end
		end else begin
			for(i = 0; i < STAGES; i = i + 1)begin
				if(enable)begin
					if(i == 0) buffer[i] <= din;
					else buffer[i] <= buffer[i-1];
				end else buffer[i] <= buffer[i];
			end
		end
	end
	
	always@(*)begin
		dout <= buffer[STAGES-1];
	end
	
endmodule


module conjugate_multiplier #(
	parameter SIZE = 32,
	parameter LATENCY = 3
	)(
	input clk, reset_n, clken,
	input s_axis_tvalid, s_axis_tuser, s_axis_tlast,
	input[SIZE-1:0] s_axis_tdata,
	output s_axis_tready,
	
	output m_axis_dout_tlast, m_axis_dout_tuser, m_axis_dout_tvalid,
	output[2*SIZE-1:0] m_axis_dout_tdata,
	input m_axis_dout_tready
	);
	
	assign s_axis_a_tready = m_axis_dout_tready;
	wire sr_enable;
	assign sr_enable = m_axis_dout_tready & clken;
	reg[SIZE - 1:0] real_result, imag_result, prod1, prod2;
	reg[2*SIZE-1:0] result;
	
	always@(*)begin
		prod1 <= s_axis_tdata[SIZE-1:SIZE/2] * s_axis_tdata[SIZE-1:SIZE/2]; //a^2
		prod2 <= s_axis_tdata[SIZE/2 - 1:0] * s_axis_tdata[SIZE/2 - 1:0]; //b^2
		real_result <= prod1 + prod2; //a^2 + b^2
		imag_result <= {0}; //zero imag
		result = {real_result,imag_result};
	end
	
	shift_register #(.SIZE(1),.STAGES(LATENCY))  tvalid_sr 
		(.clk(clk),.reset_n(reset_n),.din(s_axis_a_tvalid),.dout(m_axis_dout_tvalid),.enable(sr_enable));
		
	shift_register  #(.SIZE(1),.STAGES(LATENCY))
		tlast_sr (.clk(clk),.reset_n(reset_n),.din(s_axis_tlast),.dout(m_axis_dout_tlast),.enable(sr_enable));
		
	shift_register  #(.SIZE(1),.STAGES(LATENCY))
		tuser_sr(.clk(clk),.reset_n(reset_n),.din(s_axis_tuser),.dout(m_axis_dout_tuser),.enable(sr_enable));
		
	shift_register  #(.SIZE(2 * SIZE),.STAGES(LATENCY))
		tdata_sr (.clk(clk),.reset_n(reset_n),.din(result),.dout(m_axis_dout_tdata),.enable(sr_enable));
		
endmodule

