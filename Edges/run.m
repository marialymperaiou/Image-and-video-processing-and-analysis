close all;
clear all;

% 1st image: buildings
I1 = imread('building.tif');
I1 = imresize(I1,0.67); 								% to avoid warning due to large initial image size
figure;
imshow(I1), title('original building');
% s is the standard deviation of the respective filters
% default value = 3
s1=3;

%for s1=3:2:99
[E1,Z1,M1] = gdlog(I1,s1);

figure, grayshow(M1), title('M image buildings');		% M image
figure, grayshow(Z1), title('Z image building');		% Z image
figure, grayshow(E1), title ('E image buildings'); 		% final edge image (product of the above ones)
%end

% Canny method
figure, imshow(~edge(I1, 'canny', [], 1)), title('canny1 buildings');
figure, imshow(~edge(I1, 'canny', [], 2)), title('canny2 buildings');
figure, imshow(~edge(I1, 'canny', [], 4)), title('canny3 buildings');

% Canny image gives binary black and white image in contrary with filtering, which includes intermediate grey shades at M inage.
% So, in fact, the sharpness of each edge is lost. Moreover, it can be observed that after any next application of the canny method
% (with parameters 1,2 and 4) the edges are lost. Thus, the resulting image differs more comparing to the initial.
% The main difference is that Canny gives black edges on white background, while filtering does the opposite.

%2nd image: peppers
I2 = imread('peppers.tif');
figure;
imshow(I2), title('original peppers');
s2=3;

%for s2=3:2:99
[E2,Z2,M2] = gdlog(I2,s2);

figure, grayshow(M2), title ('M image peppers');
figure, grayshow(Z2), title('Z image peppers');
figure, grayshow(E2), title('E image peppers');
%end

%Canny
figure, imshow(~edge(I2, 'canny', [], 1)), title('canny1 peppers');
figure, imshow(~edge(I2, 'canny', [], 2)), title('canny2 peppers');
figure, imshow(~edge(I2, 'canny', [], 4)), title('canny3 peppers');

% After tests on the code above, by increasing the s parameter, it can be observed that the final images differ mostly comparing
% to the initial. This is because, the edges are not so precise (the thinner edges cannot be detected). 
% The best result is for s=3, i.e. the minimum value.

% Many methods use histogram analysis to find the mean color density, which is chosen as threshold.
% For automated threshold choice, the information for the neighbouring elements is necessary (luminosity, contrast).
% Based on such -local- values, a method for estimating s can be found (adapting threshold).
% An automated choice of optimal threshold is difficult, though.