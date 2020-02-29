% ����B��������
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
            for t=0:stepx:1 % ����u,[0,1]֮��

                g0=1/2*(t-1)^2;                 % ������g0��
                g1=1/2*(-2*t^2+2*t+1);          % ������g1��
                g2=1/2*t^2;    % ������g2��
                % �������
                x=g0*x1(1,i)+g1*x1(1,i+1)+g2*x1(1,i+2); % ȷ�����ߵĺ�����x��
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

