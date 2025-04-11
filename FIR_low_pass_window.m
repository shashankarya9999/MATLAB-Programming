% FIR low-pass filter of length 21 and 41
clear;
% sampling frequency
fs = 8e3;
% cutoff frequency
fc = 2e3;
% filter length 
N=21;
% N = input('Enter filter length: ');
% normalized cutoff frequency
wc = 2*pi*(fc/fs);

% window functions
% filter order
M = N - 1;
n = 0 : M;

% low-pass filter impulse response(ideal sinc function)
% shifted right by M/2 to the right to make it causal
hd = (wc/pi) * sinc((wc/pi) * (n - M/2));
% plot(hd)

% window functions
% rectangular window
w_rect = ones(1,N);
% hamming Window
w_hamming = 0.54-0.46*cos(2*pi*(n/M));
% hann Window
w_hann = 0.5-0.5*cos(2*pi*(n/M));  
% Blackman window
w_blackman = 0.42-0.5*cos(2*pi*(n/M)) + 0.08*cos(4*pi*(n/M));

% apply the window functions
h_rect = hd.*w_rect;
h_hamming = hd.*w_hamming;
h_hann = hd.*w_hann;
h_blackman = hd.*w_blackman;

%compute frequency response
% since w remains same for all window types(because we are using same freqz
% settings), we only need to store it once
% so ~ is used as a placeholder for output arguments that we want to ignore
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
hold off;

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

sgtitle("FIR Low-pass filter design using Window method");