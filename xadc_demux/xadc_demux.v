`timescale 1ns / 1ps
// uses negedge reset
module xadc_demux #(
	parameter DATA_WIDTH = 16, // imag always 0
	parameter CHANNEL_COUNT = 8,
	parameter TID_WIDTH = 5,
	localparam OUT_WIDTH = DATA_WIDTH*CHANNEL_COUNT*2
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

	// would this tid complete the round if we accepted it right now
	wire valid_tid = (s_axis_tid < CHANNEL_COUNT);
	reg [CHANNEL_COUNT-1:0] one_hot;
	always @(*) begin
		one_hot = 0;
		if (s_axis_tvalid && valid_tid)
			one_hot[s_axis_tid] = 1'b1;
	end
	wire [CHANNEL_COUNT-1:0] candidate_mask = valid_mask | one_hot;
	wire round_done = &candidate_mask;

	// output reg is busy if it's holding a word the downstream hasn't taken yet
	wire out_busy = m_axis_tvalid && !m_axis_tready;

	// only stall the input when accepting it would finish a round we can't flush yet
	assign s_axis_tready = !(round_done && out_busy);
	wire capture_en = s_axis_tvalid && valid_tid && s_axis_tready;
	wire flush = capture_en && round_done;

	// merged everything so we can build the flushed word
	reg [DATA_WIDTH-1:0] merged_buf [0:CHANNEL_COUNT-1];
	integer m;
	always @(*) begin
		for (m = 0; m < CHANNEL_COUNT; m = m + 1)
			merged_buf[m] = (capture_en && (s_axis_tid == m)) ? s_axis_tdata : chan_buf[m];
	end

	// pack {imag,real} per channel into the output word
	reg [OUT_WIDTH-1:0] packed_next;
	integer p;
	always @(*) begin
		packed_next = 0;
		for (p = 0; p < CHANNEL_COUNT; p = p + 1) begin
			packed_next[p*2*DATA_WIDTH +: DATA_WIDTH]     = merged_buf[p]; // real
			packed_next[(p*2+1)*DATA_WIDTH +: DATA_WIDTH] = 0; // imag
		end
	end

	// capture the incoming sample into its channel slot
	integer i;
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			for (i = 0; i < CHANNEL_COUNT; i = i + 1)
				chan_buf[i] <= 0;
		end else if (capture_en) begin
			chan_buf[s_axis_tid] <= s_axis_tdata;
		end
	end

	// round tracking and output handshake
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			valid_mask <= 0;
			m_axis_tvalid <= 0;
			m_axis_tdata <= 0;
		end else if (flush) begin
			// round complete and output free, latch the new word and start the next round
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