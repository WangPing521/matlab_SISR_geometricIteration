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
function [blk_arr, wei_arr]  =  find_blks_fast(fs, par)
S         =  18;
f         =  par.win;
f2        =  f^2;
nv        =  par.nblk;
s         =  par.step;
hp        =  130;
ch        =  size(fs,3);

N         =  size(fs,1)-f+1;
M         =  size(fs,2)-f+1;
r         =  [1:s:N];
r         =  [r r(end)+1:N];
c         =  [1:s:M];
c         =  [c c(end)+1:M];
L         =  N*M;
X         =  zeros(f2*ch, L, 'single');

k    =  0;
for i  = 1:f
    for j  = 1:f
        k    =  k+1;        
        for i1 = 1:ch
            blk  =  fs(i:end-f+i,j:end-f+j, i1);
            X(k + (i1-1)*f2,:) =  blk(:)';
        end       
    end
end

I     =   (1:L);
I     =   reshape(I, N, M);
N1    =   length(r);
M1    =   length(c);
blk_arr   =  zeros(nv, N1*M1 );
wei_arr   =  zeros(nv, N1*M1 ); 
X         =  X';
lam_w     =  38000;

for  i  =  1 : N1
    for  j  =  1 : M1
        
        row     =   r(i);
        col     =   c(j);
        off     =  (col-1)*N + row;
        off1    =  (j-1)*N1 + i;
                
        rmin    =   max( row-S, 1 );
        rmax    =   min( row+S, N );
        cmin    =   max( col-S, 1 );
        cmax    =   min( col+S, M );
         
        idx     =   I(rmin:rmax, cmin:cmax);
        idx     =   idx(:);
        B       =   X(idx, :);        
        v       =   X(off, :);
        
        
        dis     =   (B(:,1) - v(1)).^2;
        for k = 2:f2
            dis   =  dis + (B(:,k) - v(k)).^2;
        end
        dis   =  dis./f2;
        [val,ind]   =  sort(dis);        
        
        b       =   B( ind(2:nv+1),: )*v';
        wei     =   cgsolve(B( ind(2:nv+1),: )*B( ind(2:nv+1),: )' + lam_w*eye(nv), b);               
        indc        =  idx( ind(2:nv+1) );
        blk_arr(:,off1)  =  indc;
        wei_arr(:,off1)  =  wei;
    end
end
blk_arr  = blk_arr';
wei_arr  = wei_arr';
