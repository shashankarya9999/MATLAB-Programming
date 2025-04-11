clear;

% linear phase low-pass FIR filter
% sampling freq
fs = 8000; 
% cutoff freq
fc = 2000; 
% filter lengths
N1 = 21; 
N2 = 41; 

% normalized frequency 
normalized_fc = fc / (fs / 2);

% frequency vector for 'fir2'
% [0, fc, fs/2]
freqs = [0, normalized_fc, 1]; 
% desired magnitude response [passband, stopband]
mags = [0, 1, 1]; 

% fir2 filter design
h1 = fir2(N1-1, freqs, mags); 
h2 = fir2(N2-1, freqs, mags);

% filter coefficients
disp('Filter coefficients for N = 21:');
disp(h1);
disp('Filter coefficients for N = 41:');
disp(h2);

% [h,w] = freqz(b,a,n) returns the frequency response of the specified digital filter. 
% specify a digital filter with numerator coefficients b and denominator coefficients a. 
% The function returns the n-point frequency response vector in h 
% and the corresponding angular frequency vector w.
[H1, w1] = freqz(h1, 1, 1024, fs); 
[H2, w2] = freqz(h2, 1, 1024, fs); 

% magnitude spectrum for N=21
subplot(2, 2, 1);
plot(w1, 20*log10(abs(H1)), 'LineWidth', 1.5);
title('Magnitude Response of High-pass Filter (N = 21)');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
ylim([-30 5]);

% phase spectrum for N=21
subplot(2, 2, 2);
plot(w1, angle(H1), 'LineWidth', 1.5);
title('Phase Response of High-pass FIR Filter (N = 21)');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');

% magnitude spectrum for N=41
subplot(2, 2, 3);
plot(w2, 20*log10(abs(H2)), 'LineWidth', 1.5);
title('Magnitude Response of high-pass Filter (N = 41)');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
ylim([-30 5]);

% phase spectrum for N=41
subplot(2, 2, 4);
plot(w1, angle(H2), 'LineWidth', 1.5);
title('Phase Response of high-pass Filter (N = 41)');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');

