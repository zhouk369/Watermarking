function y=ber(w,w_d)
% ######����������########

%���룺    w��ԭʼˮӡ
%          w_d����⵽��ˮӡ

% ���:   y,������

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