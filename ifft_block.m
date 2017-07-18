function [iRGBb] = ifft_block(Fb_Y_mask, Fb_Cb_mask, Fb_Cr_mask)

%Υ
i_Y = blkproc(Fb_Y_mask, [8 8], 'ifftshift'); %ifftshift σε block 8x8 σε κάθε κανάλι της εικόνας μετά την εφαρμογή της μάσκας
iY = blkproc(i_Y, [8 8], 'ifft2');            %iFFT σε block 8x8 σε κάθε κανάλι της εικόνας μετά την εφαρμογή του ifftshift
iYCbCr(:,:,1) = iY;                           %Κανονικοποίηση των τιμών των καναλιών

%Cb
i_Cb = blkproc(Fb_Cb_mask, [8 8], 'ifftshift'); %ifftshift σε block 8x8 σε κάθε κανάλι της εικόνας μετά την εφαρμογή της μάσκας
iCb = blkproc(i_Cb, [8 8], 'ifft2');            %iFFT σε block 8x8 σε κάθε κανάλι της εικόνας μετά την εφαρμογή του ifftshift
iYCbCr(:,:,2) = iCb;

%Cr
i_Cr = blkproc(Fb_Cr_mask, [8 8], 'ifftshift'); %ifftshift σε block 8x8 σε κάθε κανάλι της εικόνας μετά την εφαρμογή της μάσκας
iCr = blkproc(i_Cr, [8 8], 'ifft2');            %iFFT σε block 8x8 σε κάθε κανάλι της εικόνας μετά την εφαρμογή του ifftshift
iYCbCr(:,:,3) = iCr;

iRGBb = ycbcr2rgb(iYCbCr);                     %Μετατροπή χρωματικού χώρου(από YCbCr σε RGB)
figure,imshow(iRGBb),title('block-FFT image'); %Απεικόνιση έγχρωμης ανακατασκευασμένης εικόνας (iRGB)


