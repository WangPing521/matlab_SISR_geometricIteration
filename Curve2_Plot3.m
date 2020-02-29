% 二次B样条曲线
function [xx,yy,zz]=Curve2_Plot3(X,Y,Z)
x1=X;
y1=Y;
z1=Z;
for iter=1:50
        k=1;
        for i=1:1
            for t=0:0.15:1 % 参数u,[0,1]之间

                g0=1/2*(t-1)^2;                 % 基函数g0；
                g1=1/2*(-2*t^2+2*t+1);          % 基函数g1；
                g2=1/2*t^2;    % 基函数g2；
                % 曲线拟合
                x=g0*x1(1,i)+g1*x1(1,i+1)+g2*x1(1,i+2); % 确定曲线的横坐标x；
                y=g0*y1(1,i)+g1*y1(1,i+1)+g2*y1(1,i+2); % 确定曲线的纵坐标y；
                z=g0*z1(1,i)+g1*z1(1,i+1)+g2*z1(1,i+2); % 确定曲线的纵坐标y；

                xx(1,k)=x;
                yy(1,k)=y;
                zz(1,k)=z;
                k=k+1;

            end;
        end
         xxx1 = downsample(xx,3);
         yyy1 = downsample(yy,3);
         zzz1 = downsample(zz,3);


        diffx= X-xxx1;
        diffy= Y-yyy1;
        diffz= Z-zzz1;
        if(any(any(diffx))==0&&any(any(diffy))==0&&any(any(diffz))==0)
              break;
        end
        x1=x1+diffx;
        y1=y1+diffy;
        z1=z1+diffz;
end

