`timescale 1ns / 1ps
// uses negedge reset
module xadc_demux #(
	parameter DATA_WIDTH = 16, // imag always 0
	parameter CHANNEL_COUNT = 6,
	parameter TID_WIDTH = 5,
	parameter OUT_WIDTH = DATA_WIDTH*CHANNEL_COUNT*2
)(
	input wire clk,
	input wire rst_n,

	// slave stream from the xadc
	input wire [DATA_WIDTH-1:0] s_axis_tdata,
	input wire [TID_WIDTH-1:0] s_axis_tid, // which channel s_axis_tdata belongs to
	input wire s_axis_tvalid,
	output wire s_axis_tready,

	// master stream out
	output reg [OUT_WIDTH-1:0] m_axis_tdata,
	output reg m_axis_tvalid,
	input wire m_axis_tready
);
	// sample storage and which have new ones
	reg [DATA_WIDTH-1:0] chan_buf [0:CHANNEL_COUNT-1];
	reg [CHANNEL_COUNT-1:0] valid_mask;

	// tid -> slot lookup
	reg [$clog2(CHANNEL_COUNT)-1:0] tid_slot;
	reg tid_valid;
	always @(*) begin
		tid_valid = 1'b1;
		case (s_axis_tid)
			5'h15: tid_slot = 0; // vaux5
			5'h1D: tid_slot = 1; // vaux13
			5'h16: tid_slot = 2; // vaux6
			5'h1E: tid_slot = 3; // vaux14
			5'h17: tid_slot = 4; // vaux7
			5'h1F: tid_slot = 5; // vaux15
			default: begin
				tid_slot  = 0;
				tid_valid = 1'b0;
			end
		endcase
	end

	assign s_axis_tready = 1'b1; // don't stall
	wire capture_en = s_axis_tvalid && tid_valid;

	reg [CHANNEL_COUNT-1:0] one_hot;
	always @(*) begin
		one_hot = 0;
		if (capture_en)
			one_hot[tid_slot] = 1'b1;
	end
	wire [CHANNEL_COUNT-1:0] candidate_mask = valid_mask | one_hot;
	wire round_done = &candidate_mask;
	wire flush = capture_en && round_done;

	// merged everything so we can build the flushed word
	reg [DATA_WIDTH-1:0] merged_buf [0:CHANNEL_COUNT-1];
	integer m;
	always @(*) begin
		for (m = 0; m < CHANNEL_COUNT; m = m + 1)
			merged_buf[m] = (capture_en && (tid_slot == m)) ? s_axis_tdata : chan_buf[m];
	end

	// pack channel into the output word
	reg [OUT_WIDTH-1:0] packed_next;
	integer p;
	always @(*) begin
		packed_next = 0;
		for (p = 0; p < CHANNEL_COUNT; p = p + 1) begin
			packed_next[p*2*DATA_WIDTH +: DATA_WIDTH] = merged_buf[p]; // real
			packed_next[(p*2+1)*DATA_WIDTH +: DATA_WIDTH] = 0; // imag
		end
	end

	// incoming into channel slot
	integer i;
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			for (i = 0; i < CHANNEL_COUNT; i = i + 1)
				chan_buf[i] <= 0;
		end else if (capture_en) begin
			chan_buf[tid_slot] <= s_axis_tdata;
		end
	end

	// round tracking and output handshake
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			valid_mask <= 0;
			m_axis_tvalid <= 0;
			m_axis_tdata <= 0;
		end else if (flush) begin
			// round complete, latch the new word
			valid_mask <= 0;
			m_axis_tvalid <= 1;
			m_axis_tdata <= packed_next;
		end else begin
			if (capture_en)
				valid_mask <= candidate_mask;
			if (m_axis_tvalid && m_axis_tready)
				m_axis_tvalid <= 0;
		end
	end
endmodule