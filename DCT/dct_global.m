function[D_Y_mask, D_Cb_mask, D_Cr_mask, c1, RGB]= dct_global(I,d_Y,d_C)
%'normalization of the image in the interval [0,1]
RGB = double(I) / 255;
%Color space conversion
YCbCr=rgb2ycbcr(RGB);

Y=YCbCr(:,:,1);
Cb=YCbCr(:,:,2);
Cr=YCbCr(:,:,3);

D_Y = dct2(Y); % DCT transform - Y channel
D_Cb = dct2(Cb); % DCT transform - Cb channel
D_Cr = dct2(Cr); % DCT transform - Cr channel

sc = 0.5; % scaling factor
D_Y_log = sc * log10(1 + abs(D_Y));
[fx,fy] = freqspace(size(D_Y));


sc = 0.5; % scaling factor
D_Cb_log = sc * log10(1 + abs(D_Cb));
[fx,fy] = freqspace(size(D_Cb));
%figure(5), mesh(fx, fy, D_Cb_log);

sc = 0.5 ;% scaling factor
D_Cr_log = sc * log10(1 + abs(D_Cr));
[fx,fy] = freqspace(size(D_Cr));


[r, c] = size(Y); %μέγεθος του καναλιού Υ
rc = min(r, c);
m_Y = fliplr(triu(ones(r,c),round(c-d_Y*rc)));
% Through the triu we obtain the data above the nth
% (n > 0) diagonal since n = 0 is the main diagonal, while flipr
% returns the resulting upper triangle table. Increasing dY
% increases the number of 'surviving' items

D_Y_mask = D_Y .* m_Y;
% Mask application on each channel. This operation takes place 'element to
% element', resulting in cutting off the DY channel data below
% the nth diagonal. This is reasonable, since in dct compression we wish to
% keep the components on the top left, while the rest are cut off,
% considered as less significant

%Cb and Cr channels
m_C = fliplr(triu(ones(r,c),round(c-d_C*rc))); 

D_Cb_mask = D_Cb .* m_C; %mask application on Cb channel
D_Cr_mask = D_Cr .* m_C; %mask application on Cr channel

 a1(:,:,1)=D_Y_mask; %Placing masks in matrix columns
 a1(:,:,2)=D_Cb_mask;
 a1(:,:,3)=D_Cr_mask;
 
 %and we get the non-zero elements of the table of the masks
 c1=nnz(a1);
 

end

