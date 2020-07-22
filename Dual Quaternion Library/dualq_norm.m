function [ norm ] = dualq_norm( dq1 )
 
%{
Norm of the dual quaternion is q*q_conjugate
%}

norm = dualq_mult(dq1,dualq_conjugate(dq1));

end

