clear all; close;
max_fs = 1e6; % constant maximum sampling frequency of xadc
sequences = 3; % min 3. 1 sequence == 2 channels.
transformsize = [4 8 16 32 64 128 256 512]; % power of 2
prop = 1480; % constant propagation speed of sound in water, 1480 m/s
fs = max_fs* (1./sequences) % sampling frequency of digital signal
sample_period = 1./fs
binsize = fs./transformsize

transformperiod = transformsize/max_fs % amount of time to get the signals for 1 transform
dist = prop * transformperiod % distance traveled by signal during transform period

subplot(3,1,1);
stairs(transformsize,dist)
set(gca,'XScale','log')
set(gca,'YScale','log')
xlabel("Transform size")
ylabel("Distance travelled by signal (m)")
title("Distance travelled by signal compared to transform size");

subplot(3,1,2);
stairs(transformsize,transformperiod*1e6)
set(gca,'XScale','log')
set(gca,'YScale','log')
xlabel("Transform size")
ylabel("Transform period (us)")
title("Transform acquisition period compared to transform size");

subplot(3,1,3);
stairs(transformsize,binsize/1e3)
set(gca,'XScale','log')
set(gca,'YScale','log')
xlabel("Transform size")
ylabel("Bin size (kHz)")
title("Transform bin size compared to transform size");