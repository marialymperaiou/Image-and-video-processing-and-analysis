function[Q_Y, Q_Cb, Q_Cr, c3, RGBq]= dct_quant(I,q) 

RGBq = double(I) / 255;
YCbCr=rgb2ycbcr(RGBq);


% Each mask is a column of the table when converting the color space
Y=YCbCr(:,:,1);
Cb=YCbCr(:,:,2);
Cr=YCbCr(:,:,3);
%channel values now in the interval [0,255]
Y=Y*255;
Cb=Cb*255;
Cr=Cr*255;

sc = 0.5 % scaling factor
%Applying dct to 8x8 non-overlapping blocks
Db_Y = blkproc(Y, [8 8], 'dct2'); % Y-channel 
Db_Cb = blkproc(Cb, [8 8], 'dct2');% Cb channel 
Db_Cr = blkproc(Cr, [8 8], 'dct2');% Cr-channel


%quant
%Applyingthe quant function for given q to 8x8m overlapping blocks
Q_Y = blkproc(Db_Y,[8 8],'quant_Y', q); %Y-channel
Q_Cb = blkproc(Db_Cb,[8 8],'quant_C', q); %Cb-channel
Q_Cr = blkproc(Db_Cr,[8 8],'quant_C', q); %Cr-channel

%Masks are assigned to the 3 columns of a table
a3(:,:,1)=Q_Y;
a3(:,:,2)=Q_Cb;
a3(:,:,3)=Q_Cr;


% C3 the non - zero elements of the mask table, which are equivalent to
% The size of the compressed image
c3=nnz(a3);
 

end

