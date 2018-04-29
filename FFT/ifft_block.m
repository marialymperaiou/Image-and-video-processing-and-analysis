function [iRGBb] = ifft_block(Fb_Y_mask, Fb_Cb_mask, Fb_Cr_mask)

%Õ
i_Y = blkproc(Fb_Y_mask, [8 8], 'ifftshift'); %Ifftshift in 8x8 blocks on each image channel after the mask is applied
iY = blkproc(i_Y, [8 8], 'ifft2');            %iFFT in 8x8 blocks on each image channel after ifftshift
iYCbCr(:,:,1) = iY;                           %Normalization of the channel values

%Cb
i_Cb = blkproc(Fb_Cb_mask, [8 8], 'ifftshift'); %Ifftshift in 8x8 blocks on each image channel after the mask is applied
iCb = blkproc(i_Cb, [8 8], 'ifft2');            %iFFT in 8x8 blocks on each image channel after ifftshift
iYCbCr(:,:,2) = iCb;

%Cr
i_Cr = blkproc(Fb_Cr_mask, [8 8], 'ifftshift'); %Ifftshift in 8x8 blocks on each image channel after the mask is applied
iCr = blkproc(i_Cr, [8 8], 'ifft2');            %iFFT in 8x8 blocks on each image channel after ifftshift
iYCbCr(:,:,3) = iCr;

iRGBb = ycbcr2rgb(iYCbCr);                     %Color conversion (from YCbCr to RGB)
figure,imshow(iRGBb),title('block-FFT image'); %Colored Reconfigured Image Display (iRGB)


