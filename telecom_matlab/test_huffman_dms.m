% source parameter
param.source.type = 'dms';
param.source.length = 1000;
param.source.cardinality = 3;
param.source.distribution = 'boltzmann';
param.source.nu = 2;


% source coding parameter
param.source_coding.type = 'huffman';
param.source_coding.huffman.tablefile = 'files/huffman_dms.mat';



% initialize
param = source.initialize(param);
param = source_encoding.initialize(param);


% get data from source
[d] = source(param);
fprintf('uncompressed source data takes: %i bits\n', length(d)*2);

%% Simulation

% Source encoding
u = source_encoding(param, d);
fprintf('compressed data takes %i bits\n', length(u))

% Source decoding
d_hat = source_decoding(param, u);

% some very basic error checks
assert( length(d) == length(d_hat), 'ERROR: Length of decoded output does not match length of input' );
assert( sum(abs(d-d_hat)) == 0, 'ERROR: Decoded output does not match input!' );


