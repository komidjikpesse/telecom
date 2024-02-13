function [output] = huffman(huffman_structure, input_seq)
%huffman - encodes a source sequence of arbitrary length onto a sequence of
%bits using the Huffman code created in create_huffman

% define useful variables
table = huffman_structure.symbol_codes;
input_length = length(input_seq);
B = huffman_structure.B;
encoded_stream = [];

% start timer
tic

% make sure the case where "length(input_seq) mod B ~= 0" is handled
symbols_stream_length = floor(input_length/B);
num_unreadable_elements = rem(input_length, B);

% delete elements which we can't read anyway
% num_unreadable_elements will be lost
% after this if, input_seq has length B*symbol_stream_length
if num_unreadable_elements ~= 0
    warning("Message not a multiple of B!!! Output size may vary");
    warndlg("Message not a multiple of B!!! Output size may vary");
    input_seq(end-num_unreadable_elements+1 : end) = [];
end

message_length = length(input_seq)/B;

% Reshape the array into a matrix with symbols_stream_length rows and B columns
input_matrix = reshape(input_seq, B, symbols_stream_length)';

% each row is now an array of symbols that need to be translated to binary
% using huffman coding
pointer = 1;
while(pointer <= message_length)
    % get the symbol vector to be encoded
    symbols_vector = input_matrix(pointer, :);
    % Search for the symbols_vector in the symbol_codes cell array
    index = find(cellfun(@(x) isequal(x, symbols_vector), table(:, 1)));

    if ~isempty(index)
        % use the index to translate the symbol to its codeword
        codeword = uint8(table{index, 2});
        encoded_stream = [encoded_stream codeword];
    else
        error("Symbol %s cannot be found in the huffman table", mat2str(symbols_vector));
    end
    % increase pointer by B
    pointer = pointer + 1;
end

% encoded data will be stored as 8bit unsigned integers (range 0 : 255)
output = encoded_stream;

elapsed_time = toc;
fprintf("[Log] Finished encoding\n")
fprintf('[Log] Elapsed time: %.4f seconds\n', elapsed_time);
fprintf("======================================\n");

end

