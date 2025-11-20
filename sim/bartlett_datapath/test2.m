t = 0:0.1:100
signal = cos(2 * pi * 25000 * t) + cos(2 * pi * 40000 * t)
f=fft(signal,256)
plot(real(f))