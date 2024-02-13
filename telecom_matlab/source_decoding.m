function [output] = source_decoding(param, input)
%SOURCE_DECODING Interface to source decoding

assert(param.source_coding.is_initialized == 1)

switch param.source_coding.type
    case 'none'
        output = source_decoding.none(param, input);
    case 'huffman'
        output = source_decoding.huffman(param.source_coding.huffman_structure, input);
	case 'huffman_img'
		output = source_decoding.huffman_img(param.source_coding.huffman_structure, param.source.image.width, param.source.image.height, input);
    otherwise
        error('Not Supported yet');
end

% check if output is a uint8 row vector
if ~isa(output,'uint8')
    error('BasicLab:invalidOutput', ...
        'Output of function source_decoding.%s must be of type uint8.',...
        param.source_coding.type);
end

if ~isrow(output)
    error('BasicLab:invalidOutput',...
        'Output of function source_decoding.%s must be a uint8 row vector.',...
        param.source_coding.type);
end

end

