function [output] = huffman_img(huffman_structure, img_width, img_height, input_seq)
% calculates the differential image and uses Huffman encoder in huffman.m
% to compress the image

% reshape image to matrix form
image = reshape(input_seq', img_width, img_height)';

% get differential image
diff_img_mod = calculateDifferentialImg(image, 256);

% convert image back to vector
diff_img_sequence = reshape(diff_img_mod', numel(diff_img_mod), 1);

% encode the differential image sequence
output = uint8(source_encoding.huffman(huffman_structure, diff_img_sequence));

% ====================== HELPER FUNCTIONS ===================================

function [diff_img_mod] = calculateDifferentialImg(img, int_size)
% convert image to double for allowing negative values
img = double(img);
% generate differential modulo image
zero_column = zeros(size(img, 1), 1);
slice1 = img(: , 1:end-1);
diff_img_mod = uint8(mod(img - [zero_column slice1], int_size));
end

% ==========================================================================

% end of main function
end

