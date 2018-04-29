function [E,Z,M] = gdlog(I,s)

I=im2double(I);

%2D-gaussian derivative
% creation of the gaussian filter with parameter 6*s. 
% a 6s+1 matrix with central pixel will result.

N = (0:(6*s))-(6*s)/2; 								% line array of size 6s+1 with increasing values of the elements. From each, the mean value is subtracted.
[x,y] = meshgrid(N,N); %full grid 
% the one dimensional array becomes 6s+1 * 6s+1 matrix.
G = 1 / (2*pi*s^2) * exp(-(x.^2+y.^2) / (2*s^2)); 	% The 6s+1*6s+1 matrix on which this function has been applied.

% partial derivatives x,y
Gx = -(x/s^2) .* G; 								% element by element multiplication
Gy = -(y/s^2) .* G;

% application of the filter
Dx = imfilter(I, Gx, 'replicate', 'conv');
Dy = imfilter(I, Gy, 'replicate', 'conv');
M = sqrt(Dx.^2 + Dy.^2); 							% M of the matrices Dx, Dy after the filter application 

%laplacian of gaussian filter for the image
L = fspecial('log', 6*s, s); 						% smoothing
Z = imfilter(I, L, 'replicate');

%zero crossings Z
Z=Z < 0; 											% thresholding at 0
Z=bwperim(Z);										% extracts the edges of the resulting binary image

% The edges E are being extracted of the above two elements:
E=Z.*M;

end