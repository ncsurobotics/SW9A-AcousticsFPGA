`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/13/2025 01:17:03 PM
// Design Name: 
// Module Name: hilbert
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

module fft_max #(
	parameter NUM_SIZE = 32
	)(
    input clk,
    input reset_n,

    input [NUM_SIZE * `HYDROPHONE_COUNT - 1:0] s_axis_tdata,
    input s_axis_tvalid,
    input s_axis_tlast,
    output s_axis_tready,
	
	input[8 + 8 + 8 + 32 - 1 : 0] s_axis_config_tdata, // {upper,lower,threshold}
	input[6:0] s_axis_config_tstrb,
	input s_axis_config_tvalid,
	output s_axis_config_tready,

    output [NUM_SIZE * `HYDROPHONE_COUNT - 1:0] m_axis_tdata,
	output[7:0] m_axis_tuser,
    output m_axis_tvalid,
    input m_axis_tready,
    output m_axis_tlast,
	
	output [7:0] beam_freq
	
	
	// debug
	/*
	output[NUM_SIZE * `HYDROPHONE_COUNT:0] debug_fft,
	output debug_fft_valid,
	
	output[NUM_SIZE+1:0] debug_current_magnitude,
	output debug_current_magnitude_valid*/
	
);
    //config parameters
    localparam [`HYDROPHONE_COUNT-1:0] FWD = {`HYDROPHONE_COUNT{1'b1}};
    localparam [`HYDROPHONE_COUNT-1:0] REV = {`HYDROPHONE_COUNT{1'b0}};
    wire [39:0] fft_s_axis_config_tdata; 
	assign fft_s_axis_config_tdata[`HYDROPHONE_COUNT-1:0] = FWD;       //block float
	assign fft_s_axis_config_tdata[39:`HYDROPHONE_COUNT] = {(39-`HYDROPHONE_COUNT){1'b0}};       //block float
	
	wire [7:0] k_index;
	assign k_index = m_axis_tuser[7:0];
	
	wire [NUM_SIZE * `HYDROPHONE_COUNT - 1:0] m_axis_spectrum_tdata;
	wire[39:0] m_axis_spectrum_tuser;
    wire m_axis_spectrum_tvalid;
    wire m_axis_spectrum_tready;
    wire m_axis_spectrum_tlast;
	
	wire [NUM_SIZE:0] m_axis_status_tdata;
	
	assign debug_fft = m_axis_spectrum_tdata;
	assign debug_fft_valid = m_axis_spectrum_tvalid;
	/*
	reg toggle_ready;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n) begin
			s_axis_tready <= 1;
			toggle_ready <= 0;
		end else begin
			s_axis_tready <= s_axis_tready ^ toggle_ready;
			if(s_axis_tready)begin
				toggle_ready <= s_axis_tvalid && s_axis_tlast;
			end else begin
				toggle_ready <= m_axis_spectrum_tlast;
			end
		end
	end
	*/
	wire[NUM_SIZE/2 -1 : 0] signals[`HYDROPHONE_COUNT-1:0];
	genvar sig_index;
	generate
		for(sig_index=0;sig_index<`HYDROPHONE_COUNT;sig_index=sig_index+1)begin
			assign signals[sig_index] = s_axis_tdata[sig_index*NUM_SIZE +: NUM_SIZE/2];
		end
	endgenerate
    //first FFT
xfft_0 your_instance_name (
  .aclk(clk),                                                // input wire aclk
  .aresetn(reset_n),                                          // input wire aresetn
  .s_axis_config_tdata(fft_s_axis_config_tdata),                  // input wire [79 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(1),                // input wire s_axis_config_tvalid
  //.s_axis_config_tready(s_axis_config_tready),                // output wire s_axis_config_tready
  
  .s_axis_data_tdata(s_axis_tdata),                      // input wire [127 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_tvalid),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_tready),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_tlast),                      // input wire s_axis_data_tlast
  
  .m_axis_data_tdata(m_axis_spectrum_tdata),                      // output wire [127 : 0] m_axis_data_tdata
  .m_axis_data_tuser(m_axis_spectrum_tuser),                      // output wire [15 : 0] m_axis_data_tuser
  .m_axis_data_tvalid(m_axis_spectrum_tvalid),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(m_axis_spectrum_tready),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_spectrum_tlast),                      // output wire m_axis_data_tlast
  
  .m_axis_status_tdata(m_axis_status_tdata),                  // output wire [7 : 0] m_axis_status_tdata
  .m_axis_status_tvalid(m_axis_status_tvalid),                // output wire m_axis_status_tvalid
  .m_axis_status_tready(1),                // input wire m_axis_status_tready
  
  
  
  .event_frame_started(event_frame_started),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing),                  // output wire event_tlast_missing
 // .event_fft_overflow(event_fft_overflow),                    // output wire event_fft_overflow
  .event_status_channel_halt(event_status_channel_halt),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt)  // output wire event_data_out_channel_halt
);


genvar num_index;
wire[NUM_SIZE/2 -1:0] real_part[`HYDROPHONE_COUNT - 1:0], imag_part[`HYDROPHONE_COUNT - 1:0];
generate
	for(num_index = 0; num_index < `HYDROPHONE_COUNT; num_index = num_index+1)begin
		assign real_part[num_index] = m_axis_spectrum_tdata[NUM_SIZE * num_index +: NUM_SIZE/2];
		assign imag_part[num_index] = m_axis_spectrum_tdata[NUM_SIZE * num_index + NUM_SIZE/2 +: NUM_SIZE/2];
	end
endgenerate

max_fft_bin #(.NUM_SIZE(NUM_SIZE), .INDEX_COUNT(256))
	 max_fft_bin_inst (
	 .clk(clk),
	 .reset_n(reset_n),
     .s_axis_weight_tdata(m_axis_spectrum_tdata),
     .s_axis_weight_tvalid(m_axis_spectrum_tvalid),
     .s_axis_weight_tlast(m_axis_spectrum_tlast),
     .s_axis_weight_tuser(m_axis_spectrum_tuser[7:0]),
     .s_axis_weight_tready(m_axis_spectrum_tready),
	 
	 .s_axis_config_tdata(s_axis_config_tdata),
	 .s_axis_config_tready(s_axis_config_tready),
	 .s_axis_config_tstrb(s_axis_config_tstrb),
	 .s_axis_config_tvalid(s_axis_config_tvalid),
	 
	 .beam_freq(beam_freq),
	 
     .m_axis_max_tdata(m_axis_tdata),
     .m_axis_max_tvalid(m_axis_tvalid),
     .m_axis_max_tuser(m_axis_tuser),
     .m_axis_max_tlast(m_axis_tlast),
     .m_axis_max_tready(m_axis_tready),
	 
	 .debug_current_magnitude(debug_current_magnitude),
	 .debug_current_magnitude_valid(debug_current_magnitude_valid)
	);
		
	

endmodule


// finds the maximum frequency based on channel 0's magnitude squared
module max_fft_bin #(
	parameter NUM_SIZE = 32,
	parameter INDEX_COUNT = 256
	) (
	input clk, reset_n,

	// current weight input channel
	input[`HYDROPHONE_COUNT * NUM_SIZE - 1 : 0] s_axis_weight_tdata,
	input s_axis_weight_tvalid, s_axis_weight_tlast, 
	input[$clog2(INDEX_COUNT)  - 1: 0] s_axis_weight_tuser, // index
	output reg s_axis_weight_tready,
	
	input[8 + 8 + 8 + 32 - 1 : 0] s_axis_config_tdata, // {upper,lower,threshold}
	input[6:0] s_axis_config_tstrb,
	input s_axis_config_tvalid,
	output reg s_axis_config_tready,
	
	output reg[`HYDROPHONE_COUNT * NUM_SIZE - 1 :0] m_axis_max_tdata,
	output reg m_axis_max_tvalid, m_axis_max_tlast,
	output reg [$clog2(INDEX_COUNT)  - 1: 0] m_axis_max_tuser,
	input m_axis_max_tready,
	
	output[7:0] beam_freq,
	
	output[NUM_SIZE+1:0] debug_current_magnitude,
	output debug_current_magnitude_valid
	);
	
	assign debug_current_magnitude_valid = s_axis_weight_tvalid;
	assign debug_current_magnitude = current_magnitude;

	wire signed [NUM_SIZE/2 - 1:0] real_part[`HYDROPHONE_COUNT-1:0], imag_part[`HYDROPHONE_COUNT-1:0];
	wire [NUM_SIZE/2 - 1:0] max_real_part[`HYDROPHONE_COUNT-1:0], max_imag_part[`HYDROPHONE_COUNT-1:0];
	genvar part_select;
	generate
		for(part_select = 0; part_select < `HYDROPHONE_COUNT; part_select = part_select+1)begin
			assign real_part[part_select] = s_axis_weight_tdata[NUM_SIZE * part_select +: NUM_SIZE/2];
			assign imag_part[part_select] = s_axis_weight_tdata[NUM_SIZE * part_select + NUM_SIZE/2 +: NUM_SIZE/2];
			assign max_real_part[part_select] = m_axis_max_tdata[NUM_SIZE * part_select +: NUM_SIZE/2];
			assign max_imag_part[part_select] = m_axis_max_tdata[NUM_SIZE * part_select + NUM_SIZE/2 +: NUM_SIZE/2];
		end
	endgenerate
	
	reg signed [NUM_SIZE+1:0]  current_magnitude, maximum_magnitude;
	reg signed [NUM_SIZE:0]  partial_prod[1:0];
		
	localparam SR_SIZE = 2;
	integer i;
	reg valid_sr[SR_SIZE-1:0], last_sr[SR_SIZE-1:0];
	reg[7:0] user_sr[SR_SIZE-1:0];
	reg[`HYDROPHONE_COUNT * NUM_SIZE - 1:0] data_sr[SR_SIZE-1:0];
	reg valid_threshold;
	reg[8 + 8 + 8 + 32 - 1 : 0] config_register;
	
	reg[$clog2(INDEX_COUNT)  - 1: 0] current_frequency, partial_frequency, maximum_frequency;
	
	
	wire[7:0] upper_bound, lower_bound;
	wire[31:0] threshold;
	assign beam_freq = config_register[55:48];
	assign upper_bound = config_register[47:40];
	assign lower_bound = config_register[39:32];
	assign threshold = config_register[31:0];
	
	reg[7:0] timeout; // used to prevent state machine from getting stuck.
	
	reg [1:0] state;
	localparam IDLE = 2'b00;
	localparam IN_RANGE = 2'b01;
	localparam DONE = 2'b10;
	localparam WAIT = 2'b11;
		
always@(posedge clk or negedge reset_n)begin
	if(!reset_n)begin	
		for( i = 0; i < SR_SIZE; i= i + 1)begin
			valid_sr[i] <= 0;
			user_sr[i] <= 0;
			last_sr[i] <= 0;
			data_sr[i] <= 0;
		end
	end else begin
		valid_sr[0] <= s_axis_weight_tvalid;
		user_sr[0] <= s_axis_weight_tuser;
		last_sr[0] <= s_axis_weight_tlast;
		data_sr[0] <= s_axis_weight_tdata;
		for( i = 1; i < SR_SIZE; i= i + 1)begin
			valid_sr[i] <= valid_sr[i-1];
			user_sr[i] <= user_sr[i-1];
			last_sr[i] <= last_sr[i-1];
			data_sr[i] <= data_sr[i-1];
		end
	end
end

always@(*)begin
	case(state)
		IDLE: begin
			s_axis_config_tready <= !s_axis_weight_tvalid;
		end
		IN_RANGE: begin
			s_axis_config_tready <= 0;
		end
		DONE: begin
			s_axis_config_tready <= 0;
		end
		WAIT:begin
			s_axis_config_tready <= !s_axis_weight_tvalid;
		end
	endcase
end

	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			current_magnitude <= 0;
			maximum_magnitude <= 0;
			partial_prod[0] <= 0;
			partial_prod[1] <= 0; 
			m_axis_max_tdata <= 0;
			m_axis_max_tuser <= 0;
			s_axis_weight_tready <= 0;
			valid_threshold <= 0;
			state <= 0;
			config_register <= 56'h00FF0000001000;
			m_axis_max_tvalid <= 0;
			m_axis_max_tlast <= 0;
			timeout <= 0;
		/*
	UPPER_BOUND = 8'h19, // ~-25khz //248,  >40khz
	LOWER_BOUND = 8'h07, // ~40khz //238,  <25khz
	THRESHOLD = 32'h00001000 // arbitrary number
	*/
		end else begin
			if(timeout == 16'd10000) state <= IDLE;
			else begin
				case(state)
					IDLE: begin
						if((s_axis_weight_tuser <= upper_bound) && (s_axis_weight_tuser >= lower_bound))
							state <= IN_RANGE;
							
						timeout <= 0;
					end
					IN_RANGE: begin
						if(user_sr[0] >= upper_bound)
							state <= DONE;
							
						timeout <= timeout+1;
					end
					DONE: begin
						state <= WAIT;
						
						timeout <= timeout+1;
					end
					WAIT:begin
						if(last_sr[1])
							state <= IDLE;
							
						timeout <= timeout+1;
					end
				endcase
			end
			for(i = 0; i < 7; i=i+1)begin
				if(s_axis_config_tstrb[i] && s_axis_config_tvalid) config_register[i*8+:8] <= s_axis_config_tdata[i*8+:8];
				else config_register[i*8+:8] <= config_register[i*8+:8];
			end
			valid_threshold <= maximum_magnitude > threshold; 
			if(s_axis_weight_tvalid)begin 
				partial_prod[1] <= imag_part[0] * imag_part[0];
				partial_prod[0] <= real_part[0] * real_part[0];
				partial_frequency <= s_axis_weight_tuser;
			end else begin
				partial_prod[0] <= 0;
				partial_prod[1] <= 0;
				partial_frequency <= 0;
			end
			
			if(valid_sr[0] && (state==IN_RANGE))begin
				current_magnitude <= partial_prod[0] + partial_prod[1];
				current_frequency <= partial_frequency;
			end else begin
				current_magnitude <= 0;
				current_frequency <= 0;
			end

			if(current_magnitude > maximum_magnitude)begin
				m_axis_max_tdata <= data_sr[1];
				m_axis_max_tuser <= user_sr[1];
				maximum_magnitude <= current_magnitude;
				maximum_frequency <= current_frequency;
			end
			else begin
				m_axis_max_tdata <= state==IDLE ? 0 : m_axis_max_tdata;
				m_axis_max_tuser <= state==IDLE ? 0 : m_axis_max_tuser;
				maximum_magnitude <= state==IDLE ? 0 : maximum_magnitude;
				maximum_frequency <= state==IDLE ? 0 : maximum_frequency;
			end				
			s_axis_weight_tready <= m_axis_max_tready;
			m_axis_max_tlast <= state==DONE;
			m_axis_max_tvalid <= state==DONE && valid_threshold;

		end
	end

	
endmodule

