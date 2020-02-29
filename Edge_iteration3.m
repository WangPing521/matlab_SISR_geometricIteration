function Edge_result=Edge_iteration3(LR_img,Edge_detection,Texure_result)
img_temp=zeros(1,3);
% %% 水平方向
[h,w,s]=size(LR_img);

for i=1:h
    for j=1:w
        if (any(img_temp)==0)
            k=0;
        end
        if Edge_detection(i,j)==1
            k=k+1;
            img_temp(1,k)=LR_img(i,j);
            if k==3
                %曲线段迭代拟合过程
                Xline=img_temp;
                Yline=Xline;
                Zline=Xline;
                
                [xx,yy,zz]=Curve2_Plot3(Xline, Yline, Zline);
                 line1=xx;
            
                 line1=uint8(line1);
                 Texure_result(3*i-2,3*j-8:3*j-2)=line1;
                 img_temp=zeros(1,3);
            end
        else
            img_temp=zeros(1,3);
        end
    end
end
%% 垂直方向
I_col1=Texure_result;
I_final1=I_col1';
imgCanny=Edge_detection';
I_col1=LR_img;
img1=I_col1';
img_temp=zeros(1,3);
for i=1:w
    for j=1:h
        if (any(img_temp)==0)
            k=0;
        end
        if imgCanny(i,j)==1
            k=k+1;
            img_temp(1,k)=img1(i,j);
            if k==3
                %曲线段迭代拟合过程
                Xline=img_temp;
                Yline=Xline;
                Zline=Xline;
                [xx,yy,zz]=Curve2_Plot3(Xline, Yline, Zline);
                line1=xx;

            I_final1(3*i-2,3*j-8:3*j-2)=line1;
            img_temp=zeros(1,3);
            end
        else
            img_temp=zeros(1,3);
        end
    end
end
I_col1=I_final1;
Edge_result=I_col1';

