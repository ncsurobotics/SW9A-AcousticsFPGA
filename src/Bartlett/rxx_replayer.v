`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2026 09:47:36 AM
// Design Name: 
// Module Name: rxx_replayer
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


// finish writing the theta driver module. Take anirudh code and change it to work with the fixed point. 
// It will have 2 output axis. 1 sends the theta to the PBW. the other sends a ping to the rxx_replayer, including the last.
// The rxx replayer will start in IDLE. when s_axis_rxx goes high it will go into LOAD, and load the register with the matrix, then go to IDLE.
// When it receives a ping from the theta_driver, it will enter SEND, and send the matrix. Then it will go into WAIT, where it waits for the next send.
// It will go between WAIT and SEND until it receives the last SEND, indicated by the axis_tlast field. 
`include "constants.vh"

module rxx_replayer #(
	parameter NUM_SIZE = 32
	)(
	
	input clk,
	input reset_n,
	
	input [NUM_SIZE-1:0] s_axis_rxx_tdata,
	input s_axis_rxx_tvalid,
	output reg s_axis_rxx_tready,
	
	input s_axis_trigger_tvalid,
	input s_axis_trigger_tlast,
	output reg s_axis_trigger_tready,
	
	output reg[NUM_SIZE-1:0] m_axis_tdata,
	output reg m_axis_tvalid,
	input m_axis_tready
	
	
    );
	
	localparam S_IDLE = 2'b00;
	localparam S_LOAD = 2'b01;
	localparam S_SEND = 2'b10;
	localparam S_WAIT = 2'b11;
	
	localparam RXX_SIZE = `HYDROPHONE_COUNT * `HYDROPHONE_COUNT;
	
	reg[NUM_SIZE - 1 : 0] rxx_saved[RXX_SIZE - 1 :0];
	
	reg[$clog2(RXX_SIZE)-1:0] rxx_index;
	
	reg last_trig;
	
	reg[1:0] state;
	
	wire rxx_rec = s_axis_rxx_tvalid && s_axis_rxx_tready;
	wire trig_rec = s_axis_trigger_tvalid && s_axis_trigger_tready;
	wire out_rec = m_axis_tvalid && m_axis_tready;
	
	integer i;
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			rxx_index <= 0;
			s_axis_trigger_tready <= 0;
			s_axis_rxx_tready <= 0;
			state <= S_IDLE;
			last_trig <= 0;
			m_axis_tvalid <= 0;
			m_axis_tdata <= 0;
			for(i = 0; i < RXX_SIZE; i = i + 1) rxx_saved[i] <= 0;
		end else begin
			if(rxx_rec) rxx_saved[rxx_index] <= s_axis_rxx_tdata;
			if(trig_rec) last_trig <= s_axis_trigger_tlast;
			case(state)
				S_IDLE: begin
					s_axis_trigger_tready <= 0;
					s_axis_rxx_tready <= 1;
					m_axis_tdata <= 0;
					m_axis_tvalid <= 0;
					if(rxx_rec) begin 
						state <= S_LOAD;
						rxx_index <= rxx_index + 1;
					end else begin
						rxx_index <= 0;
					end
				end
				S_LOAD: begin
					s_axis_trigger_tready <= 0;
					if(rxx_rec)begin
						rxx_index <= rxx_index + 1;
					end
					if(rxx_index == RXX_SIZE-1)begin
						state <= S_WAIT;
						s_axis_rxx_tready <= 0;
					end else begin
						state <= S_LOAD;
						s_axis_rxx_tready <= 1;
					end
				end
				S_SEND: begin
					s_axis_trigger_tready <= 0;
					m_axis_tdata <= rxx_saved[rxx_index];
					if(out_rec)begin
						rxx_index <= rxx_index + 1;
					end
					if(rxx_index == RXX_SIZE-1)begin
						if(last_trig) state <= S_IDLE;
						else state <= S_WAIT;
						m_axis_tvalid <= 0;
					end else begin
						state <= S_SEND;
						m_axis_tvalid <= 1;
					end
				end
				S_WAIT: begin
					rxx_index <= 0;
					s_axis_rxx_tready <= 0;
					if(trig_rec)begin
						state <= S_SEND;
						s_axis_trigger_tready <= 0;
					end else begin
						state <= S_WAIT;
						s_axis_trigger_tready <= 1;
					end
				end
				
			endcase
		end
	end
	

	
endmodule

module axis_combiner #(
	parameter NUM_SIZE = 32,
	parameter TUSER_SIZE = 17
	) (
	
	input clk,
	input reset_n,
	
	input [NUM_SIZE-1:0] s_axis_a_tdata,
	input s_axis_a_tvalid,
	input [TUSER_SIZE-1:0] s_axis_a_tuser,
	input s_axis_a_tlast,
	output reg s_axis_a_tready,
	
	input [NUM_SIZE-1:0] s_axis_b_tdata,
	input s_axis_b_tvalid,
	output reg s_axis_b_tready,
	
	output reg [2*NUM_SIZE-1:0] m_axis_tdata,
	output reg m_axis_tvalid,
	output reg [TUSER_SIZE-1:0] m_axis_tuser,
	output reg m_axis_tlast
	);
	
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_tdata<=0;
			m_axis_tvalid<=0;
			m_axis_tuser<=0;
			m_axis_tlast<=0;

			s_axis_a_tready <= 0;
			s_axis_b_tready <= 0;
		end else begin
			if(s_axis_a_tvalid && s_axis_b_tvalid)begin
				s_axis_a_tready <= 1;
				s_axis_b_tready <= 1;
			end else begin
				s_axis_a_tready <= 0;
				s_axis_b_tready <= 0;			
			end
			
			if(s_axis_a_tvalid && s_axis_b_tvalid && s_axis_a_tready && s_axis_b_tready)begin
				m_axis_tdata <= {s_axis_a_tdata,s_axis_b_tdata};
				m_axis_tuser <= s_axis_a_tuser;
				m_axis_tlast <= s_axis_a_tlast;
				m_axis_tvalid <= 1;
			end else begin
				m_axis_tdata <= 0;
				m_axis_tuser <= 0;
				m_axis_tlast <= 0;
				m_axis_tvalid <= 0;
			end
			
		end
	end
	

	
endmodule