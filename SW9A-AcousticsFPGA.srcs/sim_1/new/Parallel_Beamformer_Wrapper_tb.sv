`timescale 1ns / 1ps
`include "constants.vh"

module Parallel_Beamformer_Wrapper_tb #(
    parameter THETA_WIDTH = 16,
    parameter NUM_SIZE    = 32,
    parameter LATENCY     = 7
);

    logic clk;
    logic reset_n;

    logic [THETA_WIDTH-1:0] s_axis_theta_tdata;
    logic s_axis_theta_tvalid;
    logic s_axis_theta_tlast;
    wire  s_axis_theta_tready;

    logic [1:0] beam_freq;

    wire [NUM_SIZE*`HYDROPHONE_COUNT-1:0] m_axis_tdata;
    wire [THETA_WIDTH-1:0] m_axis_tuser;
    wire m_axis_tvalid;
    wire m_axis_tlast;
    logic m_axis_tready;


    // Clock: 100 MHz
    initial clk = 0;
    always #5 clk = ~clk;


    // DUT
    Parallel_Beamformer_Wrapper dut (
        .clk(clk),
        .reset_n(reset_n),

        .s_axis_theta_tdata(s_axis_theta_tdata),
        .s_axis_theta_tvalid(s_axis_theta_tvalid),
        .s_axis_theta_tlast(s_axis_theta_tlast),
        .s_axis_theta_tready(s_axis_theta_tready),

        .beam_freq(beam_freq),

        .m_axis_tdata(m_axis_tdata),
        .m_axis_tuser(m_axis_tuser),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tlast(m_axis_tlast),
        .m_axis_tready(m_axis_tready)
    );


    // Send one AXI input
    task send_sample(
        input [THETA_WIDTH-1:0] theta,
        input [1:0] freq,
        input last
    );
    begin
        @(posedge clk);

        s_axis_theta_tdata  <= theta;
        beam_freq           <= freq;
        s_axis_theta_tvalid <= 1'b1;
        s_axis_theta_tlast  <= last;

        // Wait until DUT accepts input
        do @(posedge clk);
        while (!s_axis_theta_tready);

        s_axis_theta_tvalid <= 1'b0;
        s_axis_theta_tlast  <= 1'b0;
    end
    endtask


    // Monitor outputs
    always @(posedge clk) begin
        if (m_axis_tvalid) begin
            $display(
                "time=%0t data=%h valid=%b ready=%b last=%b",
                $time,
                m_axis_tdata,
                m_axis_tvalid,
                m_axis_tready,
                m_axis_tlast
            );
        end
    end


    // Check AXI output remains stable during backpressure
    property stable_when_stalled;
        @(posedge clk)
        disable iff (!reset_n)
        m_axis_tvalid && !m_axis_tready
        |=> $stable(m_axis_tdata) &&
            $stable(m_axis_tlast) &&
            m_axis_tvalid;
    endproperty

    assert property(stable_when_stalled)
        else $error("AXI output changed while m_axis_tready = 0");


    // Main test
    initial begin
        // Initial values
        reset_n             = 1'b0;
        s_axis_theta_tdata  = '0;
        s_axis_theta_tvalid = 1'b0;
        s_axis_theta_tlast  = 1'b0;
        beam_freq           = 2'b00;
        m_axis_tready       = 1'b1;

        // Reset
        repeat(5) @(posedge clk);
        reset_n = 1'b1;

        repeat(2) @(posedge clk);


        // -------------------------
        // Test 1: Normal transfers
        // -------------------------
        send_sample(16'd100, 2'd1, 1'b0);
        send_sample(16'd200, 2'd2, 1'b0);
        send_sample(16'd300, 2'd3, 1'b1);


        // -------------------------
        // Test 2: Backpressure
        // -------------------------
        send_sample(16'd400, 2'd1, 1'b0);
        send_sample(16'd500, 2'd2, 1'b0);
        send_sample(16'd600, 2'd3, 1'b1);

        // Wait for results to approach output
        repeat(5) @(posedge clk);

        // Stop downstream for several cycles
        m_axis_tready = 1'b0;
        repeat(10) @(posedge clk);

        // Resume downstream
        m_axis_tready = 1'b1;


        // Allow FIFO to empty
        repeat(50) @(posedge clk);

        $display("TESTBENCH FINISHED");
        $finish;
    end

endmodule