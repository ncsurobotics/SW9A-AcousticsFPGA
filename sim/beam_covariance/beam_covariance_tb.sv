`timescale 1ns/1ps
`include "constants.vh"
// Add this file as a Vivado simulation source and set beam_covariance_tb as top.
// Compile with the same HYDROPHONE_COUNT definition as beam_covariance.
// Requires the simulation sources for your project's cmpy_beamformer IP.
//
// Default: column-major R = x*x^H, {imag16, real16}, signed integer CMPY
// with 16-bit inputs and a 16-bit truncated result per component.
// XSim plusargs: ROW_MAJOR, PRODUCT_SHIFT=<bits>, INPUT_SCALE=<integer>,
// CHECK_MIN_IMAG. For a raw 16-bit integer result use PRODUCT_SHIFT=0
// and INPUT_SCALE=1 together. See test setup below.
module beam_covariance_tb;
    localparam integer N = `HYDROPHONE_COUNT;
    localparam integer NUM_SIZE = 32;
    localparam integer TUSER_SIZE = 16;
    localparam integer MATRIX_SIZE = N * N;
    localparam integer MAX_FRAMES = 5;
    localparam integer MAX_BEATS = MAX_FRAMES * MATRIX_SIZE;
    localparam integer STALL_CYCLES = 80;
    localparam integer READY_CYCLES = 13;

    typedef logic [N * NUM_SIZE - 1:0] vector_t;
    typedef logic signed [15:0] component_t;
    typedef logic [NUM_SIZE - 1:0] complex_t;
    typedef logic [TUSER_SIZE - 1:0] tag_t;

    logic clk = 0;
    logic reset_n = 0;
    always #5 clk = ~clk;

    vector_t s_data = '0;
    tag_t s_user = '0;
    logic s_valid = 0;
    wire s_ready;

    wire [NUM_SIZE - 1:0] m_data;
    wire [TUSER_SIZE - 1:0] m_user;
    wire m_valid, m_last, m_ready;

    beam_covariance #(
        .NUM_SIZE(NUM_SIZE),
        .TUSER_SIZE(TUSER_SIZE)
    ) dut (
        .clk(clk), .reset_n(reset_n), .clken(1'b1),
        .s_axis_tdata(s_data), .s_axis_tuser(s_user),
        .s_axis_tvalid(s_valid), .s_axis_tready(s_ready),
        .m_axis_tdata(m_data), .m_axis_tuser(m_user),
        .m_axis_tvalid(m_valid), .m_axis_tlast(m_last),
        .m_axis_tready(m_ready)
    );

    bit row_major;
    integer product_shift = 17;
    integer input_scale = 2048;
    bit apply_backpressure = 0;
    integer stall_cycle = 0;

    // Drive long stalls to fill the CMPY buffers, then let the stream drain.
    assign m_ready = !apply_backpressure || stall_cycle >= STALL_CYCLES;

    always @(posedge clk) begin
        if (!reset_n || !apply_backpressure ||
            stall_cycle == STALL_CYCLES + READY_CYCLES - 1)
            stall_cycle <= 0;
        else
            stall_cycle <= stall_cycle + 1;
    end

    function automatic complex_t pack_complex(input component_t re,
                                               input component_t im);
        return {im, re};
    endfunction

    function automatic complex_t covariance(input complex_t x_row,
                                             input complex_t x_col);
        longint signed row_re, row_im, col_re, col_im;
        longint signed result_re, result_im;
        row_re = $signed(x_row[15:0]);
        row_im = $signed(x_row[31:16]);
        col_re = $signed(x_col[15:0]);
        col_im = $signed(x_col[31:16]);

        // Compute x[row] * conj(x[col]) in wide signed arithmetic.
        result_re = row_re * col_re + row_im * col_im;
        result_im = row_im * col_re - row_re * col_im;
        result_re = result_re >>> product_shift;
        result_im = result_im >>> product_shift;
        return {result_im[15:0], result_re[15:0]};
    endfunction

    function automatic vector_t mixed_vector(input integer frame);
        vector_t samples;
        component_t re, im;
        for (integer ch = 0; ch < N; ch = ch + 1) begin
            re = component_t'((2 * ((ch + 2 * frame) % 6) - 5) * input_scale);
            im = component_t'((2 * ((5 * ch + frame) % 7) - 6) * input_scale);
            samples[ch * NUM_SIZE +: NUM_SIZE] = pack_complex(re, im);
        end
        return samples;
    endfunction

    // Change stimulus on falling edges and hold it until a rising-edge handshake.
    task automatic send_vector(input vector_t samples, input tag_t tag);
        @(negedge clk);
        s_data = samples;
        s_user = tag;
        s_valid = 1;
        do begin
            @(posedge clk);
        end while (s_ready !== 1'b1);
        @(negedge clk);
        s_valid = 0;
    endtask

    complex_t expected [0:MAX_BEATS - 1];
    complex_t transposed [0:MAX_BEATS - 1];
    tag_t expected_tag [0:MAX_FRAMES - 1];
    integer queued_frames = 0;
    integer received_beats = 0;
    integer data_errors = 0;
    integer transpose_errors = 0;
    integer protocol_errors = 0;
    integer stalled_cycles = 0;
    bit was_stalled = 0;
    logic [NUM_SIZE + TUSER_SIZE:0] held_output;

    // Scoreboard accepts overlapping input frames and samples transfers only.
    always @(posedge clk) begin : scoreboard
        integer row, col, beat, slot;
        complex_t x_row, x_col;
        logic expected_last;
        if (reset_n) begin
            if (s_valid && s_ready) begin
                if (queued_frames == MAX_FRAMES)
                    $fatal(1, "Scoreboard capacity exceeded");
                expected_tag[queued_frames] = s_user;
                for (beat = 0; beat < MATRIX_SIZE; beat = beat + 1) begin
                    row = row_major ? beat / N : beat % N;
                    col = row_major ? beat % N : beat / N;
                    slot = queued_frames * MATRIX_SIZE + beat;
                    x_row = s_data[row * NUM_SIZE +: NUM_SIZE];
                    x_col = s_data[col * NUM_SIZE +: NUM_SIZE];
                    expected[slot] = covariance(x_row, x_col);
                    transposed[slot] = covariance(x_col, x_row);
                end
                queued_frames = queued_frames + 1;
            end

            if (was_stalled &&
                (m_valid !== 1'b1 || {m_last, m_user, m_data} !== held_output)) begin
                $display("FAIL t=%0t: output changed before a stalled beat transferred",
                         $time);
                protocol_errors = protocol_errors + 1;
            end
            was_stalled = (m_valid === 1'b1 && m_ready === 1'b0);
            if (was_stalled) begin
                held_output = {m_last, m_user, m_data};
                stalled_cycles = stalled_cycles + 1;
            end

            if (m_valid && m_ready) begin
                if (received_beats >= queued_frames * MATRIX_SIZE)
                    $fatal(1, "Unexpected extra output beat at t=%0t", $time);

                beat = received_beats % MATRIX_SIZE;
                row = row_major ? beat / N : beat % N;
                col = row_major ? beat % N : beat / N;
                slot = received_beats;
                expected_last = (beat == MATRIX_SIZE - 1);

                if (m_data !== expected[slot]) begin
                    if (data_errors < 12)
                        $display("DATA t=%0t frame=%0d beat=%0d R[%0d,%0d]: got (re=%0d, im=%0d), expected (re=%0d, im=%0d), transpose_match=%0b",
                                 $time, slot / MATRIX_SIZE, beat, row, col,
                                 $signed(m_data[15:0]), $signed(m_data[31:16]),
                                 $signed(expected[slot][15:0]),
                                 $signed(expected[slot][31:16]),
                                 m_data === transposed[slot]);
                    data_errors = data_errors + 1;
                end
                if (m_data !== transposed[slot])
                    transpose_errors = transpose_errors + 1;

                if (m_last !== expected_last ||
                    m_user !== expected_tag[slot / MATRIX_SIZE]) begin
                    $display("SIDEBAND t=%0t frame=%0d beat=%0d: TLAST=%b expected=%b, TUSER=%h expected=%h",
                             $time, slot / MATRIX_SIZE, beat, m_last, expected_last,
                             m_user, expected_tag[slot / MATRIX_SIZE]);
                    protocol_errors = protocol_errors + 1;
                end
                received_beats = received_beats + 1;
            end
        end
    end

    task automatic wait_for_frames(input integer frames);
        // Check on falling edges, after the scoreboard has counted transfers.
        while (received_beats < frames * MATRIX_SIZE)
            @(negedge clk);
    endtask

    initial begin : stimulus
        vector_t samples;
        integer baseline_errors, baseline_transpose_errors;
        integer baseline_protocol_errors;
        integer phase_magnitude;
        row_major = $test$plusargs("ROW_MAJOR");
        if ($value$plusargs("PRODUCT_SHIFT=%d", product_shift)) begin end
        if ($value$plusargs("INPUT_SCALE=%d", input_scale)) begin end
        if (N < 2)
            $fatal(1, "At least two hydrophones are needed for the phase test");
        if (product_shift < 0 || product_shift > 32 ||
            input_scale < 1 || input_scale > 5461)
            $fatal(1, "Invalid PRODUCT_SHIFT or INPUT_SCALE");
        phase_magnitude = (input_scale * input_scale) >> product_shift;
        if (phase_magnitude < 1 || phase_magnitude > 32767)
            $fatal(1, "Phase test result is outside 1..32767. Adjust INPUT_SCALE/PRODUCT_SHIFT");

        $display("beam_covariance_tb: N=%0d row_major=%0b product_shift=%0d input_scale=%0d",
                 N, row_major, product_shift, input_scale);
        repeat (6) @(negedge clk);
        reset_n = 1;
        repeat (2) @(negedge clk);

        // x[0] = A, x[1] = jA. The two cross terms have opposite signs.
        samples = '0;
        samples[0 +: NUM_SIZE] = pack_complex(component_t'(input_scale), 0);
        samples[NUM_SIZE +: NUM_SIZE] = pack_complex(0, component_t'(input_scale));
        send_vector(samples, 16'h0123);
        wait_for_frames(1);
        baseline_errors = data_errors;
        baseline_transpose_errors = transpose_errors;
        baseline_protocol_errors = protocol_errors;
        $display("Always ready: data mismatches=%0d, transposed-reference mismatches=%0d, protocol errors=%0d",
                 baseline_errors, baseline_transpose_errors, baseline_protocol_errors);
        if (baseline_errors != 0 && baseline_transpose_errors == 0)
            $display("ORDER: directed frame matches the opposite matrix traversal.");

        // Queue distinct inputs without waiting for each output matrix to drain.
        apply_backpressure = 1;
        send_vector(mixed_vector(0), 16'h019A);
        send_vector(mixed_vector(1), 16'h02D5);
        send_vector(mixed_vector(2), 16'h83AE);
        wait_for_frames(4);
        apply_backpressure = 0;
        $display("Backpressure: data mismatches=%0d, transposed-reference mismatches=%0d, protocol errors=%0d, stalled cycles=%0d",
                 data_errors - baseline_errors,
                 transpose_errors - baseline_transpose_errors,
                 protocol_errors - baseline_protocol_errors, stalled_cycles);
        if (stalled_cycles == 0)
            $fatal(1, "The backpressure test did not stall a valid output");

        // Optional: mathematically correct conjugation must handle -32768.
        if ($test$plusargs("CHECK_MIN_IMAG")) begin
            if (product_shift < 16 || product_shift > 30)
                $fatal(1, "CHECK_MIN_IMAG needs PRODUCT_SHIFT between 16 and 30");
            $display("Testing the -32768 imaginary input");
            samples = '0;
            samples[0 +: NUM_SIZE] = pack_complex(0, 16'sh8000);
            send_vector(samples, 16'h0007);
            wait_for_frames(5);
        end

        repeat (32) @(negedge clk);
        if (data_errors != 0 || protocol_errors != 0)
            $fatal(1, "FAIL: %0d data mismatches, %0d protocol errors",
                   data_errors, protocol_errors);
        $display("PASS: %0d frames, %0d output beats", queued_frames, received_beats);
        $finish;
    end

    initial begin
        repeat (1000 + 100 * MATRIX_SIZE) @(negedge clk);
        $fatal(1, "Timeout: accepted %0d frames, got %0d of %0d output beats",
               queued_frames, received_beats, queued_frames * MATRIX_SIZE);
    end
endmodule
