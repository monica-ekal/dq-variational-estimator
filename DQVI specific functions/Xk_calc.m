function [ Xk ] = Xk_calc( phi_k )


    Xk = sqrt(1-phi_k'*phi_k)*eye(3)  - skew(phi_k);


end

