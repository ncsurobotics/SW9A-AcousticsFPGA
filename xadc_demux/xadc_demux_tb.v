`timescale 1ns / 1ps
// self-checking tb for xadc_demux
module xadc_demux_tb;

	localparam DATA_WIDTH = 16;
	localparam CHANNEL_COUNT = 8;
	localparam TID_WIDTH = 5;
	localparam OUT_WIDTH = DATA_WIDTH*CHANNEL_COUNT*2;
	localparam CLK_PERIOD = 10;
	localparam NUM_RAND_ROUNDS = 5;

	reg clk;
	reg rst_n;

	reg [DATA_WIDTH-1:0] s_axis_tdata;
	reg [TID_WIDTH-1:0] s_axis_tid;
	reg s_axis_tvalid;
	wire s_axis_tready;

	wire [OUT_WIDTH-1:0] m_axis_tdata;
	wire m_axis_tvalid;
	reg m_axis_tready;

	integer errors;
	integer checks;

	// scoreboard, mirrors what the dut should be holding
	reg [DATA_WIDTH-1:0] exp_buf [0:CHANNEL_COUNT-1];
	reg [OUT_WIDTH-1:0] exp_word;

	xadc_demux #(
		.DATA_WIDTH(DATA_WIDTH),
		.CHANNEL_COUNT(CHANNEL_COUNT),
		.TID_WIDTH(TID_WIDTH)
	) dut (
		.clk(clk),
		.rst_n(rst_n),
		.s_axis_tdata(s_axis_tdata),
		.s_axis_tid(s_axis_tid),
		.s_axis_tvalid(s_axis_tvalid),
		.s_axis_tready(s_axis_tready),
		.m_axis_tdata(m_axis_tdata),
		.m_axis_tvalid(m_axis_tvalid),
		.m_axis_tready(m_axis_tready)
	);

	// clock
	initial clk = 0;
	always #(CLK_PERIOD/2) clk = ~clk;

	// safety net so a stuck handshake doesn't hang the sim forever
	initial begin
		#100000;
		$display("ERROR: tb timed out");
		errors = errors + 1;
		$finish;
	end

	// build exp_word from the scoreboard's current contents
	task build_exp_word;
		integer c;
		begin
			for (c = 0; c < CHANNEL_COUNT; c = c + 1) begin
				exp_word[c*2*DATA_WIDTH +: DATA_WIDTH]     = exp_buf[c];
				exp_word[(c*2+1)*DATA_WIDTH +: DATA_WIDTH] = 0;
			end
		end
	endtask

	// drive one sample into the slave stream, blocks until the dut accepts it
	task send_sample(input [TID_WIDTH-1:0] tid, input [DATA_WIDTH-1:0] data);
		begin
			@(posedge clk);
			#1;
			s_axis_tid    = tid;
			s_axis_tdata  = data;
			s_axis_tvalid = 1;
			@(posedge clk);
			while (!s_axis_tready) @(posedge clk);
			#1;
			s_axis_tvalid = 0;
			if (tid < CHANNEL_COUNT)
				exp_buf[tid] = data;
		end
	endtask

	// wait for m_axis_tvalid, check the word, then pop it with a bit of random backpressure
	task pop_and_check;
		integer rand_delay;
		begin
			while (!m_axis_tvalid) @(posedge clk);
			build_exp_word;
			rand_delay = $unsigned($random) % 3;
			repeat (rand_delay) @(posedge clk);
			#1;
			if (m_axis_tdata !== exp_word) begin
				$display("ERROR @ %0t: m_axis_tdata = %h, expected %h", $time, m_axis_tdata, exp_word);
				errors = errors + 1;
			end else begin
				checks = checks + 1;
			end
			m_axis_tready = 1;
			@(posedge clk);
			#1;
			m_axis_tready = 0;
		end
	endtask

	integer r, c;
	integer rand_data;

	initial begin
		errors = 0;
		checks = 0;
		rst_n = 0;
		s_axis_tvalid = 0;
		s_axis_tid = 0;
		s_axis_tdata = 0;
		m_axis_tready = 0;
		for (c = 0; c < CHANNEL_COUNT; c = c + 1)
			exp_buf[c] = 0;

		repeat (4) @(posedge clk);
		#1;
		rst_n = 1;
		@(posedge clk);
		#1;

		if (m_axis_tvalid !== 0) begin
			$display("ERROR: m_axis_tvalid high right after reset");
			errors = errors + 1;
		end
		if (s_axis_tready !== 1) begin
			$display("ERROR: s_axis_tready low right after reset, nothing should be blocking yet");
			errors = errors + 1;
		end

		// -----------------------------------------------------------
		// randomized rounds, alternating ascending/descending tid order
		// -----------------------------------------------------------
		for (r = 0; r < NUM_RAND_ROUNDS; r = r + 1) begin
			if (r % 2 == 0) begin
				for (c = 0; c < CHANNEL_COUNT; c = c + 1) begin
					rand_data = $unsigned($random) & ((1 << DATA_WIDTH) - 1);
					send_sample(c, rand_data);
				end
			end else begin
				for (c = CHANNEL_COUNT - 1; c >= 0; c = c - 1) begin
					rand_data = $unsigned($random) & ((1 << DATA_WIDTH) - 1);
					send_sample(c, rand_data);
				end
			end
			pop_and_check;
		end

		// -----------------------------------------------------------
		// invalid tid (>= CHANNEL_COUNT) should be accepted and ignored,
		// never block the input or count toward a round
		// -----------------------------------------------------------
		send_sample(CHANNEL_COUNT, 16'hDEAD);
		if (m_axis_tvalid !== 0) begin
			$display("ERROR: invalid tid incorrectly completed a round");
			errors = errors + 1;
		end
		for (c = 0; c < CHANNEL_COUNT; c = c + 1)
			send_sample(c, 16'h1100 + c);
		pop_and_check;

		// -----------------------------------------------------------
		// same channel written twice before the round flushes,
		// the later value should win
		// -----------------------------------------------------------
		send_sample(3, 16'hAAAA);
		send_sample(3, 16'hBBBB); // overwrite, exp_buf[3] should end up BBBB
		for (c = 0; c < CHANNEL_COUNT; c = c + 1) begin
			if (c != 3)
				send_sample(c, 16'h2200 + c);
		end
		pop_and_check;
		if (exp_buf[3] !== 16'hBBBB) begin
			$display("ERROR: scoreboard itself didn't model the overwrite right");
			errors = errors + 1;
		end

		// -----------------------------------------------------------
		// double-buffer stall: fill round A, hold m_axis_tready low,
		// fill 7/8 of round B (should still be accepted), then the
		// 8th sample of round B should stall s_axis_tready since the
		// output reg is still full with round A
		// -----------------------------------------------------------
		for (c = 0; c < CHANNEL_COUNT; c = c + 1)
			send_sample(c, 16'h3300 + c); // round A
		if (m_axis_tvalid !== 1) begin
			$display("ERROR: round A didn't flush to the output reg");
			errors = errors + 1;
		end
		build_exp_word; // snapshot round A's expected word before we touch exp_buf again

		for (c = 0; c < CHANNEL_COUNT - 1; c = c + 1)
			send_sample(c, 16'h4400 + c); // 7/8 of round B, output reg still full of round A

		// try the last sample of round B, should NOT be accepted yet
		@(posedge clk);
		#1;
		s_axis_tid    = CHANNEL_COUNT - 1;
		s_axis_tdata  = 16'h4400 + (CHANNEL_COUNT - 1);
		s_axis_tvalid = 1;
		@(posedge clk);
		#1;
		if (s_axis_tready !== 0) begin
			$display("ERROR: s_axis_tready should have stalled, output reg still holds round A");
			errors = errors + 1;
		end

		// now drain round A, the stalled round B sample should go through right after
		if (m_axis_tdata !== exp_word) begin
			$display("ERROR @ %0t: round A word = %h, expected %h", $time, m_axis_tdata, exp_word);
			errors = errors + 1;
		end else begin
			checks = checks + 1;
		end
		m_axis_tready = 1;
		@(posedge clk);
		#1;
		m_axis_tready = 0;
		s_axis_tvalid = 0;

		exp_buf[CHANNEL_COUNT-1] = 16'h4400 + (CHANNEL_COUNT - 1);
		pop_and_check; // round B

		$display("------------------------------------------------");
		if (errors == 0)
			$display("PASS: %0d checks, 0 errors", checks);
		else
			$display("FAIL: %0d checks, %0d errors", checks, errors);
		$finish;
	end

endmodule