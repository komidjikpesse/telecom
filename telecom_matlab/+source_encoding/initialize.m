function [param] = initialize(param)

	%if param.source_coding.is_initialized
	%	  return
	%end

	switch param.source_coding.type
		case 'none'
			param.source_coding.length = ceil(log2(param.source.cardinality));
			if param.source_coding.length == 0
				param.source_coding.length = 1;
			end
			
		case 'huffman'
			% load huffman table file
			load(param.source_coding.huffman.tablefile)
            
            assert(exist('huffman_structure','var'));
            assert(isfield(huffman_structure,'M'));
            assert(isfield(huffman_structure,'B'));
			
			% store params in param struct
			param.source_coding.huffman_structure = huffman_structure;
		
		case 'huffman_img'
			% load huffman table file
			load(param.source_coding.huffman.tablefile)
            
            assert(exist('huffman_structure','var'));
            assert(isfield(huffman_structure,'M'));
            assert(isfield(huffman_structure,'B'));
						
			% store params in param struct
			param.source_coding.huffman_structure = huffman_structure;
			
		otherwise
			error('Not Supported yet');
	end
		
	param.source_coding.is_initialized = 1;
end

