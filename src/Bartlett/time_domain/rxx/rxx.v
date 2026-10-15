`timescale 1ns/1ps

`include "constants.vh"
/*
module rxx #(
	parameter NUM_SIZE = 32 //bits per complex number.EX: NUM_SIZE = 32. num = {imag_16,real_16}
	) (
	input clk, reset_n, clken,
	
	// 4x256 matrix input channel
	input[`HYDROPHONE_COUNT * NUM_SIZE - 1 : 0] s_axis_tdata, //MSB->LSB{channel_3, channel_2, channel_1, channel_0}
	input s_axis_tvalid, s_axis_tlast, 
	output s_axis_tready,
	
	// 4 x 4 matrix output channel
	output[NUM_SIZE - 1:0]  m_axis_tdata, //serially outputted values, id-ed with m_axis_tid.
	output m_axis_tvalid, m_axis_tlast,
	input m_axis_tready,
	output[$clog2(`HYDROPHONE_COUNT)-1:0] m_axis_tid
	);
	
	wire[NUM_SIZE/2 - 1 :0] real_channel[`HYDROPHONE_COUNT-1:0], imag_channel[`HYDROPHONE_COUNT-1:0];
	genvar part_select;
	generate
		for(part_select = 0; part_select < `HYDROPHONE_COUNT; part_select=part_select+1)begin
			assign real_channel[part_select] = s_axis_tdata[part_select * NUM_SIZE +:NUM_SIZE/2];
			assign imag_channel[part_select] = s_axis_tdata[part_select * NUM_SIZE + NUM_SIZE/2+:NUM_SIZE/2];
		end
	endgenerate
	reg[NUM_SIZE - 1 : 0] base[`HYDROPHONE_COUNT-1:0],conj[`HYDROPHONE_COUNT-1:0];
	reg[$clog2(`HYDROPHONE_COUNT)-1:0] base_index, conj_index;
	reg valid;
	reg state;
	wire last;
	assign last = (base_index==(`HYDROPHONE_COUNT-1) && conj_index==(`HYDROPHONE_COUNT-1)); 
	
	integer i;
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			for(i = 0; i < `HYDROPHONE_COUNT; i = i + 1)begin
				base[i] <= 0;
				conj[i] <= 0;
			end
			valid <= 0;
			state <= 0;
			base_index <= 0;
			conj_index <= 0;
		end else begin
			if(state == 0)begin // idle
				state <= s_axis_tvalid;
				base_index <= 0;
				conj_index <= 0;
			end else begin
				state <= !last;
				if(m_axis_tready) begin
					base_index <= base_index==(`HYDROPHONE_COUNT-1) ? 0 : base_index + 1;
					conj_index <= conj_index==(`HYDROPHONE_COUNT-1) ? 0 : base_index==(`HYDROPHONE_COUNT-1) ? conj_index + 1 : conj_index;
				end
			end
			for(i = 0; i < `HYDROPHONE_COUNT; i = i + 1)begin
				base[i] <= {imag_channel[i],real_channel[i]};
				conj[i] <= {-imag_channel[i],real_channel[i]};
			end
		end
	end
	
	
cmpy_rxx your_instance_name (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                        // input wire aresetn
  .s_axis_a_tvalid(state),        // input wire s_axis_a_tvalid
  .s_axis_a_tlast(last),
  .s_axis_a_tready(s_axis_tready),        // output wire s_axis_a_tready
  .s_axis_a_tdata(conj[conj_index]),          // input wire [31 : 0] s_axis_a_tdata
  .s_axis_a_tuser(0),          // input wire [1 : 0] s_axis_a_tuser

  .s_axis_b_tvalid(state),        // input wire s_axis_b_tvalid
  //.s_axis_b_tready(s_axis_b_tready),        // output wire s_axis_b_tready
  .s_axis_b_tdata(base[base_index]),          // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tuser(0),          // input wire [1 : 0] s_axis_a_tuser
  
  .m_axis_dout_tvalid(m_axis_tvalid),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tready(m_axis_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tdata(m_axis_tdata),    // output wire [31 : 0] m_axis_dout_tdata
  .m_axis_dout_tlast(m_axis_tlast),
  .m_axis_dout_tuser(m_axis_tid)
);


endmodule
*/

	
module signal_covariance #(
	parameter NUM_SIZE = 32 //bits per complex number.EX: NUM_SIZE = 32. num = {imag_16,real_16}
	) (
	input clk, reset_n, clken,
	
	// 4x256 matrix input channel
	input[`HYDROPHONE_COUNT * NUM_SIZE - 1 : 0] s_axis_tdata, //MSB->LSB{channel_3, channel_2, channel_1, channel_0}
	input s_axis_tvalid, s_axis_tlast, 
	output reg s_axis_tready,
	
	// 4 x 4 matrix output channel
	output[NUM_SIZE - 1:0]  m_axis_tdata, //serially outputted values, id-ed with m_axis_tuser.
	output m_axis_tvalid, m_axis_tlast,
	input m_axis_tready
	);
	
	wire[NUM_SIZE/2 - 1 :0] real_channel[`HYDROPHONE_COUNT-1:0], imag_channel[`HYDROPHONE_COUNT-1:0];
	reg[`HYDROPHONE_COUNT * NUM_SIZE - 1 : 0] data_buffer;
	genvar part_select;
	generate
		for(part_select = 0; part_select < `HYDROPHONE_COUNT; part_select=part_select+1)begin
			assign real_channel[part_select] = data_buffer[part_select * NUM_SIZE +:NUM_SIZE/2];
			assign imag_channel[part_select] = data_buffer[part_select * NUM_SIZE + NUM_SIZE/2+:NUM_SIZE/2];
		end
	endgenerate
	reg[NUM_SIZE - 1 : 0] base[`HYDROPHONE_COUNT-1:0],conj[`HYDROPHONE_COUNT-1:0];
	reg[$clog2(`HYDROPHONE_COUNT)-1:0] base_index, conj_index;
	reg valid;
	reg state;
	wire last;
	assign last = (base_index==(`HYDROPHONE_COUNT-1) && conj_index==(`HYDROPHONE_COUNT-1)); 
	
	integer i;
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			for(i = 0; i < `HYDROPHONE_COUNT; i = i + 1)begin
				base[i] <= 0;
				conj[i] <= 0;
			end
			valid <= 0;
			state <= 0;
			base_index <= 0;
			conj_index <= 0;
			data_buffer <= 0;
			cmpy_valid <= 0;
		end else begin
			if(state == 0)begin // idle
				s_axis_tready <= 1;
				cmpy_valid <= 0;
				if(s_axis_tready && s_axis_tvalid)begin
					state <= 1;
					data_buffer <= s_axis_tdata;
				end
				base_index <= 0;
				conj_index <= 0;
			end else begin
				s_axis_tready <= 0;
				cmpy_valid <= 1;
				if(cmpy_ready && cmpy_valid)begin
					if(base_index==(`HYDROPHONE_COUNT-1))begin
						base_index <= 0;
						if(conj_index==(`HYDROPHONE_COUNT-1))begin
							conj_index <= 0;
							state <= 0;
						end else conj_index <= conj_index + 1;
					end else begin
						base_index <= base_index + 1;
						conj_index <= conj_index;
					end
				end
			end
			for(i = 0; i < `HYDROPHONE_COUNT; i = i + 1)begin
				base[i] <= {imag_channel[i],real_channel[i]};
				conj[i] <= {-imag_channel[i],real_channel[i]};
			end
		end
	end
	
	wire cmpy_ready;
	reg cmpy_valid;
		
cmpy_rxx cmp_rxx_inst (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                        // input wire aresetn
  .s_axis_a_tvalid(cmpy_valid),        // input wire s_axis_a_tvalid
  .s_axis_a_tlast(last),
  .s_axis_a_tready(cmpy_ready),        // output wire s_axis_a_tready
  .s_axis_a_tdata(conj[conj_index]),          // input wire [31 : 0] s_axis_a_tdata

  .s_axis_b_tvalid(cmpy_valid),        // input wire s_axis_b_tvalid
  //.s_axis_b_tready(s_axis_b_tready),        // output wire s_axis_b_tready
  .s_axis_b_tdata(base[base_index]),          // input wire [31 : 0] s_axis_b_tdata
  
  .m_axis_dout_tvalid(m_axis_tvalid),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tready(m_axis_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tdata(m_axis_tdata),    // output wire [31 : 0] m_axis_dout_tdata
  .m_axis_dout_tlast(m_axis_tlast),
  .m_axis_dout_tuser()
);
	




endmodule



	
module beam_covariance #(
	parameter NUM_SIZE = 32, //bits per complex number.EX: NUM_SIZE = 32. num = {imag_16,real_16}
	parameter TUSER_SIZE = 16
	) (
	input clk, reset_n, clken,
	
	input[`HYDROPHONE_COUNT * NUM_SIZE - 1 : 0] s_axis_tdata, 
	input [TUSER_SIZE -1 :0] s_axis_tuser, // {last_theta, theta}
	input s_axis_tvalid, 
	output reg s_axis_tready,
	
	output[NUM_SIZE - 1:0]  m_axis_tdata, 
	output[TUSER_SIZE - 1:0] m_axis_tuser, // theta passed through
	output m_axis_tvalid, m_axis_tlast,
	input m_axis_tready
	);
	
	wire[NUM_SIZE/2 - 1 :0] real_channel[`HYDROPHONE_COUNT-1:0], imag_channel[`HYDROPHONE_COUNT-1:0];
	reg[`HYDROPHONE_COUNT * NUM_SIZE - 1 : 0] data_buffer;
	reg[TUSER_SIZE-1:0] user_buffer;
	genvar part_select;
	generate
		for(part_select = 0; part_select < `HYDROPHONE_COUNT; part_select=part_select+1)begin
			assign real_channel[part_select] = data_buffer[part_select * NUM_SIZE +:NUM_SIZE/2];
			assign imag_channel[part_select] = data_buffer[part_select * NUM_SIZE + NUM_SIZE/2+:NUM_SIZE/2];
		end
	endgenerate
	reg[NUM_SIZE - 1 : 0] base[`HYDROPHONE_COUNT-1:0],conj[`HYDROPHONE_COUNT-1:0];
	reg[$clog2(`HYDROPHONE_COUNT)-1:0] base_index, conj_index;
	reg valid;
	reg state;
	wire last;
	assign last = (base_index==(`HYDROPHONE_COUNT-1) && conj_index==(`HYDROPHONE_COUNT-1)); 
	
	integer i;
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			for(i = 0; i < `HYDROPHONE_COUNT; i = i + 1)begin
				base[i] <= 0;
				conj[i] <= 0;
			end
			valid <= 0;
			state <= 0;
			base_index <= 0;
			conj_index <= 0;
			data_buffer <= 0;
			cmpy_valid <= 0;
			user_buffer <= 0;
		end else begin
			if(state == 0)begin // idle
				s_axis_tready <= 1;
				cmpy_valid <= 0;
				if(s_axis_tready && s_axis_tvalid)begin
					state <= 1;
					data_buffer <= s_axis_tdata;
					user_buffer <= s_axis_tuser;
				end
				base_index <= 0;
				conj_index <= 0;
			end else begin
				s_axis_tready <= 0;
				cmpy_valid <= 1;
				if(cmpy_ready && cmpy_valid)begin
					if(base_index==(`HYDROPHONE_COUNT-1))begin
						base_index <= 0;
						if(conj_index==(`HYDROPHONE_COUNT-1))begin
							conj_index <= 0;
							state <= 0;
						end else conj_index <= conj_index + 1;
					end else begin
						base_index <= base_index + 1;
						conj_index <= conj_index;
					end
				end
			end
			for(i = 0; i < `HYDROPHONE_COUNT; i = i + 1)begin
				base[i] <= {imag_channel[i],real_channel[i]};
				conj[i] <= {-imag_channel[i],real_channel[i]};
			end
		end
	end
	
	wire cmpy_ready;
	reg cmpy_valid;
	
cmpy_beamformer cmpy_beamformer_inst (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                        // input wire aresetn
  .s_axis_a_tvalid(cmpy_valid),        // input wire s_axis_a_tvalid
  .s_axis_a_tlast(last),
  .s_axis_a_tready(cmpy_ready),        // output wire s_axis_a_tready
  .s_axis_a_tdata(conj[conj_index]),          // input wire [31 : 0] s_axis_a_tdata
  .s_axis_a_tuser(user_buffer),          // input wire [1 : 0] s_axis_a_tuser

  .s_axis_b_tvalid(cmpy_valid),        // input wire s_axis_b_tvalid
  //.s_axis_b_tready(s_axis_b_tready),        // output wire s_axis_b_tready
  .s_axis_b_tdata(base[base_index]),          // input wire [31 : 0] s_axis_b_tdata
  //.s_axis_b_tuser(0),          // input wire [1 : 0] s_axis_a_tuser
  
  .m_axis_dout_tvalid(m_axis_tvalid),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tready(m_axis_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tdata(m_axis_tdata),    // output wire [31 : 0] m_axis_dout_tdata
  .m_axis_dout_tlast(m_axis_tlast),
  .m_axis_dout_tuser(m_axis_tuser)
);
	




endmodule