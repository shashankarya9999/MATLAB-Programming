clc; clear; 

% sampling frequency in Hz
Fs = 80e3;        
% passband edge frequency
Fp = 4e3;         
% stopband edge frequency
Fs_bp = 20e3;  
% maximum passband ripple
Rp = 0.5;     
% minimum stopband attenuation in dB
As = 45;           

T=1/Fs;
Wp = 2 * pi * Fp;  
Ws = 2 * pi * Fs_bp;  

% determine butterworth filter order
epsilon = sqrt(10^(Rp/10) - 1);  
N = ceil(log10((10^(As/10) - 1) / epsilon^2) / (2 * log10(Ws / Wp)));

% compute cutoff frequency
Omega_c = Wp / (epsilon^(1/N));

% generate butterworth poles (s-domain)
k = (1:N);  
poles = Omega_c * exp(1j * pi * (2*k + N - 1) / (2*N));  

% Compute analog transfer function coefficients
% analog butterworth filter
[num_s, den_s] = zp2tf([], poles, Omega_c^N);  

% convert to digital filter using Impulse Invariance Method
% sampling period
T = 1 / Fs;  
% mapping s-domain poles to z-domain
poles_z = exp(poles * T); 
% digital filter
[num_z, den_z] = zp2tf([], poles_z, real(Omega_c^N * T^N));  

% compute frequency response of the designed digital filter
[H, W] = freqz(num_z, den_z, 1024, Fs);  

% frequency Response
figure;
subplot(2,1,1);
plot(W, 20*log10(abs(H)), 'b', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Response of Butterworth Low-pass Filter');
ylim([-80 5]);

subplot(2,1,2);
plot(W, angle(H), 'r', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
title('Phase Response of Butterworth Low-pass Filter');

sgtitle('IIR Low-pass filter design using Impulse Invariance Method');
