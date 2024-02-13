clear

% source parameter
param.source.type = 'image';
param.source.filename = 'files/peppers.pgm';


% source coding parameter
param.source_coding.type = 'huffman_img';
param.source_coding.length = 8;
param.source_coding.huffman.tablefile = 'files/huffman_img.mat';
param.source_coding.huffman.num_symbols = 1;

% initialize source
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

% Reconstruct Source Signal from received Data
img_hat = sink.receive_image(param,d_hat);

imshow(img_hat)

% some very basic error checks
assert( length(d) == length(d_hat), 'ERROR: Length of decoded output does not match length of input' );
assert( sum(abs(d-d_hat)) == 0, 'ERROR: Decoded output does not match input!' );

