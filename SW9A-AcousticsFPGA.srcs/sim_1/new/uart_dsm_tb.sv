`timescale 1ns / 1ps

module uart_dsm_tb;

    localparam DSM_TDATA_WIDTH = 32;
    localparam AXI_ADDR_WIDTH  = 32;
    localparam AXI_DATA_WIDTH  = 32;

    reg clk = 0;
    reg reset_n = 0;

    always #5 clk = ~clk;   // 100 MHz

    // UART RX
    reg [7:0] rx_data = 0;
    reg       rx_ready = 0;

    // UART TX
    reg        uart_tx_ready = 1;
    wire [7:0] Word_To_Send;
    wire       Word_To_Send_en;

    reg [31:0] max_angle = 32'hABCDEF01;

    // AXI-Lite
    wire [31:0] m_axi_awaddr;
    wire        m_axi_awvalid;
    reg         m_axi_awready = 0;

    wire [31:0] m_axi_wdata;
    wire [3:0]  m_axi_wstrb;
    wire        m_axi_wvalid;
    reg         m_axi_wready = 0;

    reg [1:0]   m_axi_bresp = 0;
    reg         m_axi_bvalid = 0;
    wire        m_axi_bready;

    wire [31:0] m_axi_araddr;
    wire        m_axi_arvalid;
    reg         m_axi_arready = 0;

    reg [31:0]  m_axi_rdata = 0;
    reg [1:0]   m_axi_rresp = 0;
    reg         m_axi_rvalid = 0;
    wire        m_axi_rready;

    // DSM AXI-Stream
    reg [DSM_TDATA_WIDTH-1:0] s_axis_dsm_tdata = 0;
    reg                       s_axis_dsm_tvalid = 0;
    wire                      s_axis_dsm_tready;
    reg                       s_axis_dsm_tlast = 0;


    UART_TRANSACTION_HANDLER #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .DSM_TDATA_WIDTH(DSM_TDATA_WIDTH)
    ) dut (
        .clk(clk),
        .reset_n(reset_n),

        .rx_data(rx_data),
        .rx_ready(rx_ready),

        .uart_tx_ready(uart_tx_ready),
        .Word_To_Send(Word_To_Send),
        .Word_To_Send_en(Word_To_Send_en),

        .max_angle(max_angle),

        .m_axi_awaddr(m_axi_awaddr),
        .m_axi_awvalid(m_axi_awvalid),
        .m_axi_awready(m_axi_awready),

        .m_axi_wdata(m_axi_wdata),
        .m_axi_wstrb(m_axi_wstrb),
        .m_axi_wvalid(m_axi_wvalid),
        .m_axi_wready(m_axi_wready),

        .m_axi_bresp(m_axi_bresp),
        .m_axi_bvalid(m_axi_bvalid),
        .m_axi_bready(m_axi_bready),

        .m_axi_araddr(m_axi_araddr),
        .m_axi_arvalid(m_axi_arvalid),
        .m_axi_arready(m_axi_arready),

        .m_axi_rdata(m_axi_rdata),
        .m_axi_rresp(m_axi_rresp),
        .m_axi_rvalid(m_axi_rvalid),
        .m_axi_rready(m_axi_rready),

        .s_axis_dsm_tdata(s_axis_dsm_tdata),
        .s_axis_dsm_tvalid(s_axis_dsm_tvalid),
        .s_axis_dsm_tready(s_axis_dsm_tready),
        .s_axis_dsm_tlast(s_axis_dsm_tlast)
    );


    // ------------------------------------------------------------
    // Capture bytes sent toward UART
    // ------------------------------------------------------------

    reg [7:0] captured [0:63];
    integer captured_count = 0;

    always @(posedge clk) begin
        if (Word_To_Send_en) begin
            captured[captured_count] = Word_To_Send;

            $display(
                "UART BYTE %0d = 0x%02h",
                captured_count,
                Word_To_Send
            );

            captured_count = captured_count + 1;
        end
    end


    // ------------------------------------------------------------
    // Send one DSM AXI-Stream beat
    // ------------------------------------------------------------

    task send_dsm_beat(
        input [DSM_TDATA_WIDTH-1:0] data,
        input last
    );
    begin

        // Wait until DUT can accept a beat
        while (!s_axis_dsm_tready)
            @(posedge clk);

        @(negedge clk);

        s_axis_dsm_tdata  = data;
        s_axis_dsm_tvalid = 1'b1;
        s_axis_dsm_tlast  = last;

        // Handshake occurs at next rising edge
        @(posedge clk);

        @(negedge clk);

        s_axis_dsm_tvalid = 1'b0;
        s_axis_dsm_tlast  = 1'b0;
        s_axis_dsm_tdata  = 0;

    end
    endtask


    // ------------------------------------------------------------
    // Send one normal incoming UART byte
    // ------------------------------------------------------------

    task send_uart_byte(input [7:0] data);
    begin

        @(negedge clk);

        rx_data  = data;
        rx_ready = 1'b1;

        @(negedge clk);

        rx_ready = 1'b0;

    end
    endtask


    task check_byte(
        input integer index,
        input [7:0] expected
    );
    begin

        if (captured[index] !== expected) begin

            $display(
                "FAIL: byte %0d expected %02h got %02h",
                index,
                expected,
                captured[index]
            );

            $fatal;
        end

    end
    endtask


    initial begin

        // --------------------------------------------------------
        // RESET
        // --------------------------------------------------------

        #50;
        reset_n = 1'b1;

        repeat (5) @(posedge clk);


        // ========================================================
        // TEST 1
        // One DSM beat:
        // 12345678 -> 12 34 56 78
        // ========================================================

        $display("\nTEST 1: Single DSM beat");

        send_dsm_beat(32'h12345678, 1'b1);

        wait(captured_count == 4);

        check_byte(0, 8'h12);
        check_byte(1, 8'h34);
        check_byte(2, 8'h56);
        check_byte(3, 8'h78);

        $display("TEST 1 PASS");


        // ========================================================
        // TEST 2
        // Two-beat packet
        //
        // AABBCCDD
        // 11223344 TLAST
        //
        // expected:
        // AA BB CC DD 11 22 33 44
        // ========================================================

        $display("\nTEST 2: Multi-beat DSM packet");

        send_dsm_beat(32'hAABBCCDD, 1'b0);
        send_dsm_beat(32'h11223344, 1'b1);

        wait(captured_count == 12);

        check_byte(4,  8'hAA);
        check_byte(5,  8'hBB);
        check_byte(6,  8'hCC);
        check_byte(7,  8'hDD);

        check_byte(8,  8'h11);
        check_byte(9,  8'h22);
        check_byte(10, 8'h33);
        check_byte(11, 8'h44);

        $display("TEST 2 PASS");


        // ========================================================
        // TEST 3
        // UART backpressure
        // ========================================================

        $display("\nTEST 3: UART backpressure");

        uart_tx_ready = 1'b0;

        send_dsm_beat(32'hDEADBEEF, 1'b1);

        // No UART bytes should be transmitted
        repeat (10) @(posedge clk);

        if (captured_count != 12) begin
            $display("FAIL: data transmitted while UART not ready");
            $fatal;
        end

        // Release UART
        uart_tx_ready = 1'b1;

        wait(captured_count == 16);

        check_byte(12, 8'hDE);
        check_byte(13, 8'hAD);
        check_byte(14, 8'hBE);
        check_byte(15, 8'hEF);

        $display("TEST 3 PASS");


        // ========================================================
        // TEST 4
        // Make sure old GET_ANGLE path still works
        //
        // Command 10xxxxxx = 0x80
        // max_angle = ABCDEF01
        // ========================================================

        $display("\nTEST 4: Existing GET_ANGLE path");

        send_uart_byte(8'h80);

        wait(captured_count == 20);

        check_byte(16, 8'hAB);
        check_byte(17, 8'hCD);
        check_byte(18, 8'hEF);
        check_byte(19, 8'h01);

        $display("TEST 4 PASS");


        $display("\n----------------------------");
        $display("ALL DSM UART TESTS PASSED");
        $display("----------------------------");

        #100;

        $finish;

    end

endmodule