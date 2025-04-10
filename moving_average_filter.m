clear;

l=200;
n=0:l-1;

s=2*(n.*(0.9).^n);
subplot(2,3,1);
stem(n,s);
title('original signal');
xlabel('Time');
ylabel("Original signal");
ylim([-1 8]);

d=rand(1,l) - 0.5;
subplot(2,3,2);
stem(n,d);
title('noise');
xlabel('Time');
ylabel("Noise signal");

x=s+d;
subplot(2,3,3);
stem(n,x);
title('corrupted signal');
xlabel('Time');
ylabel("Noise corrupted signal");

M1 = 5;
b1 = ones(1,M1)/M1;
y1 = filter(b1,1,x);
subplot(2,3,4);
stem(n,y1);
title('filter length = 5');
xlabel('Time');
ylabel("Filtered signal with length =5 ");
ylim([-1 8]);

M2 = 7;
b2 = ones(1,M2)/M2;
y2 = filter(b2,1,x);
subplot(2,3,5);
stem(n,y2);
title('filter length = 7');
xlabel('Time');
ylabel("Filtered signal with length =7 ");
ylim([-1 8]);

M3 = 9;
b3 = ones(1,M3)/M3;
y3 = filter(b3,1,x);
subplot(2,3,6);
stem(n,y3);
title('filter length = 9');
xlabel('Time');
ylabel("Filtered signal with length =9 ");
ylim([-1 8]);