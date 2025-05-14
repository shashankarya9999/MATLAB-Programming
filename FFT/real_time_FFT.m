% Real-Time FFT Comparison for Two Sinusoids
clear; close all; clc;

% Sampling frequency (Hz)
fs = 1000;          
% Extended time vector (2 seconds)
% The largest FFT being computed is 1024 points.
% for f=1000Hz
% 1 second provides only 1000 samples (but we need 1024).
% 2 seconds provides 2000 samples, ensures enough data.
t = 0:1/fs:2-1/fs;  
% First sinusoid frequency (Hz)
f1 = 50;            
% Second sinusoid frequency (Hz)
f2 = 120;           

N_values = [64 128 256 512 1024]; 

signal = sin(2*pi*f1*t) + 0.5*sin(2*pi*f2*t);

% Create figure
% h_plots stores handles (references) to the stem plots created in the loop.
% allows updating plots dynamically (real-time animation).
% avoids recreating plots in each iteration (better performance).
h_plots = gobjects(length(N_values), 1);

% Initialize plots
for i = 1:length(N_values)
    subplot(length(N_values), 1, i);
    h_plots(i) = stem(0, 0);
    title(sprintf('FFT (N = %d)', N_values(i)));
    xlabel('Frequency (Hz)');
    ylabel('Normalized Magnitude');
    xlim([0 200]);
    ylim([0 1]);
    grid on;
end

% Buffer to store signal
% buffer is used to store the most recent samples of the signal before computing the FFT.
% The buffer is continuously updated in a first-in, first-out (FIFO) manner.
% New samples overwrite the oldest ones, keeping the buffer size fixed.
buffer_size = 1024;
signal_buffer = zeros(1, buffer_size);

% Real-time simulation
for k = 1:length(t)
    % Update circular buffer
    signal_buffer = [signal_buffer(2:end) signal(k)];
    
    for i = 1:length(N_values)
        N = N_values(i);
        if k >= N
            % Get the last N samples
            current_window = signal_buffer(end-N+1:end);
            
            % Compute FFT
            fft_result = fft(current_window, N);
            fft_magnitude = abs(fft_result(1:N/2+1));
            
            % Normalize
            fft_magnitude = fft_magnitude/max(fft_magnitude); 
            
            % Frequency axis
            f_axis = (0:N/2)*fs/N;
            
            % Update plot
            set(h_plots(i), 'XData', f_axis, 'YData', fft_magnitude);
        end
    end
    % drawnow updates figures and processes any pending callbacks. 
    % drawnow limitrate limits the number of updates to 20 frames per second.
    % Use this command if you are updating graphics objects in a loop and do not need to see every update on the screen.
    drawnow limitrate; 
    % small delay for animation effect
    pause(0.01); 
end
