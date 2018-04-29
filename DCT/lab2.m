% initialization
close all, clear;

% load image
I = imread('flowers.tif');
%I = imread('board.tif');
fig = 1; 
if(fig), figure(1), imshow(I), title('Original image'), end

i=1;            % Initial counter value for the loop
tmp= size(I);   % Original image size before processing
d_Y=0.1;        % Initial parameter values
d_C=0.05;
k_Y=2;
k_C=1;
q=0.2;
for i=1:10;
% coding on entire image
        [D_Y_mask, D_Cb_mask, D_Cr_mask, c1, RGB]= dct_global(I,d_Y,d_C);
       
        % The input arguments are the given values ??and the original image
        % The output arguments are the masks, its non-zero c1 elements
        % of the compressed image and the RGB image as obtained with values ??in [0.1]
        [iRGB, SNR_D, CR_D] = idct_global(D_Y_mask, D_Cb_mask, D_Cr_mask, tmp, c1, RGB);

        % Here we enter the masks, the size of the original image, the
        % Number of non-zero data compressed using dct and the RGB image before
        % compression, and as an output we get the picture after
        % processing, the SNR signal ratio, and the compression ratio for
        % this method
        

        % Inverse compression ratio is entered at the appropriate location of a
        % l1 table 
        l1(i)= 1.0/CR_D;
        

        % Signal to noise ratio is entered in a table for this iteration
        snr1(i) = SNR_D;
        
% block-based coding 
        [Zb_Y_mask, Zb_Cb_mask, Zb_Cr_mask, c2, RGBb] = dct_block(I, k_Y, k_C);
       
        [iRGBz, SNR_Dz, CR_Dz] = idct_zigzag(Zb_Y_mask, Zb_Cb_mask, Zb_Cr_mask, tmp, c2, RGB);

        % Inverse compression ratio ë for the transformed image (in blocks)
         l2(i)= 1.0/CR_Dz;
        
       % signal to noise ratio
        snr2 (i)= SNR_Dz;
   
%quant coding       
        [Q_Y_mask, Q_Cb_mask, Q_Cr_mask, c3, RGBq]= dct_quant(I, q);
      
        [iRGBq, SNR_Dq, CR_Dq] = idct_quant(Q_Y_mask, Q_Cb_mask, Q_Cr_mask, q, tmp, c3, RGB);
        
        l3(i)=1.0/CR_Dq;
             
        % signal to noise ratio
        snr3 (i)= SNR_Dq;

        i=i+1;          % To the next iteration
        d_Y=d_Y+0.1;    % Increase the parameters' values according to a suitable step
        d_C = d_Y/2;    % To achieve a uniform increase
        k_Y=k_Y+1.8;
        k_C = k_Y/2;
        q=q+1.58;
    end


figure
plot (l1,snr1), hold on, plot (l2,snr2,'r'), hold on, plot (l3,snr3, 'g')
% Visualization of the requested diagrams 
legend('global',' zig-zag','quant');
xlabel('compression ratio') % Names of axes horizontally
ylabel('SNR')               % And vertically
