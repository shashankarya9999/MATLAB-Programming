clear;
% sampling frequency
fs = 8e3;
% cutoff frequency
fc = 2e3;
% filter length 
N=21;
% filter order
M = N-1;
% cutoff index in frequency domain
k_c = round((fc/fs)*M);

% initialize frequency response
H = zeros(1,N);
% passband (0 to fc)
H(1:k_c+1) = 1;
% symmetric passband for real response
H(N-k_c+1:N) = 1;

% compute IDFT to get time-domain filter coefficients, h[n]
h = real(ifft(H));

% shift for linear phase
h = fftshift(h);

% display filter coefficients
fprintf('FIR filter coefficients for N = %d: \n',N);
disp(h);

% frequency response
[Hf, w] = freqz(h,1,1024,fs);

% plot magnitude response
figure;
subplot(2,1,1);
plot(w,20*log10(abs(Hf)), 'b', 'LineWidth',1.5);
xlabel('Frequency(Hz)');
ylabel('Magnitude(dB)');
title(['Magnitude Response (N = ',num2str(N),')']);
ylim([-80 5])

% plot phase resonse
subplot(2,1,2);
plot(w,angle(Hf), 'r', 'LineWidth',1.5);
xlabel('Frequency(Hz)');
ylabel('Phase(radians)');
title(['Phase Response (N = ',num2str(N),')']);

sgtitle("FIR Low-pass filter design using Frequency Sampling method");