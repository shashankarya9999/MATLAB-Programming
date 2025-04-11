clear;
% audioread() reads the audio file
% inputAudio contains the audio samples(a vector or matrix, depending on mono/stereo)
% fs is sampling frequency(e.g. 44100 Hz for standard audio)
[inputAudio, fs] = audioread('Copy_of_Recording.mp3');
l = length(inputAudio);
noisePower = 0.1;
% generates Gaussian random noise of the same size as inputAudio
% noisyAudio is the original signal with added noise
noisyAudio = inputAudio + noisePower * randn(size(inputAudio));
noisy_filename = 'noise.mp3';
% audiowrite() saves the noisy audio as 'noise.mp3' with the same sampling
% rate(fs)
audiowrite(noisy_filename, noisyAudio, fs);
% designing of a Low-Pass FIR Filter
filterOrder = 50;
cutoffFreq = 4000;
normalizedFreq = cutoffFreq / (fs / 2);
% design an FIR low-pass filter with the given order
% cutoff freq
b = fir1(filterOrder, normalizedFreq, 'low');
% applies the filter b to noisyAudio
filteredAudio = filter(b, 1, noisyAudio);
% saving the filtered audio
filtered_filename = 'filter.mp3';
audiowrite(filtered_filename, filteredAudio, fs);
% plotting the original audio, noisy audio and filtered audio
% t = (0:l-1)*(1/fs);
figure;
subplot(3,1,1);
plot((fs/l)*(-l/2:l/2-1),abs(fftshift(fft(inputAudio))),'k');
title('Original Audio');
xlabel('Frequency');
ylabel('Magnitude');
ylim([0 400]);
subplot(3,1,2);
plot((fs/l)*(-l/2:l/2-1),abs(fftshift(fft(noisyAudio))),'k');
title('Noisy Audio');
xlabel('Frequency');
ylabel('Magnitude');
ylim([0 400]);
subplot(3,1,3);
plot((fs/l)*(-l/2:l/2-1),abs(fftshift(fft(filteredAudio))),'k');
title('Filtered Audio')
xlabel('Frequency');
ylabel('Magnitude');
ylim([0 400]);