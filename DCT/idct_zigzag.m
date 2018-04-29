function[iRGBz, SNR_Dz, CR_Dz] = idct_zigzag(Z_Y, Z_Cb, Z_Cr, tmp, c2, RGB)


% Application of the inverse dct to 8x8 non-overlapping channels of each
% mask.
% Y channel
i_Y_z= blkproc(Z_Y, [8 8], 'idct2'); %idct 

% Assign each reverted component in a table so as to
% return to the original color space
iYCbCr_z(:,:,1) = i_Y_z;%reformation

% Cb channel
i_Cb_z = blkproc(Z_Cb, [8 8], 'idct2'); % idct
iYCbCr_z(:,:,2) = i_Cb_z;%reformation

% Cr channel
i_Cr_z = blkproc(Z_Cr, [8 8], 'idct2'); % idct
iYCbCr_z(:,:,3) = i_Cr_z;%reformation

% YCBCR -> RGB Color space reset
iRGBz = ycbcr2rgb(iYCbCr_z);

CR_Dz= (tmp(1)*tmp(2)*tmp(3))/c2; 
% Original image / non-zero compressed image data = compression ratio
% C2 the non-zero elements of the compressed image after
% the zig zag transformation

SNR_Dz= 10 * log10(sum(sum(sum(RGB.^2))) / sum(sum(sum((RGB-iRGBz).^2))));
% RGB signal, RGB-iRGBz noise, iRGBz the image that results in after the
% inverse transformation and return to original RGB color space

% Display the remanufactured image
figure, imshow(iRGBz),title('block Zig-Zag image');

end

