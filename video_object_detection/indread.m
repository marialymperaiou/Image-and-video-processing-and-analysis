function I = indread(file, crop);

% read indexed image and return in double rgb format

if(nargin < 2), crop = []; end

[I,map] = imread(file);
I = ind2rgb(I,map);

if(~isempty(crop)), 
	[rows, cols, channels] = size(I);
	I = I(crop:rows-crop, crop:cols-crop, :);
end

