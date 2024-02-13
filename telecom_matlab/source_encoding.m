function [output] = source_encoding(param,input)
%SOURCE_ENCODING Interface to source encoding

assert(param.source_coding.is_initialized == 1)

switch param.source_coding.type
    case 'none'
        output = source_encoding.none(param.source_coding.huffman_structure, input);
    case 'huffman'
        output = source_encoding.huffman(param.source_coding.huffman_structure, input);
	case 'huffman_img'
		output = source_encoding.huffman_img(param.source_coding.huffman_structure, param.source.image.width, param.source.image.height, input);
    otherwise
        error('Not Supported yet');
end

% check if output is a uint8 row vector
if ~isa(output,'uint8')
    error('BasicLab:invalidOutput', ...
        'Output of function source_encoding.%s must be of type uint8.',...
        param.source_coding.type);
end

if ~isrow(output)
    error('BasicLab:invalidOutput',...
        'Output of function source_encoding.%s must be a uint8 row vector.',...
        param.source_coding.type);
end


end

