clear;
clc;

% Parameters
N = 10000;              % Number of bits
EbN0_dB = 0:2:10;       % Eb/N0 range in dB
BER = zeros(size(EbN0_dB));

% Generate random bits
bits = randi([0 1], 1, N);

% BPSK Modulation (0 -> -1, 1 -> +1)
bpsk_signal = 2*bits - 1;

% Loop over Eb/N0 values
for i = 1:length(EbN0_dB)
    
    % Convert Eb/N0 from dB to linear
    EbN0 = 10^(EbN0_dB(i)/10);
    
    % Noise variance
    noise_var = 1/(2*EbN0);
    
    % AWGN noise
    noise = sqrt(noise_var) * randn(1, N);
    
    % Received signal
    rx_signal = bpsk_signal + noise;
    
    % BPSK Demodulation
    detected_bits = rx_signal > 0;
    
    % BER calculation
    BER(i) = sum(bits ~= detected_bits)/N;
end

% Display results
disp('Eb/N0 (dB)    BER');
disp([EbN0_dB.' BER.']);
