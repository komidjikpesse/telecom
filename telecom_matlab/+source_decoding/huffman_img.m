function [output] = huffman_img(huffman_structure, img_width, img_height, encoded_seq)
% uses huffman decoder in huffman.m to reconstruct the differential image.
% Restores the original image from the differential image

% encode the differential image sequence
symbol_stream = source_decoding.huffman(huffman_structure, encoded_seq);
	
% reshape image to matrix form
image = reshape(symbol_stream', img_width, img_height)';
% fprintf('%s%s\n', "decoded diff image:", mat2str(image));

% print decoded differential image before restoring original image
% fprintf("decoded diff image\n")
% disp(image);

% get original image from differential image
restoredImage = restoreFromDiff(image, 256);

% convert image matrix to row vector
vectorized_decoded_img_original = reshape(restoredImage', numel(restoredImage), 1)';
output = uint8(vectorized_decoded_img_original);


% ====================== HELPER FUNCTIONS ===================================

function [recovered_img] = restoreFromDiff(diff_img, int_size)
% Reconstruct the original image from the differential image
diff_img = double(diff_img);
% Preallocate the original image with the same size as the differential image
recovered_img = zeros(size(diff_img));
% The first column of the original image is the same as the differential image
recovered_img(:,1) = diff_img(:,1);

% Compute the original image
for col_i = 2:size(diff_img, 2)
    recovered_img(:, col_i) = mod(recovered_img(:, col_i-1) + diff_img(:, col_i), int_size);
end
% convert back to uint8
recovered_img = uint8(recovered_img);
end
% ==========================================================================


% end of main function

end
