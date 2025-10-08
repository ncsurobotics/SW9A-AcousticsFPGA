`timescale 1ns/1ps

// Takes in CHANNEL_COUNT channels of 16 bit fixed point signed (1.15) data in 1 axi stream.
module hilbert_fir_filter_axis_wrapper #(
	parameter CHANNEL_COUNT = 4,
	parameter DO_IMAG_SKIP = 1 // assumes data inputted is (imag,real), and skips imag values
	) (
	input clk, reset_n,
	input clk_enable,
	
	input[(DO_IMAG_SKIP + 1) * 16 * CHANNEL_COUNT  - 1 : 0] s_axis_tdata,
	input s_axis_tvalid, s_axis_tlast,
	
	output[(DO_IMAG_SKIP + 1) * 16 * CHANNEL_COUNT - 1 : 0] m_axis_tdata,
	output m_axis_tvalid, m_axis_tlast
	);
	
	reg last_latch;
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n) begin
			last_latch <= 0;
		end else begin
			last_latch <= last_latch ? !m_axis_tlast : s_axis_tlast;
		end
	end
		
	
	wire[CHANNEL_COUNT * 16 - 1 : 0] dout_buffer, dout_buffer_2;
	wire valid_buffer;
	
	shift_register #(
		.SIZE(CHANNEL_COUNT * 16), .STAGES(1)
		) data_buffer(
		.clk(clk), 
		.reset_n(reset_n), 
		.enable(clk_enable),
		.din(dout_buffer), 
		.dout(dout_buffer_2)
		);
	
	shift_register #(
		.SIZE(1), .STAGES(1)
		) last_buffer(
		.clk(clk), 
		.reset_n(reset_n), 
		.enable(clk_enable),
		.din(valid_buffer), 
		.dout(m_axis_tvalid)
		);
		
	assign m_axis_tlast = !valid_buffer && m_axis_tvalid && last_latch; // if the next one is invalid, but this one is valid, then last. TODO

	genvar i, j;
	generate
	for(i = 0; i < CHANNEL_COUNT; i=i+1)begin
		hilbert_fir_filter channel_filter(
			.clk(clk),
			.reset(reset_n),
			.clk_enable(clk_enable),
			.dataIn(s_axis_tdata[i * (16 * (1 + DO_IMAG_SKIP)) +: 16]),
			.validIn(s_axis_tvalid),
			.ce_out(),//don't care
			.dataOut(dout_buffer[i * 16 +: 16]),
			.validOut(valid_buffer)
			);

	end
	endgenerate
	
	assign m_axis_tdata = {
		{16'h0000, dout_buffer_2[63:48],16'h0000, dout_buffer_2[47:32],16'h0000, dout_buffer_2[31:16],16'h0000, dout_buffer_2[15:0]}};
	
	
endmodule