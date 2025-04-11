% linear phase band-pass FIR filter
% sampling frequency
fs = 8000; 
% lower cutoff frequency
fc1 = 2500; 
% upper cutoff frequency
fc2 = 3000;
% filter lengths
N1 = 21; 
N2 = 41; 

% normalized lower cutoff
normalized_fc1 = fc1 / (fs / 2);
% normalized lower cutoff
normalized_fc2 = fc2 / (fs / 2); 

% frequency vector for 'fir2'
% [0, fc1, fc2, fs/2]
freqs = [0, normalized_fc1, normalized_fc2, 1]; 
% Desired magnitude response [passband, stopband, passband]
mags = [1, 0, 0, 1]; 

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
title('Magnitude Response of Band-Pass FIR Filter (N = 21)');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
ylim([-65 5]);

% phase spectrum for N=21
subplot(2, 2, 2);
plot(w1, angle(H1), 'LineWidth', 1.5);
title('Phase Response of Band-Pass FIR Filter (N = 21)');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');

% magnitude spectrum for N=41
subplot(2, 2, 3);
plot(w1, 20*log10(abs(H2)), 'LineWidth', 1.5);
title('Magnitude Response of Band-Pass FIR Filter (N = 41)');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
ylim([-65 5]);

% phase spectrum for N=41
subplot(2, 2, 4);
plot(w2, angle(H2), 'LineWidth', 1.5);
title('Phase Response of Band-Pass FIR Filter (N = 41)');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');


