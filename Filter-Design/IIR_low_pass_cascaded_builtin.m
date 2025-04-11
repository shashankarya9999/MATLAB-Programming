clear;

fc = 225;
fs = 1000;

[b,a] = butter(4,fc/(fs/2),'low');
[H,f] = freqz(b,a,[],fs);

[b1,a1]=butter(1,fc/(fs/2),'low');    % lowpass
[b2,a2]=butter(1,fc/(fs/2),'low');    % lowpass
[b3,a3]=butter(1,fc/(fs/2),'low');    % lowpass
[b4,a4]=butter(1,fc/(fs/2),'low');    % lowpass
H1=dfilt.df2t(b1,a1);
H2=dfilt.df2t(b2,a2);
H3=dfilt.df2t(b3,a3);
H4=dfilt.df2t(b4,a4);
Hcas=dfilt.cascade(H1,H2,H3,H4); 
[Hcas,~] = freqz(Hcas,[],fs);

figure;
subplot(2,1,1);
hold on;
plot(f,20*log10(abs(H)),'LineWidth',1.5);
plot(f,20*log10(abs(Hcas)),'LineWidth',1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Response of a low-pass IIR filter');
ylim([-150 50]);
legend('4th order','four cascaded 1st order');
hold off;

subplot(2,1,2);
hold on;
plot(f,angle(H),'LineWidth',1.5);
plot(f,angle(Hcas),'LineWidth',1.5);
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
title('Phase Response of a low-pass IIR filter');
legend('4th order','four cascaded 1st order');
hold off;
