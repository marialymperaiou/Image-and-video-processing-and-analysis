function Z = expand(X, b)

% Expands grayscale image X of size (r,c) using blocks of size b, and returns 
% image Z of size (b*r, b*c). Similarly for color images.

if(ndims(X) == 2)

	[r,c] = size(X);
	br = b(1);
	bc = b(2);

	Y = zeros(r, c*bc);
	for i = 1:c, Y(:, (i-1)*bc+(1:bc)) = X(:,i) * ones(1,bc); end

	Z = zeros(r*br, c*bc);
	for i = 1:r, Z((i-1)*br+(1:br), :) = ones(br,1) * Y(i,:); end

elseif(ndims(X) == 3)

	[r,c,d] = size(X);
	br = b(1);
	bc = b(2);

	Y = zeros(r, c*bc, d);
	for i = 1:c, for j = 1:d
		Y(:, (i-1)*bc+(1:bc), j) = X(:,i,j) * ones(1,bc); 
	end, end

	Z = zeros(r*br, c*bc);
	for i = 1:r, for j = 1:d
		Z((i-1)*br+(1:br), :, j) = ones(br,1) * Y(i,:,j); 
	end, end

end