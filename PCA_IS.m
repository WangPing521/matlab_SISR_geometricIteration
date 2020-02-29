% =========================================================================
% Nonlocal Autoregressive Modeling based image interpolation, Version 1.0
% Copyright(c) 2013 Weisheng Dong, Lei Zhang, Guangming Shi
% All Rights Reserved.
%
% ----------------------------------------------------------------------
% Permission to use, copy, or modify this software and its documentation
% for educational and research purposes only and without fee is here
% granted, provided that this copyright notice and the original authors'
% names appear on all copies and supporting documentation. This program
% shall not be used, rewritten, or adapted as the basis of a commercial
% software or hardware product without first obtaining permission of the
% authors. The authors make no representations about the suitability of
% this software for any purpose. It is provided "as is" without express
% or implied warranty.
%----------------------------------------------------------------------
%
% This is an implementation of the algorithm for image interpolation
% 
% Please cite the following paper if you use this code:
%
% Weisheng Dong, Lei Zhang, R. Lukac, and G. Shi,"Sparse representation based
% image interpolation with nonlocal autoregressive modeling", IEEE Trans. on
% Image Processing, vol. 22, no. 4, pp. 1382-1394, Apr. 2013.
% 
%--------------------------------------------------------------------------
function  [im1, im_out, im_wei]    =   PCA_IS( im, Dict, par, Tau1, Tau2, blk_arr, wei_arr, flag )
PCA_idx    =   Dict.cls_idx;
PCA_D      =   Dict.PCA_D;
s_idx      =   Dict.s_idx;
seg        =   Dict.seg;
A          =   Dict.D0;
opts       =   par.s1;
[h w ch]   =   size(im);

b          =   opts.win;
b2         =   b*b*ch;
k          =   0;
s          =   opts.step;

N     =  h-b+1;
M     =  w-b+1;
L     =  N*M;
r     =  [1:s:N];
r     =  [r r(end)+1:N];
c     =  [1:s:M];
c     =  [c c(end)+1:M];
X     =  zeros(b*b,L,'single');
for i  = 1:b
    for j  = 1:b
        k    =  k+1;
        blk  =  im(i:h-b+i,j:w-b+j);
        blk  =  blk(:);
        X(k,:) =  blk';            
    end
end
X_m     =  zeros(length(r)*length(c),b*b,'single');
X0 = X';
for i = 1:opts.nblk
   v        =  wei_arr(:,i);
   X_m      =  X_m(:,:) + X0(blk_arr(:,i),:) .*v(:, ones(1,b2));
end
X_m=X_m';


ind         =   zeros(N,M);
ind(r,c)    =   1;
X           =   X(:, ind~=0);

N           =   length(r);
M           =   length(c);
L           =   N*M;
Y           =   zeros( b2, L );

idx          =   s_idx(seg(1)+1:seg(2));
tau1         =   par.tau1;
tau2         =   par.tau2;
if  flag==1
    tau1    =   Tau1(:, idx);
    tau2    =   Tau2(:, idx);
end
Y(:, idx)    =   A'*soft((A*X(:, idx) + 2*tau2.*(A*X_m(:,idx)))./(1+2*tau2),  tau1./(1+2*tau2));  

for   i  = 2:length(seg)-1   
    idx  =  s_idx(seg(i)+1:seg(i+1));    
    cls  =  PCA_idx(idx(1));
    P    =   reshape(PCA_D(:, cls), b2, b2);
    tau1         =   par.tau1;
    tau2         =   par.tau2;
    if  flag==1 
        tau1    =   Tau1(:, idx);
        tau2    =   Tau2(:, idx);        
    end
    Y(:, idx)    =   P'*soft((P*X(:, idx) + 2*tau2.*(P*X_m(:,idx)))./(1+2*tau2),  tau1./(1+2*tau2));   
end

im_out   =  zeros(h,w);
im_wei   =  zeros(h,w);
k        =  0;
for i  = 1:b
    for j  = 1:b
        k    =  k+1;
        im_out(r-1+i,c-1+j)  =  im_out(r-1+i,c-1+j) + reshape( Y(k,:)', [N M]);
        im_wei(r-1+i,c-1+j)  =  im_wei(r-1+i,c-1+j) + 1;       
    end
end

im1  =  im_out./(im_wei+eps);
return;
