`timescale 1ns/1ps


`include "constants.vh"

`define SAMPLE_RATE 128000.0
`define M_PI 3.141592653589793
`define PROPAGATION_SPEED 1480
`define SHORT_SIZE 16
`define SIGNAL_PATH "C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sweep_3"
`define CONFIG_PATH "C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sweep_3"
`define RESULTS_PATH "C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sweep_3"
`define DO_FILE_WRITE 0

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
		
		noise_value = 0;
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
	
	function void set_frequency(real new_freq);
		frequency=new_freq;
	endfunction
	
	function void set_phase(real new_phase);
		phase=new_phase;
	endfunction
	
	function void set_timedelay(real new_timedelay);
		timedelay=new_timedelay;
	endfunction

	function void set_snr(real new_snr);
		snr_db = new_snr;
	endfunction
	
	function void set_amplitude(real new_amplitude);
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
        foreach(sig_gen[i]) begin
            sig_gen[i] = new();
            if (sig_gen[i] == null)
                $fatal(1, "Could not construct signal generator %0d", i);
        end
		foreach(x_pos[i]) x_pos[i] = 0;
		foreach(y_pos[i]) y_pos[i] = 0;
    endfunction
	
	function void set_positions(real x[0:`HYDROPHONE_COUNT-1], real y[0:`HYDROPHONE_COUNT-1]);
	
		for(int i = 0; i < `HYDROPHONE_COUNT; i = i + 1)begin
		$display("HYDROPHONE_COUNT = %0d", `HYDROPHONE_COUNT);
$display("i = %0d", i);
$display("x_pos size = %0d", $size(x_pos));
$display("x size = %0d", $size(x));
			x_pos[i]=x[i];
			y_pos[i]=y[i];
		end
	endfunction
	
	function void set_frequency(real new_freq);
		foreach(sig_gen[i]) sig_gen[i].set_frequency(new_freq);
	endfunction
	
	function void set_theta(real new_theta); //degrees
		theta=(new_theta/180)*`M_PI;
		foreach(sig_gen[i])begin
			sig_gen[i].set_timedelay((x_pos[i]*$cos(theta)+y_pos[i]*$sin(theta))/(`PROPAGATION_SPEED));
		end
	endfunction
	
	function void set_amplitude(real new_amplitude);
		foreach(sig_gen[i])sig_gen[i].set_amplitude(new_amplitude);
	endfunction
	
	function void set_phase(real new_phase);
		foreach(sig_gen[i])sig_gen[i].set_phase(new_phase);
	endfunction
	
	
	function logic[`SHORT_SIZE * `HYDROPHONE_COUNT-1:0] get_signals();
		logic[`SHORT_SIZE * `HYDROPHONE_COUNT-1:0] result;
		foreach(sig_gen[i]) result[i*`SHORT_SIZE +: `SHORT_SIZE] = sig_gen[i].next_sample();
		get_signals = result;
	endfunction
	
	function void set_snr(real new_snr);
		foreach(sig_gen[i]) sig_gen[i].set_snr(new_snr);
	endfunction
	
endclass
	








module dsp_tb();

logic clk, reset_n;

logic	[`SHORT_SIZE * 2 * `HYDROPHONE_COUNT - 1:0]	s_axis_tdata;
logic	s_axis_tvalid;
logic	s_axis_tready;
logic	s_axis_tlast;

 // {beam_freq 8, upper frequency bound 8, lower frequency bound 8 , magnitude threshold 32}
logic	[8 + 8 + 8 + 32 - 1 : 0]	s_axis_config_tdata;
logic	s_axis_config_tvalid;
logic	s_axis_config_tready;
logic	s_axis_config_tlast;
logic	[6:0]	s_axis_config_tstrb;

logic 	[15:0]	m_axis_tdata;
logic 	m_axis_tvalid;
logic 	m_axis_tlast;
integer signals_file, config_file, results_file;

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
	.m_axis_tlast(m_axis_tlast)
    );


logic[31:0] threshold;
logic[7:0] min_frequency, max_frequency, beam_freq;
// Controller for bartlett config	
bartlett_config_controller bartlett_config_controller_inst(
	.clk(clk),
	.reset_n(reset_n),
	.max_frequency(max_frequency),
	.min_frequency(min_frequency),
	.threshold(threshold),
	.m_axis_config_tdata(s_axis_config_tdata),
	.m_axis_config_tstrb(s_axis_config_tstrb),
	.m_axis_config_tvalid(s_axis_config_tvalid),
	.m_axis_config_tready(s_axis_config_tready)
);


task Reset();
	$display("Beginning Reset");

clk = 0;
reset_n = 0;
s_axis_tdata = '0;
s_axis_tvalid = '0;
s_axis_tready = '0;
s_axis_tlast = '0;
s_axis_config_tdata = '0;
s_axis_config_tvalid = '0;
s_axis_config_tready = '0;
s_axis_config_tlast = '0;
s_axis_config_tstrb = '0;
m_axis_tdata = '0;
m_axis_tvalid = '0;
m_axis_tlast = '0;
beam_freq = '0;
min_frequency = '0;
max_frequency = '0;
threshold = '0;
repeat(10) @(posedge clk);
@(negedge clk);
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
if (`HYDROPHONE_COUNT != 6)
    $fatal(1, "This pentagon + center geometry requires six hydrophones");
for (int i = 0; i < 5; i++) begin
    x_pos[i] = $cos(i*2.0*`M_PI/5.0)*d;
    y_pos[i] = $sin(i*2.0*`M_PI/5.0)*d;
end
x_pos[5] = 0.0;
y_pos[5] = 0.0;
// ULA
//foreach(x_pos[i])x_pos[i]=i*d;
//foreach(y_pos[i])y_pos[i]=0;
harray.set_positions(x_pos,y_pos);
$display("Finished Initializing Array");
endtask


task automatic SendSignal(input real freq, input real theta, input bit last_sample);
	logic[`HYDROPHONE_COUNT * `SHORT_SIZE -1 : 0] packed_signals;
	@(negedge clk);
	s_axis_tdata = '0; // Each complex lane is {imaginary=0, real sample}.
	s_axis_tlast = last_sample;
	harray.set_frequency(freq);
	harray.set_theta(theta);
	packed_signals = harray.get_signals();
	for(int i = 0; i < `HYDROPHONE_COUNT; i = i + 1)begin
		s_axis_tdata[2*i*`SHORT_SIZE +: `SHORT_SIZE] = packed_signals[i*`SHORT_SIZE+:`SHORT_SIZE];
		signals[i] = packed_signals[i*`SHORT_SIZE+:`SHORT_SIZE];
		if(`DO_FILE_WRITE) $fwrite(signals_file,"%c%d",i==0 ? " " : ",",$signed(signals[i]));		
	end
	if(`DO_FILE_WRITE) $fwrite(signals_file,"\n");		
	s_axis_tvalid = 1;
    // Keep data, valid and last stable until an accepting rising edge.
    do begin
        @(posedge clk);
    end while (s_axis_tready !== 1'b1);
    @(negedge clk);
    s_axis_tvalid = 0;
    s_axis_tlast = 0;

endtask

int batch_index = 0;
string config_filename, signal_filename, results_filename;
// Keep scalar queues instead of a queue of unpacked structs containing reals.
// This also avoids the invalid real-valued concatenation in push_back().
int sent_start_time[$];
real sent_end_time[$];
real sent_frequency[$];
real sent_angle[$];
real sent_snr[$];
int sent_count[$];
int received_time[$]; 
logic [15:0] received_results[$];
localparam int RESULT_TIMEOUT_CYCLES = 100000;




task automatic SendBatch(input real freq, input real theta, input int count, input real snr);
    if (harray == null) $fatal(1, "Hydrophone array has not been initialized");
    if (count < 1) $fatal(1, "Batch count must be positive");
    $display("Configuring batch %0d", batch_index);
    harray.set_snr(snr);
    sent_frequency.push_back(freq);
    sent_angle.push_back(theta);
    sent_count.push_back(count);
    sent_snr.push_back(snr);
	$display("Beginning Send Batch with frequency: %f, theta: %f, count: %0d, snr: %f",freq,theta,count,snr);
	config_filename = $sformatf(
		"%s\\sim_%0d_%0.3f_%0.3f_%0d_%0.3f_config.csv",
		`CONFIG_PATH, batch_index, freq, theta, count, snr
		);
	if(`DO_FILE_WRITE) config_file = $fopen(config_filename,"w");
    if(`DO_FILE_WRITE) if (!config_file) $fatal(1, "Cannot open %s", config_filename);
	if(`DO_FILE_WRITE) $fwrite(config_file,"frequency,theta,count,snr,samplerate\n");
	if(`DO_FILE_WRITE) $fwrite(config_file,"%f,%f,%0d,%f,%f\n",freq,theta,count,snr,`SAMPLE_RATE);
	if(`DO_FILE_WRITE) $fclose(config_file);
	signal_filename = $sformatf(
		"%s\\sim_%0d_%0.3f_%0.3f_%0d_%0.3f_signal.csv",
		`SIGNAL_PATH, batch_index, freq, theta, count, snr
		);	
	if(`DO_FILE_WRITE) signals_file = $fopen(signal_filename,"w");
    if(`DO_FILE_WRITE) if (!signals_file) $fatal(1, "Cannot open %s", signal_filename);
	sent_start_time.push_back($time());
    for (int n = 0; n < count; n++)
        SendSignal(freq, theta, n == count-1);
	sent_end_time.push_back($time());
    batch_index++;
	if(`DO_FILE_WRITE) if(signals_file) $fclose(signals_file);
	$display("Finished Send Batch");
endtask

task automatic SendSweep(
	real start_freq, real end_freq, int freq_steps, 
	real start_theta, real end_theta, int theta_steps, 
	real start_snr, real end_snr, int snr_steps, 
	int batchsize);
	real freq_step_size, theta_step_size, snr_step_size;
	freq_step_size = freq_steps==1 ? 0 : (end_freq-start_freq)/(freq_steps-1);
	theta_step_size = theta_steps==1 ? 0 : (end_theta-start_theta)/(theta_steps-1);
	snr_step_size = snr_steps==1 ? 0 : (end_snr-start_snr)/(snr_steps-1);
	for(int f = 0; f < freq_steps; f = f + 1)begin
		if((f*freq_step_size+start_freq - 25000) <= 2500) beam_freq = 0;
		else if((f*freq_step_size+start_freq - 30000) <= 2500) beam_freq = 1;
		else if((f*freq_step_size+start_freq - 35000) <= 2500) beam_freq = 2;
		else if((f*freq_step_size+start_freq - 40000) <= 2500) beam_freq = 3;
		else beam_freq = 0;
		#10;
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





task automatic WaitForResults();
    int cycles;
    cycles = 0;
    // The datapath can finish well after the final input handshake.
    while (received_results.size() < sent_frequency.size() &&
           cycles < RESULT_TIMEOUT_CYCLES) begin
        @(negedge clk);
        cycles++;
    end
    if (received_results.size() != sent_frequency.size())
        $fatal(1, "Expected %0d batch results, received %0d after %0d wait cycles",
               sent_frequency.size(), received_results.size(), cycles);
endtask

task automatic SaveResults();
    results_filename = $sformatf("%s\\sim_results.csv", `RESULTS_PATH);
	if(`DO_FILE_WRITE)begin
		results_file = $fopen(results_filename, "w");
		if (!results_file) $fatal(1, "Cannot open %s", results_filename);
		$fwrite(results_file, "Send_Start_time,Send_End_time,Elapsed_Send_time,Receive_time,Latency,Frequency,Count,SNR,Fixed Point Real Angle, Normalized Real Angle, Fixed Point Estimated Angle, Normalized Estimated Angle\n");
		
		foreach (sent_frequency[i]) begin
			$fwrite(results_file, "%0d,%0d,%0d,%0d,%0d,%f,%0d,%f,%f,%f,%0d,%f\n",
					sent_start_time.size() > i ? sent_start_time[i] : 0, 
					sent_end_time.size() > i ? sent_end_time[i] : 0,
					sent_end_time[i]-sent_start_time[i],
					received_time.size() > i ? received_time[i] : 0, 
					received_time[i]-sent_end_time[i],
					sent_frequency.size() > i ? sent_frequency[i] : 0, 
					sent_count.size() > i ? sent_count[i] : 0, 
					sent_snr.size() > i ? sent_snr[i] : 0, 
					sent_angle[i] *4096/180,
					sent_angle.size() > i ? sent_angle[i] : 0,
					received_results.size() > i ? received_results[i] : 0,
					180*received_results[i]/4096
					);
		end
		$fclose(results_file);
	end
endtask




// Headerless CSV: one time sample per row, one signed integer per hydrophone.
// Blank lines are ignored. Metadata defaults preserve SendFile(csv_path) calls.
task automatic SendFile(
    input string csv_path,
    input real freq = 0.0,
    input real theta = 0.0,
    input real snr = 0.0
);
    integer csv_file;
    int read_status, line_number, column, token_start, sample_value, count;
    string line, token, trailing;
    bit blank_line;
    logic [`SHORT_SIZE * 2 * `HYDROPHONE_COUNT-1:0] row_data;
    logic [`SHORT_SIZE * 2 * `HYDROPHONE_COUNT-1:0] rows[$];

    csv_file = $fopen(csv_path, "r");
    if (!csv_file) $fatal(1, "Cannot open input CSV %s", csv_path);
    line_number = 0;
    // Validate and buffer before transmitting so the last row is known even
    // when the file ends with blank lines or without a newline.
    while (!$feof(csv_file)) begin
        read_status = $fgets(line, csv_file);
        if (read_status == 0) begin
            if (!$feof(csv_file)) begin
                $fclose(csv_file);
                $fatal(1, "Error reading %s after line %0d", csv_path, line_number);
            end
            break;
        end
        line_number++;
        blank_line = 1;
        for (int j = 0; j < line.len(); j++) begin
            if (line.getc(j) != 8'd32 && line.getc(j) != 8'd9 &&
                line.getc(j) != 8'd13 && line.getc(j) != 8'd10)
                blank_line = 0;
        end
        if (blank_line) continue;
        row_data = '0;
        column = 0;
        token_start = 0;
        for (int j = 0; j <= line.len(); j++) begin
            if (j == line.len() || line.getc(j) == 8'd44) begin
                if (column >= `HYDROPHONE_COUNT || j == token_start) begin
                    $fclose(csv_file);
                    $fatal(1, "%s line %0d: expected exactly %0d nonempty columns",
                           csv_path, line_number, `HYDROPHONE_COUNT);
                end
                token = line.substr(token_start, j-1);
                // A second conversion detects any non-whitespace suffix.
                trailing = "";
                if ($sscanf(token, "%d %s", sample_value, trailing) != 1 ||
                    $isunknown(sample_value)) begin
                    $fclose(csv_file);
                    $fatal(1, "%s line %0d column %0d: expected a signed decimal integer",
                           csv_path, line_number, column+1);
                end
                if (sample_value < -(64'sd1 << (`SHORT_SIZE-1)) ||
                    sample_value > (64'sd1 << (`SHORT_SIZE-1))-1) begin
                    $fclose(csv_file);
                    $fatal(1, "%s line %0d column %0d: sample %0d exceeds signed %0d-bit range",
                           csv_path, line_number, column+1, sample_value, `SHORT_SIZE);
                end
                // Same packing as SendSignal: {imaginary=0, real sample}.
                row_data[2*column*`SHORT_SIZE +: `SHORT_SIZE] = sample_value;
                column++;
                token_start = j+1;
            end
        end
        if (column != `HYDROPHONE_COUNT) begin
            $fclose(csv_file);
            $fatal(1, "%s line %0d: expected %0d columns, got %0d",
                   csv_path, line_number, `HYDROPHONE_COUNT, column);
        end
        rows.push_back(row_data);
    end
    $fclose(csv_file);
    count = rows.size();
    if (count == 0) $fatal(1, "Input CSV %s has no samples", csv_path);

    // Track this replay in memory for WaitForResults/SaveResults.
    sent_frequency.push_back(freq);
    sent_angle.push_back(theta);
    sent_count.push_back(count);
    sent_snr.push_back(snr);
    sent_start_time.push_back($time());
    $display("Beginning Send File batch %0d: %s (%0d samples)", batch_index, csv_path, count);
    for (int n = 0; n < count; n++) begin
        @(negedge clk);
        s_axis_tdata = rows[n];
        s_axis_tlast = (n == count-1);
        s_axis_tvalid = 1;
        do begin
            @(posedge clk);
        end while (s_axis_tready !== 1'b1);
        @(negedge clk);
        s_axis_tvalid = 0;
        s_axis_tlast = 0;
    end
    sent_end_time.push_back($time());
    batch_index++;
    $display("Finished Send File");
endtask



always@(posedge clk)begin
	if(reset_n && m_axis_tvalid)begin
		received_results.push_back(m_axis_tdata);
		received_time.push_back($time());
		$display("Received result: %d\n",m_axis_tdata);
	end
end
initial begin
	Reset();
	InitArray();
	#100
	
	harray.set_amplitude(0.5);
	harray.set_phase(0);
	
	min_frequency = 0; // first positive bin
	max_frequency = 128; // last positive bin
	threshold = 10000; // arbitrary number
	beam_freq = 3; // 40k
	#10; // wait for config to write

	//SendFile("C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sim_295_40000.000_360.000_256_2.000_signal.csv");
	//#10 beam_freq = 0;
	//#50;
	//SendFile("C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sim_0_25000.000_0.000_256_0.500_signal.csv");
	/*
	
	SendFile("C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sim_222_40000.000_0.000_256_0.500_signal.csv");

	SendFile("C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sim_224_40000.000_10.000_256_0.500_signal.csv");

	SendFile("C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sim_226_40000.000_20.000_256_0.500_signal.csv");

	SendFile("C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sim_228_40000.000_30.000_256_0.500_signal.csv");

	SendFile("C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sim_230_40000.000_40.000_256_0.500_signal.csv");

	SendFile("C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sim_232_40000.000_50.000_256_0.500_signal.csv");

	SendFile("C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sim_234_40000.000_60.000_256_0.500_signal.csv");

	SendFile("C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sim_236_40000.000_70.000_256_0.500_signal.csv");

	SendFile("C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sim_238_40000.000_80.000_256_0.500_signal.csv");

	SendFile("C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sim_240_40000.000_90.000_256_0.500_signal.csv");

	SendFile("C:\\Users\\Aweso\\Verilog\\Aquapack\\sw9-jan\\sim\\dsp_tb\\sim_242_40000.000_100.000_256_0.500_signal.csv");

	SendSweep(
		25000,40000,4,
		0,360,37,
		0.5,2,2,
		256
		);
	*/	
	
	SendSweep(
		40000,40000,1,
		0,360,73,
		1,1,1,
		256
		);
	
	WaitForResults();
	SaveResults();
		
	$finish();
	
// The results appear to all be 16 unnormalized theta values off, which is also the step size of the theta generator. I am guessing there is an off by one error that needs to be resolved. also 180 -> 0 and 0 -> 180, but 90 and 270 were correct. a wider range of angles will need to be tested.
end



endmodule