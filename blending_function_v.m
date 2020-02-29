%求基函数
function m=blending_function_v(i,k,u)
global knot_vector_V
global n
    if k==1
        if knot_vector_V(i)<=u&u<knot_vector_V(i+1)
            m=1;
            return;
        else
            m=0;
            return;
        end  
 
    else
         %增加一行以便处理u=1的情况
         if knot_vector_V(i)==1
            m=1;
            return
           elseif knot_vector_V(i+k-1)==knot_vector_V(i)&knot_vector_V(i+k)==knot_vector_V(i+1)
            m=0;
            return;
        elseif knot_vector_V(i+k-1)==knot_vector_V(i)
            m=(knot_vector_V(i+k)-u)*blending_function_v(i+1,k-1,u)/(knot_vector_V(i+k)-knot_vector_V(i+1));
            return;
        elseif knot_vector_V(i+k)==knot_vector_V(i+1)
            m=(u-knot_vector_V(i))*blending_function_v(i,k-1,u)/(knot_vector_V(i+k-1)-knot_vector_V(i));
            return;
        else
            m=(u-knot_vector_V(i))*blending_function_v(i,k-1,u)/(knot_vector_V(i+k-1)-knot_vector_V(i))+(knot_vector_V(i+k)-u)*blending_function_v(i+1,k-1,u)/(knot_vector_V(i+k)-knot_vector_V(i+1));
            return;
        end
    end