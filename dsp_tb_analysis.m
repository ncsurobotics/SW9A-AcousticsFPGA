clear; close all;

% small helper: ternary function since MATLAB anonymous can't use ?: operator
function out = ternary(cond, a, b)
if cond
    out = a;
else
    out = b;
end
end
test_index = 37;

signals_filename = sprintf("sim\\dsp_tb\\sim_%d_signal.csv",test_index);
config_filename = sprintf("sim\\dsp_tb\\sim_%d_config.csv",test_index);
H = 6;   % number of hydrophones

opts = detectImportOptions(signals_filename);
opts.SelectedVariableNames = opts.VariableNames(1:H);

data = readmatrix(signals_filename, opts);

configCells = readcell(config_filename)

fieldNames = string(configCells(1, :));
fieldValues = configCells(2, :);

for k = 1:numel(fieldNames)
    varName = matlab.lang.makeValidName(fieldNames(k));
    value = fieldValues{k};

    if isstring(value) || ischar(value)
        numericValue = str2double(value);
        if ~isnan(numericValue)
            value = numericValue;
        end
    end

    assignin("base", varName, value);
end
% imports frequency, theta, count, snr, and samplerate as variables

t = 1:1:256;

Fs = samplerate;
data = transpose(data);
signal_fft = fft(data, [], 2);
shifted_signal_fft = fftshift(signal_fft);
f = Fs * (-floor(count/2):floor(count/2)-1) / count ;


[~, idx] = max(abs(signal_fft(1,:)));

numRows = size(signal_fft,1);

sumVals = zeros(numRows,1);   % complex sums
sumMags = zeros(numRows,1);   % optional


for r = 1:numRows
    segment = signal_fft(r, idx);
    sumVals(r) = sum(segment);          % complex sum
    sumMags(r) = sum(abs(segment));     % optional
end

%sumVals = sumVals .* exp(f_signal * j * 2 * pi * acquisition_delays);

R = sumVals * sumVals';
penta_d = 0.0254;
hydrophone_array = [cos(0)*penta_d sin(0)*penta_d 0
    cos(2*pi/5)*penta_d sin(2*pi/5)*penta_d 0
    cos(2*2*pi/5)*penta_d sin(2*2*pi/5)*penta_d 0
    cos(3*2*pi/5)*penta_d sin(3*2*pi/5)*penta_d 0
    cos(4*2*pi/5)*penta_d sin(4*2*pi/5)*penta_d 0
    0 0 0];

theta = 0:181:65536;
theta = theta * 2*pi/65536;
array_factor = zeros(H,length(theta)); % allocate space for array manifold

k = frequency * pi * 2/1480;
% Create array manifold (for each angle in theta, there is a 4x1 steering vector s(theta))
for i=1:length(theta)
    distance = cos(theta(i))*hydrophone_array(:,1) + sin(theta(i))*hydrophone_array(:,2); % get vertical and horizontal distance
    array_factor(:,i) = exp(-1j*k*distance) * 65536/4; % s(theta) = e^j * (distance * radians/meter)
end
af_theta = zeros(H, H, numel(theta));
for i = 1:numel(theta)
    af_theta(:, :, i) = array_factor(:, i) * array_factor(:, i)';
end

af_theta = af_theta * 1/(65536*2);

ptheta = squeeze(sum(af_theta .* R, [1 2]));










nTheta = numel(theta);

figure('Name', 'array_factor Slider Plot');

ax1 = subplot(2,1,1);
hReal = stairs(ax1, real(array_factor(:, 1)));
title(ax1, sprintf('Real Part of array\\_factor, Angle = %.1f deg', rad2deg(theta(1))));
xlabel(ax1, 'Element');
ylabel(ax1, 'Real Value');
%ylim(ax1, [-1.1 1.1])
grid(ax1, 'on');

ax2 = subplot(2,1,2);
hImag = stairs(ax2, imag(array_factor(:, 1)));
title(ax2, sprintf('Imaginary Part of array\\_factor, Angle = %.1f deg', rad2deg(theta(1))));
xlabel(ax2, 'Element');
ylabel(ax2, 'Imaginary Value');
%ylim(ax2, [-1.1 1.1])
grid(ax2, 'on');

if nTheta > 1
    sliderStep = [1 / (nTheta - 1) min(10 / (nTheta - 1), 1)];
else
    sliderStep = [1 1];
end

uicontrol('Style', 'slider', ...
    'Min', 1, 'Max', nTheta, 'Value', 1, ...
    'SliderStep', sliderStep, ...
    'Units', 'normalized', 'Position', [0.15 0.01 0.7 0.04], ...
    'Callback', @(src,~) updateArrayFactorPlot(src, array_factor, hReal, hImag, theta));

figure('Name', 'af_theta Slider Plot');

ax1 = subplot(2,1,1);
hRealAf = stairs(ax1, real(reshape(af_theta(:, :, 1).', [], 1)));
title(ax1, sprintf('Real Part of af\\_theta, Angle = %.1f deg', rad2deg(theta(1))));
xlabel(ax1, 'Index');
ylabel(ax1, 'Real Value');
grid(ax1, 'on');

ax2 = subplot(2,1,2);
hImagAf = stairs(ax2, imag(reshape(af_theta(:, :, 1).', [], 1)));
title(ax2, sprintf('Imaginary Part of af\\_theta, Angle = %.1f deg', rad2deg(theta(1))));
xlabel(ax2, 'Index');
ylabel(ax2, 'Imaginary Value');
grid(ax2, 'on');

if nTheta > 1
    sliderStep = [1 / (nTheta - 1) min(10 / (nTheta - 1), 1)];
else
    sliderStep = [1 1];
end

uicontrol('Style', 'slider', ...
    'Min', 1, 'Max', nTheta, 'Value', 1, ...
    'SliderStep', sliderStep, ...
    'Units', 'normalized', 'Position', [0.15 0.01 0.7 0.04], ...
    'Callback', @(src,~) updateAfThetaPlot(src, af_theta, hRealAf, hImagAf, theta));


signal_fig = figure('Name','Signals at Hydrophones');
signals_P = gobjects(H,1);
hold on;
for i = 1:H
    signals_P(i) = stairs(t, data(i,:), 'DisplayName', ['Hydrophone ' num2str(i)]);
end
hold off;
title('Received Signals from Hydrophones');
xlabel('time (s)'); ylabel('Amplitude');
legend show; grid on;
cbPanel = uipanel('Parent', signal_fig, 'Title', 'Show Signals', ...
    'Units','normalized', 'Position',[0.78 0.25 0.20 0.35]); % adjust position as needed

% Create a checkbox for each hydrophone that toggles the corresponding plot
for i = 1:H
    % vertical stacking: compute normalized position
    posY = 1 - i*(1/(H+1));
    uicontrol(cbPanel, 'Style','checkbox', 'String', ['Hydrophone ' num2str(i)], ...
        'Units','normalized', 'Position',[0.05 posY 0.9 0.08], ...
        'Value', 1, ...
        'Callback', @(src,~) set(signals_P(i), 'Visible', ternary(src.Value==1, 'on', 'off')));
end




figure('Name', 'Channel Real and Imag FFTs');

subplot(2,1,1)
hold on
for i = 1:H
    stairs(f, real(shifted_signal_fft(i,:)))
end
hold off
title('FFT Real Part of All Channels')
xlabel('Frequency')
ylabel('Real Value')
xlim([-frequency*1.5 frequency*1.5])
grid on

subplot(2,1,2)
hold on
for i = 1:H
    stairs(f, imag(shifted_signal_fft(i,:)))
end
hold off
title('FFT Imaginary Part of All Channels')
xlabel('Frequency')
ylabel('Imaginary Value')
xlim([-frequency*1.5 frequency*1.5])
grid on



figure('Name', 'Channel Magnitude and Phase FFTs');

subplot(2,1,1)
hold on
for i = 1:H
    stairs(f, abs(shifted_signal_fft(i,:)))
end
hold off
title('FFT Real of All Channels')
xlabel('Frequency')
ylabel('Magnitude Value')
xlim([-frequency*1.5 frequency*1.5])
grid on

subplot(2,1,2)
hold on
for i = 1:H
    stairs(f, angle(shifted_signal_fft(i,:)))
end
hold off
title('FFT Phase of All Channels')
xlabel('Frequency')
ylabel('Phase Value')
%ylim([-pi pi])
xlim([-frequency*1.5 frequency*1.5])
grid on


figure('Name','Rxx plot');
subplot(2,1,1);
hold on;
stairs(real(reshape(R.',[],1)))
hold off;
title('Real Part of Rxx');
xlabel('Index');
ylabel('Real Value');
grid on;

subplot(2,1,2);
hold on;
stairs(imag(reshape(R.',[],1)));
hold off;
title('Imaginary Part of Rxx');
xlabel('Index');
ylabel('Imaginary Value');
grid on;


function updateAfThetaPlot(src, af_theta, hReal, hImag, theta)
idx = round(src.Value);
idx = max(1, min(numel(theta), idx));
src.Value = idx;

selected = af_theta(:, :, idx);
realVec = real(reshape(selected.', [], 1));
imagVec = imag(reshape(selected.', [], 1));

set(hReal, 'YData', realVec);
set(hImag, 'YData', imagVec);

title(hReal.Parent, sprintf('Real Part of af\\_theta, Angle = %.1f deg', rad2deg(theta(idx))));
title(hImag.Parent, sprintf('Imaginary Part of af\\_theta, Angle = %.1f deg', rad2deg(theta(idx))));
drawnow;
end

function updateArrayFactorPlot(src, array_factor, hReal, hImag, theta)
idx = round(src.Value);
idx = max(1, min(numel(theta), idx));
src.Value = idx;

selected = array_factor(:, idx);

set(hReal, 'YData', real(selected));
set(hImag, 'YData', imag(selected));

title(hReal.Parent, sprintf('Real Part of array\\_factor, Angle = %.1f deg', rad2deg(theta(idx))));
title(hImag.Parent, sprintf('Imaginary Part of array\\_factor, Angle = %.1f deg', rad2deg(theta(idx))));
drawnow;
end

figure('Name','PTheta');
plot(theta,abs(ptheta));