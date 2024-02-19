codesymbol = @(x)x.*2-1;

% System
N = 2;        % available channels
M = 1e6;      % message size (bits)

% Sender
R = 1e6;      % bit rate
Tb = 1/R;     % bit duration
roll = 0.40;  % rolloff factor
beta = 4*N;   % upsampling factor
Tn = Tb/beta; % upsample sampling rate
span = 20;    % rcos span for thinner bandwidth consumption
pwr = 200;     % channel power in mW

% Channel
shift = 4;    % samples delay
variance = 1; % noise variance

% Receiver
impulseL = 128;
startSeq = [1 0 1 0 1 0 1 0 ... % test the channel response
            1 1 1 1 1 1 1 1];   % set an unique sequence
