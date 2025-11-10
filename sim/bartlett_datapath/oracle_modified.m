function oracle_modified(path)
f = 30e3; % frequency of emitted sinusoid (pinger)
c = 1480;
lambda = c/f;
d = lambda/2; %lambda/2
H = 4;

fs = 500e3; % sampling freq
t256 = 256/fs; % time to get 256 samples

n = 0:1/fs:t256-1/fs; % discrete time
N = length(n);


do_file_write = false;
doPlotFFT = true;
directory = path
%directory = 'test_11_32_60_5';

hydro_path = strcat(directory,"\\data.csv");
rxx_path = strcat(directory,"\\oracle_rxx.csv");
rxx_mat_path = strcat(directory,"\\rxx.mat");
matpath = strcat(directory,"\\new_algo_magP.mat");
fft_path = strcat(directory,"\\oracle_fft.mat");
mag_fft_path = strcat(directory,"\\oracle_mag_fft.mat");
max_freq_mat_path = strcat(directory,"\\oracle_max_freq.mat");
max_freq_csv_path = strcat(directory,"\\oracle_max_freq.csv");



dd = (0:1:H-1) * d;

arrival_ang_estimate = 45; % degrees arrival angle (changeable)
arrival_ang_rad = deg2rad(arrival_ang_estimate); % arrival angle in rad


hydro_dec = readmatrix(hydro_path );
[rows, columns] = size(hydro_dec);
if rows == 5
    hydro_dec(5,:)=[];
end

theta = (0:10:180) * pi / 180; % define angle range
k = 2*pi/lambda; % constant

% Create array manifold (for each angle in theta, there is a 4x1 steering vector s(theta))
a = zeros(H,length(theta)); % allocate space for array manifold
for i=1:length(theta)
    a(:,i) = exp(1j*k*dd*cos(theta(i))); % s(theta)
end

% Hilbert Transform
negativeFreqs = ceilDiv(length(hydro_dec),2):length(hydro_dec);
fourier = fft(hydro_dec,[],2)/N; % scale fft to have Re and Im components between -1/+1
save(fft_path,'fourier');
fourier_mag = abs(fourier)
save(mag_fft_path,'fourier_mag')
if doPlotFFT
f_index = -128:1:127;
subplot(2,1,1);
plot(f_index ,real(fourier(1,:)));
subplot(2,1,2);
plot(f_index ,imag(fourier(1,:)));
figure
plot(f_index,abs(fourier(1,:)));
end
fourier(:,negativeFreqs) = zeros(4,length(negativeFreqs)); % zero negative frequencies

[maxValue, index] = max(fourier_mag(2, :));% 2 used to skip DC offset/1st frequency
freq = index * fs/256

max_freq_vector = fourier(:,index);
save(max_freq_mat_path,'max_freq_vector');
mfv_split = zeros(2,4);
mfv_split(1,:) = real(max_freq_vector);
mfv_split(2,:) = imag(max_freq_vector);
writematrix(transpose(mfv_split),max_freq_csv_path);
R = max_freq_vector * max_freq_vector' ;
save(rxx_mat_path ,'R');
R_vector = reshape(R,[],1);
R_vector_split = zeros(2,16);
R_vector_split(1, :) = real(R_vector)
R_vector_split(2, :) = imag(R_vector)
writematrix(transpose(R_vector_split),rxx_path);
% Calculate P(theta) for every theta
P = zeros(1,length(theta));
magP = zeros(1,length(theta));

% Normalize P by s(theta)^H*s(theta)
a_constants = cell(1, length(theta));
for i=1:length(theta)
    
    P(i) = a(:,i)'*R*a(:,i) / (a(:,i)'*a(:,i));
    magP(i) = norm(P(i)); 
    a_constants{i} = (a(:,i)*a(:,i)')./(a(:,i)'*a(:,i));
end

for a=1:length(a_constants)
    a_constants;
end


%export(a_constants)
fig = figure;
angle_axis = 0:10:180;
plot(angle_axis,magP);
title(directory);
xlabel("Frequency (Hz)");
ylabel("Relative weight");
grid on;
if do_file_write 
    save(matpath, 'magP');
    exportgraphics(fig ,strcat(directory,'\\matlab_new_algo_magP.png'));
end
end