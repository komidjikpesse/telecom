function [output] = source(param)
%SOURCE Summary of this function goes here
%   Detailed explanation goes here

assert(param.source.is_initialized == 1)

if strcmp(param.source.type,'dms')
    output = source.random(param);
else
    output = param.source.sequence;
end

%switch param.source.type
%    case 'image'
%    		assert(param.source.image.is_initialized == 1)
%    		
%        if isfield(param.source.image,'filename')
%            filename = param.source.image.filename;
%        else
%            filename = source.choose_image();
%        end
%        [output,param] = source.load_image(param);
%        
%    otherwise
%        error('Source Type not supported');
%end
        
end

