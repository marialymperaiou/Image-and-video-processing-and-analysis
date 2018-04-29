function [F_Y_mask, F_Cb_mask, F_Cr_mask, RGB] = fft_global(I, r_Y, r_C, fig)

% 1. FFT on entire image

%if (nargin < 2), r_Y = 0.8; end
%if (nargin < 3), r_C = 0.3; end
if (nargin < 4), fig = 1; end

% initialization
RGB = double(I) / 255;

% scaling for log images
sc = 0.5;

% RGB->YCBCR
YCbCr = (rgb2ycbcr(RGB));
Y = YCbCr(:,:,1);   %we assign each component to a column
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

% FFT transform

% Y channel
F_Y = fftshift(fft2(Y));
if(fig)
	F_Y_log = sc * log10(1 + abs(F_Y));
	[fx,fy] = freqspace(size(F_Y));
	%figure, mesh(fx, fy, F_Y_log), title('3D shifted abs of FFT2 of Y channel');
	%figure, imshow(F_Y_log / max(max(F_Y_log))), title('shifted abs of FFT2 of Y channel');
end

% Cb channel
F_Cb = fftshift(fft2(Cb));
if(fig)
	F_Cb_log = sc * log10(1 + abs(F_Cb));
	[fx,fy] = freqspace(size(F_Cb));
	%figure, mesh(fx, fy, F_Cb_log), title('3D shifted abs of FFT2 of Cb channel');
	%figure, imshow(F_Cb_log / max(max(F_Cb_log))), title('shifted abs of FFT2 of Cb channel');
end

% Cr channel
F_Cr = fftshift(fft2(Cr));
if(fig)
	F_Cr_log = sc * log10(1 + abs(F_Cr));
	[fx,fy] = freqspace(size(F_Cr));
	%figure, mesh(fx, fy, F_Cr_log), title('3D shifted abs of FFT2 of Cr channel');
	%figure, imshow(F_Cr_log / max(max(F_Cr_log))), title('shifted abs of FFT2 of Cr channel');
end

% mask application
[r, c] = size(Y);
[fx, fy] = meshgrid((1:c) - (c+1)/2, (1:r) - (r+1)/2);
rc = min(r, c) / 2;

% Y channel
m_Y = zeros(r, c);
m_Y(sqrt(fx.^2 + fy.^2) < r_Y * rc) = 1;
F_Y_mask = F_Y .* m_Y;
%if(fig), figure, mesh(fx, fy, m_Y), title('mask for Y'), end

% Cb and Cr channels
m_C = zeros(r, c);
m_C(sqrt(fx.^2 + fy.^2) < r_C * rc) = 1;
F_Cb_mask = F_Cb .* m_C;
F_Cr_mask = F_Cr .* m_C;
%if(fig), figure, mesh(fx, fy, m_C), title('mask for Cb and Cr'), end


