close all;
clear all;
clc;
% Files = dir(strcat('kodak\','*.png'));
% LengthFiles = length(Files);
% for i = 1:1:LengthFiles
%     Real_input = imread(strcat('kodak\',Files(i).name));

   Real_input=imread('Set5\baby_GT.bmp');
    [hh,ww,ss]=size(Real_input);
    if ss==1
       Real_input1(:,:,1)=Real_input;
       Real_input1(:,:,2)=Real_input;
       Real_input1(:,:,3)=Real_input;
       Real_input=Real_input1;
    end

%     G=fspecial('gaussian',[3,3],2);
%     Real_input=imfilter(Real_input,G,'same');
    
    im_l_ycbcr = rgb2ycbcr(Real_input);
    im_l_y = im_l_ycbcr(:, :, 1);
    im_l_cb = im_l_ycbcr(:, :, 2);
    im_l_cr = im_l_ycbcr(:, :, 3);
    % 
    im_l_y=double(im_l_y);
    im_l_cb=double(im_l_cb);
    im_l_cr=double(im_l_cr);
    imgX=im_l_y;
    imgY=im_l_cb;
    imgZ=im_l_cr;
    scale=3;
%     LR_img=imresize(imgX,1/scale);
%     imgY=imresize(imgY,1/scale);
%     imgZ=imresize(imgZ,1/scale);
    
    LR_img=imgX(1:scale:end,1:scale:end);
    imgY=imgY(1:scale:end,1:scale:end);
    imgZ=imgZ(1:scale:end,1:scale:end);
    
%     LR_img=imgX;
    
    [m,n]=size(LR_img);
    %分形加密
    Texure_Addpoints=main_function(LR_img,m,n,scale);

    %双三次加密
%     Texure_Addpoints=imresize(LR_img, [hh, ww], 'bicubic');
    
    Texure_Addpoints=uint8(Texure_Addpoints);
    figure
    imshow(Texure_Addpoints)
    title('fenxing')
    Texure_Addpoints=double(Texure_Addpoints);
    Texure_result=Texure_iteration(Texure_Addpoints,scale);
    Texure_result=uint8(Texure_result);
    figure
    imshow(Texure_result)
    title('wenlidiedai')
    Texure_result=uint8(Texure_result);
    % NSCT判断各种区域，进行替换整合
    nlevels = 4;       % Decomposition level 
    pfilter = 'maxflat' ;              % Pyramidal filter
    dfilter = 'dmaxflat7' ;              % Directional filter
    % 
    % % % Nonsubsampled Contourlet decomposition
    LR_img1=LR_img;
    coeffs = nsctdec(double(LR_img), nlevels,'dmaxflat7', 'maxflat');
%     shownsct( coeffs ) ;
    HF1=cell2mat(coeffs{1,2}(1,1));
%     figure,hist(HF1);
    HF2=cell2mat(coeffs{1,2}(1,2));
    HF3=cell2mat(coeffs{1,2}(1,3));
    HF4=cell2mat(coeffs{1,2}(1,4));
    HF5=cell2mat(coeffs{1,2}(1,5));
    HF6=cell2mat(coeffs{1,2}(1,6));
    HF7=cell2mat(coeffs{1,2}(1,7));
    HF8=cell2mat(coeffs{1,2}(1,8));
    HF9=cell2mat(coeffs{1,2}(1,9));
    HF10=cell2mat(coeffs{1,2}(1,10));
    HF11=cell2mat(coeffs{1,2}(1,11));
    HF12=cell2mat(coeffs{1,2}(1,12));
    HF13=cell2mat(coeffs{1,2}(1,13));
    HF14=cell2mat(coeffs{1,2}(1,14));
    HF15=cell2mat(coeffs{1,2}(1,15));
    HF16=cell2mat(coeffs{1,2}(1,16));

%     f1=HF1;
%     f2=HF2;
%     f3=HF3;
%     f4=HF4;

%     f1=(HF1+HF2)/2;
%     f2=(HF3+HF4)/2;
%     f3=(HF5+HF6)/2;
%     f4=(HF7+HF8)/2;
    
    f1=(HF1+HF2+HF3+HF4)/4;
    f2=(HF5+HF6+HF7+HF8)/4;
    f3=(HF9+HF10+HF11+HF12)/4;
    f4=(HF13+HF14+HF15+HF16)/4;

    Edge_detection= regions_division(f1,f2,f3,f4);
    y=im2uint8(Edge_detection);
%     figure
%     imshow(y)
%     title('边缘检测')

    %运行时间太长
    Edge_result=Edge_iteration(LR_img1,Edge_detection,Texure_result,m,n,scale);

    % Edge_result=im2double(Edge_result);
    [nrow, ncol] = size(Edge_result);
    im_h_cb = imresize(imgY, [nrow, ncol], 'bicubic');
    im_h_cr = imresize(imgZ, [nrow, ncol], 'bicubic');
    im_h_ycbcr(:, :, 1) = Edge_result;
    im_h_ycbcr(:, :, 2) = im_h_cb;
    im_h_ycbcr(:, :, 3) = im_h_cr;
    im_h_ycbcr=uint8(im_h_ycbcr);
    im_h = ycbcr2rgb(im_h_ycbcr);
    figure
    imshow(im_h);
    title('结果');
    imwrite(im_h,'test_results\baby3.jpg');

%     newname = strcat('test_commom\kodakx3\',Files(i).name);
%     imwrite(im_h,newname);
%     clear im_h_ycbcr;
% end
