function [iRGBq, SNR_Dq, CR_Dq]= idct_quant(Q_Y, Q_Cb, Q_Cr, q, tmp, c3, RGB)

%Call of the inverse quant for each channel in 8x8 non-overlapping blocks
Q_Y_i = blkproc(Q_Y,[8 8],'iquant_Y', q); %Y-channel
Q_Cb_i = blkproc(Q_Cb,[8 8],'iquant_C', q); %Cb-channel
Q_Cr_i = blkproc(Q_Cr,[8 8],'iquant_C', q); %Cr-channel

%inverse dct 
%y
i_Y_q= blkproc(Q_Y_i, [8 8], 'idct2'); %idct 

% Assigning the rebuilt mask to a table to reset the color space in the end
iYCbCr_q(:,:,1) = i_Y_q;%reformation

% Cb channel
i_Cb_q = blkproc(Q_Cb_i, [8 8], 'idct2'); % idct
iYCbCr_q(:,:,2) = i_Cb_q;%reformation

% Cr channel
i_Cr_q = blkproc(Q_Cr_i, [8 8], 'idct2'); % idct
iYCbCr_q(:,:,3) = i_Cr_q;%reformation

% YCBCR -> RGB
iRGBq = ycbcr2rgb(iYCbCr_q);

CR_Dq= (tmp(1)*tmp(2)*tmp(3))/c3;
SNR_Dq= 10 * log10(sum(sum(sum(RGB.^2))) / sum(sum(sum((RGB-iRGBq).^2))));



figure, imshow(iRGBq),title('quant image');


end

