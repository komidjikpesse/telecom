

x = randi([0 1], M, N);
% append the start sequence
x = [startSeq'*ones(1, N); x];
a = codesymbol(x);
% shape to impulse
rcos = rcosdesign(roll, span, beta);
a = upsample(a, beta);
s1 = conv2(rcos, 1, a);
len1 = size(s1, 1);

% carrier frequencies
carfreq = (0:N-1)'*2/Tb;

% modulate by carriers
t = (0:Tn:(len1-1)*Tn)'*ones(1,N);
s1High = s1.*cos(2*pi*carfreq'.*t);

% normalise power to 'pwr' mW
power = sum(s1High.^2, 1)/len1;
ratio = (pwr*1e-3)./power;
s1High = s1High.*sqrt(ratio);

% sum all channels before transmission
data = sum(s1High, 2);

% plot impulsions
iX = linspace(0, span/1e2, 1e2*span+1);
iY = rcosdesign(roll, span, 1e2);
plot(iX, iY' * ones(1, N) .* ...
     cos(carfreq*linspace(0, 2*pi, span*1e2+1))')
ylim([-max(iY)*1.1 +max(iY)*1.1])
title("Representation temporelle des impulsions utilisees")
ylabel("Coefficient d'amplitude"), xlabel("Temps (s)")
legend(strcat("Canal ", num2str((1:N)')))
grid
clear iX iY

% plot visual representation of the transmission
figure
subplot(2,1,1)
stem(linspace(0, len1*Tn, len1), s1High)
title('Representation temporelle du signal envoye')
ylabel('Amplitude (v)'), xlabel('Times (s)')
legend(strcat("Canal ", num2str((1:N)')), 'Location', 'NorthEast')
grid

subplot(2,1,2)
semilogy(linspace(0, 1/Tn-1, len1), abs(fft(s1High/len1)).^2)
ylim([10^-6 10^0])
title('Representation frequentielle du signal envoye')
ylabel('Puissance (dBm)'), xlabel('Frequency (Hz)')
legend(strcat("Canal ", num2str((1:N)')), 'Location', 'North')
grid
