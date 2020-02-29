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
function  A   =  Set_delta_matrix( par )
s          =   par.scale;
[h,w,ch]   =   size(par.LR);
h=2*h-1;
w=2*w-1;
ch         =   1;
lh         =   ceil(h/s);
lw         =   ceil(w/s);
hh         =   lh*s-s+1;
hw         =   lw*s-s+1;
M          =   lh*lw;
N          =   hh*hw;

nv         =   1;
nt         =   (nv)*M;
R          =   zeros(nt,1);
C          =   zeros(nt,1);
V          =   zeros(nt,1);
cnt        =   1;

pos     =  (1:hh*hw);
pos     =  reshape(pos, [hh hw]);

for lrow = 1:lh
    for lcol = 1:lw
        
        row        =   (lrow-1)*s + 1;
        col        =   (lcol-1)*s + 1;
        
        row_idx    =   (lcol-1)*lh + lrow;
        col_ind    =    pos(row, col);
        nn         =    1;
        R(cnt:cnt+nn-1)  =  row_idx;
        C(cnt:cnt+nn-1)  =  col_ind;
        V(cnt:cnt+nn-1)  =  1;
        
        cnt              =  cnt + nn;
    end
end
R   =  R(1:cnt-1);
C   =  C(1:cnt-1);
V   =  V(1:cnt-1);
if  ch==1
    A   =  sparse(R, C, V, M, N);
else
   R2    =  R + M;
   C2    =  C + N;
   V2    =  V;
   R3    =  R + M*2;
   C3    =  C + N*2;
   V3    =  V;   
   R     =  [R; R2; R3;];
   C     =  [C; C2; C3;];
   V     =  [V; V2; V3;];
   A     =  sparse(R, C, V, M*3, N*3);
end