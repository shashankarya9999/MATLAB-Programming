% FIR band-pass filter of length 21 and 41
clear;
clc;
% sampling frequency
fs = 8e3;
% lower cutoff frequency
fl = 2.5e3;
% upper cutoff frequency
fh = 3e3;
% normalized lower cutoff frequency
wl = 2*pi*(fh/fs);
% normalized upper cutoff frequency
wh = 2*pi*(fl/fs);
% filter length
N=21;
% N = input('Enter filter length: ');
% filter order
M = N-1;
n=0:M;
% ideal sinc function for band-pass filter
hd_low = (wl/pi)*sinc((wl/pi)*(n-M/2));
hd_high = (wh/pi)*sinc((wh/pi)*(n-M/2));
% bandpass impulse response(difference of LPFs)
hd = hd_high - hd_low;

% window functions
% rectangular window
w_rect = ones(1,N);
% hamming Window
w_hamming = 0.54-0.46*cos(2*pi*(n/M));
% hann Window
w_hann = 0.5-0.5*cos(2*pi*(n/M));  
% Blackman window
w_blackman = 0.42-0.5*cos(2*pi*(n/M)) + 0.08*cos(4*pi*(n/M));

% apply windows
h_rect = hd.*w_rect;
h_hamming = hd.*w_hamming;
h_hann = hd.*w_hann;
h_blackman = hd.*w_blackman;

% compute frequency response
[H_rect,w] = freqz(h_rect,1,1024,fs);
[H_hamming,~] = freqz(h_hamming,1,1024,fs);
[H_hann,~] = freqz(h_hann,1,1024,fs);
[H_blackman,~] = freqz(h_blackman,1,1024,fs);

% plot all magnitude responses
figure;
subplot(2,1,1);
plot(w,20*log10(abs(H_rect)), 'r', 'LineWidth',1.5);
hold on;
plot(w,20*log10(abs(H_hamming)), 'g', 'LineWidth',1.5);
plot(w,20*log10(abs(H_hann)), 'b', 'LineWidth',1.5);
plot(w,20*log10(abs(H_blackman)), 'm', 'LineWidth',1.5);
xlabel('Frequency(Hz)');
ylabel('Magnitude(dB)');
ylim([-150 5]);
title(['Magnitude Response (N = ',num2str(N),')']);
legend('Rectangular','Hamming','Hann','Blackman');

% plot all phase resonses
subplot(2,1,2);
plot(w,angle(H_rect), 'r', 'LineWidth',1.5);
hold on;
plot(w,angle(H_hamming), 'g', 'LineWidth',1.5);
plot(w,angle(H_hann), 'b', 'LineWidth',1.5);
plot(w,angle(H_blackman), 'm', 'LineWidth',1.5);
xlabel('Frequency(Hz)');
ylabel('Phase(radians)');
title(['Phase Response (N = ',num2str(N),')']);
legend('Rectangular','Hamming','Hann','Blackman');
hold off;

sgtitle("FIR Band-pass filter design using Window method");
