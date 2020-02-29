%Çó»ùº¯Êý
function m=blending_function(i,k,u,knot_vector)
% global knot_vector
 % global n
    if k==1
        if knot_vector(i)<=u&u<knot_vector(i+1)
            m=1;
            return;
        else
            m=0;
            return;
        end  
 
    else
         if knot_vector(i)==1
            m=1;
            return
         elseif knot_vector(i+k-1)==knot_vector(i)&knot_vector(i+k)==knot_vector(i+1)
            m=0;
            return;
        elseif knot_vector(i+k-1)==knot_vector(i)
            m=(knot_vector(i+k)-u)*blending_function(i+1,k-1,u,knot_vector)/(knot_vector(i+k)-knot_vector(i+1));
            return;
        elseif knot_vector(i+k)==knot_vector(i+1)
            m=(u-knot_vector(i))*blending_function(i,k-1,u,knot_vector)/(knot_vector(i+k-1)-knot_vector(i));
            return;
        else
            m=(u-knot_vector(i))*blending_function(i,k-1,u,knot_vector)/(knot_vector(i+k-1)-knot_vector(i))+(knot_vector(i+k)-u)*blending_function(i+1,k-1,u,knot_vector)/(knot_vector(i+k)-knot_vector(i+1));
            return;
        end
    end
 