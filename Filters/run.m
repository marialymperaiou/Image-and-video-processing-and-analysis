close all;  %αρχικοποιήσεις
clear all;
I =imread('cat.jpg');
%I = rgb2gray(I);
figure;
imshow(I), title ('original image');
sigma_d=1;
sigma_r=10;

%bilateral filter application
for k=1:1:10;
        
        J = bilateral(I,sigma_d,sigma_r);
        figure;
        imshow(J), title('bilateral image');
        sigma_d=sigma_d+1; 						%increase counters
        sigma_r=sigma_r+10;
 
end
%median filter application
im = medfilt2(I);
figure;
imshow(im), title('median image');

%s must be an odd integer greater than 1
for s = 3:2:99
    newIm = adpmedian(I,s);
    figure;
    imshow(newIm), title('adaptive median filtered image');
end