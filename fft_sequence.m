clc; clear; close all;

function X = dit_fft(x)
    N = length(x);
    % Built-in bit reversal
    X = bitrevorder(x); 
    
    for stage = 1:log2(N)
        L = 2^stage;
        % twiddle factor
        W = exp(-1i * 2 * pi / L); 
        
        for k = 0:L:N-1
            for n = 0:L/2-1
                % MATLAB uses 1-based indexing
                idx1 = k + n + 1; 
                idx2 = k + n + L/2 + 1;
                
                % Butterfly operation
                temp = X(idx1) + X(idx2) * W^n;
                X(idx2) = X(idx1) - X(idx2) * W^n;
                X(idx1) = temp;
            end
        end
    end
end

function X = dif_fft(x)
    N = length(x);
    X = x;
    
    for stage = log2(N):-1:1
        L = 2^stage;
        W = exp(-1i * 2 * pi / L);
        
        for k = 0:L:N-1
            for n = 0:L/2-1
                idx1 = k + n + 1;
                idx2 = k + n + L/2 + 1;
                
                % Butterfly operation (different from DIT)
                temp = X(idx1) + X(idx2);
                X(idx2) = (X(idx1) - X(idx2)) * W^n;
                X(idx1) = temp;
            end
        end
    end
    
    % Built-in bit reversal
    X = bitrevorder(X); 
end

x1 = [-1, 0, 2, 0, -4, 0, 2, 0];
X1_dit = dit_fft(x1);
X1_dif = dif_fft(x1);
X1_matlab = fft(x1); 

x2 = [1, 0, -1, 2, 0, -4, 0, 0];
X2_dit = dit_fft(x2);
X2_dif = dif_fft(x2);
X2_matlab = fft(x2);

% plot magnitude and phase of DFT of x1 and x2
figure;
subplot(2,2,1);
stem(abs(X1_dit));
title('Magnitude of DIT-FFT for x1');
xlabel('k'); 
ylabel('|X1(k)|');

subplot(2,2,2);
stem(angle(X1_dit));
title('Phase of DIT-FFT for x1');
xlabel('k'); 
ylabel('∠X1(k)');

subplot(2,2,3);
stem(abs(X2_dit));
title('Magnitude of DIT-FFT for x2');
xlabel('k'); ylabel('|X2(k)|');

subplot(2,2,4);
stem(angle(X2_dit));
title('Phase of DIT-FFT for x2');
xlabel('k'); ylabel('∠X2(k)');

% display results
disp('DIT-FFT of x1:');
disp(X1_dit);
disp('DIF-FFT of x1:');
disp(X1_dif);
disp('FFT of x1(using fft()):');
disp(X1_matlab);

disp('DIT-FFT of x2:');
disp(X2_dit);
disp('DIF-FFT of x2:');
disp(X2_dif);
disp('FFT of x2(using fft()):');
disp(X2_matlab);
