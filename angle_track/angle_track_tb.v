`timescale 1ns/1ps

module angle_track_tb;

	// clock and reset
	reg clk, rst_n;
	initial clk = 0;
	always #5 clk = ~clk; // 100 mhz

	// dut ports
	reg [31:0] s_axis_tdata; // prevangle
	reg [31:0] s_axis_tuser; // confidence
	reg s_axis_tvalid;
	wire s_axis_tready;

	wire [15:0] m_axis_tdata;
	wire m_axis_tvalid;
	reg m_axis_tready;
	wire m_axis_tlast;

	// dut
	angle_track #(
		.THETA_WIDTH(16),
		.threshold(50),
		.angle_min(0),
		.angle_max(180),
		.window(5),
		.step_local(1),
		.step_global(10)
	) dut (
		.clk(clk),
		.rst_n(rst_n),
		.s_axis_tdata(s_axis_tdata),
		.s_axis_tuser(s_axis_tuser),
		.s_axis_tvalid(s_axis_tvalid),
		.s_axis_tready(s_axis_tready),
		.m_axis_tdata(m_axis_tdata),
		.m_axis_tvalid(m_axis_tvalid),
		.m_axis_tready(m_axis_tready),
		.m_axis_tlast(m_axis_tlast)
	);

	// test tracking
	integer pass_cnt, fail_cnt;

	// build the list of thetas we expect
	// the bram holds the angle in q4.12 radians, 4096 = 2*pi so 2048 = pi
	// theta = (deg * 2048 + 90) / 180, the +90 makes it round the same way the coe does
	integer exp_val [0:511];
	integer exp_cnt, got_cnt;

	// axi hold check, if valid is up and ready is down nothing can change
	reg was_valid, was_ready;
	reg [15:0] held_data;
	reg held_last;
	always @(posedge clk) begin
		if (rst_n) begin
			if (was_valid && !was_ready) begin
				if (!m_axis_tvalid) begin
					$display("FAIL tvalid dropped before the sink took it, t=%0t", $time);
					fail_cnt = fail_cnt + 1;
				end else if (m_axis_tdata !== held_data || m_axis_tlast !== held_last) begin
					$display("FAIL beat changed while it was being held, t=%0t", $time);
					fail_cnt = fail_cnt + 1;
				end
			end
			was_valid <= m_axis_tvalid;
			was_ready <= m_axis_tready;
			held_data <= m_axis_tdata;
			held_last <= m_axis_tlast;
		end
	end

	// run one sweep test
	// args: prevangle, confidence, lo, hi, stp (all in degrees)
	task run_sweep;
		input [31:0] prev_ang;
		input [31:0] conf;
		input [31:0] lo;
		input [31:0] hi;
		input [31:0] stp;
		integer ang;
		integer timeout;
		reg timed_out;
	begin
		exp_cnt = 0;
		got_cnt = 0;
		for (ang = lo; ang <= hi; ang = ang + stp) begin
			exp_val[exp_cnt] = (ang * 2048 + 90) / 180;
			exp_cnt = exp_cnt + 1;
		end

		// fire the trigger, drive after the edge so we dont race the dut
		@(posedge clk);
		#1 s_axis_tdata = prev_ang;
		s_axis_tuser = conf;
		s_axis_tvalid = 1;
		@(posedge clk);
		while (!s_axis_tready) @(posedge clk);
		#1 s_axis_tvalid = 0;

		// collect beats with random backpressure
		timed_out = 0;
		timeout = 0;
		while (got_cnt < exp_cnt && !timed_out) begin
			@(posedge clk);
			timeout = timeout + 1;
			if (timeout > 50000) begin
				$display("TIMEOUT waiting for beat %0d", got_cnt);
				fail_cnt = fail_cnt + 1;
				timed_out = 1;
			end
			if (m_axis_tvalid && m_axis_tready) begin
				// check the theta
				if (m_axis_tdata !== exp_val[got_cnt]) begin
					$display("FAIL beat %0d: got %0d exp %0d",
						got_cnt, m_axis_tdata, exp_val[got_cnt]);
					fail_cnt = fail_cnt + 1;
				end else begin
					pass_cnt = pass_cnt + 1;
				end
				// check tlast is only on the very last beat
				if (got_cnt == exp_cnt - 1 && !m_axis_tlast) begin
					$display("FAIL tlast missing on last beat %0d", got_cnt);
					fail_cnt = fail_cnt + 1;
				end
				if (got_cnt < exp_cnt - 1 && m_axis_tlast) begin
					$display("FAIL tlast asserted too early at beat %0d", got_cnt);
					fail_cnt = fail_cnt + 1;
				end
				got_cnt = got_cnt + 1;
			end
			// pick ready for the next cycle after the edge, same reason as above
			#1 m_axis_tready = $random % 2;
		end
		#1 m_axis_tready = 1;
		repeat(5) @(posedge clk);
	end
	endtask

	initial begin
		// init
		rst_n = 0;
		s_axis_tdata = 0;
		s_axis_tuser = 0;
		s_axis_tvalid = 0;
		m_axis_tready = 1;
		pass_cnt = 0;
		fail_cnt = 0;
		was_valid = 0;
		was_ready = 0;
		held_data = 0;
		held_last = 0;

		repeat(5) @(posedge clk);
		rst_n = 1;
		repeat(2) @(posedge clk);

		// confident so it does the small window around 90
		$display("--- test 1: confident sweep around 90 ---");
		run_sweep(90, 80, 85, 95, 1);

		// confident but the window has to clamp at angle_min
		$display("--- test 2: confident near the lower edge ---");
		run_sweep(2, 80, 0, 7, 1);

		// confident but the window has to clamp at angle_max
		$display("--- test 3: confident near the upper edge ---");
		run_sweep(178, 80, 173, 180, 1);

		// not confident so it sweeps everything with the big step
		$display("--- test 4: global sweep ---");
		run_sweep(0, 10, 0, 180, 10);

		// done
		if (fail_cnt == 0)
			$display("ALL TESTS PASSED (%0d checks)", pass_cnt);
		else
			$display("FAILED %0d / %0d checks", fail_cnt, pass_cnt + fail_cnt);

		$finish;
	end

endmodule