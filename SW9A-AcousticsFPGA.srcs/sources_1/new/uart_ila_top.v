`timescale 1ns / 1ps

module uart_ila_top (
    input wire clk
);


    wire [7:0]  rx_data;
    wire        rx_ready;
    wire [31:0] max_angle;
    wire        reset_n;

    wire uart_tx_ready = 1'b1;

    wire [7:0] Word_To_Send;
    wire       Word_To_Send_en;

    wire [31:0] m_axi_awaddr;
    wire        m_axi_awvalid;
    wire        m_axi_awready;

    wire [31:0] m_axi_wdata;
    wire [3:0]  m_axi_wstrb;
    wire        m_axi_wvalid;
    wire        m_axi_wready;

    wire [1:0]  m_axi_bresp;
    wire        m_axi_bvalid;
    wire        m_axi_bready;

    wire [31:0] m_axi_araddr;
    wire        m_axi_arvalid;
    wire        m_axi_arready;

    reg  [31:0] m_axi_rdata;
    reg  [1:0]  m_axi_rresp;
    reg         m_axi_rvalid;
    wire        m_axi_rready;

    vio_0 vio_inst (
        .clk(clk),

        .probe_out0(rx_data),
        .probe_out1(rx_ready),
        .probe_out2(max_angle),
        .probe_out3(reset_n)
    );

    UART_TRANSACTION_HANDLER uart_handler_inst (
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


    // =========================================================
    // Simple synthesizable AXI-Lite test slave
    // =========================================================

    reg [31:0] axi_memory [0:63];

    integer i;

    assign m_axi_arready = !m_axi_rvalid;

    always @(posedge clk or negedge reset_n) begin

        if (!reset_n) begin

            m_axi_rdata  <= 32'b0;
            m_axi_rresp  <= 2'b00;
            m_axi_rvalid <= 1'b0;

        end
        else begin

            if (m_axi_arvalid && m_axi_arready) begin

                m_axi_rdata  <= axi_memory[m_axi_araddr[5:0]];
                m_axi_rresp  <= 2'b00;
                m_axi_rvalid <= 1'b1;

            end

            else if (m_axi_rvalid && m_axi_rready) begin

                m_axi_rvalid <= 1'b0;

            end

        end

    end

    reg [31:0] awaddr_hold;
    reg        aw_pending;

    reg [31:0] wdata_hold;
    reg [3:0]  wstrb_hold;
    reg        w_pending;

    reg [1:0] bresp_reg;
    reg       bvalid_reg;


    assign m_axi_awready = !aw_pending && !bvalid_reg;
    assign m_axi_wready  = !w_pending  && !bvalid_reg;

    assign m_axi_bresp  = bresp_reg;
    assign m_axi_bvalid = bvalid_reg;


    always @(posedge clk or negedge reset_n) begin

        if (!reset_n) begin

            awaddr_hold <= 32'b0;
            aw_pending  <= 1'b0;

            wdata_hold <= 32'b0;
            wstrb_hold <= 4'b0;
            w_pending  <= 1'b0;

            bresp_reg  <= 2'b00;
            bvalid_reg <= 1'b0;

            for (i = 0; i < 64; i = i + 1)
                axi_memory[i] <= 32'b0;

            axi_memory[6'h05] <= 32'h12345678;

        end
        else begin
        
            if (m_axi_awvalid && m_axi_awready) begin

                awaddr_hold <= m_axi_awaddr;
                aw_pending  <= 1'b1;

            end

            if (m_axi_wvalid && m_axi_wready) begin

                wdata_hold <= m_axi_wdata;
                wstrb_hold <= m_axi_wstrb;
                w_pending  <= 1'b1;

            end

            if (aw_pending && w_pending && !bvalid_reg) begin

                if (wstrb_hold[0])
                    axi_memory[awaddr_hold[5:0]][7:0]
                        <= wdata_hold[7:0];

                if (wstrb_hold[1])
                    axi_memory[awaddr_hold[5:0]][15:8]
                        <= wdata_hold[15:8];

                if (wstrb_hold[2])
                    axi_memory[awaddr_hold[5:0]][23:16]
                        <= wdata_hold[23:16];

                if (wstrb_hold[3])
                    axi_memory[awaddr_hold[5:0]][31:24]
                        <= wdata_hold[31:24];

                aw_pending <= 1'b0;
                w_pending  <= 1'b0;

                bresp_reg  <= 2'b00;
                bvalid_reg <= 1'b1;

            end

            if (bvalid_reg && m_axi_bready) begin

                bvalid_reg <= 1'b0;

            end

        end

    end

    wire [2:0] debug_status;

    assign debug_status = {
        Word_To_Send_en,
        rx_ready,
        uart_tx_ready
    };


    ila_0 ila_inst (
        .clk(clk),

        .probe0(rx_data),
        .probe1(rx_ready),

        .probe2(Word_To_Send),
        .probe3(Word_To_Send_en),

        .probe4(m_axi_awaddr),
        .probe5(m_axi_awvalid),
        .probe6(m_axi_awready),

        .probe7(m_axi_wdata),
        .probe8(m_axi_wstrb),
        .probe9(m_axi_wvalid),
        .probe10(m_axi_wready),

        .probe11(m_axi_bresp),
        .probe12(m_axi_bvalid),
        .probe13(m_axi_bready),

        .probe14(m_axi_araddr),
        .probe15(m_axi_arvalid),
        .probe16(m_axi_arready),

        .probe17(m_axi_rdata),
        .probe18(m_axi_rresp),
        .probe19(m_axi_rvalid),
        .probe20(m_axi_rready),

        .probe21(debug_status)
    );


endmodule