`timescale 1ns/1ps


`include "constants.vh"

`define SAMPLE_RATE 512000.0
`define M_PI 3.141592653589793
`define PROPAGATION_SPEED 1480
`define SHORT_SIZE 16


// Testbench to verify the functionality of the bartlett algorithm
// This one does not rely on external files (previous tb relied on matlab csvs)
class SignalGenerator;

    real frequency;
    real sample_rate;
    real amplitude;
    real phase;
    real snr_db;
	real timedelay;

    int sample_index;

    function new(
        real frequency   = 25000.0,
        real sample_rate = `SAMPLE_RATE,
        real amplitude   = 1.0,
        real phase       = 0.0,
        real snr_db      = 5.0
    );
        this.frequency    = frequency;
        this.sample_rate  = sample_rate;
        this.amplitude    = amplitude;
        this.phase        = phase;
        this.snr_db       = snr_db;
        this.sample_index = 0;
		this.timedelay	  = 0;
    endfunction


    // Generate one Gaussian random number
    // with mean = 0 and standard deviation = sigma
    function real gaussian_noise(real sigma);

        real u1;
        real u2;
        real z;

        // Uniform random numbers between 0 and 1
        u1 = ($urandom() + 1.0) / 4294967297.0;
        u2 = ($urandom() + 1.0) / 4294967297.0;

        // Box-Muller transform
        z = $sqrt(-2.0 * $ln(u1)) *
            $cos(2.0 * `M_PI * u2);

        return sigma * z;

    endfunction


    function shortint next_sample();

        real sine_value;
        real noise_value;
        real output_value;
        real noise_sigma;
		real t;

		t = sample_index/sample_rate;
        // Sine wave
        sine_value =
            amplitude *
            $sin(
                2.0 * `M_PI *
                frequency *
                (timedelay-t) +
                phase
            );

        // Calculate noise standard deviation
        //
        // Psignal = A^2 / 2
        // Pnoise  = Psignal / 10^(SNR/10)
        //
        noise_sigma =
            amplitude /
            ($sqrt(2.0) *
             $pow(10.0, snr_db / 20.0));

        // Gaussian noise
        noise_value = gaussian_noise(noise_sigma);

        // Add noise
        output_value = sine_value + noise_value;

        sample_index++;

        // Convert to signed 16-bit
        output_value = output_value * 32767.0;

        // Prevent overflow
        if (output_value > 32767.0)
            output_value = 32767.0;

        if (output_value < -32768.0)
            output_value = -32768.0;

        return shortint'($rtoi(output_value));

    endfunction
	
	function set_frequency(real new_freq);
		frequency=new_freq;
	endfunction
	
	function set_phase(real new_phase);
		phase=new_phase;
	endfunction
	
	function set_timedelay(real new_timedelay);
		timedelay=new_timedelay;
	endfunction

	function set_snr(real new_snr);
		snr_db = new_snr;
	endfunction
	
	function set_amplitude(real new_amplitude);
		amplitude = new_amplitude;
	endfunction

    function void reset();
        sample_index = 0;
    endfunction

endclass


class HydrophoneArray;

	real x_pos [0:`HYDROPHONE_COUNT-1];
	real y_pos [0:`HYDROPHONE_COUNT-1];
	SignalGenerator sig_gen [0:`HYDROPHONE_COUNT-1];
	real theta;
	
	
	function new();
        foreach(sig_gen[i])
            sig_gen[i] = new();
		foreach(x_pos[i]) x_pos[i] = 0;
		foreach(y_pos[i]) y_pos[i] = 0;
    endfunction
	
	
	function set_positions(real x[0:`HYDROPHONE_COUNT-1], real y[0:`HYDROPHONE_COUNT-1]);
	
		for(int i = 0; i < `HYDROPHONE_COUNT; i = i + 1)begin
		$display("HYDROPHONE_COUNT = %0d", `HYDROPHONE_COUNT);
$display("i = %0d", i);
$display("x_pos size = %0d", $size(x_pos));
$display("x size = %0d", $size(x));
			x_pos[i]=x[i];
			y_pos[i]=y[i];
		end
	endfunction
	
	function set_frequency(real new_freq);
		foreach(sig_gen[i]) sig_gen[i].set_frequency(new_freq);
	endfunction
	
	function set_theta(real new_theta); //degrees
		theta=(new_theta/180)*`M_PI;
		foreach(sig_gen[i])begin
			sig_gen[i].set_timedelay((x_pos[i]*$cos(theta)+y_pos[i]*$sin(theta))/(`PROPAGATION_SPEED));
		end
	endfunction
	
	function set_amplitude(real new_amplitude);
		foreach(sig_gen[i])sig_gen[i].set_amplitude(new_amplitude);
	endfunction
	
	
	function logic[`SHORT_SIZE * `HYDROPHONE_COUNT-1:0] get_signals();
		logic[`SHORT_SIZE * `HYDROPHONE_COUNT-1:0] result;
		foreach(sig_gen[i]) result[i*`SHORT_SIZE +: `SHORT_SIZE] = sig_gen[i].next_sample();
		get_signals = result;
	endfunction
	
	function set_snr(real new_snr);
		foreach(sig_gen[i]) sig_gen[i].set_snr(new_snr);
	endfunction
	
endclass
	








module dsp_tb();

logic clk, reset_n;

logic	[`SHORT_SIZE * 2 * `HYDROPHONE_COUNT - 1:0]	s_axis_tdata;
logic	s_axis_tvalid;
logic	s_axis_tready;
logic	s_axis_tlast;
logic	s_axis_tdest;

 // {beam_freq 8, upper frequency bound 8, lower frequency bound 8 , magnitude threshold 32}
logic	[8 + 8 + 8 + 32 - 1 : 0]	s_axis_config_tdata;
logic	s_axis_config_tvalid;
logic	s_axis_config_tready;
logic	s_axis_config_tlast;
logic	[6:0]	s_axis_config_tstrb;

logic 	[31:0]	m_axis_tdata;
logic 	m_axis_tvalid;
logic 	m_axis_tlast;
logic 	[7:0]	m_axis_tdest;

HydrophoneArray harray;
logic[`SHORT_SIZE -1:0] signals[`HYDROPHONE_COUNT-1:0];


bartlett_datapath #(
	.NUM_SIZE(`SHORT_SIZE * 2)
	) dut(
	.clk(clk),
	.reset_n(reset_n),
	
	.s_axis_tdata(s_axis_tdata),
	.s_axis_tvalid(s_axis_tvalid),
	.s_axis_tready(s_axis_tready),
	.s_axis_tlast(s_axis_tlast),

	.s_axis_config_tdata(s_axis_config_tdata),
	.s_axis_config_tvalid(s_axis_config_tvalid),
	.s_axis_config_tready(s_axis_config_tready),
	.s_axis_config_tstrb(s_axis_config_tstrb),
	
	.m_axis_tdata(m_axis_tdata),
	.m_axis_tvalid(m_axis_tvalid),
	.m_axis_tlast(m_axis_tlast),
	.m_axis_tdest(m_axis_tdest)

    );


task Reset();
	$display("Beginning Reset");

clk = 0;
reset_n = 0;
s_axis_tdata = '0;
s_axis_tvalid = '0;
s_axis_tready = '0;
s_axis_tlast = '0;
s_axis_tdest = '0;
s_axis_config_tdata = '0;
s_axis_config_tvalid = '0;
s_axis_config_tready = '0;
s_axis_config_tlast = '0;
s_axis_config_tstrb = '0;
m_axis_tdata = '0;
m_axis_tvalid = '0;
m_axis_tlast = '0;
m_axis_tdest = '0;
repeat(10) @(posedge clk);
reset_n = 1;
	$display("Finished Reset");

endtask

always #5 clk = ~clk;

task InitArray();
real x_pos[`HYDROPHONE_COUNT], y_pos[`HYDROPHONE_COUNT];
real d = 0.0254; // inter element distance
$display("Initializing Array");
harray=new();
// pentagon + 1 in the center
assert(`HYDROPHONE_COUNT==6);
//x_pos = {$cos(0*2*`M_PI/5)*d, $cos(1*2*`M_PI/5)*d, $cos(2*2*`M_PI/5)*d, $cos(3*2*`M_PI/5)*d, $cos(4*2*`M_PI/5)*d, 0};
//y_pos = {$sin(0*2*`M_PI/5)*d, $sin(1*2*`M_PI/5)*d, $sin(2*2*`M_PI/5)*d, $sin(3*2*`M_PI/5)*d, $sin(4*2*`M_PI/5)*d, 0};
// ULA
foreach(x_pos[i]) x_pos[i] = d * i;
foreach(y_pos[i]) y_pos[i] = 0;
harray.set_positions(x_pos,y_pos);
$display("Finished Initializing Array");
endtask

task SendSignal(real freq, real theta);
	logic[`HYDROPHONE_COUNT * `SHORT_SIZE -1 : 0] packed_signals;
	harray.set_frequency(freq);
	harray.set_theta(theta);
	packed_signals = harray.get_signals();
	for(int i = 0; i < `HYDROPHONE_COUNT; i = i + 1)begin
		s_axis_tdata[2*i*`SHORT_SIZE +: `SHORT_SIZE] = packed_signals[i*`SHORT_SIZE+:`SHORT_SIZE];
		signals[i] = packed_signals[i*`SHORT_SIZE+:`SHORT_SIZE];
	end
	s_axis_tvalid = 1;
	wait(s_axis_tready);
	#1 @(posedge clk);
	s_axis_tvalid = 0;

endtask

task SendBatch(real freq, real theta, real count, real snr);
	harray.set_snr(snr);
	$display("Beginning Send Batch with frequency: %f, theta: %f, count: %f, snr: %f",freq,theta,count,snr);
	s_axis_tlast = 0;
	repeat(count-1) SendSignal(freq,theta);
	s_axis_tlast = 1;
	SendSignal(freq,theta);
	s_axis_tlast = 0;
	$display("Finished Send Batch");
endtask

task SendSweep(
	real start_freq, real end_freq, real freq_steps, 
	real start_theta, real end_theta, real theta_steps, 
	real start_snr, real end_snr, real snr_steps, 
	real batchsize);
	real freq_step_size, theta_step_size, snr_step_size;
	freq_step_size = freq_steps==1 ? 0 : (end_freq-start_freq)/(freq_steps-1);
	theta_step_size = theta_steps==1 ? 0 : (end_theta-start_theta)/(theta_steps-1);
	snr_step_size = snr_steps==1 ? 0 : (end_snr-start_snr)/(snr_steps-1);
	for(int f = 0; f < freq_steps; f = f + 1)begin
		for(int t = 0; t < theta_steps; t = t + 1)begin
			for(int s = 0; s < snr_steps; s = s + 1)begin
				SendBatch(
					f*freq_step_size+start_freq,
					t*theta_step_size+start_theta,
					batchsize,
					s*snr_step_size+start_snr
					);
			end
		end
	end
	
	
endtask

initial begin
	Reset();
	InitArray();
	harray.set_amplitude(0.5);
	s_axis_tready = 1;
	SendSweep(
		25000,40000,4,
		0,360,36,
		100,100,1,
		256
		);
	$finish();
	

end



endmodule