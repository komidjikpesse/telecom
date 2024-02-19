parameters
% generate data and send it
sender
% add noise and delay
channel
% filter data and read it
receiver

% compare the sent signal with the received one
figure
subplot(2,1,1)
stem(linspace(0, len1*Tn, len1), s1(:,1));
title('Signal normalise envoye par l''emetteur')
xlabel('Temps de transmission (s)')
ylabel('Amplitude du signal')
grid

subplot(2,1,2)
len3 = size(s2,1);
stem(linspace(0, len3*Tn, len3), s2(:,1), 'Color', [0.85 0.33 0.1]);
title('Signal recompose dans le receveur')
xlabel('Temps de transmission (s)')
ylabel('Amplitude du signal')
grid

% report QS
disp("Taux d'erreurs :")
errorRate = sum(xor(x, decoded))/size(x,1);
disp(errorRate)
