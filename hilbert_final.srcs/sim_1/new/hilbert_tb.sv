`timescale 1ns/1ps

module hilbert_tb;

    reg clk = 0;
    reg reset_b = 0;

    // DUT inputs
    reg  [127:0] x_s_axis_data_tdata;
    reg          x_s_axis_data_tvalid;
    reg          x_s_axis_data_tlast;
    wire         x_s_axis_data_tready;

    // DUT outputs
    wire [127:0] ifft_m_axis_data_tdata;
    wire         ifft_m_axis_data_tvalid;
    reg          ifft_m_axis_data_tready;
    wire         ifft_m_axis_data_tlast;
    wire [127:0] x_m_axis_data_tdata;
    wire         x_m_axis_data_tvalid;

    // Clock
    always #5 clk = ~clk; // 100 MHz

    // Instantiate DUT
    hilbert dut (
        .clk(clk),
        .reset_b(reset_b),
        .x_s_axis_data_tdata(x_s_axis_data_tdata),
        .x_s_axis_data_tvalid(x_s_axis_data_tvalid),
        .x_s_axis_data_tlast(x_s_axis_data_tlast),
        .x_s_axis_data_tready(x_s_axis_data_tready),
        .ifft_m_axis_data_tdata(ifft_m_axis_data_tdata),
        .ifft_m_axis_data_tvalid(ifft_m_axis_data_tvalid),
        .ifft_m_axis_data_tready(ifft_m_axis_data_tready),
        .ifft_m_axis_data_tlast(ifft_m_axis_data_tlast),
        .x_m_axis_data_tdata(x_m_axis_data_tdata),
        .x_m_axis_data_tvalid(x_m_axis_data_tvalid)
    );

    // File handles
    integer fin, fout, fout2;
    integer sample_number = 0;
    integer status;

    initial begin
        // Open files
        fin  = $fopen("input_data.txt", "r");
        fout = $fopen("output_data.txt", "w");
        fout2 = $fopen("fft_data.txt", "w");

        // Reset sequence
        x_s_axis_data_tvalid = 0;
        x_s_axis_data_tlast  = 0;
        ifft_m_axis_data_tready = 1; // always ready to accept DUT output
        #100;
        reset_b = 1;
        x_s_axis_data_tdata = 0;

        repeat (20) @(posedge clk);

        // Feed data from file
        while (!$feof(fin)) begin
            status = $fscanf(fin, "%h\n", x_s_axis_data_tdata);
            if (status != 1) break;
            sample_number = sample_number + 1;
            x_s_axis_data_tvalid = 1;
            if (sample_number == 256) x_s_axis_data_tlast = 1; // Last sample after 256 samples
            wait (x_s_axis_data_tready && x_s_axis_data_tvalid);
            @(negedge clk);
        end

        x_s_axis_data_tvalid = 0;
        x_s_axis_data_tlast = 0;

        // Wait for DUT to finish
        repeat (4000) @(posedge clk);

        $fclose(fin);
        $fclose(fout);
        $finish;
    end

    // Capture DUT output
    always @(posedge clk) begin
        if (ifft_m_axis_data_tvalid) begin
            $display("%h\n", ifft_m_axis_data_tdata);
            $fwrite(fout, "%h\n", ifft_m_axis_data_tdata);
        end
        else if (x_m_axis_data_tvalid) begin
            $display("%h", x_m_axis_data_tdata);
            $fwrite(fout2, "%h\n", x_m_axis_data_tdata);
        end
    end

endmodule
