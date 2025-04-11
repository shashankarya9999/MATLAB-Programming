% x = input('Enter x: ');
% h = input('Enter h: ');
% N = input('Enter N: ');
x = [1 2 3 4 5 6 7 8 9 10 11 12];
h = [4 3 9 5];
N = 4; 
Y=conv(x,h);
disp(Y);
subplot(2,1,1);
stem(Y);
title('Linear convolution using direct method: ');

M = length(h);
L = length(x);
H = [h zeros(1,N-M)];
num_segments = ceil(L/N);
Y_ = zeros(1, L+M-1);
for i = 1:num_segments
    start_index = (i-1)*N + 1;
    end_index = min(i*N, L);
    segment = x(start_index:end_index);
    y = conv(segment, H);
    Y_(start_index:start_index+length(y)-1) = Y_(start_index:start_index+length(y)-1)+y;
end
subplot(2,1,2);
stem(Y_);
disp(Y_);
title('Linear Convolution using Overlap-Add method')