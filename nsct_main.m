close all;
clear all;
clc; 
Real_input=imread('3lr.jpg');
LR_img=rgb2gray(Real_input);

nlevels = 2;       % Decomposition level 
pfilter = 'maxflat' ;              % Pyramidal filter
dfilter = 'dmaxflat7' ;              % Directional filter
coeffs = nsctdec(double(LR_img), nlevels,'dmaxflat7', 'maxflat');
%     shownsct( coeffs ) ;
    HF1=cell2mat(coeffs{1,2}(1,1));
%     figure,hist(HF1);
    HF2=cell2mat(coeffs{1,2}(1,2));
    HF3=cell2mat(coeffs{1,2}(1,3));
    HF4=cell2mat(coeffs{1,2}(1,4));

    f1=HF1/4;
    f2=HF2/4;
    f3=HF3/4;
    f4=HF4/4;

    Edge_detection= regions_division(f1,f2,f3,f4);
    y=im2uint8(Edge_detection);
    figure
    imshow(y)
    title('±ßÔµ¼ì²â')
    imwrite(y,'3.jpg')