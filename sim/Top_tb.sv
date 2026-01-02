`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AquaPack Robotics
// Engineer: Myles Oakley
// 
// Create Date: 10/12/2025 02:55:26 PM
// Design Name: 
// Module Name: SW9_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module SW9_tb;
    // dut vars
    logic clock_100MHz;
    logic reset_b;

    logic ADC_clk1, ADC_clk2, ADC_clk3, ADC_clk4;
    logic ADC_cs1, ADC_cs2, ADC_cs3, ADC_cs4;
    reg ADC_data1, ADC_data2, ADC_data3, ADC_data4;

    reg UART_rx;
    logic UART_tx;

    logic VGA1, VGA2, VGA3, VGA4;

    logic debug1, debug2, debug3, debug4;

    // memories for ADC samples
    logic [9:0] ADC1_samples [int];
    logic [9:0] ADC2_samples [int];
    logic [9:0] ADC3_samples [int];
    logic [9:0] ADC4_samples [int];
    
    int ADC1_sample_number = 0; 
    int ADC2_sample_number = 0; 
    int ADC3_sample_number = 0;
    int ADC4_sample_number = 0;

    int ADC1_total_samples = 0;
    int ADC2_total_samples = 0;
    int ADC3_total_samples = 0;
    int ADC4_total_samples = 0;

    // DUT instantiation
    top DUT (
        .reset_b(reset_b),
        .clk(clock_100MHz),

        // ADCs
        .ADC_clk1(ADC_clk1),
        .ADC_cs1(ADC_cs1),
        .ADC_serial_data1(ADC_data1),

        .ADC_clk2(ADC_clk2),
        .ADC_cs2(ADC_cs2),
        .ADC_serial_data2(ADC_data2),
        .ADC_clk3(ADC_clk3),
        .ADC_cs3(ADC_cs3),
        .ADC_serial_data3(ADC_data3),

        .ADC_clk4(ADC_clk4),
        .ADC_cs4(ADC_cs4),
        .ADC_serial_data4(ADC_data4),
        // UART
        .UART_tx(UART_tx),
        .UART_rx(UART_rx),

        // VGA
        .VGA1(VGA1),
        .VGA2(VGA2),
        .VGA3(VGA3),
        .VGA4(VGA4),

        // Other I/O
        .debug1(debug1),
        .debug2(debug2),
        .debug3(debug3),
        .debug4(debug4)

    );
    
    // parameters / defines
    parameter 
        period_100MHz = 10,  
        period_115200Baud = 8680.55,
        period_3MHz = 333.33333;

    // Send UART command task
    task send_UART_command(input [7:0] command);
        begin
            $display("Sending UART command: %h", command);
            // Send start bit
            UART_rx = 1'b0;
            #(period_115200Baud);
        
            // Send data bits (LSB first)
            for (int i = 0; i < 8; i = i + 1) begin
                UART_rx = command[i];
                #(period_115200Baud);
            end

            // Send stop bit
            UART_rx = 1'b1;
            #(period_115200Baud);
        end
    endtask

    task recieve_UART_response();
    logic [7:0] response;
        begin
            // wait for start bit
            @(negedge UART_tx);
            #(period_115200Baud / 2); // sample in the middle of the bit

            // read data bits
            
            for (int i = 0; i < 8; i = i + 1) begin
                #(period_115200Baud);
                response[7- i] = UART_tx;
            end

            // wait for stop bit
            #(period_115200Baud);
            if (UART_tx != 1'b1) begin
                $display("UART Response Error: Stop bit not detected");
            end else begin
                $display("Received UART response: %h", response);
            end
        end
    endtask

    task write_regs_to_file();
    int file = $fopen("output.txt", "w");
    int addr = 0;
    logic [7:0] rx_data;
        begin
            $fdisplay(file, "=========== Register Dump ===========");
            $fdisplay(file, "Address\t Data\t Time");
            for(addr = 0; addr < 26; addr = addr + 1) begin
                send_UART_command(addr); // write command
                // wait for start bit
                @(negedge UART_tx);
                #(period_115200Baud / 2);
            
                for (int i = 0; i < 8; i = i + 1) begin
                    #(period_115200Baud);
                    rx_data[7- i] = UART_tx;
                end

                #(period_115200Baud);
                if (UART_tx != 1'b1) begin
                    $fdisplay(file, "%h\t ERROR\t %0t", addr, $time);
                end else begin
                    $fdisplay(file, "%h\t %h\t %0t", addr, rx_data, $time);
                end
            end
            $fclose(file);
        end
    endtask

    // send ADC sample task
    task send_ADC_sample(input integer ADC, input [9:0] sample);
        // $display("Sending sample to ADC %0d: %h", ADC, sample);
        begin
            case (ADC) 
                1: begin
                    for (int i = 0; i < 14; i = i + 1) begin
                        @(posedge ADC_clk1);
                        if(i==13) ADC_data1 = 1'b1;
                        else if (i < 3) ADC_data1 = 1'b0;
                        else ADC_data1 = sample[12 - i];
                    end
                end
                2: begin 
                    for (int i = 0; i < 14; i = i + 1) begin
                        @(posedge ADC_clk2);
                        if(i==13) ADC_data2 = 1'b1;
                        else if (i < 3) ADC_data2 = 1'b0;
                        else ADC_data2 = sample[12 - i];
                    end
                end
                3: begin
                    for (int i = 0; i < 14; i = i + 1) begin
                        @(posedge ADC_clk3);
                        if(i==13) ADC_data3 = 1'b1;
                        else if (i < 3) ADC_data3 = 1'b0;
                        else ADC_data3 = sample[12 - i];
                    end
                end
                4: begin
                    for (int i = 0; i < 14; i = i + 1) begin
                        @(posedge ADC_clk4);
                        if(i==13) ADC_data4 = 1'b1;
                        else if (i < 3) ADC_data4 = 1'b0;
                        else ADC_data4 = sample[12 - i];
                    end
                end
            endcase
        end
    endtask

    // sample files (paste your absolute paths here)
    `define ADC1_sample_file "/home/bigpi/AMD/Vivado/2022.2/Projects/SW9A-AcousticsFPGA/sim/Bartlett_test_vals/ADC1_samples.txt"
    `define ADC2_sample_file "/home/bigpi/AMD/Vivado/2022.2/Projects/SW9A-AcousticsFPGA/sim/Bartlett_test_vals/ADC2_samples.txt"
    `define ADC3_sample_file "/home/bigpi/AMD/Vivado/2022.2/Projects/SW9A-AcousticsFPGA/sim/Bartlett_test_vals/ADC3_samples.txt"
    `define ADC4_sample_file "/home/bigpi/AMD/Vivado/2022.2/Projects/SW9A-AcousticsFPGA/sim/Bartlett_test_vals/ADC4_samples.txt"

    // clock_100MHz generation
   initial begin
        clock_100MHz = 0;
        forever #(period_100MHz/2) clock_100MHz = ~clock_100MHz;
    end

    // Reset generation
    initial begin
        reset_b = 0;
        #1000 reset_b = 1;
    end

    // UART_Tx stimulus
    initial begin
        // Initialize inputs
        UART_rx = 1'b1; // idle state


        
        //#(.0028*100000000); // wait for finish
        //write_regs_to_file();
                
    end

    // UART_Rx monitoring
    initial begin
        forever recieve_UART_response();
    end

    // ADC stimulus
    initial begin
        ADC_data1 = 1'b1;
        $readmemh(`ADC1_sample_file, ADC1_samples);
        ADC1_total_samples = $size(ADC1_samples);
        $display("Detected %0d samples for ADC1", ADC1_total_samples);
        forever @(negedge ADC_cs1) begin 
            if (ADC1_sample_number < ADC1_total_samples) begin
                $display("Sending ADC1 Sample Number: %0d, at time %0t", ADC1_sample_number, $time);
                send_ADC_sample(1, ADC1_samples[ADC1_sample_number++]);    
            end
            else ADC_data1 = 1'b1;
        end    
    end

    initial begin
        ADC_data2 = 1'b1;
        $readmemh(`ADC2_sample_file, ADC2_samples);
        ADC2_total_samples = $size(ADC2_samples);
        $display("Detected %0d samples for ADC2", ADC2_total_samples);
        forever @(negedge ADC_cs2) begin
            if (ADC2_sample_number < ADC2_total_samples) begin
                $display("Sending ADC2 Sample Number: %0d, at time %0t", ADC2_sample_number, $time);
                send_ADC_sample(2, ADC2_samples[ADC2_sample_number++]);    
            end
            else ADC_data2 = 1'b1;
        end
    end

    initial begin
        ADC_data3 = 1'b1;
        $readmemh(`ADC3_sample_file, ADC3_samples);
        ADC3_total_samples = $size(ADC3_samples);
        $display("Detected %0d samples for ADC3", ADC3_total_samples);
        forever @(negedge ADC_cs3) begin
            if (ADC3_sample_number < ADC3_total_samples) begin
                $display("Sending ADC3 Sample Number: %0d, at time %0t", ADC3_sample_number, $time);
                send_ADC_sample(3, ADC3_samples[ADC3_sample_number++]);   
            end 
            else ADC_data3 = 1'b1;
        end
    end

    initial begin
        ADC_data4 = 1'b1;
        $readmemh(`ADC4_sample_file, ADC4_samples);
        ADC4_total_samples = $size(ADC4_samples);
        $display("Detected %0d samples for ADC4", ADC4_total_samples);
        forever @(negedge ADC_cs4) begin
            if (ADC4_sample_number < ADC4_total_samples) begin
                $display("Sending ADC4 Sample Number: %0d, at time %0t", ADC4_sample_number, $time);
                send_ADC_sample(4, ADC4_samples[ADC4_sample_number++]);    
            end
            else ADC_data4 = 1'b1;
        end
    end

endmodule


