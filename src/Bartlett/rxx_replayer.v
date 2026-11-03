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
`include "constants.vh"

module rxx_replayer #(
    parameter NUM_SIZE = 32
)(
    input  wire clk,
    input  wire reset_n,

    // Rxx matrix input stream
    input  wire [NUM_SIZE-1:0] s_axis_rxx_tdata,
    input  wire s_axis_rxx_tvalid,
    output reg  s_axis_rxx_tready,

    // Replay trigger stream
    input  wire s_axis_trigger_tvalid,
    input  wire s_axis_trigger_tlast,
    output reg  s_axis_trigger_tready,

    // Replayed matrix output stream
    output reg  [NUM_SIZE-1:0] m_axis_tdata,
    output reg  m_axis_tvalid,
    input  wire m_axis_tready
);

    localparam S_IDLE = 2'b00;
    localparam S_LOAD = 2'b01;
    localparam S_SEND = 2'b10;
    localparam S_WAIT = 2'b11;

    localparam RXX_SIZE = `HYDROPHONE_COUNT * `HYDROPHONE_COUNT;
    localparam INDEX_WIDTH = (RXX_SIZE <= 1) ? 1 : $clog2(RXX_SIZE);

    reg [NUM_SIZE-1:0] rxx_saved [0:RXX_SIZE-1];

    reg [INDEX_WIDTH-1:0] rxx_index;
    reg [1:0] state;
    reg last_trig;

    wire rxx_rec =
        s_axis_rxx_tvalid && s_axis_rxx_tready;

    wire trig_rec =
        s_axis_trigger_tvalid && s_axis_trigger_tready;

    wire out_rec =
        m_axis_tvalid && m_axis_tready;

    integer i;

    // ------------------------------------------------------------
    // AXI-Stream interface control
    // ------------------------------------------------------------
    always @(*) begin
        // Default outputs
        s_axis_rxx_tready     = 1'b0;
        s_axis_trigger_tready = 1'b0;
        m_axis_tvalid         = 1'b0;
        m_axis_tdata          = {NUM_SIZE{1'b0}};

        case (state)
            S_IDLE: begin
                // Accept the first element of a new Rxx matrix
                s_axis_rxx_tready = 1'b1;
            end

            S_LOAD: begin
                // Continue loading the matrix
                s_axis_rxx_tready = 1'b1;
            end

            S_WAIT: begin
                // Accept a trigger only when ready to replay
                s_axis_trigger_tready = 1'b1;
            end

            S_SEND: begin
                // Hold the current element until accepted
                m_axis_tvalid = 1'b1;
                m_axis_tdata  = rxx_saved[rxx_index];
            end

            default: begin
                // Keep defaults
            end
        endcase
    end

    // ------------------------------------------------------------
    // State machine and matrix storage
    // ------------------------------------------------------------
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state     <= S_IDLE;
            rxx_index <= {INDEX_WIDTH{1'b0}};
            last_trig <= 1'b0;

            for (i = 0; i < RXX_SIZE; i = i + 1)
                rxx_saved[i] <= {NUM_SIZE{1'b0}};
        end else begin
            case (state)

                // ------------------------------------------------
                // Wait for the first matrix element
                // ------------------------------------------------
                S_IDLE: begin
                    rxx_index <= {INDEX_WIDTH{1'b0}};

                    if (rxx_rec) begin
                        rxx_saved[0] <= s_axis_rxx_tdata;

                        if (RXX_SIZE == 1) begin
                            state <= S_WAIT;
                        end else begin
                            rxx_index <= 1;
                            state     <= S_LOAD;
                        end
                    end
                end

                // ------------------------------------------------
                // Load the remaining matrix elements
                // ------------------------------------------------
                S_LOAD: begin
                    if (rxx_rec) begin
                        rxx_saved[rxx_index] <= s_axis_rxx_tdata;

                        if (rxx_index == RXX_SIZE - 1) begin
                            // Matrix is fully loaded
                            rxx_index <= 0;
                            state     <= S_WAIT;
                        end else begin
                            rxx_index <= rxx_index + 1'b1;
                        end
                    end
                end

                // ------------------------------------------------
                // Wait for a replay trigger
                // ------------------------------------------------
                S_WAIT: begin
                    rxx_index <= 0;

                    if (trig_rec) begin
                        // Remember whether this is the final replay
                        last_trig <= s_axis_trigger_tlast;
                        state     <= S_SEND;
                    end
                end

                // ------------------------------------------------
                // Send the stored matrix
                // ------------------------------------------------
                S_SEND: begin
                    // Do not advance unless the output handshake
                    // succeeds. This also preserves data during stalls.
                    if (out_rec) begin
                        if (rxx_index == RXX_SIZE - 1) begin
                            rxx_index <= 0;

                            if (last_trig) begin
                                // Final replay completed
                                state <= S_IDLE;
                            end else begin
                                // Wait for the next replay request
                                state <= S_WAIT;
                            end
                        end else begin
                            rxx_index <= rxx_index + 1'b1;
                        end
                    end
                end

                default: begin
                    state     <= S_IDLE;
                    rxx_index <= 0;
                    last_trig <= 1'b0;
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
	
	always@(*)begin
		s_axis_a_tready<=s_axis_b_tvalid;
		s_axis_b_tready<=s_axis_a_tvalid;
	end
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_tdata<=0;
			m_axis_tvalid<=0;
			m_axis_tuser<=0;
			m_axis_tlast<=0;

			//s_axis_a_tready <= 0;
			//s_axis_b_tready <= 0;
		end else begin
			//if(s_axis_a_tvalid && s_axis_b_tvalid)begin
			//	s_axis_a_tready <= 1;
			//	s_axis_b_tready <= 1;
			//end else begin
			//	s_axis_a_tready <= 0;
			//	s_axis_b_tready <= 0;			
			//end
			
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