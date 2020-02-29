% find_span 在节点矢量中找出UV的范围
function  ij=findspan(uv,UV)
len=length(UV);
for  tag=1:len-1
   if  uv>=UV(tag)&&uv<UV(tag+1)
       ij=tag;
       return
   elseif UV(tag)==1&&UV(tag+1)==1
       ij=tag;
       return
   end
end