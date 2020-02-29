% ����B��������
function [xx,yy,zz]=Curve2_Plot3(X,Y,Z)
x1=X;
y1=Y;
z1=Z;
for iter=1:50
        k=1;
        for i=1:1
            for t=0:0.15:1 % ����u,[0,1]֮��

                g0=1/2*(t-1)^2;                 % ������g0��
                g1=1/2*(-2*t^2+2*t+1);          % ������g1��
                g2=1/2*t^2;    % ������g2��
                % �������
                x=g0*x1(1,i)+g1*x1(1,i+1)+g2*x1(1,i+2); % ȷ�����ߵĺ�����x��
                y=g0*y1(1,i)+g1*y1(1,i+1)+g2*y1(1,i+2); % ȷ�����ߵ�������y��
                z=g0*z1(1,i)+g1*z1(1,i+1)+g2*z1(1,i+2); % ȷ�����ߵ�������y��

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

