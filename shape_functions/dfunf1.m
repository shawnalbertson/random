function [DNJ] =  dfunf1(xi,nnode)   
%-----------------------------------------------------------------------
%  FUNF1F     dfunf1                                                     
%  PURPOSE    Compute derivative of interpolation functions for 1D-isoparametric      
%             element at Nint points of intrinsic coordinate xi                 
%  CALL       dfunf1(xi,nnode)                                           
%  CALL ARG.  nnode              = Number of nodes of the element      
%  RET. ARG.  DNJ(nnode,:)       = Shape functions at Nint points xi         
%-----------------------------------------------------------------------
                                                                       
 if nnode == 2                                                 
     DNJ(1,1:l) = -0.5;                                           
     DNJ(2,1:nnode) =  0.5;                                           
 elseif nnode == 3                                          
     DNJ(1,:) = xi-0.5;                                       
     DNJ(2,:) = -2*xi;                                              
     DNJ(3,:) = xi+0.5;                                       
 elseif nnode == 4                                         
     DNJ(1,:) = -1.6875*xi.*xi + 1.125*xi + 0.0625;                        
     DNJ(2,:) =  5.0625*xi.*xi - 1.125*xi - 1.6875;                         
     DNJ(3,:) = -5.0625*xi.*xi - 1.125*xi + 1.6875;                         
     DNJ(4,:) =  1.6875*xi.*xi + 1.125*xi - 0.0625;                          
 end

 return            
