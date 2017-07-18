% initialization
close all, clear;

% load image
I = imread('flowers.tif');
%I = imread('board.tif');
fig = 1; 
if(fig), figure(1), imshow(I), title('Original image'), end

i=1;            %αρχική τιμή μετρητή επανάληψης
tmp= size(I);   %μέγεθος αρχικής εικόνας πριν την επεξεργασία
r_Y=0.1;        %αρχικές τιμές παραμέτρων
r_C=0.2;
for j=1:5;
% coding on entire image
        [F_Y_mask, F_Cb_mask, F_Cr_mask,RGB] = fft_global(I, r_Y, r_C, fig);
        a1(:,:,1)=F_Y_mask; %τοποθέτηση μασκών σε στήλες πίνακα
        a1(:,:,2)=F_Cb_mask;
        a1(:,:,3)=F_Cr_mask;
       
        [iRGB] = ifft_global(F_Y_mask, F_Cb_mask, F_Cr_mask);
        %παίρνω τα μη μηδενικά στοιχεία της εικόνας μετά το fft
        %αυτό ισοδυναμεί με το μέγεθος της συμπιεσθείσας εικόνας
        %διαιρώντας με το μέγεθος της αρχικής έχω το λ=1/cr
        l1(i)= nnz(a1)/(tmp(1)*tmp(2)*tmp(3));
        
        % signal to noise ratio
        snr1(i) = 10 * log10(sum(sum(sum(RGB.^2))) / sum(sum(sum((RGB-iRGB).^2))));
        %θεωρώντας ως σήμα την RGB και ως θόρυβο την RGB-iRGB
% block-based coding 
        [Fb_Y_mask, Fb_Cb_mask, Fb_Cr_mask, RGBb] = fft_block(I, r_Y, r_C, fig);
        a2(:,:,1)=Fb_Y_mask;
        a2(:,:,2)=Fb_Cb_mask;
        a2(:,:,3)=Fb_Cr_mask;
        [iRGBb] = ifft_block(Fb_Y_mask, Fb_Cb_mask, Fb_Cr_mask);
        
        l2(i)=nnz(a2)/(tmp(1)*tmp(2)*tmp(3));
        %αντίστροφος λόγος συμπίεσης λ για τη μετασχηματισμένη κατά μπλοκ
        %εικόνα
        
        % signal to noise ratio
        snr2 (i)= 10 * log10(sum(sum(sum(RGB.^2))) / sum(sum(sum((RGBb-iRGBb).^2))));
        %το σήμα θεωρείται η αρχική RGB εικόνα, ενώ ο θόρυβος η διαφορά
        %αυτής μείον την εικόνα που προέκυψε μετά τη χρήση FFT-iFFT
       
        i=i+1;  %προς επόμενη επανάληψη
        r_Y=r_Y+0.18    %αυξάνω τις παραμέτρους με κατάλληλο βήμα
        r_C=r_C+0.12
    end


figure
plot (l1,snr1), hold on, plot (l2,snr2,'r')
%απεικόνιση των ζητουμένων σε κοινό διάγραμμα
xlabel('compression ratio') %ονομασίες των αξόνων οριζοντίως
ylabel('SNR')               %και καθέτως
