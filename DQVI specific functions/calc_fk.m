function [f_k] = calc_fk(p,p_next)
%{
A function to calculate f_k, for the preliminary checks
%}
    

    f_k = dualq_mult(dualq_conjugate(p),p_next);
end

