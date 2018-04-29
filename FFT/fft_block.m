function [Fb_Y_mask, Fb_Cb_mask, Fb_Cr_mask, RGBb] = fft_block(I, r_Y, r_C, fig)

% 2. block-based FFT 
%if (nargin < 2), r_Y = 0.8; end
%if (nargin < 3), r_C = 0.4; end
if (nargin < 4), fig = 1; end

% initialization
RGBb = double(I) / 255;

% scaling for log images
sc = 0.5;

% RGB->YCBCR
YCbCr = (rgb2ycbcr(RGBb));
Y = YCbCr(:,:,1);
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

% FFT transform

% Y channel
Fb_Y = blkproc(Y, [8 8], 'fft2');
Fb_Y = blkproc(Fb_Y, [8 8], 'fftshift');
if(fig)
	Fb_Y_log = sc * log10(1 + abs(Fb_Y));
	%figure, imshow(Fb_Y_log), title('block-based FFT of Y channel');
end

% Cb channel
Fb_Cb = blkproc(Cb, [8 8], 'fft2');
Fb_Cb = blkproc(Fb_Cb, [8 8], 'fftshift');
if(fig)
	Fb_Cb_log = sc * log10(1 + abs(Fb_Cb));
	%figure, imshow(Fb_Cb_log), title('block-based FFT of Cb channel');
end

% Cr channel
Fb_Cr = blkproc(Cr, [8 8], 'fft2');
Fb_Cr = blkproc(Fb_Cr, [8 8], 'fftshift');
if(fig)
	Fb_Cr_log = sc * log10(1 + abs(Fb_Cr));
	%figure, imshow(Fb_Cr_log), title('block-based FFT of Cr channel');
end

% mask application
[fx,fy] = freqspace([8 8], 'meshgrid');

% Y channel
m = zeros(8);
m(sqrt(fx.^2 + fy.^2) < r_Y) = 1;
Fb_Y_mask = blkproc(Fb_Y, [8 8], 'times', m);
%if(fig), figure, mesh(fx, fy, m), title('mask for Y'), end

% Cb and Cr channels
m_C = zeros(8);
m_C(sqrt(fx.^2 + fy.^2) < r_C) = 1;
Fb_Cb_mask = blkproc(Fb_Cb, [8 8], 'times', m_C);
Fb_Cr_mask = blkproc(Fb_Cr, [8 8], 'times', m_C);
%if(fig), figure, mesh(fx, fy, m_C), title('mask for Cb and Cr'), end

