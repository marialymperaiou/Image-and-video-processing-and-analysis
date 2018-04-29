function [iRGB] = ifft_global(F_Y_mask, F_Cb_mask, F_Cr_mask)

%ifft

%Y
i_F_Y=ifftshift(F_Y_mask);      % ifftshift μετά την εφαρμογή της μάσκας
i_FY = abs(ifft2(i_F_Y));       % ifft2
iYCbCr(:,:,1) = i_FY;           % reformation

%Cb
i_F_Cb=ifftshift(F_Cb_mask);    % ifftshift
i_FCb = abs(ifft2(i_F_Cb));     % ifft2
iYCbCr(:,:,2) = i_FCb;          % reformation

%Cr
i_F_Cr=ifftshift(F_Cr_mask);    % ifftshift
i_FCr = abs(ifft2(i_F_Cr));     % ifft2
iYCbCr(:,:,3) = i_FCr;          % reformation

iRGB = ycbcr2rgb(iYCbCr);                           %Color conversion (from YCbCr to RGB)
figure,imshow(iRGB),title('global-FFT image');      %Colored Reconfigured Image Display (iRGB)



