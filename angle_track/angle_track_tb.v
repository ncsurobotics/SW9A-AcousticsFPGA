`timescale 1ns/1ps

module angle_track_tb;
	parameter THETA_WIDTH = 16;
	reg clk;
	reg rst_n;
	reg [31:0] prev_angle;
	reg [31:0] confidence;
	reg rx_tvalid;
	wire rx_tready;
	wire [THETA_WIDTH-1:0] m_axis_tdata;
	wire m_axis_tvalid;
	wire m_axis_tlast;
	reg m_axis_tready;
	integer err_cnt; // total errors seen so far
	integer exp_cnt; // how many angles this sweep should send
	integer got_cnt; // how many angles we actually got
	integer exp_val [0:255]; // expected angle for each beat
	integer wait_cyc; // cycles spent waiting for a sweep to finish
	reg hold_pend; // last cycle was valid but not accepted
	reg [THETA_WIDTH-1:0] hold_data; // data we saw on that stalled beat

	angle_track #(.THETA_WIDTH(THETA_WIDTH)) dut (
		.clk(clk),
		.rst_n(rst_n),
		.prev_angle(prev_angle),
		.confidence(confidence),
		.rx_tvalid(rx_tvalid),
		.rx_tready(rx_tready),
		.m_axis_tdata(m_axis_tdata),
		.m_axis_tvalid(m_axis_tvalid),
		.m_axis_tready(m_axis_tready),
		.m_axis_tlast(m_axis_tlast)
	);

	initial clk = 0;
	always #5 clk = ~clk;

	// random sink backpressure
	always @(negedge clk or negedge rst_n) begin
		if (!rst_n)
			m_axis_tready <= 1;
		else
			m_axis_tready <= (($random & 3) != 0);
	end

	// check every accepted beat
	always @(posedge clk) begin
		if (rst_n && m_axis_tvalid && m_axis_tready) begin
			if (got_cnt >= exp_cnt) begin
				$display("ERROR t=%0t: unexpected theta %0d", $time, m_axis_tdata);
				err_cnt = err_cnt + 1;
			end else begin
				if (m_axis_tdata !== exp_val[got_cnt]) begin
					$display("ERROR t=%0t: got %0d exp %0d (idx %0d)", $time, m_axis_tdata, exp_val[got_cnt], got_cnt);
					err_cnt = err_cnt + 1;
				end
				if (m_axis_tlast !== (got_cnt == exp_cnt-1)) begin
					$display("ERROR t=%0t: tlast wrong at idx %0d", $time, got_cnt);
					err_cnt = err_cnt + 1;
				end
			end
			got_cnt = got_cnt + 1;
		end
	end

	// once valid is up and not accepted, it has to stay up with the same data on the next cycle
	always @(posedge clk) begin
		if (rst_n && hold_pend && (m_axis_tvalid !== 1'b1 || m_axis_tdata !== hold_data)) begin
			$display("ERROR t=%0t: AXI-Stream hold violated", $time);
			err_cnt = err_cnt + 1;
		end
		hold_pend <= m_axis_tvalid && !m_axis_tready;
		hold_data <= m_axis_tdata;
	end

	// fire one sweep and check it comes out right
	task run_sweep(input [31:0] prev, input [31:0] conf, input integer lo, input integer hi, input integer stp);
		integer ang;
		begin
			@(negedge clk);
			while (!rx_tready) @(negedge clk);

			prev_angle = prev;
			confidence = conf;

			// build the list of angles we expect
			exp_cnt = 0;
			got_cnt = 0;
			for (ang = lo; ang <= hi; ang = ang + stp) begin
				exp_val[exp_cnt] = ang;
				exp_cnt = exp_cnt + 1;
			end

			// one-cycle trigger pulse
			rx_tvalid = 1;
			@(negedge clk);
			rx_tvalid = 0;

			// wait for every beat to come out, bail out if it hangs
			wait_cyc = 0;
			while (got_cnt < exp_cnt && wait_cyc < 1000) begin
				@(negedge clk);
				wait_cyc = wait_cyc + 1;
			end
			repeat (3) @(negedge clk);

			if (got_cnt != exp_cnt) begin
				$display("ERROR: prev=%0d conf=%0d got %0d of %0d", prev, conf, got_cnt, exp_cnt);
				err_cnt = err_cnt + 1;
			end else
				$display("PASS: prev=%0d conf=%0d (%0d angles)", prev, conf, exp_cnt);
		end
	endtask

	initial begin
		err_cnt = 0;
		exp_cnt = 0;
		got_cnt = 0;
		hold_pend = 0;
		hold_data = 0;
		rst_n = 0;
		rx_tvalid = 0;
		prev_angle = 0;
		confidence = 0;
		m_axis_tready = 1;
		repeat (3) @(negedge clk);
		rst_n = 1;
		run_sweep(90, 80, 85, 95, 1); // local window around 90
		run_sweep(2, 80, 0, 7, 1); // lower clamp
		run_sweep(178, 80, 173, 180, 1); // upper clamp
		run_sweep(0, 10, 0, 180, 10); // global sweep

		if (err_cnt == 0) $display("ALL TESTS PASSED");
		else $display("FAIL: %0d errors", err_cnt);
		$finish;
	end

	initial begin
		#2000000;
		$display("FAIL: watchdog expired");
		$finish;
	end
endmodule