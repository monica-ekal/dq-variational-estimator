function [ est ] =LSQ_batch( phi_k,psi_k,tau_body,dt,realVals )
%{
Implementation of the batch least squares estimator using DQ discrete rigid body
dynamics given the values of phi,psi and tau.
%}

for i = 1:size(phi_k,2)-1

    H_all((i-1)*6+1:i*6,:) = H_calc(phi_k(:,i+1),psi_k(:,i+1),phi_k(:,i),psi_k(:,i));    
end


% --- Try simple linear LSQ --- %
% size(H_all)
% size(tau_body)
% size(Tau_b_all(:,2:end))
%size(inv(H_all'*H_all)*H_all')

% -------------
% The third value of forces and torques is used because of the formulation
% of the problem in the variational integrator.
% -----------


T = (reshape(dt*dt*tau_body(:,2:end)./2,[],1));
est = inv(H_all'*H_all)*H_all'*T;

norm(H_all*est - T)
norm(H_all*realVals - T)




est = [est(1:6);est(7:9)/est(10);est(10)] %Ixx Iyy Izz Ixy Ixz Iyz offx

end

