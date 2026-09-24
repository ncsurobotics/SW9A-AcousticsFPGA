close all;
clear
k = 1:1:256; % Define the range for k
n= 0:1:255;
x = exp(-1j * 2 * pi * k .* n/ 256); % Correct the complex exponential

% Create the first subplot for the real part
plot3(k, n, real(x)); % Plot the real part against k
title('Real Part of x');
xlabel('k');
ylabel('n');
zlabel('Real(x)');

% Create the second subplot for the imaginary part
plot3(k, n, imag(x)); % Plot the imaginary part against k
title('Imaginary Part of x');
xlabel('k');
ylabel('n');
zlabel('Imaginary(x)');
