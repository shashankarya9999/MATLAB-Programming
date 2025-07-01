% Original Audio
[audio, fs]=audioread('Copy_of_Recording.mp3');

% Speech signal plot
n=(0:length(audio)-1)/fs;
subplot(2,1,1);
plot(n,audio);
xlabel('samples');
ylabel('Amplitude');
title('0riginal Audio');

% Quantization range
minValue=min(audio);
maxValue=max(audio);

% No. of bits for quantization
bitNum=[8,16,32,64,128];
subplot(2,1,2);
hold on;
for i=1:length(bitNum)
    num=bitNum(i);
    quantizedSpeech=quantize(audio,num,minValue,maxValue);
    % SNR
    SNRval=snr(audio,audio-quantizedSpeech);
    plot(num,SNRval, 'o', 'DisplayName',sprintf('%d bits',num));
end
hold off;
title('SNR vs. Number of Bits/Sample');
xlabel('Number of Bits/Sample');
ylabel('SNR (dB)');
legend('show');
grid on;

% function for quantization
function quantizedSignal = quantize(signal, num, minValue, maxValue)
    % Calculate the step size for quantization
    stepSize = (maxValue - minValue) / (2^num - 1);
    % Quantize the signal
    quantizedSignal = round(signal / stepSize) * stepSize;
end
