f = 30e3; % frequency of emitted sinusoid (pinger)
c = 1480;
lambda = c/f;
d = lambda/2; %lambda/2
H = 4;
N = 128000000; % number from running original script

dd = (0:1:H-1) * d;

arrival_ang_estimate = 45; % degrees arrival angle (changeable)
arrival_ang_rad = deg2rad(arrival_ang_estimate); % arrival angle in rad

hydro_dec = readmatrix('data.csv')

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
fourier(:,negativeFreqs) = zeros(4,length(negativeFreqs)); % zero negative frequencies
hydro_dec = ifft(fourier,[],2); % hydro_dec now complex

% Save fourier data (split real and imaginary components)
export_fourier = zeros(8, 256);
for i = 1:4
    export_fourier(2*i - 1, :) = real(fourier(i, :));
    export_fourier(2*i, :) = imag(fourier(i, :));
end
save('fft_data.mat','export_fourier')

% Save post hilbert transform hydrophone data (split real and imaginary components)
export_post_hilbert_data = zeros(8, 256);
for i = 1:4
    export_post_hilbert_data(2*i - 1, :) = real(hydro_dec(i, :));
    export_post_hilbert_data(2*i, :) = imag(hydro_dec(i, :));
end
save('post_hilbert_hydro_data.mat','export_post_hilbert_data')

% Create R
R = zeros(H,H); % allocate space for x(t)*x(t)^H

for i = 1 : length(hydro_dec)
    R = R + hydro_dec(:,i) * hydro_dec(:,i)';
end

R = R / N; % normalize by number of samples

% Save R matrix with real and imaginary parts interleaved row-wise
export_r_data = zeros(8, 4);  % 2 rows per original row (real and imag parts)
for i = 1:4
    export_r_data(2*i - 1, :) = real(R(i, :));
    export_r_data(2*i, :)     = imag(R(i, :));
end
save('export_r_data.mat', 'export_r_data');


% Calculate P(theta) for every theta
P = zeros(1,length(theta));
magP = zeros(1,length(theta));

% Normalize P by s(theta)^H*s(theta)
for i=1:length(theta)
    P(i) = a(:,i)'*R*a(:,i) / (a(:,i)'*a(:,i));
    magP(i) = norm(P(i)); 
end

save('magP.mat', 'magP');
figure1;
plot(magP);
exportgraphics(figure1,"matlab_magP.png")
