function  par  =  Parameters_setting( scale )
if scale==2
    par.pre       =   'NARM_X2_';
    par.tau1      =   0.11;    
    par.tau2      =   1.2;         
        
    par.c1        =   0.17;
    par.c2        =   2.8;   
    par.beta      =   0.1;   % 0.12
    par.iters     =   10;
elseif scale==3
    par.pre       =   'NARM_X3_';    
    par.tau1      =   0.1;       
    par.tau2      =   1.6;       
        
    par.c1        =   0.15;        %  0.04    0.09     0.15    0.2      0.25
    par.c2        =   2.5;        %  1.2     2.0      2.8     3.6      4.4
    par.beta      =   0.12;  
    par.iters     =   15;
end
if scale==2
    par.extrapol  =   1;
else
    par.extrapol  =   0;
end
par.lamada    =   1;
par.nSig      =   0;
par.scale     =   scale;
par.eps1      =   0.3;
par.eps2      =   0.3;
par.nblk      =   17;  % 13
par.ch        =   1;

return;