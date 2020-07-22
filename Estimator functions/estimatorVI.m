function [est_all ] = estimatorVI(rhist,qhist,tau_body,dt)
%{
An estimator function that uses the measurements and applied torques 
to estimate the parameters using the discrete dual quaternion rigid
body equations.
%}

    R = [];
    z = [];
    est_all = [];
    err_est_all = [];
    [phi_k,psi_k] = PhikPsiK_calc(rhist(:,1:2),qhist(:,1:2));
   
% --------- Recursive LSQ method ---------------- %
    
    for i = 2:size(rhist,2)-2
     [phi_kplus1,psi_kplus1] = PhikPsiK_calc(rhist(:,i:i+1),qhist(:,i:i+1));     % calculate phi at every step
     H_k = H_calc(phi_kplus1,psi_kplus1,phi_k,psi_k) ;                         % Regressor H
     Y_k = (dt*dt*tau_body(:,i)./2);                                           % Torques Y                       

     [Q,R] = qr([R; H_k],0);
         z = Q'*[z; Y_k];
     est = R\z;

% ----- log data and prepare for next step -------%
     phi_k = phi_kplus1; psi_k = psi_kplus1; 
     est_all = [est_all  [est(1:6);est(7:9)/est(10);est(10)]];

    end
  
end

