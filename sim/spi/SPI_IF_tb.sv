`timescale 1ns/1ps

module SPI_IF_tb ();

    localparam NUM_TESTS = 5;

    localparam CLK_DIVIDE = 5;
    localparam DELAY_CYCLES = 10;

    logic clk;
	logic reset_n;
	
	logic SPI_SCLK;
	logic SPI_CS_N;
	logic SPI_DI;
	logic SPI_SDO_DRDY = 1'bz;
	
    // input channel
	logic [15:0] s_axis_tdata;
	logic s_axis_tvalid = 0;
	logic s_axis_tready;
    logic s_axis_tuser;
	
    // output channel
	logic [15:0] m_axis_tdata;
	logic m_axis_tuser; // DRDY value read before other stuff
	logic m_axis_tvalid;
	logic m_axis_tready = 0;

    SPI_IF #(
        .CLK_DIVIDE(CLK_DIVIDE),
        .DELAY_CYCLES(DELAY_CYCLES)
    ) DUT (
        .clk(clk),
        .reset_n(reset_n),
        
        .SPI_SCLK(SPI_SCLK),
        .SPI_CS_N(SPI_CS_N),
        .SPI_DI(SPI_DI),
        .SPI_SDO_DRDY(SPI_SDO_DRDY),
        
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tready(s_axis_tready),
        .s_axis_tuser(s_axis_tuser),

        .m_axis_tdata(m_axis_tdata),
        .m_axis_tuser(m_axis_tuser),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tready(m_axis_tready)
    );


    bit [15:0] data_in_axis [$]; // data fed in to AXIS input
    bit data_in_axis_tuser [$];
    logic [15:0] data_out_axis [$]; // data read from AXIS output
    logic data_out_axis_tuser [$];
    bit [15:0] data_in_SPI [$]; // data fed in to SPI interface
    bit data_in_SPI_drdy [$];
    logic [23:0] data_out_SPI [$]; // data read from SPI output



    task automatic ResetDUT();
        reset_n = 0; // asserted asynchronously
        #10
        @(posedge clk)
        reset_n <= 1; // deasserted synchronously
    endtask


    task automatic SendCommand();
        bit [15:0] command = $urandom;
        bit init_flag = $urandom;
        int tvalid_delay = $urandom_range(9,0) - signed'(4);

        if (tvalid_delay <= 0) begin
            s_axis_tdata <= command;
            s_axis_tvalid <= 1;
            s_axis_tuser <= init_flag;

            wait(s_axis_tready)
            data_in_axis.push_back(command);
            data_in_axis_tuser.push_back(init_flag);
            
        end else begin
            // Wait for tready and then assert tvalid after a delay
            do begin
                @(posedge clk);
            end while (~s_axis_tready);

            repeat (tvalid_delay-1) @(posedge clk);
            s_axis_tdata <= command;
            s_axis_tvalid <= 1;
            s_axis_tuser <= init_flag;

            data_in_axis.push_back(command);
            data_in_axis_tuser.push_back(init_flag);
        end

        // Wait for tready and tvalid to be high on clock edge (handshake)
        do begin
            @(posedge clk);
        end while (~s_axis_tready);

        // Deassert tvalid
        s_axis_tvalid <= 0;
        s_axis_tdata <= 'x;
        s_axis_tuser <= 'x;
    endtask

    task automatic ReadSPI();
        bit data_finished = 0;
        // bit drdy_timeout = 0;
        bit [23:0] send_data = $urandom;
        bit drdy_n = $urandom;
        logic [23:0] recv_data = 0;
        int SPI_frame_size; // 24 bits or 16 bits


        @(negedge SPI_CS_N)
        if (data_in_axis.size() == 0) begin
            $fatal(1, "[t:%0t] CS pulled low before AXIS gave command", $time);
        end
        SPI_frame_size = data_in_axis_tuser.pop_front() ? 24 : 16;

        fork
            begin : spi_thread
                // fork
                //     begin : drdy_thread
                //         // Wait 17 ns before DRDY signal is latched to SDO_DRDY
                //         #17 SPI_SDO_DRDY <= drdy_n;
                //         drdy_timeout = 1; 
                //     end
                // join_none
                SPI_SDO_DRDY <= drdy_n;

                for (int i = SPI_frame_size-1; i >= 0; --i) begin
                    @(posedge SPI_SCLK)
                    // if (!drdy_timeout) begin
                    //     drdy_timeout = 1;
                    //     $warning("[t:%0t] SCLK posedge before 17ns for SDO_DRDY pin to be driven", $time);
                    //     disable drdy_thread;
                    // end
                    SPI_SDO_DRDY <= send_data[i];
                    @(negedge SPI_SCLK)
                    recv_data[i] = SPI_DI;
                end

                data_finished = 1;
                $display("[t:%0t] SPI frame completed with data 0b%b", $time, recv_data[15:0]);
            end
        join_none

        @(posedge SPI_CS_N) 
        disable spi_thread;
        SPI_SDO_DRDY <= 1'bz;

        if (data_finished) begin // Check if CS pulled high before the SPI frame finished
            data_out_SPI.push_back(recv_data[15:0]);
            data_in_SPI.push_back(send_data[15:0]);
            data_in_SPI_drdy.push_back(drdy_n);
        end else begin
            $error("[t:%0t] CS high before SPI frame completed", $time);
        end

    endtask

    task automatic ReadAXISData();
        int tvalid_delay = $urandom_range(5+4,0) - signed'(4);

        if (tvalid_delay <= 0) begin
            m_axis_tready <= 1;
        end else begin
            do begin
                @(posedge clk);
            end while (~m_axis_tvalid);
            repeat (tvalid_delay-1) @(posedge clk);
            m_axis_tready <= 1;
        end

        do begin
            @(posedge clk);
        end while (~m_axis_tvalid);

        if (data_in_SPI.size() == 0) begin
            $fatal(1, "[t:%0t] AXIS output signalled valid before SPI provided data", $time);
        end
        m_axis_tready <= 0;
        data_out_axis.push_back(m_axis_tdata);
        data_out_axis_tuser.push_back(m_axis_tuser);
    endtask


    int A2S_test_num = 0;
    int A2S_errors = 0;
    int S2A_test_num = 0;
    int S2A_errors = 0;

    task automatic CheckSPICommand();
        bit success = 1; 

        wait(data_in_axis.size() > 0 && data_out_SPI.size() > 0);
        ++A2S_test_num;

        if (data_in_axis.pop_front() != data_out_SPI.pop_front()) begin
            success = 0;
            $error("[t:%0t] Command data mismatch", $time);
        end
        if (success) $display("Test %d: SUCCESS command data AXIS to SPI matches", A2S_test_num);
        else begin
            $display("Test %d: FAILURE command data AXIS to SPI mismatch", A2S_test_num);
            ++A2S_errors;
        end
    endtask

    task automatic CheckAXISOutput();
        bit success = 1;

        wait(data_in_SPI.size() > 0 && data_out_axis.size() > 0);
        ++S2A_test_num;

        if (data_in_SPI.pop_front() != data_out_axis.pop_front()) begin
            success = 0;
            $error("[t:%0t] SPI data mismatch", $time);
        end
        if (data_in_SPI_drdy.pop_front() != data_out_axis_tuser.pop_front()) begin
            success = 0;
            $error("[t:%0t] SPI DRDY mismatch", $time);
        end
        if (success) $display("Test %d: SUCCESS return data SPI to AXIS matches", S2A_test_num);
        else begin
            $display("Test %d: FAILURE return data SPI to AXIS mismatch", S2A_test_num);
            ++S2A_errors;
        end
    endtask


    initial clk = 0;
    always #5 clk = ~clk; 

    initial begin
        fork
            forever CheckSPICommand();
            forever CheckAXISOutput();
        join
    end

    // initial begin
    //     $timeformat(-9, 2, "ns");
    //     ResetDUT();
    //     for (int test = 0; test < NUM_TESTS; ++test) begin
    //         fork
    //             SendCommand();
    //             ReadSPI();
    //             ReadAXISData();
    //         join
    //     end

    //     #20 $finish();
    // end

    initial begin
        ResetDUT();
        fork
            repeat (NUM_TESTS) SendCommand();
            repeat (NUM_TESTS) ReadSPI();
            repeat (NUM_TESTS) ReadAXISData();
        join
        
        #50
        $display("Simulation finished!");
        $display("AXIS to SPI PASSED:%0d FAILED:%0d", NUM_TESTS-A2S_errors, A2S_errors);
        $display("SPI to AXIS PASSED:%0d FAILED:%0d", NUM_TESTS-S2A_errors, S2A_errors);
        $finish();
    end
    
endmodule
