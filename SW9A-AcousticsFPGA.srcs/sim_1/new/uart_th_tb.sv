`timescale 1ns / 1ps

module uart_th_tb();

    logic clk;
    logic reset_n;

    always #5 clk = ~clk;

    logic [7:0] rx_data;
    logic       rx_ready;
    
    logic       uart_tx_ready;
    wire [7:0]  Word_To_Send;
    wire        Word_To_Send_en;

    logic [31:0] max_angle;

    wire [31:0] m_axi_awaddr;
    wire        m_axi_awvalid;
    logic       m_axi_awready;

    wire [31:0] m_axi_wdata;
    wire [3:0]  m_axi_wstrb;
    wire        m_axi_wvalid;
    logic       m_axi_wready;

    logic [1:0] m_axi_bresp;
    logic       m_axi_bvalid;
    wire        m_axi_bready;

    wire [31:0] m_axi_araddr;
    wire        m_axi_arvalid;
    logic       m_axi_arready;

    logic [31:0] m_axi_rdata;
    logic [1:0]  m_axi_rresp;
    logic        m_axi_rvalid;
    wire         m_axi_rready;

    UART_TRANSACTION_HANDLER dut (
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
        .m_axi_rready(m_axi_rready)
    );

    logic [31:0] axi_memory [0:63];

    integer i;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            m_axi_arready <= 1'b1;
            m_axi_rvalid  <= 1'b0;
            m_axi_rdata   <= 32'b0;
            m_axi_rresp   <= 2'b00;
        end
        else begin

            if (m_axi_arvalid && m_axi_arready && !m_axi_rvalid) begin
                m_axi_rdata  <= axi_memory[m_axi_araddr[5:0]];
                m_axi_rresp  <= 2'b00;
                m_axi_rvalid <= 1'b1;
            end

            else if (m_axi_rvalid && m_axi_rready) begin
                m_axi_rvalid <= 1'b0;
            end

        end
    end


    // -------------------------
    // AXI Write
    // -------------------------
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            m_axi_awready <= 1'b1;
            m_axi_wready  <= 1'b1;

            m_axi_bvalid  <= 1'b0;
            m_axi_bresp   <= 2'b00;
        end
        else begin

            if (!m_axi_bvalid &&
                m_axi_awvalid && m_axi_awready &&
                m_axi_wvalid  && m_axi_wready) begin

                if (m_axi_wstrb[0])
                    axi_memory[m_axi_awaddr[5:0]][7:0]
                        <= m_axi_wdata[7:0];

                if (m_axi_wstrb[1])
                    axi_memory[m_axi_awaddr[5:0]][15:8]
                        <= m_axi_wdata[15:8];

                if (m_axi_wstrb[2])
                    axi_memory[m_axi_awaddr[5:0]][23:16]
                        <= m_axi_wdata[23:16];

                if (m_axi_wstrb[3])
                    axi_memory[m_axi_awaddr[5:0]][31:24]
                        <= m_axi_wdata[31:24];

                m_axi_bresp  <= 2'b00;
                m_axi_bvalid <= 1'b1;
            end

            else if (m_axi_bvalid && m_axi_bready) begin
                m_axi_bvalid <= 1'b0;
            end

        end
    end

    localparam [1:0] OP_READ      = 2'b00;
    localparam [1:0] OP_WRITE     = 2'b01;
    localparam [1:0] OP_GET_ANGLE = 2'b10;


    // =========================================================
    // Send one UART byte
    // =========================================================

    task automatic SendByte(
        input [7:0] data
    );
    begin

        @(negedge clk);

        rx_data  = data;
        rx_ready = 1'b1;

        @(negedge clk);

        rx_ready = 1'b0;

    end
    endtask


    // =========================================================
    // GET_ANGLE
    //
    // Format:
    // [7:6] = 10
    // [5:0] = unused
    // =========================================================

    task automatic GetAngle();
    begin
        $display("GET_ANGLE");

        SendByte({OP_GET_ANGLE, 6'h00});
    end
    endtask


    // =========================================================
    // AXI Read
    //
    // One UART byte:
    // [7:6] = READ
    // [5:0] = address
    // =========================================================

    task automatic Read(
        input [5:0] addr
    );
    begin
        $display("READ address: 0x%02h", addr);

        SendByte({OP_READ, addr});
    end
    endtask


    // =========================================================
    // AXI Write
    //
    // Byte 0 = operation + address
    // Byte 1 = data[31:24]
    // Byte 2 = data[23:16]
    // Byte 3 = data[15:8]
    // Byte 4 = data[7:0]
    // =========================================================

    task automatic Write(
        input [5:0] addr,
        input [31:0] data
    );
    begin

        $display(
            "WRITE address: 0x%02h data: 0x%08h",
            addr,
            data
        );

        SendByte({OP_WRITE, addr});

        SendByte(data[31:24]);
        SendByte(data[23:16]);
        SendByte(data[15:8]);
        SendByte(data[7:0]);

    end
    endtask


    // =========================================================
    // Receive a 32-bit UART response
    // =========================================================

    task automatic ReceiveWord(
        output [31:0] data
    );

        integer n;

    begin

        data = 32'b0;

        for (n = 0; n < 4; n = n + 1) begin

            do begin
                @(negedge clk);
            end while (!Word_To_Send_en);

            data = {
                data[23:0],
                Word_To_Send
            };

        end

        $display(
            "UART received: 0x%08h",
            data
        );

    end
    endtask


    // =========================================================
    // Test
    // =========================================================

    logic [31:0] received_data;


    initial begin

        clk = 1'b0;
        reset_n = 1'b0;

        rx_data  = 8'b0;
        rx_ready = 1'b0;

        uart_tx_ready = 1'b1;

        max_angle = 32'hABCDEF01;


        // Initialize fake AXI memory
        for (i = 0; i < 64; i = i + 1)
            axi_memory[i] = 32'b0;

        axi_memory[6'h05] = 32'h12345678;

        repeat (5)
            @(posedge clk);

        reset_n = 1'b1;

        repeat (3)
            @(posedge clk);


        // =====================================================
        // Test 1: GET_ANGLE
        // =====================================================

        GetAngle();

        ReceiveWord(received_data);

        if (received_data == max_angle)
            $display("GET_ANGLE PASS");
        else
            $error("GET_ANGLE FAIL");


        repeat (5)
            @(posedge clk);


        // =====================================================
        // Test 2: AXI Read
        // =====================================================

        Read(6'h05);

        ReceiveWord(received_data);

        if (received_data == 32'h12345678)
            $display("AXI READ PASS");
        else
            $error("AXI READ FAIL");


        repeat (5)
            @(posedge clk);


        // =====================================================
        // Test 3: AXI Write
        // =====================================================

        Write(
            6'h09,
            32'hDEADBEEF
        );

        wait (
            m_axi_bvalid &&
            m_axi_bready
        );

        @(posedge clk);

        if (axi_memory[6'h09] == 32'hDEADBEEF)
            $display("AXI WRITE PASS");
        else
            $error("AXI WRITE FAIL");


        repeat (5)
            @(posedge clk);

        // =====================================================
        // Test 4: Read back written data
        // =====================================================

        Read(6'h09);

        ReceiveWord(received_data);

        if (received_data == 32'hDEADBEEF)
            $display("AXI WRITE/READBACK PASS");
        else
            $error("AXI WRITE/READBACK FAIL");


        repeat (10)
            @(posedge clk);


        $display("-----------------------------");
        $display("TESTBENCH COMPLETE");
        $display("-----------------------------");

        $finish;

    end


endmodule