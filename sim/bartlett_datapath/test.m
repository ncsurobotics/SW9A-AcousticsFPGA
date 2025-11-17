n = 0:1:255;
signal = sin(n * pi / 10);
plot(n,signal);
frequency = fft(signal,256);
subplot(2,1,1)
plot(n,real(frequency))
subplot(2,1,2)
plot(n,imag(frequency))
