`timescale 1ns/1ps


`include "constants.vh"

/*
module p_theta #(
	parameter NUM_SIZE = 32 //bits per complex number.EX: NUM_SIZE = 32. num = {imag_16,real_16}
	) (
	input clk, reset_n, clken,
	
	// 4x4 matrix input channel
	input[NUM_SIZE - 1 : 0] s_axis_r_tdata, //MSB->LSB{channel_3, channel_2, channel_1, channel_0}
	input s_axis_r_tvalid, s_axis_r_tlast,
	output s_axis_r_tready,
	input[3:0] s_axis_r_tid,
	
	// 1x1 weight
	output[NUM_SIZE - 1:0]  m_axis_tdata,//real 
	output m_axis_tvalid, m_axis_tlast,
	output[$clog2(`THETA_COUNT) - 1:0] m_axis_tdest,
	input m_axis_tready	
	);
	
	reg[NUM_SIZE - 1 : 0] r_buffer[`MATRIX_SIZE * `MATRIX_SIZE -1 :0];
	
	reg[NUM_SIZE - 1 : 0] r_factor, s_factor;
	
	wire[$clog2(`THETA_COUNT) - 1:0] theta_counter;
	wire[3:0] r_counter;
	
	reg[$clog2(`THETA_COUNT) + 3 : 0] global_counter,global_counter_buf; // counter that allows for r and theta to be incremented through. Therefore Rxx must be input once. 
	assign r_counter = global_counter[3:0];
	assign theta_counter = global_counter[8: 4];
	
	reg state; // 0 - idle, 1 - processing
	reg valid_buf;
	reg last;
	assign s_axis_r_tready = 1;
	integer i;
	always@(posedge clk or negedge reset_n)begin
		if(~reset_n) begin
			for(i = 0; i < `MATRIX_SIZE * `MATRIX_SIZE; i = i + 1) r_buffer[i] <= 0;
			r_factor <= 0;
			s_factor <= 0;
			global_counter <= 0;
			global_counter_buf <= 0;
			state <= 0;
			valid_buf <= 0;
			last <= 0;
		end
		else begin			
			if (state==0)begin
				state <= s_axis_r_tlast;
				if(s_axis_r_tvalid) r_buffer[s_axis_r_tid] <= s_axis_r_tdata;
				valid_buf <= 0;
				last<= 0;
				global_counter <= 0;
			end else begin
				state <= ~last;
				r_factor <= r_buffer[r_counter];
				s_factor <= s_sh_theta[r_counter * NUM_SIZE +: NUM_SIZE];
				global_counter <= global_counter + 1;
				valid_buf <= 1;
				global_counter_buf <= global_counter;
				last <= theta_counter == `THETA_COUNT;
			end
		end
	end
	
	wire[`MATRIX_SIZE * `MATRIX_SIZE * NUM_SIZE - 1 : 0] s_sh_theta;
	
	s_theta_16 s_theta_inst(
		.theta(theta_counter),
		.s_sh_theta(s_sh_theta)
		);
		
		
	wire [2*NUM_SIZE -1 : 0] mid_data;
	wire mid_last, mid_valid;
	wire [8:0] mid_tuser;

cmpy_1 your_instance_name (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                        // input wire aresetn
  
  .s_axis_a_tvalid(valid_buf),        // input wire s_axis_a_tvalid
  //.s_axis_a_tready(s_axis_a_tready),        // output wire s_axis_a_tready
  .s_axis_a_tuser(global_counter_buf[3:0]),          // input wire [3 : 0] s_axis_a_tuser
  .s_axis_a_tdata(r_factor),          // input wire [31 : 0] s_axis_a_tdata
  
  .s_axis_b_tvalid(valid_buf),        // input wire s_axis_b_tvalid
 // .s_axis_b_tready(s_axis_b_tready),        // output wire s_axis_b_tready
  .s_axis_b_tuser(global_counter_buf[8 : 4]),          // input wire [4 : 0] s_axis_b_tuser
  .s_axis_b_tlast(last),          // input wire s_axis_b_tlast
  .s_axis_b_tdata(s_factor),          // input wire [31 : 0] s_axis_b_tdata
  
  .m_axis_dout_tvalid(mid_valid),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tready(1),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(mid_tuser),    // output wire [8 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(mid_last),    // output wire m_axis_dout_tlast
  .m_axis_dout_tdata(mid_data)    // output wire [63 : 0] m_axis_dout_tdata
);

wire[NUM_SIZE - 1 :0] accumulation;
assign m_axis_tdata = accumulation;
	
real_accumulator #(
	.NUM_SIZE(NUM_SIZE)
	) 
real_accumulator_inst (
	.clk(clk),
	.reset_n(reset_n),
	
	.s_axis_tdata(mid_data[NUM_SIZE-1:0]),
	.s_axis_tvalid(mid_valid),
	.s_axis_tlast(mid_last),
	.s_axis_tdest(mid_tuser[8:4]),
	.s_axis_tid(mid_tuser[3:0]),
	
	
	.m_axis_tdata(accumulation),
	.m_axis_tvalid(m_axis_tvalid),
	.m_axis_tlast(m_axis_tlast),
	.m_axis_tdest(m_axis_tdest)
	);
	


endmodule*/


// Receives in rxx of signal ( 1 transaction )
// Receives in stheta of beamform ( 
module ptheta_v2 #(
	parameter NUM_SIZE = 32,
	parameter TUSER_SIZE = 9,
	parameter MATRIX_SIZE = `HYDROPHONE_COUNT*`HYDROPHONE_COUNT
	)(
	input clk,
	input reset_n,
	
	// Operand 1 (Rxx) elements in order,
	input[NUM_SIZE -1 : 0] s_axis_rxx_tdata, 
	input s_axis_rxx_tvalid, s_axis_rxx_tlast,
	output reg s_axis_rxx_tready,
	
	
	// Operand 2 (S(theta))
	input[NUM_SIZE -1 : 0] s_axis_stheta_tdata,
	input s_axis_stheta_tvalid, s_axis_stheta_tlast,
	input[TUSER_SIZE-1:0] s_axis_stheta_tuser,
	output reg s_axis_stheta_tready,
	
	
	// Result
	output[NUM_SIZE : 0] m_axis_product_tdata, // halves bit width bc we only care about real (the result will be all real), then doubles bc multiply, +1 for add. Saturates on overflow.
	output m_axis_product_tvalid,
	output[TUSER_SIZE -1 : 0] m_axis_product_tuser, // theta value
	input m_axis_product_tready,
	output m_axis_product_tlast
	);
	
	reg[NUM_SIZE - 1 : 0] r_buffer[MATRIX_SIZE - 1 :0];
	reg[$clog2(MATRIX_SIZE)-1:0] r_index;
	wire[NUM_SIZE -1  : 0] r_factor;
	assign r_factor = r_buffer[r_index];

	reg[7:0] rxx_ready_timeout; // timeout counter to prevent rxx from waiting forever for a new theta value.

	integer i;
	always@(posedge clk or negedge reset_n)begin
		if(~reset_n) begin
			for(i = 0; i < MATRIX_SIZE; i = i + 1) r_buffer[i] <= 0;
			r_index <= 0;
			rxx_ready_timeout <= 0;
			s_axis_stheta_tready <= 0;
			s_axis_rxx_tready <= 0;
		end else begin			
			if(s_axis_rxx_tready) begin // receiving
				if(s_axis_rxx_tvalid)begin
					r_buffer[r_index] <= s_axis_rxx_tdata;
					if(s_axis_rxx_tlast) begin
						r_index <= 0;
						s_axis_rxx_tready <= 0; // not ready for new rxx until theta stuff has occured.
					end
					else r_index <= r_index + 1;
				end 
			end else begin // processing
				if (s_axis_stheta_tvalid) begin
					rxx_ready_timeout <= 0;
					r_index <= r_index + 1;
				end else begin
					rxx_ready_timeout <= rxx_ready_timeout + 1;
				end
				s_axis_rxx_tready <= rxx_ready_timeout == 8'hFF ? 1 : s_axis_stheta_tlast ? 1 : 0;
			end
			
			if(s_axis_stheta_tready)begin
				if(s_axis_stheta_tvalid)begin
					
				end
			end else begin
				
			end
				
		end
	end
	
			
	wire [2*NUM_SIZE -1 : 0] mid_data;
	wire mid_last, mid_valid;
	wire [TUSER_SIZE-1:0] mid_tuser;
	

wire[NUM_SIZE - 1 :0] accumulation;
assign m_axis_tdata = accumulation;
	
real_accumulator #(
	.NUM_SIZE(NUM_SIZE)
	) 
real_accumulator_inst (
	.clk(clk),
	.reset_n(reset_n),
	
	.s_axis_tdata(0),
	.s_axis_tvalid(0),
	.s_axis_tlast(0),
	.s_axis_tdest(0),
	.s_axis_tid(0),
	
	
	.m_axis_tdata(accumulation),
	.m_axis_tvalid(m_axis_tvalid),
	.m_axis_tlast(m_axis_tlast),
	.m_axis_tdest(m_axis_tdest)
	);
	

endmodule

module complex_dot_product #(
	parameter NUM_SIZE = 32,
	parameter TUSER_SIZE = 17
	)(
	input clk,
	input reset_n,
	
	input[NUM_SIZE * 2 - 1:0] s_axis_tdata, // A*B, both operands in this field
	input s_axis_tvalid,
	input s_axis_tlast, // end of vector
	input [TUSER_SIZE-1:0] s_axis_tuser,
	
	output[NUM_SIZE * 2 : 0] m_axis_tdata,
	output m_axis_tvalid,
	output[TUSER_SIZE - 1 : 0] m_axis_tuser
	);
	
	
	
//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
cmpy_dot_product your_instance_name (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                        // input wire aresetn
  
  .s_axis_a_tvalid(s_axis_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tuser(s_axis_tuser),          // input wire [16 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),          // input wire s_axis_a_tlast
  .s_axis_a_tdata(s_axis_tdata[0+:NUM_SIZE]),          // input wire [31 : 0] s_axis_a_tdata
  
  .s_axis_b_tvalid(s_axis_tvalid),        // input wire s_axis_b_tvalid
  .s_axis_b_tdata(s_axis_tdata[NUM_SIZE+:NUM_SIZE]),          // input wire [31 : 0] s_axis_b_tdata
  
  .m_axis_dout_tvalid(m_axis_dout_tvalid),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tuser(m_axis_dout_tuser),    // output wire [16 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast),    // output wire m_axis_dout_tlast
  .m_axis_dout_tdata(m_axis_dout_tdata)    // output wire [63 : 0] m_axis_dout_tdata
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

wire	[NUM_SIZE*2-1:0]	m_axis_dout_tdata;
wire	m_axis_dout_tvalid;
wire	m_axis_dout_tlast;
wire	[TUSER_SIZE-1:0]	m_axis_dout_tuser;

complex_accumulator #(
	.NUM_SIZE(2*NUM_SIZE),
	.TUSER_SIZE(TUSER_SIZE)
	) 
comp_accumulator_inst (
	.clk(clk),
	.reset_n(reset_n),
	
	.s_axis_tdata(m_axis_dout_tdata), 
	.s_axis_tvalid(m_axis_dout_tvalid), 
	.s_axis_tlast(m_axis_dout_tlast),
	.s_axis_tuser(m_axis_dout_tuser),
	
	
	.m_axis_tdata(m_axis_tdata),
	.m_axis_tvalid(m_axis_tvalid),
	.m_axis_tuser(m_axis_tuser)
	);
	
endmodule