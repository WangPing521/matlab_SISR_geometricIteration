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
function  [s_idx, seg]    =  Proc_cls_idx( cls_idx )

[idx  s_idx]    =  sort(cls_idx);
idx2   =  idx(1:end-1) - idx(2:end);
seq    =  find(idx2);
seg    =  [0; seq; length(cls_idx)];