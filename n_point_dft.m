M = 10;
%N = input('Enter N: ');
N = 100;
A = 1;
x = A*ones(1,M);
X = fft(x,N);
subplot(2,2,1)
f = (0:N-1)*(1/N);

subplot(2,2,1)
stem(f,abs(X))
title('Magnitude Spectrum of DFT');
xlabel('Frequency')
ylabel('Magnitude')

subplot(2,2,2)
stem(f,angle(X))
title('Phase Spectrum of DFT')
xlabel('Frequency')
ylabel('Phase')

N_ = 1000; 
omega = linspace(0, 2*pi, N_);

X_ = zeros(1, N_); 
n = 0:length(x)-1; 

for k = 1:N_
    X_(k) = sum(x .* exp(-1j * omega(k) * n));
end

subplot(2, 2, 3);
plot(omega, abs(X_));
xlabel('omega (rad/sample)');
ylabel('Magnitude of DTFT');
title('Magnitude spectrum of DTFT');

subplot(2, 2, 4);
plot(omega, angle(X_));
xlabel('omega (rad/sample)');
ylabel('Phase of DTFT');
title('Phase spectrum of DTFT');





