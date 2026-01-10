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

// 0 - no print, 1 - some print, 2 - lots of print
`define LOG_LEVEL 1

// sample files (paste your absolute paths here)
`define ADC1_sample_file "../../../../sim/Bartlett_test_vals/ADC1_samples.txt"
`define ADC2_sample_file "../../../../sim/Bartlett_test_vals/ADC2_samples.txt"
`define ADC3_sample_file "../../../../sim/Bartlett_test_vals/ADC3_samples.txt"
`define ADC4_sample_file "../../../../sim/Bartlett_test_vals/ADC4_samples.txt"

`define UART_dump_path "../../../../sim/Bartlett_test_vals/output.txt"


module SW9_tb;
    // dut vars
    logic clock_12MHz;
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
        .clk(clock_12MHz),

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
    
	
	
	UART_RX UART_RX_inst(
    
        .clk(clock_12MHz),
        .reset_b(reset_b),
        .RX_Data_in(UART_tx),
        
        .RX_Data_out(UART_TX_WORD),
        .RX_Data_Ready(UART_TX_READY)
        
    );
	logic[7:0] UART_buffer[3:0];
	wire[7:0] UART_TX_WORD;
	wire UART_TX_READY;
	logic displayed_tx_word=0;
	always @(*)begin
		if(UART_TX_READY && !displayed_tx_word)begin
			if(`LOG_LEVEL>=1) $display("Received UART response: %h", UART_TX_WORD);
			displayed_tx_word = 1;
		end else begin
			displayed_tx_word = 0;
		end
	end
	
	
    // parameters / defines
    parameter 
        period_12MHz = 83.333333,  
        period_115200Baud = 8680.55,
        period_3MHz = 333.33333;

    // Send UART command task
    task send_UART_command(input [7:0] command);
        begin
            if(`LOG_LEVEL>=1) $display("Sending UART command: %h", command);
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


    task write_regs_to_file();
    int file = $fopen(`UART_dump_path, "w");
    int addr = 0;
    logic [7:0] rx_data;
        begin
            $fdisplay(file, "=========== Register Dump ===========");
            $fdisplay(file, "Address\t Data\t Time");
            for(addr = 0; addr < 26; addr = addr + 1) begin
                send_UART_command(addr); // write command
                // wait for start bit
                wait(UART_TX_READY);
				rx_data = UART_TX_WORD;

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
    task automatic send_ADC_sample(input integer ADC, input [9:0] sample);
        if(`LOG_LEVEL>=2)$display("Sending sample to ADC %0d: %h", ADC, sample);
        begin
            case (ADC) 
                1: begin
                    for (int i = 0; i < 14; i = i + 1) begin
                        @(posedge ADC_clk1);
                        if(i==13) ADC_data1 = 1'b1;
                        else if (i < 3) ADC_data1 = 1'b0;
                        else ADC_data1 = sample[12 - i];
                    end
					if(`LOG_LEVEL>=2)$display("Done sending sample to ADC1: %h", sample);
                end
                2: begin 
                    for (int i = 0; i < 14; i = i + 1) begin
                        @(posedge ADC_clk2);
                        if(i==13) ADC_data2 = 1'b1;
                        else if (i < 3) ADC_data2 = 1'b0;
                        else ADC_data2 = sample[12 - i];
                    end
					if(`LOG_LEVEL>=2)$display("Done sending sample to ADC2: %h", sample);
                end
                3: begin
                    for (int i = 0; i < 14; i = i + 1) begin
                        @(posedge ADC_clk3);
                        if(i==13) ADC_data3 = 1'b1;
                        else if (i < 3) ADC_data3 = 1'b0;
                        else ADC_data3 = sample[12 - i];
                    end
					if(`LOG_LEVEL>=2)$display("Done sending sample to ADC3: %h", sample);
                end
                4: begin
                    for (int i = 0; i < 14; i = i + 1) begin
                        @(posedge ADC_clk4);
                        if(i==13) ADC_data4 = 1'b1;
                        else if (i < 3) ADC_data4 = 1'b0;
                        else ADC_data4 = sample[12 - i];
                    end
					if(`LOG_LEVEL>=2) $display("Done sending sample to ADC4: %h", sample);
                end
            endcase
        end
    endtask


    // clk_12mhz generation
   initial begin
        clock_12MHz = 0;
        forever #(period_12MHz/2) clock_12MHz = ~clock_12MHz;
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


       
		
		#(2900000); // wait for finish. 2.9ms
		write_regs_to_file();	
                
    end


    // ADC stimulus
    initial begin
        ADC_data1 = 1'b1;
        $readmemh(`ADC1_sample_file, ADC1_samples);
        ADC1_total_samples = $size(ADC1_samples);
        if(`LOG_LEVEL>=1) $display("Detected %0d samples for ADC1", ADC1_total_samples);
		if(`LOG_LEVEL>=2) foreach(ADC1_samples[i]) if(i<5)$display("%x",ADC1_samples[i]);
        forever @(negedge ADC_cs1) begin 
            if (ADC1_sample_number < ADC1_total_samples) begin
                if(`LOG_LEVEL>=1 && ADC1_sample_number%8==0) $display("Sending ADC1 Sample Number: %0d, at time %0t. Sample = %h", ADC1_sample_number, $time, ADC1_samples[ADC1_sample_number]);
                send_ADC_sample(1, ADC1_samples[ADC1_sample_number++]);    
            end
            else ADC_data1 = 1'b1;
        end    
    end

    initial begin
        ADC_data2 = 1'b1;
        $readmemh(`ADC2_sample_file, ADC2_samples);
        ADC2_total_samples = $size(ADC2_samples);
        if(`LOG_LEVEL>=1) $display("Detected %0d samples for ADC2", ADC2_total_samples);
		if(`LOG_LEVEL>=2) foreach(ADC2_samples[i]) if(i<5) $display("%x",ADC2_samples[i]);
        forever @(negedge ADC_cs2) begin
            if (ADC2_sample_number < ADC2_total_samples) begin
                if(`LOG_LEVEL>=1 && ADC2_sample_number%8==0) $display("Sending ADC2 Sample Number: %0d, at time %0t. Sample = %h", ADC2_sample_number,$time, ADC2_samples[ADC2_sample_number]);
                send_ADC_sample(2, ADC2_samples[ADC2_sample_number++]);    
            end
            else ADC_data2 = 1'b1;
        end
    end

    initial begin
        ADC_data3 = 1'b1;
        $readmemh(`ADC3_sample_file, ADC3_samples);
        ADC3_total_samples = $size(ADC3_samples);
        if(`LOG_LEVEL>=1)$display("Detected %0d samples for ADC3", ADC3_total_samples);
		if(`LOG_LEVEL>=2)foreach(ADC3_samples[i]) if(i<5) $display("%x",ADC3_samples[i]);
        forever @(negedge ADC_cs3) begin
            if (ADC3_sample_number < ADC3_total_samples) begin
                if(`LOG_LEVEL>=1 && ADC3_sample_number%8==0) $display("Sending ADC3 Sample Number: %0d, at time %0t. Sample = %h", ADC3_sample_number,$time,ADC3_samples[ADC3_sample_number]);
                send_ADC_sample(3, ADC3_samples[ADC3_sample_number++]);   
            end 
            else ADC_data3 = 1'b1;
        end
    end

    initial begin
        ADC_data4 = 1'b1;
        $readmemh(`ADC4_sample_file, ADC4_samples);
        ADC4_total_samples = $size(ADC4_samples);
        if(`LOG_LEVEL>=1)$display("Detected %0d samples for ADC4", ADC4_total_samples);
		if(`LOG_LEVEL>=2)foreach(ADC4_samples[i]) if(i<5) $display("%x",ADC4_samples[i]);
        forever @(negedge ADC_cs4) begin
            if (ADC4_sample_number < ADC4_total_samples) begin
                if(`LOG_LEVEL>=1 && ADC4_sample_number%8==0) $display("Sending ADC4 Sample Number: %0d, at time %0t. Sample = %h", ADC4_sample_number,$time, ADC4_samples[ADC4_sample_number]);
                send_ADC_sample(4, ADC4_samples[ADC4_sample_number++]);    
            end
            else ADC_data4 = 1'b1;
        end
    end

endmodule


