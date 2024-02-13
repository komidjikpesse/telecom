close all

impulseL = 512;

gd = zeros(impulseL, N);
hold on

% first channel lowpass
[tmp1,tmp2] = butter(10, cutoff(1,2));
gd(:,1) = grpdelay(tmp1, tmp2, impulseL, 'whole', 1/Tn);
[hf,ff] = freqz(tmp1, tmp2, impulseL, 'whole', 1/Tn);
plot(ff(1:ceil(end/2)), ...
    20*log10(abs(hf(1:ceil(end/2)))));

% others channels bandpass
for n = 2:N
    [tmp1,tmp2] = butter(10, [cutoff(n,1) cutoff(n,2)]);
    gd(:,n) = grpdelay(tmp1, tmp2, impulseL, 'whole', 1/Tn);
    [hf,ff] = freqz(tmp1, tmp2, impulseL, 'whole', 1/Tn);
    plot(ff(1:ceil(end/2)), ...
        20*log10(abs(hf(1:ceil(end/2)))));
end

xlim([0 75]);
xlabel('Frequence (Hz)')
ylabel('Amplitude (dB)')
grid, hold off

figure, plot(ff,gd*Tn), grid
xlabel('Frequence (Hz)')
ylabel('Samples (sample x rad)')
