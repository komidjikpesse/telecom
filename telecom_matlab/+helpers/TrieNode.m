classdef TrieNode < handle

properties
    symbol
    children
end

methods
    % constructor
    function obj = TrieNode()
        obj.symbol = [];
        obj.children = cell(1, 2);
    end
end
end