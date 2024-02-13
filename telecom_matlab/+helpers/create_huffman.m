function [huffman_structure] = create_huffman(M, pM, B)
%CREATE_HUFFMAN creates a huffman tree structure from a list of symbols and their probabilities 
%   Detailed explanation goes here
%   Inputs:
%       M: all possible source symbols
%       pM: probabilities of the source symbols
%       B: numbers of source symbols to combine
%   Outputs:
%       huffman_structure: struct containing huffman data tree

huffman_structure = struct();
huffman_structure.B = B;
huffman_structure.M = M;

% Check for incorrect user input
if B > length(M)
    error('B is greater than the length of M.');
end

if length(M) ~= length(pM)
    error('The lengths of M and pM dont match')
end


tic % start timer

% save all combinations with their probabilities to the struct
sortedTable = generateAllCombinations(M, pM, B);
huffman_structure.combs = sortedTable;

% create huffman table from the data
cell_huff = huffmanTable(sortedTable);

% convert huffman table to readable table
huffStruct = convertToReadableTable(cell_huff);
huffman_structure.symbol_codes = huffStruct.symbol_codes;
huffman_structure.depth = huffStruct.max_depth;
huffman_structure.min_depth = huffStruct.min_depth;

% build a Trie data structure (for decoding) from the symbol_codes table
trie = buildTrie(huffStruct.symbol_codes);
huffman_structure.trie = trie;

elapsed_time = toc;
fprintf("[Log] Finished building huffman table\n")
fprintf('[Log] Elapsed time: %.4f seconds\n', elapsed_time);
fprintf("======================================\n");


% =================== GETTING ALL COMBINATIONS ========================

function [sortedTable] = generateAllCombinations(M, pM, B)
% Generate all possible messages (combinations of length B of symbols from M);
    cell_arr = cell(1,B);
    for i = 1:B
        cell_arr{i} = M;
    end
    combs = combinations(cell_arr{:});
    % convert table to matrix
    combs = combs{:,:};

    % calculate probability for all messages in combs (all rows)
    % then add the probability as first column of matrix 'table'
    prob=zeros(length(combs),1);
    for i=1:length(combs)
        % p is the probability of the new symbol of length B
        p=1;
        for j=1:B
            probIndex = M==combs(i,j);
            p = p * pM(probIndex);
        end
        prob(i) = p;
    end
    table = [prob, combs];

    % sort messages with respect to (increasing) probability
    sortedTable = sortrows(table,1);
    % note: this is required for the generation of the huffman tree

end


% ======================= HUFFMAN TABLE =======================

% creates a table with symbols and their codewords
function cell_arr = huffmanTable(sortedTable)

cell_arr = cell(1, size(sortedTable,1));

for i=1:size(sortedTable,1)
    % create a starter tree with one node
    huffNode = cell(1,3);

    % first column is the probability of the node
    huffNode{1} = sortedTable(i,1);
    % second column holds arrays of symbols
    symbols = cell(1);
    symbols{1} = sortedTable(i, 2:end);
    huffNode{2} = symbols; 
    % third colums holds corresponding codewords to be determined
    codewords = cell(1);  
    huffNode{3} = codewords;

    % insert huffNode into main cell array
    cell_arr{i} = huffNode;
end

while(length(cell_arr)>1)
    % get 2 smallest elements
    left = cell_arr{1};
    right = cell_arr{2};

    % remove first 2 elements from main cell array
    cell_arr(1:2) = [];

    % caluclate combined probability of the new node
    l_p = left{1};
    r_p = right{1};
    combined_p = l_p + r_p;

    % get the current codeword and update it with one more bit (0/1)
    % if the child is on the left, update codeword with 0
    for i=1:length(left{3})
        code_vector = left{3}{i};
        left{3}{i} = [0 code_vector];
    end
    % if the child is on the right, update codeword with 1
    for i=1:length(right{3})
        code_vector = right{3}{i};
        right{3}{i} = [1 code_vector];
    end

    % create new node that combines nodes from left and right child
    new_symbols = [left{2} right{2}];
    new_codewords = [left{3} right{3}];

    % prepare new tree with new node for insertion
    new_tree = cell(1, 3);
    new_tree{1} = combined_p;
    new_tree{2} = new_symbols;
    new_tree{3} = new_codewords;

    % insert new node into cell_arr
    biggest_p = true;
    % insert sort the newly created tree by considering p of each tree
    % in cell_arr. Search for the right index to insert.
    for i=1:length(cell_arr)
        % get node/tree to compare with new_node and then
        current_tree = cell_arr{i};
        % get probability of that node/tree
        p_i = current_tree{1};
        
        % compare probabilities
        if(combined_p <= p_i)
            % the combined p is not the biggest p
            biggest_p = false;
            % insert new tree at this index
            cell_arr = [cell_arr(1:i-1), {new_tree}, cell_arr(i:end)];
            break;
        end
    end
    % if the combined p is biggest yet, add new_tree at the end
    if(biggest_p)
        cell_arr = [cell_arr(1:end), {new_tree}];
    end
end
end


% ============= Convert output to a readable table ===============

% convert the cell_arr into a redable cell array symbol_codes
function [huffStruct] = convertToReadableTable(cell_arr)
% first column has the symbol in an array, 2nd column has the codeword in bits
symbol_codes = cell(length(cell_arr),2);

% convert the cell_arr structure into a more readable huffman table
for i=1:length(cell_arr{1}{2})
    % get symbols and and their corresponding codewords
    symbols_arr = cell_arr{1}{2}{i};
    codewords_arr = cell_arr{1}{3}{i};

    % fill the huffman table with symbols and codewords
    symbol_codes{i,1} = symbols_arr;
    symbol_codes{i,2} = codewords_arr;
end

% sort and save the lookup table to the huffman struct
symbol_codes = sortHuff(symbol_codes);

% add the min/max depth of the binary huffman tree to the struct (useful info)
huffStruct.max_depth = length(symbol_codes{end ,2});
huffStruct.min_depth = length(symbol_codes{1   ,2});
huffStruct.symbol_codes = symbol_codes;

end


% ==================== GENERATE TRIE STRUCTURE ==========================

% a trie (prefix tree) is a data structure that works like a binary tree
% but it ensures that no codeword is a prefix of another codeword.
function trie = buildTrie(symbol_codes)
    % get symbols and codewords
    symbols = symbol_codes(:,1);
    codewords = symbol_codes(:,2);
    % Initialize the root of the trie
    trie = helpers.TrieNode();

    % Populate the trie with codewords and corresponding symbols
    for i = 1:length(codewords)
        insertCodeword(trie, codewords{i}, symbols{i});
    end
end

% inserts new child to the Trie
function insertCodeword(trie, codeword, symbol)
    % Insert a codeword and symbol into the trie
    current_node = trie;

    % Traverse the trie, creating nodes as needed
    for j = 1:length(codeword)
        bit = codeword(j) + 1;  % Assuming codeword(j) is 0 or 1
        if isempty(current_node.children{bit})
            current_node.children{bit} = helpers.TrieNode();
        end
        current_node = current_node.children{bit}; 
    end

    % Assign the symbol to the leaf node
    current_node.symbol = symbol;
end

% useful for printing the Trie for debugging
function printTrie(node, level)
    % Print the current level
    fprintf("======== %d ========\n", level);

    % Print the symbol at the current node, if any
    if ~isempty(node.symbol)
        fprintf("Symbol: %s\n", mat2str(node.symbol));
    end

    % Recursively print the left and right children, if they exist
    if ~isempty(node.children{1})
        fprintf("LEFT (level %d):\n", level);
        printTrie(node.children{1}, level + 1);
    end
    if ~isempty(node.children{2})
        fprintf("RIGHT (level %d):\n", level);
        printTrie(node.children{2}, level + 1);
    end
end

% ======================== HELPER FUNCTIONS =============================

% sort the huffman output for better visualisation
% also speeds up encoding and decoding as the symbols with highest 
% probability are checked first
function sorted_huffTable = sortHuff(symbol_codes)
   lengths = cellfun(@length, symbol_codes(:,2));
   [~, sorted_indices] = sort(lengths);
   sorted_huffTable = symbol_codes(sorted_indices, :);
end

% ======================================================================

end




