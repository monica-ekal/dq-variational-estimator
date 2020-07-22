function [ DQ_conj ] = dualq_conjugate( DQ )

%{
Function to find conjugate of a dual quaternion
If q = [qr;qd]; q_conjugate = [qr_conjugate;qd_conjugate];
%}

 DQ_conj = [-DQ(1:3);DQ(4);-DQ(5:7);DQ(8)]; 

end

