function generate_data_batch(angle_min,angle_inc,angle_max,iters_per_angle)
	%usage matlab -batch "generate_data_batch(ANGLE_MIN,ANGLE_INC,ANGLE_MAX,ITERATIONS_PER_ANGLE)"
    %constants 
f = 30e3; % frequency of emitted sinusoid (pinger)
c = 1480; % speed of sound in water
lambda = c/f; % wavelength
d = lambda/2; %lambda/2 spacing between hydrophones
H = 4;
dd = (0:1:H-1) * d; % hydrophone positions in meters. ULA
% 0	0.024666666666667	0.049333333333333	0.074000000000000
fs = 500e3; % sampling freq
t256 = 256/fs; % time to get 256 samples
dec_factor = 1; % downsampling factor

angle_range = angle_min : angle_inc : angle_max
for arrival_ang_estimate = angle_range
    for iter = 1:iters_per_angle
        
arrival_ang_rad = deg2rad(arrival_ang_estimate); % arrival angle in rad

% Delays for each hydrophone in samples
delay = zeros(H,1);
for h = 1 : H
    delay(h) = ceil(abs((((h-1) * d * cos(arrival_ang_rad)) / c) * fs));
end

max_delay = (d * sin(pi/2)) / c; % delay of last hydro if hit endfire
max_delay_samples = ceil(max_delay * fs);

n = 0:1/fs:t256-1/fs; % discrete time
N = length(n);

% Generate ping
signal = sin(2*pi*f*n); % pinger signal (biased to 2.5v)

% Hydro ~ (4,length(t)) array, each row is a signal received by each hydrophone
hydro = zeros(H, N); 

% Set refmic as mic that gets hit first and apply delays accordingly
if arrival_ang_estimate < 90
    for h = 1 : H
        hydro(H-h+1,:) = sin(2*pi*f*(n-delay(h)*1/fs));
    end
    refmic = hydro(H,:);
else
    for h = 1 : H
        hydro(h,:) = sin(2*pi*f*(n-delay(h)*1/fs));
    end
    refmic = hydro(1,:);
end

% Add AWGN noise to signals
signalPower = rms(hydro(:,1))^2;
[hydroNoisey, noiseVar] = awgn(hydro,0,'measured'); % 2nd parameter is SNR

% Decimate hydrophone signals
hydro_dec = zeros(H,N/dec_factor);
for h = 1 : H
    hydro_dec(h,:) = hydroNoisey(h,1:dec_factor:end);
end

% Normalize hydrophone data [-1, 1]
maximum = max(hydro_dec,[],"all");
minimum = min(hydro_dec,[],"all");
hydro_dec = (hydro_dec - minimum)/(maximum - minimum);
hydro_dec = 2 * hydro_dec - 1;

% Save to raw hydro data .mat file
path = 'C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\test_data\\hydro_data\\';
filename = "raw_hydro_data_" + num2str(arrival_ang_estimate) + "deg_" + num2str(iter);
save(path+filename+'.mat','hydro_dec');
writematrix(hydro_dec,path+filename+'.csv');




    end
end
