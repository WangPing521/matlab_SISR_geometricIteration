%{
��ͼ������˹�˲�����ԭͼ��ȥ��˹�˲����ͼ���ٽ���ֵ����128
%}
clear,clc;close all;
% [filename,pathname] = uigetfile('*.jpg;*.bmp;*.png','ѡ��ͼƬ','bic2_fratal');
% imgaepath = strcat(pathname,filename);
% image = imread(imgaepath);
% figure,imshow(image);
% Image = image;
%  
% Image=double(Image);
Image=imread('test_commom\5-bicubic-2.jpg'); 
Image1=Image;
figure, imshow(Image1);
% ���ø�˹�˲���
Half_size=5;
F_size=2*Half_size+1;
G_Filter=fspecial('gaussian',F_size,F_size/6);
 
% ����˹�˲�
Image_Filter = imfilter(Image1, G_Filter,'conv');
 
% ����ֵ
Image_Diff=Image-Image_Filter;
 
% ��ֵ����128
Image_out=Image_Diff+10;
 
Image1=Image+Image_out;
 out=uint8(Image1);
% imshow(Image/255);
%  figure, imshow(Image_out/255);
%  figure, imshow(Image1/255);
  figure, imshow(out);
imwrite(out,'test_commom\new-5-bicubic-2.jpg')