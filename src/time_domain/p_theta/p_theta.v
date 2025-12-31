`timescale 1ns/1ps


`include "constants.vh"


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
	
	reg[$clog2(`THETA_COUNT) + 3 : 0] global_counter,global_counter_buf;
	assign r_counter = global_counter[3:0];
	assign theta_counter = global_counter[8: 4];
	
	reg state; // 0 - idle, 1 - processing
	reg valid_buf;
	reg last;
	assign s_axis_r_tready = 1;
	
	always@(posedge clk or negedge reset_n)begin
		if(~reset_n) begin
			foreach(r_buffer[i]) r_buffer[i] <= 0;//system verilog syntax  feature
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
				last <= theta_counter > `THETA_COUNT;
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
	


endmodule
