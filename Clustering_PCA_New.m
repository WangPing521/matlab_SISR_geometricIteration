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
function  Dict   =  Clustering_PCA_New( im, par )
cls_num   =   par.cls_num;
b         =   par.win;
psf       =   fspecial('gauss', par.win+2, 1.6);
[Y, X]    =   Get_patches(im, b, psf, 1, 1);
for i=1:2:6 
   [Ys, Xs]   =   Get_patches(im, b, psf, 1, 0.8^i);
   Y          =   [Y Ys];
   X          =   [X Xs];
end

delta       =   sqrt(16);
v           =   sqrt( mean( Y.^2 ) );
[a, i0]     =   find( v<delta );
D0          =   dctmtx(par.win*par.win);
set         =   1:size(Y, 2);
set(i0)     =   [];
Y           =   Y(:,set);
X           =   X(:,set);

b2        =   size(Y, 1);
L         =   size(Y, 2);
itn       =   13;
m_num     =   par.m_blks; 
rand('seed',0);


n0     =   ceil(0.35*b2);
P0     =   getpca(Y);
Y2     =   P0*Y;
Y      =   Y2(1:n0, :);


[cls_idx, vec, cls_num]   =  Clustering(Y, cls_num, itn, m_num);
vec   =  vec';

[s_idx, seg]   =  Proc_cls_idx( cls_idx );
PCA_D          =  zeros(b^4, cls_num);
for  i  =  1 : length(seg)-1
   
    idx    =   s_idx(seg(i)+1:seg(i+1));    
    cls    =   cls_idx(idx(1));    
    X1     =   X(:, idx);

    [P, mx]   =  getpca(X1);    
    PCA_D(:,cls)    =  P(:);
end

[Y, X]      =   Get_patches(im, b, psf, par.step, 1);
cls_idx     =   zeros(size(X, 2), 1);

v           =   sqrt( mean( Y.^2 ) );
[a, ind]    =   find( v<delta );

Y           =   P0*Y;
Y           =   Y(1:n0,:);
set         =   1:size(X, 2);
set(ind)    =   [];
L           =   size(set,2);

vec         =   vec';
b2          =   size(Y, 1);

for j = 1 : L
    dis   =   vec(:, 1) -  Y(1, set(j));
    for i = 2 : b2
        dis  =  dis + (vec(:, i)-Y(i, set(j))).^2;
    end
    [val ind]      =   min( dis );
    cls_idx( set(j) )   =   ind;
end
[s_idx, seg]    =   Proc_cls_idx( cls_idx );
Dict.PCA_D      =   PCA_D;
Dict.cls_idx    =   cls_idx;
Dict.s_idx      =   s_idx;
Dict.seg        =   seg;
Dict.D0         =   D0;
return;



%--------------------------------------------------
function  [Py  Px]  =  Get_patches( im, b, psf, s, scale )
im        =  imresize( im, scale, 'bilinear' );

[h w ch]  =  size(im);
ws        =  floor( size(psf,1)/2 );

if  ch==3
    lrim      =  rgb2ycbcr( uint8(im) );
    im        =  double( lrim(:,:,1));    
end

lp_im     =  conv2( psf, im );
lp_im     =  lp_im(ws+1:h+ws, ws+1:w+ws);
hp_im     =  im - lp_im;

N         =  h-b+1;
M         =  w-b+1;
r         =  [1:s:N];
r         =  [r r(end)+1:N];
c         =  [1:s:M];
c         =  [c c(end)+1:M];
L         =  length(r)*length(c);
Py        =  zeros(b*b, L, 'single');
Px        =  zeros(b*b, L, 'single');

k    =  0;
for i  = 1:b
    for j  = 1:b
        k       =  k+1;
        blk     =  hp_im(r-1+i,c-1+j);
        Py(k,:) =  blk(:)';
        
        blk     =  im(r-1+i,c-1+j);
        Px(k,:) =  blk(:)';        
    end
end

%------------------------------------------------------------------------
%------------------------------------------------------------------------
function   [cls_idx,vec,cls_num]  =  Clustering(Y, cls_num, itn, m_num)
Y         =   Y';
[L b2]    =   size(Y);
P         =   randperm(L);
P2        =   P(1:cls_num);
vec       =   Y(P2(1:end), :);

for i = 1 : itn
    
    cnt       =  zeros(1, cls_num);    
    
    v_dis    =   zeros(L, cls_num);
    for  k = 1 : cls_num
        v_dis(:, k) = (Y(:,1) - vec(k,1)).^2;
        for c = 2:b2
            v_dis(:,k) =  v_dis(:,k) + (Y(:,c) - vec(k,c)).^2;
        end
    end      
    [val cls_idx]         =   min(v_dis, [], 2);
    
    [s_idx, seg]   =  Proc_cls_idx( cls_idx );
    for  k  =  1 : length(seg)-1
        idx    =   s_idx(seg(k)+1:seg(k+1));    
        cls    =   cls_idx(idx(1));    
        vec(cls,:)    =   mean(Y(idx, :));
        cnt(cls)      =   length(idx);
    end        
    
    if (i==itn-2)
        [val ind]  =  min( cnt );  
        while (val<m_num) && (cls_num>=40)
            vec(ind, :)    =  [];
            cls_num       =  cls_num - 1;
            cnt(ind)      =  [];

            [val  ind]    =  min(cnt);
        end        
    end
end
