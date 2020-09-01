function R=psnr(I,In)


delta=(double(I)-double(In)).^2;
if ndims(I)==3
    delta=sum(sum(sum(delta)))/3;
else
    delta=sum(sum(delta));
end
delta=delta/size(I,1)/size(I,2);
if delta==0
    delta=10^(-10);
end
if max(max(max(max(I))),max(max(max(In))))>10
    S=255^2;
else
    S=1;
end
R=10*log10(S/delta);