% using built-in function
% x1 = input('Enter the first sequence: ');
% y1 = input('Enter the second sequence: ');

x1 = [1 5 1 6 4];
y1 = [1 5];
conv_builtin = conv(x1,y1);
disp(conv_builtin);
subplot(2,1,1);
grid on;
stem(conv_builtin);
title('Linear Convolution using direct method');

l1 = length(x1);
l2 = length(y1);

n = l1+l2-1;

x2 = [x1 zeros(1,n)];
y2 = [y1 zeros(1,n)];

X1 = fft(x2,n);
Y1 = fft(y2,n);

Y = X1.*Y1;

y = ifft(Y,n);
subplot(2,1,2);
grid on;
stem(y);
disp(y);
title('Linear Convolution using DFT');
