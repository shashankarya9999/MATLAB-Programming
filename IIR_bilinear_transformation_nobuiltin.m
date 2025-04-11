clc; clear; close all;

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

% convert frequencies using bilinear pre-warping
T = 1 / Fs;  
Wp = 2 * pi * Fp;  
Ws = 2 * pi * Fs_bp;  

% pre-warped frequencies
Omega_p = (2/T) * tan(Wp * T / 2);  
Omega_s = (2/T) * tan(Ws * T / 2);  

% butterworth filter order
epsilon = sqrt(10^(Rp/10) - 1);  
N = ceil(log10((10^(As/10) - 1) / epsilon^2) / (2 * log10(Omega_s / Omega_p)));

% cutoff frequency
Omega_c = Omega_p / (epsilon^(1/N));

% analog Butterworth poles
k = (1:N);
poles = Omega_c * exp(1j * pi * (2*k + N - 1) / (2*N));

% analog transfer function H(s)
[num_s, den_s] = zp2tf([], poles, Omega_c^N);  

% convert to digital filter using Bilinear Transformation
[num_z, den_z] = bilinear(num_s, den_s, Fs);  

% frequency response of the designed digital filter
[H, W] = freqz(num_z, den_z, 1024, Fs);  

% Plot Gain Response
figure;
subplot(2,1,1);
plot(W, 20*log10(abs(H)), 'b', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Response of Butterworth Low-pass Filter');
grid on;
ylim([-80 5]);

% Plot Phase Response
subplot(2,1,2);
plot(W, angle(H), 'r', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
title('Phase Response of Butterworth Low-pass Filter');
grid on;

sgtitle('IIR Low-pass filter design using Bilinear Transformation Method');
