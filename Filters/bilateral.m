function J = bilateral(I , sigma_d , sigma_r )

I = im2double (I); 				% normalization of image values

J = zeros(size(I)); 			% here the filtered image will be stored
tmp= size(I);       			% image size, so that we know the limits for filter implementation

g=fspecial('gaussian', 6*sigma_d+1, sigma_d); 			% gaussian filter

photometric = zeros(6*sigma_d+1); 						% matrix with photometric differences
I=padarray(I,[3*sigma_d 3*sigma_d],'symmetric');		% black padarray

for i=(3*sigma_d+1):(tmp(1)+(3*sigma_d)) 				% scan all the image in 2 dimensions
    for j = (3*sigma_d+1):(tmp(2)+(3*sigma_d))
        
        block = I((i-(3*sigma_d)):(i+(3*sigma_d)),(j-(3*sigma_d)):(j+(3*sigma_d))); % block creation for sigma_d data
        photometric = exp(I(i,j)-block).^2/(2*sigma_r^2);       					% photometric gaussian filter               
        bilateral= g.*photometric ;     											% bilateral = spatial gaussian * photometric gaussian (element by element)
        J(i-(3*sigma_d),j-(3*sigma_d))= sum(block(:).*bilateral(:))/sum(bilateral(:)); % convolution of the block with the bilateral
        % thus, the final image is created after finishing this loop
    end
end

