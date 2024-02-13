% takes in training text, finds its empirical letter distribution,
% then creates the huffman code data structure using create_huffman
% for the coding, B=1 is used as each character can be represented
% with one symbol (symbol is of type uint8)

% choose sample text file to generate huffman tree from:
% sample_file = 'training_text.txt';
sample_file = 'dummy_textsource.txt';

% Define the paths to the read and save text files in the 'files' subfolder
filePath_read = fullfile('..', 'files', sample_file);
filePath_save = fullfile('..', 'files', 'huffman_text.mat');

% read the text data
content = fileread(filePath_read);
% conver string text data into uint8 values between 0 and 255
text_stream = double(content);

% get all possible symbols and their probabilities
[M, pM] = huffmanFromData(text_stream, 256);

% create huffman structure with generated symbols M and their probability
% distribution pM, set B=1
huffman_structure = helpers.create_huffman(M, pM, 1);

% print most probable ASCII characters in order
% most_probable_ASCII(huffman_structure.symbol_codes);

% Save the struct to a .mat file
save(filePath_save, "huffman_structure");

% ========================= FUNCTIONS =================================

function [M, pM] = huffmanFromData(data, int_len)
data_len = numel(data);
vectorized_data = reshape(data, 1, data_len);

% preallocate symbols and probability vectors with the correct size
M = 0:int_len-1;
pM = zeros(1, int_len);

% find occurences of all uint8's between 0 and int_len (255)
for num=0:int_len-1
    occurrences = sum(vectorized_data == num);
    % calculate normalised (range 0 to 1) probability
    p_i = (occurrences/data_len);
    % add the probability p_i to the probability the vector
    pM(num+1) = p_i;
end
end

% just for fun, display the most probable ASCII characters
function most_probable_ASCII(huff_table)
int_symbols = cell2mat(huff_table(:,1));
ASCII_symbols = char(int_symbols);
fprintf("Most common ASCII characters are:\n")
disp(ASCII_symbols);
end

% ==============================================================
