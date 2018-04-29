function grayshow(I)

I = double(I);
mx = max(I(:));
mn = min(I(:));
I = (I - mn) ./ (mx - mn);
imshow(I)