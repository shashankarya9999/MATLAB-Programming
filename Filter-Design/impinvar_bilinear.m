% comparison between impulse invariance and bilinear transformation for IIR
% filter design

clear;
% sampling frequency
fs = 80e3;
% passband edge frequency
fpb = 4e3;
% stopband edge frequency
fsb = 20e3;
% maximum passband ripple
Rp = 0.5;
% minimum stopband attenuation
As = 45;

% frequencies for impulse invariance
wpb1 = 2*pi*fpb;
wsb1 = 2*pi*fsb;

% pre-warping frequencies for bilinear transformation
% wpb2= 2 * fs * tan(pi * fpb / fs);
% wsb2 = 2 * fs * tan(pi * fsb / fs);

% without pre-warping frequencies for bilinear transformation
wpb2 = 2*pi*fpb;
wsb2 = 2*pi*fsb;

% determine the order and cutoff frequency of Butterworth filter
[n,Wn] = buttord(wpb1,wsb1,Rp,As,'s');
[n2,Wn2] = buttord(wpb2,wsb2,Rp,As,'s');

% design the analog Butterworth low-pass filter
[b1,a1] = butter(n,Wn,'s');
[b2,a2] = butter(n2,Wn2,'s');

% convert the analog filter to digital using impinvar
[bz1,az1] = impinvar(b1,a1,fs);
[bz2,az2] = bilinear(b2,a2,fs);

[H_impinvar,f] = freqz(bz1,az1,1024,fs);
[H_bilinear,~] = freqz(bz2,az2,1024,fs);

figure;
subplot(2,1,1);
hold on;
plot(f,20*log10(abs(H_impinvar)), 'b','LineStyle',"--", 'LineWidth',1.5);
plot(f,20*log10(abs(H_bilinear)),'r','LineStyle',"-.",'LineWidth',1.5);
xlabel('Frequency');
ylabel('Magnitude(dB)');
title('Magnitude Response');
legend('Impulse Invariance','Bilinear Transformation');
ylim([-80 5]);
hold off;

subplot(2,1,2);
hold on;
plot(f,angle(H_impinvar), 'b','LineStyle',"--", 'LineWidth',1.5);
plot(f,angle(H_bilinear),'r','LineStyle',"-",'LineWidth',1.5);
xlabel('Frequency');
ylabel('Phase(radians)');
title('Phase Response');
legend('Impulse Invariance','Bilinear Transformation');
hold off;