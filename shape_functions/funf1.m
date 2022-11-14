function [NJ] =  funf1(xi,nnode)   
%-----------------------------------------------------------------------
%  FUNF1F     funf1                                                     
%  PURPOSE    Compute interpolation functions for 1D-isoparametric      
%             element at Nint points of intrinsic coordinate xi                 
%  CALL       funf1(xi,nnode)                                           
%  CALL ARG.  nnode              = Number of nodes of the element      
%  RET. ARG. NJ(nnode,:)         = Shape functions at Nint points xi         
%-----------------------------------------------------------------------
                                                                       
 if nnode == 2                                                 
     NJ(1,:) = 0.5*(1-xi);                                           
     NJ(2,:) = 0.5*(1+xi);                                           
 elseif nnode == 3                                          
     NJ(1,:) = 0.5*xi.*(xi-1);                                       
     NJ(2,:) = 1-xi.*xi;                                              
     NJ(3,:) = 0.5*xi.*(xi+1);                                       
 elseif nnode == 4                                         
     NJ(1,:) = 0.0625*(1-xi).*(9*xi.*xi-1);                        
     NJ(2,:) = 0.5625*(1-xi.*xi).*(1-3*xi);                         
     NJ(3,:) = 0.5625*(1-xi.*xi).*(1+3*xi);                         
     NJ(4,:) = 0.0625*(1+xi).*(9*xi.*xi-1);                          
 end

 return            