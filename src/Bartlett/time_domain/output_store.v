`timescale 1ns/1ps


`include "constants.vh"


module output_store #(
	parameter NUM_SIZE = 32
	) (
	input clk, reset_n, 

	// current theta input channel
	input[$clog2(`THETA_COUNT) - 1: 0] s_axis_theta_tdata, 
	input s_axis_theta_tvalid, s_axis_theta_tlast, s_axis_theta_tuser, 
	output reg s_axis_theta_tready,
	
	// current weight input channel
	input[NUM_SIZE - 1 : 0] s_axis_weight_tdata,
	input s_axis_weight_tvalid, s_axis_weight_tlast, s_axis_weight_tuser,
	output reg s_axis_weight_tready,
	
	// all weights output channel
	output reg[`THETA_COUNT * NUM_SIZE - 1:0]  m_axis_all_tdata, 
	output reg m_axis_all_tvalid, m_axis_all_tuser, m_axis_all_tlast,
	input m_axis_all_tready	
	);
	
	integer i;
	
	initial begin
		m_axis_all_tuser <= 0;
	end
	
	always@(*)begin
		m_axis_all_tlast <= s_axis_theta_tlast;
	end
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_all_tdata = 0;
			s_axis_weight_tready = 0;
			s_axis_theta_tready = 0;
			m_axis_all_tvalid = 0;
		end else begin
			m_axis_all_tvalid = s_axis_weight_tlast & s_axis_theta_tlast;
			s_axis_weight_tready = m_axis_all_tready;
			s_axis_theta_tready = m_axis_all_tready;
			
			m_axis_all_tdata = m_axis_all_tdata;
			
			if(s_axis_weight_tvalid && s_axis_theta_tvalid) begin

				case(s_axis_theta_tdata) 
					5'd0: begin m_axis_all_tdata[0  * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end
					5'd1: begin m_axis_all_tdata[1  * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end
					5'd2: begin m_axis_all_tdata[2  * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end
					5'd3: begin m_axis_all_tdata[3  * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end
					5'd4: begin m_axis_all_tdata[4  * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end
					5'd5: begin m_axis_all_tdata[5  * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end
					5'd6: begin m_axis_all_tdata[6  * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end
					5'd7: begin m_axis_all_tdata[7  * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end
					5'd8: begin m_axis_all_tdata[8  * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end
					5'd9: begin m_axis_all_tdata[9  * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end
					5'd10:begin m_axis_all_tdata[10 * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end 
					5'd11:begin m_axis_all_tdata[11 * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end 
					5'd12:begin m_axis_all_tdata[12 * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end 
					5'd13:begin m_axis_all_tdata[13 * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end 
					5'd14:begin m_axis_all_tdata[14 * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end 
					5'd15:begin m_axis_all_tdata[15 * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end 
					5'd16:begin m_axis_all_tdata[16 * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end 
					5'd17:begin m_axis_all_tdata[17 * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end 
					5'd18:begin m_axis_all_tdata[18 * NUM_SIZE +: NUM_SIZE] = s_axis_weight_tdata; end 
				endcase
			end
		end
	end
	
endmodule

