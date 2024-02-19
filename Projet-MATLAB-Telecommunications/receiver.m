

% calculate the bandwidth limits for each channel
cutoff = [carfreq-1/Tb carfreq+1/Tb]*2*Tn;
% pre-allocate filters matrix
H = zeros(impulseL, N);

% first channel lowpass
[bf,af] = butter(10, cutoff(1,2));
H(:,1) = ifft(freqz(bf, af, impulseL, 'whole', 1/Tn));

% others channels bandpass
for n = 2:N
    [bf,af] = butter(10, [cutoff(n,1) cutoff(n,2)]);
    H(:,n) = ifft(freqz(bf, af, impulseL, 'whole', 1/Tn));
end

% separate channels
s2High = conv2(data, 1, H);
len2 = size(s2High,1);

% demodulate
t = (0:Tn:(len2-1)*Tn)'*ones(1,N);
s2 = s2High.*cos(2*pi*carfreq'.*t);
s2(:,1) = s2High(:,1);
for n = 2:N
    [bf,af] = butter(5, carfreq(n)*2*Tn);
    impulse = ifft(freqz(bf, af, impulseL, 'whole', 1/Tn));
    s2(:,n) = conv(s2(:,n), impulse(1:+1:end), 'same'); % forward
    s2(:,n) = conv(s2(:,n), impulse(end:-1:1), 'same'); % backward
end

% filter the canal noise with the adequate filter
s2 = conv2(rcos, 1, s2);
[len3,~] = size(s2);
% find filters delay
[~,i] = max(H);
% compensate the start trame
s2t = zeros(len3,N);
for n = 1:N
    delay = span*beta+i(n)+shift-n;
    s2t(1:len3-delay+1,n) = s2(delay:end,n);
end
% generate the index vector
s2i = 1:beta:beta*size(x,1);
% extract the values at index
decoded = s2t(s2i,:);
% quantize the extracted values
decoded = decoded>0;

% hit markers *PEW* *PEW*
figure, hold on
stem(s2t(:,1))
stem(s2i, s2t(s2i,1), 'r*', 'MarkerSize', 8.0)
grid, hold off

% plot visual representation of the transmission
figure
subplot(2,1,1)
stem(linspace(0, len2*Tn, len2), s2High)
title('Representation temporelle du signal recu')
ylabel('Amplitude (v)'), xlabel('Times (s)')
legend(strcat("Canal ", num2str((1:N)')), 'Location', 'NorthEast')
grid

subplot(2,1,2)
semilogy(linspace(0, 1/Tn-1, len2), abs(fft(s2High/len2)).^2)
ylim([10^-6 10^0])
title('Representation frequentielle du signal recu')
ylabel('Puissance (dBm)'), xlabel('Frequency (Hz)')
legend(strcat("Canal ", num2str((1:N)')), 'Location', 'North')
grid
