function [ Yk ] = Yk_calc( phi_k )


    Yk = sqrt(1-phi_k'*phi_k)*eye(3)  + skew(phi_k);


end

