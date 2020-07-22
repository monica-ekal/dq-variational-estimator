
function [H] = H_calc(Phi_kplus1,Psi_kplus1,Phi_k,Psi_k)

%{
 Constructing the H matrix --- 
 Gathering the products of m and J on the left 
%} 
    
        H(1:3,1:6) =  Yk_calc(Phi_kplus1)*Gk_calc(Phi_kplus1) - Xk_calc(Phi_k)*Gk_calc(Phi_k);
        
        H(1:3,7:9) = (Qk_calc(Phi_kplus1,Psi_kplus1)*skew(Phi_kplus1) - Yk_calc(Phi_kplus1)*skew(Psi_kplus1) -...
                     (Pk_calc(Phi_k,Psi_k)*skew(Phi_k) - Xk_calc(Phi_k)*skew(Psi_k)));
                 
        H(1:3,10)  =  Qk_calc(Phi_kplus1,Psi_kplus1)*eye(3)*Psi_kplus1 - Pk_calc(Phi_k,Psi_k)*eye(3)*Psi_k;
        
        H(4:6,1:6) =  zeros(3,6);
        H(4:6,7:9) = (Yk_calc(Phi_kplus1)*skew(Phi_kplus1) - Xk_calc(Phi_k)*skew(Phi_k));
        
        H(4:6,10)  =  Yk_calc(Phi_kplus1)*eye(3)*Psi_kplus1 - Xk_calc(Phi_k)*eye(3)*Psi_k;
end