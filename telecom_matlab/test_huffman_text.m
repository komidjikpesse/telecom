% source parameter
param.source.type = 'text_utf8';
param.source.text_utf8.filename = 'files/dummy_textsource.txt'


% source coding parameter
param.source_coding.type = 'huffman';
param.source_coding.length = 8;
param.source_coding.huffman.tablefile = 'files/huffman_text.mat';
param.source_coding.huffman.num_symbols = 1;



% initialize
param = source.initialize(param);
param = source_encoding.initialize(param);


% get data from source
[d] = source(param);
fprintf('uncompressed source data takes: %i bits\n', length(char(d))*8);

%% Simulation

% Source encoding
u = source_encoding(param,d);
fprintf('compressed data takes %i bits\n', length(u))

% Source decoding
d_hat = source_decoding(param,u);

% some very basic error checks
assert( length(d) == length(d_hat), 'ERROR: Length of decoded output does not match length of input' );
assert( sum(abs(d-d_hat)) == 0, 'ERROR: Decoded output does not match input!' );


