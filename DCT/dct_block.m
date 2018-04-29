function[Z_Y, Z_Cb, Z_Cr, c2, RGBb]= dct_block(I, k_Y, k_C)

RGBb = double(I) / 255;
YCbCr=rgb2ycbcr(RGBb);

Y=YCbCr(:,:,1);
Cb=YCbCr(:,:,2);
Cr=YCbCr(:,:,3);
sc = 0.5 % scaling factor

%dct
Db_Y = blkproc(Y, [8 8], 'dct2'); % Y-channel
Db_Cb = blkproc(Cb, [8 8], 'dct2');% Cb channel
Db_Cr = blkproc(Cr, [8 8], 'dct2');% Cr-channel

%zig-zag
Z_Y = blkproc(Db_Y, [8 8], 'zigzag', k_Y); % Y-channel
Z_Cb = blkproc(Db_Cb, [8 8], 'zigzag', k_C); % Cb-channel
Z_Cr = blkproc(Db_Cr, [8 8], 'zigzag', k_C); % Cr-channel 

a2(:,:,1)=Z_Y; %Placing masks in matrix columns
a2(:,:,2)=Z_Cb;
a2(:,:,3)=Z_Cr;
 
c2=nnz(a2);

end

