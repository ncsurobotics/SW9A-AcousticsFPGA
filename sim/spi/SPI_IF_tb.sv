`timescale 1ns/1ps

module SPI_IF_tb ();

    logic SPI_clk;
	logic SPI_reset_n;
	
	logic SPI_SCLK;
	logic SPI_CS_N;
	logic SPI_DI;
	logic SPI_SDO_DRDY;
	
    // input channel
	logic [15:0] s_axis_tdata;
	logic s_axis_tvalid;
	logic s_axis_tready;
	
    // output channel
	logic [15:0] m_axis_tdata;
	logic m_axis_tid; // DRDY value read before other stuff
	logic m_axis_tvalid;
	logic m_axis_tready;

    SPI_IF DUT (
        .SPI_clk(SPI_clk),
        .SPI_reset_n(SPI_reset_n),
        
        .SPI_SCLK(SPI_SCLK),
        .SPI_CS_N(SPI_CS_N),
        .SPI_DI(SPI_DI),
        .SPI_SDO_DRDY(SPI_SDO_DRDY),
        
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tready(s_axis_tready),

        .m_axis_tdata(m_axis_tdata),
        .m_axis_tid(m_axis_tid),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tready(m_axis_tready)
    );


    logic [15:0] next_command [$]; // data fed in to AXIS input
    logic [15:0] data_out_axis [$]; // data read from AXIS output
    logic [15:0] data_out_SPI [$]; // data read from SPI output
    logic DRDY_signal = 1'b0; // always ready (for now)

    task automatic ResetSPI();
        SPI_reset_n = 0; // asserted asynchronously
        #10
        @(posedge SPI_clk)
        SPI_reset_n <= 1; // deasserted synchronously
    endtask

    task automatic SendCommand(
        input bit [15:0] command = $urandom_range(16'hFFFF,0)
    );
        // Assert tvalid, put command
        @(posedge SPI_clk)
        s_axis_tdata <= command;
        s_axis_tvalid <= 1;

        // Wait for tready to be high on clock edge
        do begin
            @(posedge SPI_clk);
        end while (~s_axis_tready);

        // Deassert tvalid
        s_axis_tvalid <= 0;
        s_axis_tdata <= 'x;

        next_command.
    endtask

    task automatic ReadSPI();
        @(negedge SPI_CS_N)
        SPI_SDO_DRDY <= DRDY_signal;

        fork
            begin
                @(posedge SPI_clk)
                SPI_SDO_DRDY <=
            end
            begin
                @(posedge SPI_CS_N)
            end
        join_any
    endtask

    task automatic ReadAXISData();
        
    endtask


    initial SPI_clk = 0;
    always #5 SPI_clk = ~SPI_clk;

    

endmodule
