function [DQ] = dualq_calc(l,q)

%{
Find the dual quaternion representation given position and attitude
DQ =  q + dual(1/2*l*q)
%}

    DQ(1:4,1) = q;
    DQ(5:8,1) = 0.5*qmult([l;0], q);
    
end