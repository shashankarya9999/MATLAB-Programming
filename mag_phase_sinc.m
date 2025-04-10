%k = input('Enter value of k: ');
k=127;
n = -k:k-1;
z = 0.5*sinc(0.5*n);

subplot(3,1,1);
stem(n,z);
title('Original Function')
xlabel('n')
ylabel('x[n]')

Z = fft(z);
N = length(z);
W = (0:N-1)*(2*pi/N);

subplot(3,1,2)
stem(W,abs(Z));
%plot(W,abs(Z));
title('Magnitude Response')
xlabel('Frequency')
ylabel('Magnitude Spectrum')

subplot(3,1,3)
stem(W,angle(Z));
%plot(W,angle(Z));
title('Phase Response')
xlabel('Frequency')
ylabel('Phase Spectrum')
