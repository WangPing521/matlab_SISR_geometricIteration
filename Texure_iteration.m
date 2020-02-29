function Texure_result=Texure_iteration(initial_image,scale)
k = 3; l = 3;
[h,w]=size(initial_image);
 X=im2double(initial_image);
 if scale==2
    ww=4;
 end
if scale==3
    ww=6;
 end
p1=2*scale;
p2=3*scale+1;
par=3*scale;
par1=3*scale+1;
    for x1=1:ww:h-par
        for y1=1:ww:w-par
            Xpatch1=X(x1:x1+par,y1:y1+par);
            Xpatch=Xpatch1;

            for iter=1:7
                I2=Surf_PlotSubMesh(par1, par1, k, l, Xpatch);
                II1=I2;
                diffxTotal=Xpatch1-II1;
                III1 = downsample(diffxTotal,scale);
                IIII1 = downsample(III1',scale);
                diffx = IIII1';
                
                if(any(any(diffx))==0)
                    break;
                end
                Xpatch=Xpatch+diffxTotal;
            end
            if ((x1~=h-ww)&&(y1==w-ww))
                I2=I2(1:p1,1:p2,:);
            end
            if ((x1==h-ww)&&(y1~=w-ww))
                I2=I2(1:p2,1:p1,:);
            end
            if ((x1==h-ww)&&(y1==w-ww))
                I2=I2(1:p2,1:p2,:);
            end
            if ((x1~=h-ww)&&(y1~=w-ww))
                I2=I2(1:p1,1:p1,:);
            end
            if y1==1
                IM=I2;
            else
                IM=cat(2,IM,I2);
            end

        end
        if x1==1
            Texure_result=IM;
        else
            Texure_result=cat(1,Texure_result,IM);
        end
    end   
 end