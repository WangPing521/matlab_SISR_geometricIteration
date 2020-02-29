function [c] = regions_division(x1,x2,x3,x4)
x1=im2double(x1);
average1=mean2(x1);
std_variance1=std2(x1);
variance1=std_variance1*std_variance1;
threshold1=average1+variance1;

average2=mean2(x2);
std_variance2=std2(x2);
variance2=std_variance2*std_variance2;
threshold2=average2+variance2;

average3=mean2(x3);
std_variance3=std2(x3);
variance3=std_variance3*std_variance3;
threshold3=average3+variance3;

average4=mean2(x4);
std_variance4=std2(x4);
variance4=std_variance4*std_variance4;
threshold4=average4+variance4;

[m,n] = size(x1);
c=zeros(m,n);
for i=1:1:m
    for j=1:1:n
        if(abs(x1(i,j))>threshold1||abs(x2(i,j))>threshold2||abs(x3(i,j))>threshold3||abs(x4(i,j))>threshold4)
           c(i,j)=1;    
        else
           c(i,j)=0;     
        end 
    end
end
c=im2uint8(c);