function [ est_all] = estimatorFD( rhist,qhist,vhist, whist, tau_body,dt)

    R = [];
    z = [];
    est_all = [];

    for i = 2:size(rhist,2)-1
        
        %calculate linear and angular accelerations using finite
        %difference.
        dvhist_FD_body(:,i) =  convToBody(qhist(:,i),(vhist(:,i+1)-vhist(:,i))/dt) ;
        dwhist_FD_body(:,i) = (whist(:,i+1)-whist(:,i))/dt ;
        
        % The regressor matrix can be found in Ekal, M., Ventura, R. On the Accuracy of Inertial Parameter Estimation of a Free-Flying Robot While Grasping an Object. J Intell Robot Syst 98, 153–163 (2020). https://doi.org/10.1007/s10846-019-01040-y
        H_k = [  (Gk_calc(dwhist_FD_body(:,i)) + skew(whist(:,i))*Gk_calc(whist(:,i)))    -skew(dvhist_FD_body(:,i))                                              zeros(3,1)    ;
                                     zeros(3,6)                                                                 skew(whist(:,i))*skew(whist(:,i)) + skew(dwhist_FD_body(:,i))    dvhist_FD_body(:,i)];
        Y_k = tau_body(:,i);                                           % Torques Y                       

        [Q,R] = qr([R; H_k],0);
        z = Q'*[z; Y_k];
        est = R\z;
        est_all = [est_all [est(1:6);est(7:9)/est(10);est(10)]];
        
    end     
        
end

