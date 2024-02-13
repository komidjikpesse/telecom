function [output] = huffman(huffman_structure,input_seq)
%huffman - reverts the Huffman coding. Takes a bit string of arbitrary
%length and returns the symbols according to the table created in create_huffman

% at the time of decoding we do not know how long the bit stream should be,
% therefore we read the bit stream until a symbol cannot be resolved.

% start timer
tic
% get decoded message

% IMPLEMENTATION 1
output = trieSolution(huffman_structure, input_seq);

% IMPLEMENTATION 2
% output = slowDecode(huffman_structure, input_seq);

elapsed_time = toc;
fprintf("[Log] Finished decoding\n")
fprintf('[Log] Elapsed time: %.4f seconds\n', elapsed_time);
fprintf("======================================\n");

% ======================== FUNCTIONS ===============================
% Below are two implementations of decoding, the first one works and
% is currently faster for small input data.

% IMPLEMENTATION 1
function decoded_symbols = trieSolution(huffman_structure, input_seq)

    trie = huffman_structure.trie;
    B = huffman_structure.B;
    max_depth = huffman_structure.depth;
    min_depth = huffman_structure.min_depth;

    % Initialize variables
    current_node = trie;
    code_length = 1;

    % preallocate decoded symbols array knowing that shortest bit vector is
    % of length min_depth (assuming worst case)
    numOfSymbols = floor(length(input_seq)/min_depth) + min_depth;
    required_len = numOfSymbols * B;
    decoded_symbols = zeros(1, required_len);
    % keep track of final length
    final_len = 0;
    
    % Decode the input sequence
    for i = 1:length(input_seq)

        % make sure we aren't exceeding max_depth of the tree
        assert(code_length<=max_depth, sprintf("Codeword of length %d found in encoded message is not defined!", code_length));

        % Go to either left child (1) or right child (2) of current node
        current_node = current_node.children{input_seq(i) + 1};
        
        % If a symbol is reached, add it to the decoded symbols
        % Then reset the node to root of trie.
        if ~isempty(current_node.symbol)
            decoded_symbols(final_len+1 : final_len+B) = current_node.symbol;
            % fprintf("step %d DECODED: %s\n", i, mat2str(decoded_symbols));
            final_len = final_len + B;
            current_node = trie;  % Reset to the root of the trie
            code_length = 1; % reset code length

            decoded_symbols(final_len+1:end) = [];
        else
            code_length = code_length + 1;
        end
    end
    % remove extra 0's from the final array
    decoded_symbols(final_len+1:end) = [];
    % convert output to unsigned integers in range 0-255
    decoded_symbols = uint8(decoded_symbols);
end

% ============================= HELPER FUNCTIONS ======================

% useful print for the huffman table
function printHuff(table)
fprintf("\n======================\n");
for i=1:length(table)
    fprintf("s: %s | c: %s\n", mat2str(table{i,1}), mat2str(table{i,2}));
end
fprintf("======================\n")
end

% end of main function
end

% =====================================================================

% IMPLEMENTATION 2
function [decoded_seq] = slowDecode(huffman_structure, encoded_seq)
    B = huffman_structure.B;
    symbol_codes = huffman_structure.symbol_codes;
    
    decoded_seq = [];
    idx = 1; % Start index for parsing the encoded sequence
    
    while idx <= length(encoded_seq)
        found = false; % Flag to track if a codeword is found
        for j = 1:size(symbol_codes, 1)
            codeword_stored = symbol_codes{j, 2};
            if length(codeword_stored) <= length(encoded_seq) - idx + 1
                % Extract codeword of the same length as stored codewords
                codeword = encoded_seq(idx:idx+length(codeword_stored)-1);
                if isequal(codeword_stored, codeword)
                    % Found the corresponding symbol for the codeword
                    symbol = symbol_codes{j, 1};
                    decoded_seq = [decoded_seq, symbol];
                    idx = idx + length(codeword_stored); % Move index
                    found = true; % Set flag indicating codeword found
                    break; % Exit inner loop
                end
            end
        end
        
        if ~found
            fprintf('Codeword not found. Aborting decoding.\n');
            decoded_seq = []; % Return empty sequence in case of failure
            return;
        end
    end
end


% % IMPLEMENTATION 3 (OLD)
% function [decoded_symbols] = alwaysSearchForBuffer(table, input_seq, B, max_depth, min_depth)
% codewords = table(:,2);
% symbols = table(:,1);
% pointer = 1;
% % preallocate decoded symbols array knowing that shortest bit vector is
% % of length min_depth
% numOfSymbols = floor(length(input_seq)/min_depth) + min_depth;
% required_len = numOfSymbols * B;
% decoded_symbols = zeros(1, required_len);
% % keep track of final length
% final_len = 0;
% 
% while pointer < length(input_seq)
%     % preallocate buffer
%     buffer = zeros(1,max_depth);
%     bit_number = 1;
% 
%     for i = pointer : pointer + max_depth
% 
%         % make sure we don't go beyond bit stream
%         if(i>length(input_seq))
%             error("Codeword:\n%s\nis not defined!", mat2str(buffer));
%         end
% 
%         % prepare the next bit and add it to the buffer
%         bit = input_seq(i);
%         buffer(bit_number) = bit;
%         fprintf("buffer:")
%         disp(buffer);
% 
%         % Search for the codeword in the codewords cell array
%         index = find(cellfun(@(x) isequal(x, buffer(1:bit_number)), codewords), 1);
% 
%         if ~isempty(index)
%             % match found
%             symbol = symbols{index};
%             decoded_symbols(final_len+1:final_len+B) = symbol;
%             % update pointer
%             pointer = pointer + bit_number;
%             final_len = final_len + B;
%             % increase bit number
%             bit_number = bit_number + 1;
%             break;
%         elseif bit_number == max_depth
%             error("Codeword:\n%s\nis not defined!", mat2str(buffer));
%         end
%     end
% end
% % resize decoded symbols to final length (dispose of extra 0's)
% decoded_symbols(final_len:end) = [];
% decoded_symbols = uint8(decoded_symbols);
% end


