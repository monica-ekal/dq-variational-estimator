function [ Qk ] = Qk_calc( phi_k,psi_k )


    Qk = -dot(psi_k,phi_k)*eye(3)/sqrt(1-phi_k'*phi_k)  + skew(psi_k);


end

