`timescale 1ns / 1ps
// self-checking tb for xadc_demux
module xadc_demux_tb;

	localparam DATA_WIDTH = 16;
	localparam CHANNEL_COUNT = 6;
	localparam TID_WIDTH = 5;
	localparam OUT_WIDTH = DATA_WIDTH*CHANNEL_COUNT*2;
	localparam CLK_PERIOD = 10;
	localparam NUM_RAND_ROUNDS = 5;

	reg [TID_WIDTH-1:0] tid_of_slot [0:CHANNEL_COUNT-1];

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

	// scoreboard, mirrors what the dut should be holding, indexed by slot (not raw tid)
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

	// drive one sample into the slave stream for exactly one cycle
	// (s_axis_tready is tied high, so this never needs to wait)
	task send_sample(input [TID_WIDTH-1:0] tid, input [DATA_WIDTH-1:0] data, input integer slot, input integer slot_valid);
		begin
			@(posedge clk);
			#1;
			s_axis_tid    = tid;
			s_axis_tdata  = data;
			s_axis_tvalid = 1;
			if (s_axis_tready !== 1) begin
				$display("ERROR @ %0t: s_axis_tready dropped, xadc errata violated", $time);
				errors = errors + 1;
			end
			@(posedge clk);
			#1;
			s_axis_tvalid = 0;
			if (slot_valid)
				exp_buf[slot] = data;
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
		tid_of_slot[0] = 5'h15; // vaux5
		tid_of_slot[1] = 5'h1D; // vaux13
		tid_of_slot[2] = 5'h16; // vaux6
		tid_of_slot[3] = 5'h1E; // vaux14
		tid_of_slot[4] = 5'h17; // vaux7
		tid_of_slot[5] = 5'h1F; // vaux15

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
			$display("ERROR: s_axis_tready not high right after reset");
			errors = errors + 1;
		end

		// -----------------------------------------------------------
		// randomized rounds, alternating ascending/descending slot order,
		// driving the real xadc tid for each slot
		// -----------------------------------------------------------
		for (r = 0; r < NUM_RAND_ROUNDS; r = r + 1) begin
			if (r % 2 == 0) begin
				for (c = 0; c < CHANNEL_COUNT; c = c + 1) begin
					rand_data = $unsigned($random) & ((1 << DATA_WIDTH) - 1);
					send_sample(tid_of_slot[c], rand_data, c, 1);
				end
			end else begin
				for (c = CHANNEL_COUNT - 1; c >= 0; c = c - 1) begin
					rand_data = $unsigned($random) & ((1 << DATA_WIDTH) - 1);
					send_sample(tid_of_slot[c], rand_data, c, 1);
				end
			end
			pop_and_check;
		end

		send_sample(5'h00, 16'hDEAD, 0, 0);
		if (m_axis_tvalid !== 0) begin
			$display("ERROR: unmapped tid incorrectly completed a round");
			errors = errors + 1;
		end
		for (c = 0; c < CHANNEL_COUNT; c = c + 1)
			send_sample(tid_of_slot[c], 16'h1100 + c, c, 1);
		pop_and_check;


		send_sample(tid_of_slot[2], 16'hAAAA, 2, 1);
		send_sample(tid_of_slot[2], 16'hBBBB, 2, 1); // overwrite, exp_buf[2] should end up BBBB
		for (c = 0; c < CHANNEL_COUNT; c = c + 1) begin
			if (c != 2)
				send_sample(tid_of_slot[c], 16'h2200 + c, c, 1);
		end
		pop_and_check;
		if (exp_buf[2] !== 16'hBBBB) begin
			$display("ERROR: scoreboard itself didn't model the overwrite right");
			errors = errors + 1;
		end

		// -----------------------------------------------------------
		// latest-wins: a second round completes while the first round's
		// output word was never popped (m_axis_tready held low). the
		// first word should just be silently overwritten by the second.
		// -----------------------------------------------------------
		for (c = 0; c < CHANNEL_COUNT; c = c + 1)
			send_sample(tid_of_slot[c], 16'h3300 + c, c, 1); // round A, never popped
		if (m_axis_tvalid !== 1) begin
			$display("ERROR: round A didn't flush to the output reg");
			errors = errors + 1;
		end
		for (c = 0; c < CHANNEL_COUNT; c = c + 1)
			send_sample(tid_of_slot[c], 16'h4400 + c, c, 1); // round B, should overwrite round A
		if (s_axis_tready !== 1) begin
			$display("ERROR: input stalled during round B, tready must never drop");
			errors = errors + 1;
		end
		pop_and_check; // should see round B's data, round A was silently dropped

		$display("------------------------------------------------");
		if (errors == 0)
			$display("PASS: %0d checks, 0 errors", checks);
		else
			$display("FAIL: %0d checks, %0d errors", checks, errors);
		$finish;
	end

endmodule