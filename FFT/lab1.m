% initialization
close all, clear;

% load image
I = imread('flowers.tif');
%I = imread('board.tif');
fig = 1; 
if(fig), figure(1), imshow(I), title('Original image'), end

i=1;            %initial value of the loop index
tmp= size(I);   %size of the initial image before processing
r_Y=0.1;        %initial parameter values
r_C=0.2;
for j=1:5;
% coding on entire image
        [F_Y_mask, F_Cb_mask, F_Cr_mask,RGB] = fft_global(I, r_Y, r_C, fig);
        a1(:,:,1)=F_Y_mask; %mask application (matrix columns)
        a1(:,:,2)=F_Cb_mask;
        a1(:,:,3)=F_Cr_mask;
       
        [iRGB] = ifft_global(F_Y_mask, F_Cb_mask, F_Cr_mask);
        %we take the non-zero elements of the image after the fft processing
        %this is equivalent to the size of the compressed image
        %dividing with the size of the original one we get ë=1/cr
        l1(i)= nnz(a1)/(tmp(1)*tmp(2)*tmp(3));
        
        % signal to noise ratio
        snr1(i) = 10 * log10(sum(sum(sum(RGB.^2))) / sum(sum(sum((RGB-iRGB).^2))));
        %Considering RGB as the signal and RGB-iRGB as the noise
% block-based coding 
        [Fb_Y_mask, Fb_Cb_mask, Fb_Cr_mask, RGBb] = fft_block(I, r_Y, r_C, fig);
        a2(:,:,1)=Fb_Y_mask;
        a2(:,:,2)=Fb_Cb_mask;
        a2(:,:,3)=Fb_Cr_mask;
        [iRGBb] = ifft_block(Fb_Y_mask, Fb_Cb_mask, Fb_Cr_mask);
        
        l2(i)=nnz(a2)/(tmp(1)*tmp(2)*tmp(3));
      
%Inverse compression ratio ë for the transformed block picture
        % signal to noise ratio
        snr2 (i)= 10 * log10(sum(sum(sum(RGB.^2))) / sum(sum(sum((RGBb-iRGBb).^2))));

% The signal is considered as the original RGB image, while the noise is the difference
% between the original image minus the resulting image after using FFT-iFFT
       
        i=i+1;  %to nexti iteraton
        r_Y=r_Y+0.18    %we increase the parameters' values using the appropriate step
        r_C=r_C+0.12
    end


figure
plot (l1,snr1), hold on, plot (l2,snr2,'r')
%Visualization of the requested diagrams 
xlabel('compression ratio') %Names of axes horizontally
ylabel('SNR')               %and vertically
