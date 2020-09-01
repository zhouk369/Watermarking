function y=ber(w,w_d)
% ######计算误码率########

%输入：    w，原始水印
%          w_d，检测到的水印

% 输出:   y,误码率

[m,n]=size(w);
number=m*n;
w=reshape(w,1,number);
w_d=reshape(w_d,1,number);
err=0;
for i=1:number
    if w(i)~=w_d(i)
        err=err+1;
    end
end
y=err/number;