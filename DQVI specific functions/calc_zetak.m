function [zeta_k] = calc_zetak(fk,M)

%{
A function to calculate zeta_k, for the preliminary checks
%}

    zeta_k = fk'*M;
    
end
