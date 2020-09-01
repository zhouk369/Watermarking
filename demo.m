 %%%%%%%%%%%%%%%%%%%%%% 嵌入64位的水印信息
clc
clear all
close all

orim = imread('lena.ppm');

orim_r = orim(:,:,1); % r channel
orim_g = orim(:,:,2); % g channel
orim_b = orim(:,:,3); % b channel
orim_y = 0.299*double(orim_r) + 0.587*double(orim_g) + 0.114*double(orim_b);  % y channel
orim_cb = -0.169*double(orim_r) - 0.331*double(orim_g) + 0.500*double(orim_b) + 128;  %cb channel
orim_cr = 0.500*double(orim_r)  - 0.419*double(orim_g) - 0.081*double(orim_b) + 128;  % cr channel
I = double(orim_y);
[m,n]=size(I);
msize=m/8;nsize=n/8;
w=imread('water.bmp');  % load watermark image
ww=w;   %保存原始水印
%%  Proposed method
p=1;
strong_stMW4 = 0.447;   % embed strength
[jnd{p}] =  func_jnd_wan(I);  % the JND model

%  watermark embedding
[I_w{p}]  = embed_dmjnd(I,w,strong_stMW4,jnd{p}); 
w_r{p} = 1.0*I_w{p} + 0.0*(orim_cb - 128) + 1.403*(orim_cr - 128);
w_g{p} = 1.0*I_w{p} - 0.344*(orim_cb - 128) - 0.714*(orim_cr - 128);
w_b{p} = 1.0*I_w{p} + 1.773*(orim_cb - 128) + 0*(orim_cr - 128);
w_rgb{p} = cat(3, uint8(w_r{p}), uint8(w_g{p}), uint8(w_b{p}));%imshow(w_rgb{p},[])

% watermark extraction
s = 0.0025; % gaussian noise attack
[BER{p},www{p},gn_img]=detect_dmjnd(w_rgb{p},strong_stMW4,ww,s);
figure(1)
subplot(1,3,1);imshow(orim, []);title('Original image');
subplot(1,3,2);imshow(w_rgb{p}, []);title('Watermarked image');
subplot(1,3,3);imshow(gn_img, []);title('Gaussian noise image');
figure(2)
subplot(1,2,1);imshow(ww, []);title('Original watermark');
subplot(1,2,2);imshow(www{p}, []);title('Extract watermark image');
 

