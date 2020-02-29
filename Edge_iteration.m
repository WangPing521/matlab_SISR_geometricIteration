function Edge_result=Edge_iteration(LR_img,Edge_detection,Texure_result,m,n,scale)
 for i=1:m
        img_temp=zeros(1,3);
        for j=1:n
            if (any(img_temp)==0)
                k=0;
            end
            if Edge_detection(i,j)==0
                k=k+1;
                img_temp(1,k)=LR_img(i,j);
                if k==3
                    %曲线段迭代拟合过程
                    Xline=img_temp;
                    xx=Curve2_Plot(Xline, scale);
                    line1=xx;
                    if scale==2
                        Texure_result(2*i-1,2*j-5:2*j-1,:)=line1;
                    end
                    if scale==3
                        Texure_result(3*i-2,3*j-8:3*j-2)=line1;
                    end
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
    for i=1:n
        img_temp=zeros(1,3);
        for j=1:m
            if (any(img_temp)==0)
                k=0;
            end
            if imgCanny(i,j)==0
                k=k+1;
                img_temp(1,k)=img1(i,j);
                if k==3
                    %曲线段迭代拟合过程
                    Xline=img_temp;
                    xx=Curve2_Plot(Xline, scale);
                    line1=xx;
                    if scale==2
                        Texure_result(2*i-1,2*j-5:2*j-1)=line1;
                    end
                    if scale==3
                        Texure_result(3*i-2,3*j-8:3*j-2)=line1;
                    end
                    img_temp=zeros(1,3);
                end
            else
                img_temp=zeros(1,3);
            end
        end
    end
    I_col1=I_final1;
    Edge_result_hv=I_col1';
    
 %%45度和135度------------===================---------------------------
 %去正方矩阵，大小为square
 if scale==2
    square=min(m,n);

     for kk1=1:square-2
         img_temp=zeros(1,3);
         for ii=kk1:square-kk1+1
             if (any(img_temp)==0)
                   k=0;
             end
             wx=ii+kk1-1;
             if Edge_detection(wx,ii)==0
                            k=k+1;
                            img_temp(1,k)=LR_img(wx,ii);
                            if k==3
                                %曲线段迭代拟合过程
                                Xline=img_temp;
                                xx=Curve2_Plot(Xline, scale);
                                line1=xx;
                                if scale==2
                                   Edge_result_hv(2*wx-1,2*ii-1)=line1(1,5);
                                   Edge_result_hv(2*wx-2,2*ii-2)=line1(1,4);
                                   Edge_result_hv(2*wx-3,2*ii-3)=line1(1,3);
                                   Edge_result_hv(2*wx-4,2*ii-4)=line1(1,2);
                                   Edge_result_hv(2*wx-5,2*ii-5)=line1(1,1);
    %                              Texure_result(2*i-1,2*j-5:2*j-1,:)=line1;
                                end
    %                             if scale==3
    %                                 Texure_result(3*i-2,3*j-8:3*j-2)=line1;
    %                             end
                                img_temp=zeros(1,3);
                            end
        
                            img_temp=zeros(1,3);
                        end    
          end
     end
     %%===    
      for kk2=2:square-2
          img_temp=zeros(1,3);
         for ii=1:square-kk2+1
             if (any(img_temp)==0)
                   k=0;
             end
             wx=ii+kk2-1;
             if Edge_detection(wx,ii)==0
                            k=k+1;
                            img_temp(1,k)=LR_img(wx,ii);
                            if k==3
                                %曲线段迭代拟合过程
                                Xline=img_temp;
                                xx=Curve2_Plot(Xline, scale);
                                line1=xx;
                                if scale==2
                                   Edge_result_hv(2*wx-1,2*ii-1)=line1(1,5);
                                   Edge_result_hv(2*wx-2,2*ii-2)=line1(1,4);
                                   Edge_result_hv(2*wx-3,2*ii-3)=line1(1,3);
                                   Edge_result_hv(2*wx-4,2*ii-4)=line1(1,2);
                                   Edge_result_hv(2*wx-5,2*ii-5)=line1(1,1);
    %                              Texure_result(2*i-1,2*j-5:2*j-1,:)=line1;
                                end
    %                             if scale==3
    %                                 Texure_result(3*i-2,3*j-8:3*j-2)=line1;
    %                             end
                                img_temp=zeros(1,3);
                            end
                        else
                            img_temp=zeros(1,3);
                        end    
          end
     end         
    %================反方向============================
     for kk1=3:square
         img_temp=zeros(1,3);
         for ii=1:kk1
             if (any(img_temp)==0)
                   k=0;
             end
             wx=kk1-ii+1;
             if Edge_detection(ii,wx)==0
                            k=k+1;
                            img_temp(1,k)=LR_img(ii,wx);
                            if k==3
                                %曲线段迭代拟合过程
                                Xline=img_temp;
                                xx=Curve2_Plot(Xline, scale);
                                line1=xx;
                                if scale==2
                                   Edge_result_hv(2*ii-1,2*wx-1)=line1(1,5);
                                   Edge_result_hv(2*ii-2,2*wx)=line1(1,4);
                                   Edge_result_hv(2*ii-3,2*wx+1)=line1(1,3);
                                   Edge_result_hv(2*ii-4,2*wx+2)=line1(1,2);
                                   Edge_result_hv(2*ii-5,2*wx+3)=line1(1,1);
    %                              Texure_result(2*i-1,2*j-5:2*j-1,:)=line1;
                                end
    %                             if scale==3
    %                                 Texure_result(3*i-2,3*j-8:3*j-2)=line1;
    %                             end
                                img_temp=zeros(1,3);
                            end
                        else
                            img_temp=zeros(1,3);
                        end    
          end
     end
     %%===    
      for kk2=2:square-2
          img_temp=zeros(1,3);
         for ii=1:square-kk2+1
             if (any(img_temp)==0)
                   k=0;
             end
             wx=ii+kk2-1;
             wy=square-ii-kk2+3;
             if Edge_detection(wx,wy)==0
                            k=k+1;
                            img_temp(1,k)=LR_img(wx,wy);
                            if k==3
                                %曲线段迭代拟合过程
                                Xline=img_temp;
                                xx=Curve2_Plot(Xline, scale);
                                line1=xx;
                                if scale==2
                                   Edge_result_hv(2*wx-1,2*wy-1)=line1(1,5);
                                   Edge_result_hv(2*wx-2,2*wy)=line1(1,4);
                                   Edge_result_hv(2*wx-3,2*wy+1)=line1(1,3);
                                   Edge_result_hv(2*wx-4,2*wy+2)=line1(1,2);
                                   Edge_result_hv(2*wx-5,2*wy+3)=line1(1,1);
    %                              Texure_result(2*i-1,2*j-5:2*j-1,:)=line1;
                                end
    %                             if scale==3
    %                                 Texure_result(3*i-2,3*j-8:3*j-2)=line1;
    %                             end
                                img_temp=zeros(1,3);
                            end
                        else
                            img_temp=zeros(1,3);
                        end    
          end
      end    
 end
 
  Edge_result=Edge_result_hv;