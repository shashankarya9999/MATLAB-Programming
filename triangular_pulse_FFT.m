clc; clear; close all;

pulse_length = 16;
% Triangular pulse of length 16 (amplitude 1)
amplitudes = [0:1:15, 14:-1:1] / 15; 
% Pad with zeros for visualization
full_signal = [amplitudes zeros(1, 256-length(amplitudes))]; 

% FFT sizes to analyze
N_values = [8, 16, 32, 64, 128, 256 512 1024];

% plot the triangular pulse
subplot(3, 3, 1);
plot(0:255, full_signal, 'b', 'LineWidth', 1.5);
% Show first 32 samples to see the pulse clearly
%xlim([0 31]); 
title('Triangular Pulse (16 samples)');
xlabel('Sample');
ylabel('Amplitude');

% Plot FFT magnitudes for different N values
for i = 1:length(N_values)
    N = N_values(i);
    subplot(3, 3, i+1);

    % Take FFT of the first 16 samples (the pulse) with different N
    fft_result = fft(amplitudes, N);
    fft_magnitude = abs(fft_result);

    % Normalize to have maximum of 1 for comparison
    fft_magnitude = fft_magnitude / max(fft_magnitude);

    % Plot
    stem(0:N-1, fft_magnitude);
    title(sprintf('FFT Magnitude (N=%d)', N));
    xlabel('Frequency Bin');
    ylabel('Normalized Magnitude');
    xlim([0 N-1]);
end

sgtitle('FFT of Triangular Pulse with Different N Values');