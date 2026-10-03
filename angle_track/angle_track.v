`timescale 1ns/1ps

module angle_track #(
	parameter THETA_WIDTH = 16,
	parameter threshold = 50,
	parameter angle_min = 0,
	parameter angle_max = 180,
	parameter window = 5,
	parameter step_local = 1,
	parameter step_global = 10
)(
	input wire clk,
	input wire rst_n,
	input wire [31:0] prev_angle,
	input wire [31:0] confidence,
	input wire rx_tvalid,
	output wire rx_tready,

	// master for values to the wrapper
	output reg [THETA_WIDTH-1:0] m_axis_tdata,
	output reg m_axis_tvalid,
	input wire m_axis_tready,
	output reg m_axis_tlast
);

	reg [31:0] end_ang; // last angle of the sweep
	reg [31:0] step_sz; // how far to jump each beat
	reg in_sweep; // sweep is running, don't take a new trigger

	// next angle and is it the last one
	wire [31:0] next_ang = m_axis_tdata + step_sz;
	wire next_last = (next_ang + step_sz > end_ang);

	// clamp the window around prev_angle so it stays in range
	wire [31:0] lo_raw = (prev_angle > window) ? prev_angle - window : 0;
	wire [31:0] hi_raw = prev_angle + window;
	wire [31:0] win_lo = (lo_raw < angle_min) ? angle_min : lo_raw;
	wire [31:0] win_hi = (hi_raw > angle_max) ? angle_max : hi_raw;

	// only take a new trigger when no sweep is running
	assign rx_tready = !in_sweep;
	wire got_trig = rx_tvalid && rx_tready;

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			m_axis_tdata <= 0;
			m_axis_tvalid <= 0;
			m_axis_tlast <= 0;
			end_ang <= 0;
			step_sz <= 0;
			in_sweep <= 0;
		end else begin
			// new trigger, pick local window or global sweep based on confidence
			if (got_trig) begin
				if (confidence >= threshold) begin
					// confident, search a small window around the last angle
					m_axis_tdata <= win_lo[THETA_WIDTH-1:0];
					end_ang <= win_hi;
					step_sz <= step_local;
					m_axis_tlast <= ((win_lo + step_local) > win_hi);
				end else begin
					// not confident, sweep the whole range
					m_axis_tdata <= angle_min;
					end_ang <= angle_max;
					step_sz <= step_global;
					m_axis_tlast <= ((angle_min + step_global) > angle_max);
				end
				m_axis_tvalid <= 1;
				in_sweep <= 1;

			// move to the next angle or finish the sweep
			end else if (m_axis_tvalid && m_axis_tready) begin
				if (m_axis_tlast) begin
					// that was the last angle, drop valid and free up for the next trigger
					m_axis_tvalid <= 0;
					m_axis_tlast <= 0;
					in_sweep <= 0;
				end else begin
					m_axis_tdata <= next_ang[THETA_WIDTH-1:0];
					m_axis_tlast <= next_last;
				end
			end
		end
	end
endmodule