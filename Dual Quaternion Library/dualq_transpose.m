function [ dq_trans ] = dualq_transpose( dq )

%{
Transpose of a dual quaternion q = [q_r q_d] is defined as q_trans = [q_d q_r];
%}

 q_r = dq(1:4,1); q_d = dq(5:8,1);
 dq_trans = [q_d; q_r];
 
 
end

