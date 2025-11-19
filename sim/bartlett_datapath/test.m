n = 0:1:15
x = ones(1,16)
pointsizes = [16 32 64 128]
index = 1;
figure;
% real fft
for pointsize = pointsizes
    subplot(4,1,index);
f = fft(x,pointsize)

stem(real(f))
    grid on;
title(sprintf("%d point DFT Real",pointsize))
ylabel('Magnitude')
xlabel('Frequency index');

index = index + 1

end
%imag fft
index = 1;
figure;
for pointsize = pointsizes
    subplot(4,1,index);
f = fft(x,pointsize)

stem(imag(f))
    grid on;
title(sprintf("%d point DFT Imaginary",pointsize))
ylabel('Magnitude')
xlabel('Frequency Index');

index = index + 1

end

figure;
% real ifft
index = 1;
for pointsize = pointsizes
    subplot(4,1,index);
f = ifft(fft(x,pointsize),pointsize)

stem(real(f))
    grid on;
title(sprintf("%d point IDFT Real",pointsize))
ylabel('Magnitude')
xlabel('Time');

index = index + 1

end

%imag ifft
index = 1;
figure;
for pointsize = pointsizes
    subplot(4,1,index);
f = ifft(fft(x,pointsize),pointsize)

stem(imag(f))
    grid on;
title(sprintf("%d point IDFT Imaginary",pointsize))
ylabel('Magnitude')
xlabel('Time');

index = index + 1

end
