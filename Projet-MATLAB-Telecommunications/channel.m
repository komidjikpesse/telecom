% gaussian noise
noise_1 = randn([numel(data) 1]);
[bf,af] = butter(1, 0.99);
noise_f = ifft(freqz(bf, af, impulseL, 'whole', 1/Tn));
noise_2 = conv(noise_f, noise_1);
noise_2 = noise_2(1:end-impulseL+1);

if exist('forcedPwr', 'var')
    % for fine-grained control of the noise in diagram.m
    power_data = sum(data.^2);
    power_noise = sum(noise_2.^2);
    ratio = (power_data/power_noise)/10^(forcedPwr/10);
    noise_2 = noise_2.*sqrt(ratio);
    alpha = 1; std_dev = 1;
    ebn0(uniqIDX) = snr(data, noise_2);
else
    % damping factor; between 0.60<=x<=0.90
    alpha = (0.90-0.60)*rand([1 1])+0.60;
    % increase noise with variance
    std_dev = sqrt(variance);
end

data = alpha*data+std_dev*noise_2;
data = [zeros(shift,1); data];
