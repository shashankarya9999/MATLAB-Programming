% Clear workspace and close all figures
clc;
clear;
close all;

% User Inputs
% L = input('Enter the desired length of the sequence (L): ');
% A = input('Enter the amplitude (A): ');
% w0 = input('Enter the angular frequency (w0, where 0 < w0 < pi): ');
% phi = input('Enter the phase (phi, where 0 < phi < 2*pi): ');
L=50;
A=1;
% w0=0.7854;
w0=pi/24;
% phi=1.0472;
phi=0;

% % Validate inputs
% if w0 <= 0 || w0 >= pi
%     error('Angular frequency w0 must be between 0 and pi.');
% end
% if phi < 0 || phi >= 2*pi
%     error('Phase phi must be between 0 and 2*pi.');
% end

% Sampling rate (20 kHz)
fs = 20000; % Hz
Ts = 1/fs;  % Sampling period (s)

% Time indices (n)
n = 0:L-1; % Discrete-time index

% Generate the sinusoidal sequence
x = A * cos(w0 * n + phi);

% Plot the sequence using stem
stem(n, x);
xlabel('Discrete-time index (n)');
ylabel('Amplitude x[n]');
title(['Sinusoidal Sequence: x[n] = ', num2str(A), 'cos(', num2str(w0), 'n + ', num2str(phi), ')']);
grid on;