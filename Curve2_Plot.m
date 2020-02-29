% 二次B样条曲线
function xx=Curve2_Plot(X,scale)
x1=X;
if scale==2
    stepx=0.25;
end
if scale==3
    stepx=0.15;
end
for iter=1:16
        k=1;
        for i=1:1
            for t=0:stepx:1 % 参数u,[0,1]之间

                g0=1/2*(t-1)^2;                 % 基函数g0；
                g1=1/2*(-2*t^2+2*t+1);          % 基函数g1；
                g2=1/2*t^2;    % 基函数g2；
                % 曲线拟合
                x=g0*x1(1,i)+g1*x1(1,i+1)+g2*x1(1,i+2); % 确定曲线的横坐标x；
                xx(1,k)=x;
                k=k+1;
            end;
        end
         xxx1 = downsample(xx,scale);
        diffx= X-xxx1;
        if(any(any(diffx))==0)
              break;
        end
        x1=x1+diffx;
end

