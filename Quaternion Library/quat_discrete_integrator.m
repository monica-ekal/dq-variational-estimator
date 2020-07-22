function [ q_nplus1 ] = quat_discrete_integrator( q_n,w_n,dt )

% Discrete quaternion integrator from Landis and Markley, 2003
  
    ksi = sin(0.5*norm(w_n)*dt)*w_n/norm(w_n);
    Omega = [cos(0.5*norm(w_n)*dt)*eye(3) - skew(ksi)            ksi;
                -ksi'                                        cos(0.5*norm(w_n)*dt)];

    q_nplus1 =Omega*q_n;

end



