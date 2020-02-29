%Çó»ùº¯Êý
function m=blending_function_u(i,k,u)
global knot_vector_U
knot_vector_U=[0 0 0 0 0.2 0.4 0.6 0.8 1 1 1 1];    
% knot_vector_V=[0 0 0 0 0.2 0.4 0.6 0.8 1 1 1 1];
global n
    if k==1
        if knot_vector_U(i)<=u&u<knot_vector_U(i+1)
            m=1;
            return;
        else
            m=0;
            return;
        end  
 
    else
 
       if  knot_vector_U(i)==1
           m=1;
           return
       elseif knot_vector_U(i+k-1)==knot_vector_U(i)&knot_vector_U(i+k)==knot_vector_U(i+1)
            m=0;
            return;
        elseif knot_vector_U(i+k-1)==knot_vector_U(i)
            m=(knot_vector_U(i+k)-u)*blending_function_u(i+1,k-1,u)/(knot_vector_U(i+k)-knot_vector_U(i+1));
            return;
        elseif knot_vector_U(i+k)==knot_vector_U(i+1)
            m=(u-knot_vector_U(i))*blending_function_u(i,k-1,u)/(knot_vector_U(i+k-1)-knot_vector_U(i));
            return;
        else
            m=(u-knot_vector_U(i))*blending_function_u(i,k-1,u)/(knot_vector_U(i+k-1)-knot_vector_U(i))+(knot_vector_U(i+k)-u)*blending_function_u(i+1,k-1,u)/(knot_vector_U(i+k)-knot_vector_U(i+1));
            return;
        end
    end