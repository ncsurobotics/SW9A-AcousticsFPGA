`timescale 1ns/1ps





// Takes in CHANNEL_COUNT channels of 16 bit fixed point signed (1.15) data in 1 axi stream.
// zero pad after
module hilbert_fir_filter_axis_wrapper #(
	parameter CHANNEL_COUNT = 4,
	parameter NUM_SIZE = 32, //imag,real, 2's c or fix_15
	parameter FIR_LATENCY = 33
	) (
	input clk, reset_n,
	input clk_enable,
	
	input[NUM_SIZE * CHANNEL_COUNT  - 1 : 0] s_axis_tdata,
	input s_axis_tvalid, s_axis_tlast,
	
	output[NUM_SIZE * CHANNEL_COUNT - 1 : 0] m_axis_tdata,
	output m_axis_tvalid, m_axis_tlast
	);
	
	
		reg s_last_latch, m_last_latch;

	
	wire[NUM_SIZE * CHANNEL_COUNT  - 1 : 0] muxed_sdata = s_last_latch 
						? 0 
						: s_axis_tdata;
						
	wire muxed_valid = 	s_last_latch
						? 1
						: s_axis_tvalid;
	
		wire[NUM_SIZE/2 - 1 : 0] imag_result[CHANNEL_COUNT -1  : 0], real_result[CHANNEL_COUNT -1  : 0], nothing;
	wire validOut;
	assign m_axis_tvalid = validOut & !m_last_latch;

	
	shift_register #(
		.SIZE(1),
		.STAGES(FIR_LATENCY)
		) last_latency(
		.clk(clk),
		.reset_n(reset_n),
		.enable(clk_enable),
		.din(s_axis_tlast),
		.dout(m_axis_tlast)
	);
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n) begin
			s_last_latch <= 0;
			m_last_latch <= 0;
		end else begin
			m_last_latch <= m_last_latch ? !s_axis_tvalid : m_axis_tlast;
			s_last_latch <= s_last_latch ? !m_axis_tlast : s_axis_tlast;
		end
	end


	genvar i, j;
	generate
	for(i = 0; i < CHANNEL_COUNT; i=i+1)begin
		hilbert_fir_filter_1027 channel_filter(
			.clk(clk),
			.reset(reset_n),
			.resetIn(~reset_n),
			.clk_enable(clk_enable),
			.dataIn(muxed_sdata[i * (NUM_SIZE) +: NUM_SIZE/2]),
			.validIn(muxed_valid),
			.ce_out(),//don't care
			.dataOut({imag_result[i],nothing}),
			.validOut(validOut)
			);
		shift_register #(
			.SIZE(NUM_SIZE/2), //only store real
			.STAGES(FIR_LATENCY)
			) real_data_buffer(
			.clk(clk),
			.reset_n(reset_n),
			.enable(clk_enable),
			.din(muxed_sdata[i * (NUM_SIZE) +: NUM_SIZE/2]),
			.dout(real_result[i])
			);
	end
	endgenerate
	
	assign m_axis_tdata = {	imag_result[3], real_result[3],
							imag_result[2], real_result[2],
							imag_result[1], real_result[1],
							imag_result[0], real_result[0]};
	
endmodule
