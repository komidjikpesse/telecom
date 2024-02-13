% This work is licensed under the Creative Commons Attribution 4.0
% International License. To view a copy of this license, visit
% http://creativecommons.org/licenses/by/4.0/ or send a letter to
% Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

% BER curves
% PAM-2 best case
t = linspace(0, 10, 1e3);
y = 1/2*erfc(sqrt(10.^(t/10)));
semilogy(t, y)
grid

% Our case
dB2test = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
tries = numel(dB2test);
BER = zeros([1 tries]);
ebn0 = zeros([1 tries]);
for uniqIDX = 1:tries
    forcedPwr = dB2test(uniqIDX);
    main;
    BER(uniqIDX) = sum(errorRate)/N;
end
hold on, semilogy(ebn0, BER), hold off

% Eye Diagram
folded = reshape(s2t(1:max(s2i)-1,2), beta, []);
[rows,cols] = size(folded);
eyeDiag = zeros([rows+1 cols]);
eyeDiag(1:rows,1:cols) = folded;
for n = 1:cols-1
    eyeDiag(beta+1,n) = eyeDiag(1,n+1);
end
eyeDiag(beta+1,cols) = eyeDiag(beta+1,1);
