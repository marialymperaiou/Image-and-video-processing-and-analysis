function obj_overlay (W,obj,a,z)

[k,l,m]=size(W);
[k1,l1,m1]=size(obj(:,:,1));
d1=k-k1; d2=l-l1;
er= zeros(d1,l);
ec= zeros(k1,d2);
i=1;
for f=a:z
    imshow([obj(:,:,f) ec ;er]+W(:,:,i))
    pause(0.25);
    i=i+1;
end
