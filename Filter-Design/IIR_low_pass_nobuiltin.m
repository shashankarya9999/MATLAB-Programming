clear;
% cutoff frequency in radians
wc = 0.45 * pi;
% sampling frequency
fs = 1; 
% sampling period
Ts = 1/fs; 

% Single Stage Realization (1st order analog LPF)
% Analog prototype: H(s) = 1 / (s + omega_c)
% gain of the analog filter
K = 1; 
% numerator coefficients
num_single = K; 
% denominator coefficients
den_single = [1, wc]; 

% Bilinear Transform to get digital filter coefficients
s = tf('s');
H_s = K / (s + wc);
% convert to discrete-time system
H_z = c2d(H_s, Ts, 'tustin'); 

% coefficients of the single stage filter
b_single = H_z.Numerator{1};
a_single = H_z.Denominator{1};

% Cascade of Four 1st Order Filters
% Each first-order filter has the form: H(z) = b / (1 - a*z^-1)
% we will use the same coefficients as the single stage filter
% numerator coefficients from the single-stage filter
num_cascade = b_single; 
% denominator coefficients (using second coefficient)
den_cascade = [1, -a_single(2)]; 

% initialize the cascade transfer function
% start with a transfer function of 1
H_cascade = tf(1, 1); 

% create the cascade of four first-order filters
for i = 1:4
    H_cascade = H_cascade * tf(num_cascade, den_cascade); 
end

% frequency response
%f = linspace(0, pi, 1000); % Frequency range from 0 to pi
[H,f] = freqz(b_single, a_single);
[Hcas,~] = freqz(num_cascade, den_cascade);

figure;
subplot(2,1,1);
hold on;
plot(f,20*log10(abs(H)),'LineWidth',1.5);
plot(f,20*log10(abs(Hcas)),'LineWidth',1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Response');
ylim([-60 5]);
legend('4th order','four cascaded 1st order');
hold off;

subplot(2,1,2);
hold on;
plot(f,angle(H),'LineWidth',1.5);
plot(f,angle(Hcas),'LineWidth',1.5);
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
title('Phase Response');
legend('4th order','four cascaded 1st order');
hold off;

sgtitle('IIR Low pass filter design');

