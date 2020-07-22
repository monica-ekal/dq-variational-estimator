function [ dq3 ] = dualq_mult( dq1,dq2 )

%{
 Multiply two dual quaternions
a = [a_r;a_d] and b = [b_r;b_d] 
Then a*b =  a_r*b_r + dual(a_r*b_d + b_r*a_d)
%}

a_r = dq1(1:4); a_d = dq1(5:8);
b_r = dq2(1:4); b_d = dq2(5:8);

c_r = qmult(a_r,b_r);
c_d = qmult(a_r,b_d) + qmult(a_d,b_r);

dq3 = [c_r;c_d];
end

