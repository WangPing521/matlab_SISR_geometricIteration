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
function  H =  Cal_Matrixes_LS( fs, ws, par )
S       =  18;
f       =  ws;
f2      =  f^2;
t       =  floor(f/2);
nv      =  15;  
[h w ch]    =  size( fs );
fs_ext   =  zeros(h+2*t, w+2*t, ch);
for k = 1:ch
    fs_ext(:,:,k)    =  padarray( fs(:,:,k), [t t], 'symmetric' );
end
L       =  h*w;
X       =  zeros(f2*ch, L, 'single');

% For the Y component
k    =  0;
for i  = 1:f
    for j  = 1:f
        k    =  k+1;
        
        for c = 1:par.ch
            blk  =  fs_ext(i:end-f+i,j:end-f+j, c);
            X(k + (c-1)*f2,:) =  blk(:)';
        end
     
    end
end

% Index image
I         =   reshape((1:L), h, w);
s         =   par.scale;
Il        =   I(1:s:end, 1:s:end);
[h1 w1]   =   size(Il);

Flag      =   ones(h,w);
Flag(1:s:end,1:s:end)   =  0;
cnt2         =   1;
X         =   X';
lamada    =   0.72;

nt2       =  (nv)*h1*w1;
R2        =  zeros(nt2,1);
C2        =  zeros(nt2,1);
V2        =  zeros(nt2,1);
lam_w     =  48000;

for  row  =  1 : h
    for  col  =  1 : w
        
        off_cen    =   (col-1)*h + row;
        
        if  (Flag(row,col)==0)
            rmin    =   max( row-S, 1 );
            rmax    =   min( row+S, h );
            cmin    =   max( col-S, 1 );
            cmax    =   min( col+S, w );         
            idx0    =   I(rmin:rmax, cmin:cmax);
            idx     =   idx0(:);            
            B       =   X(idx, :);
        else
            continue;
        end        

        v       =   X(off_cen, :);        
        dis     =   (B(:,1) - v(1)).^2;
        for k = 2:f2
            dis   =  dis + (B(:,k) - v(k)).^2;
        end
        mE   =  dis./f2;        
        [val,ind]      =   sort(mE);
                
        b       =   B( ind(2:nv+1),: )*v';
        b(1)    =   max(0.01,b(1)-20*par.nSig^2);
        wei     =   cgsolve(B( ind(2:nv+1),: )*B( ind(2:nv+1),: )' + lam_w*eye(nv), b);        
        
        if (Flag(row,col)==0)
            row1        =   ceil(row/s);
            col1        =   ceil(col/s);
            off         =   (col1-1)*h1 + row1;
            
            R2(cnt2:cnt2+nv)   =   off;
            C2(cnt2:cnt2+nv)   =   [idx( ind(2:nv+1) );  off_cen];
            V2(cnt2:cnt2+nv)   =   [lamada*(wei./(sum(wei)+eps)); (1-lamada)];
            cnt2               =   cnt2 + nv + 1;                  
        else
            continue;
        end
    end
end


N       =   h*w;
R2      =   R2(1:cnt2-1);
C2      =   C2(1:cnt2-1);
V2      =   V2(1:cnt2-1);
H       =   sparse(R2, C2, V2, h1*w1, N);
