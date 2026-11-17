`timescale 1ns/1ps

module angle_track #(
	parameter THETA_WIDTH = 16,
	parameter threshold = 50,
	parameter angle_min = 0,
	parameter angle_max = 180,
	parameter window = 5,
	parameter step_local = 1,
	parameter step_global = 10,
	parameter bram_lat = 2 // THERE IS A 2 CYCLE LATENCY WITH THE BRAM
)(
	input wire clk,
	input wire rst_n,
	input wire [31:0] s_axis_tdata, // confidence
	input wire [31:0] s_axis_tuser, // prevangle
	input wire s_axis_tvalid,
	output wire s_axis_tready,

	// master for values to the wrapper
	output reg [THETA_WIDTH-1:0] m_axis_tdata,
	output reg m_axis_tvalid,
	input wire m_axis_tready,
	output reg m_axis_tlast
);

	localparam ST_IDLE = 2'd0; // waiting for a trigger
	localparam ST_WAIT = 2'd1; // address is out, waiting on the bram
	localparam ST_SEND = 2'd2; // holding a beat until the sink takes it

	reg [1:0] state;
	reg [2:0] wait_cnt; // cycles left before douta is good
	reg [31:0] cur_ang; // angle we are looking up right now in deg
	reg [31:0] end_ang; // last angle of the sweep
	reg [31:0] step_sz; // how far to jump each beat

	// 16 width by 360 depth, the bram turns the degree into q4.12 radians
	reg [8:0] bram_addr;
	wire [15:0] bram_dout;

	blk_mem_gen_0 bram_inst (
		.clka(clk),
		.ena(1'b1),
		.addra(bram_addr),
		.douta(bram_dout)
	);

	// next angle and is it the last one
	wire [31:0] next_ang = cur_ang + step_sz;

	// clamp the window around prev_angle so it stays in range
	wire [31:0] lo_raw = (s_axis_tdata > window) ? s_axis_tdata - window : 0;
	wire [31:0] hi_raw = s_axis_tdata + window;
	wire [31:0] win_lo = (lo_raw < angle_min) ? angle_min : lo_raw;
	wire [31:0] win_hi = (hi_raw > angle_max) ? angle_max : hi_raw;

	// small window around the last angle, otherwise sweep everything
	wire confident = (s_axis_tuser >= threshold);
	wire [31:0] start_ang = confident ? win_lo : angle_min;
	wire [31:0] stop_ang = confident ? win_hi : angle_max;
	wire [31:0] stp_ang = confident ? step_local : step_global;

	// only take a new trigger when no sweep is running
	assign s_axis_tready = (state == ST_IDLE);
	wire got_trig = s_axis_tvalid && s_axis_tready;

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			m_axis_tdata <= 0;
			m_axis_tvalid <= 0;
			m_axis_tlast <= 0;
			cur_ang <= 0;
			end_ang <= 0;
			step_sz <= 0;
			bram_addr <= 0;
			wait_cnt <= 0;
			state <= ST_IDLE;
		end else begin
			case (state)

			// start read
			ST_IDLE: begin
				m_axis_tvalid <= 0;
				m_axis_tlast <= 0;
				if (got_trig) begin
					cur_ang <= start_ang;
					end_ang <= stop_ang;
					step_sz <= stp_ang;
					bram_addr <= start_ang[8:0];
					wait_cnt <= bram_lat;
					state <= ST_WAIT;
				end
			end

			// wait for latency and pick up the douta
			ST_WAIT: begin
				if (wait_cnt != 0) begin
					wait_cnt <= wait_cnt - 1;
				end else begin
					m_axis_tdata <= bram_dout;
					m_axis_tlast <= (next_ang > end_ang);
					m_axis_tvalid <= 1;
					state <= ST_SEND;
				end
			end

			// wait for sink to take
			ST_SEND: begin
				if (m_axis_tready) begin
					m_axis_tvalid <= 0;
					if (m_axis_tlast) begin
						// get ready for next
						m_axis_tlast <= 0;
						state <= ST_IDLE;
					end else begin
						cur_ang <= next_ang;
						bram_addr <= next_ang[8:0];
						wait_cnt <= bram_lat;
						state <= ST_WAIT;
					end
				end
			end
			default: state <= ST_IDLE;
			endcase
		end
	end
endmodule