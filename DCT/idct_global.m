function [iRGB, SNR_D, CR_D] = idct_global(D_Y_mask, D_Cb_mask, D_Cr_mask, tmp, c1, RGB)

%idct2
%Y
i_D_Y=idct2(D_Y_mask); % idct
iYCbCr(:,:,1) = i_D_Y; % reformation

%Cb channel
i_D_Cb =idct2(D_Cb_mask); % idct
iYCbCr(:,:,2) = i_D_Cb; % reformation

%Cr channel
i_D_Cr =idct2(D_Cr_mask); % idct
iYCbCr(:,:,3) = i_D_Cr; % reformation

iRGB = ycbcr2rgb(iYCbCr); 

CR_D= (tmp(1)*tmp(2)*tmp(3))/c1;
SNR_D= 10 * log10(sum(sum(sum(RGB.^2))) / sum(sum(sum((RGB-iRGB).^2))));


figure,imshow(iRGB),title('global-DCT image');      


