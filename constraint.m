function [iii,jjj]=constraint(ii,jj,n,m)

if ii == n || ii == n-1 
    iii = n-2;
else
    iii = ii;
end;

if jj == m || jj == m-1
    jjj = m-2;
else
    jjj = jj;
end;