function R_interp=nurbsIter(CPz,W,p,q,patch) 
knot_vector_U=[0 0 0 0 0.2 0.4 0.6 0.8 1 1 1 1];    
knot_vector_V=[0 0 0 0 0.2 0.4 0.6 0.8 1 1 1 1];
CPz=double(CPz);
CPzO=CPz;
for iter=1:1
    for ii=1:patch
        for jj=1:patch
             Pw_z(ii,jj)=CPz(ii,jj)*W(ii,jj);
        end
    end

    tag=1;
    for u=0:0.15:1
       for v=0:0.15:1
            tag1=1;
            i=findspan(u,knot_vector_U); 
            j=findspan(v,knot_vector_V);  %找出 u，v 对应落在的节点向量的区间
            for  temp1=i-p:i
              N_kpu(tag1)=blending_function_u(temp1,p,u);   % 计算与u值对应的各基函数的值
              tag1=tag1+1;
            end

            tag2=1;
            for temp2=j-q:j
               N_lqv(tag2)=blending_function_v(temp2,q,v);   % 计算与v值对应的各基函数的值
                tag2=tag2+1;
            end
            Sw(tag,1)= N_kpu*Pw_z*(N_lqv.');
            Sw(tag,2)= N_kpu*W*(N_lqv.');
            S(tag,1)=Sw(tag,1)/Sw(tag,2);
            tag=tag+1;
       end
    end
    R_interp=reshape(S(:,1),7,7);
    CPz1 = downsample(R_interp,2);
    CPz2 = downsample(CPz1',2);
    CPz3 = CPz2';
    diffz=CPzO-CPz3;
    CPz=CPz+diffz;
end
  surf(R_interp)