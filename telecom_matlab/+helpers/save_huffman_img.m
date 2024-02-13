% loads sample image, generates differential image (pixels) and finds
% the empirical distribution of the difference values.

% load sample image
param.source.type = 'image';
param.source.filename = 'files/lena.pgm';
param = source.initialize(param); % init source

img = [];
height = 0;
width = 0;

% select if parameters from the GUI should be used for image size
useParams = true;
if useParams
    % image is 512 by 512 pixels
    img = param.source.sequence;
    width = param.source.image.width;
    height = param.source.image.height;
else
    % custom image for testing
    width = 10;
    height = 6;
    total_size = width * height;
    img = uint8(randi([0 255], 1, total_size));
end

% reshape image such that it is in matrix form as defined before
img = reshape(img, [width, height])';

% get the differential image
diff_img_mod = calculateDifferentialImg(img, 256);

% get all possible pixel values (M) and their probabilities (pM)
[M, pM] = huffmanFromData(diff_img_mod, 256);

% create huffman structure. 
huffman_structure = helpers.create_huffman(M, pM, 1);

% Define the full path to the image file in the 'files' subfolder
filePath = fullfile('..', 'files', 'huffman_img.mat');

% Save the struct to a .mat file
save(filePath, "huffman_structure");

% ======================= TESTING ===================================

% serialized_img = reshape(img', numel(img), 1);
% encoded = source_encoding.huffman_img(huffman_structure, width, height, serialized_img);
% decoded = source_decoding.huffman_img(huffman_structure, width, height, encoded);
% matrix_decoded_img = reshape(decoded', width, height)';

if(~useParams)
    
    % fprintf("serialized:\n");
    % disp(serialized_img);
    % fprintf("encoded image:\n");
    % disp(encoded);
    % fprintf("original image:\n");
    % disp(img);
    % fprintf("original diff image:\n");
    % disp(diff_img_mod);
    % fprintf("decoded image:\n");
    % disp(matrix_decoded_img);
    % fprintf("size of decoded image:\n");
    % disp(size(decoded));
    % fprintf("size of encoded image:\n");
    % disp(size(encoded));
    % fprintf("compression rate: %d\n", length(serialized_img)/length(encoded));
end

% ====================== FUNCTIONS ===================================

function [M, pM] = huffmanFromData(data, int_len)
data_len = numel(data);
vectorized_data = reshape(data', data_len, 1)';

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

% ====================== HELPER FUNCTIONS =============================

function [diff_img_mod] = calculateDifferentialImg(img, int_size)
% convert image to double for allowing negative values
img = double(img);
% generate differential modulo image
zero_column = zeros(size(img, 1), 1);
slice1 = img(: , 1:end-1);
diff_img_mod = uint8(mod(img - [zero_column slice1], int_size));
end

% ===================================================================



