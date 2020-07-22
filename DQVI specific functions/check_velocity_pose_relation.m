
function [] = check_velocity_pose_relation(w,v,q,p,p_next,dt)

%{
    To test the validity of (2*p_conj*p_dot) = omega_b
%}

    v_b = qmult([-q(1:3);q(4)],qmult([v;0],q));
    Xi = [w;0;v_b];
    p_conj = dualq_conjugate(p);
    p_dot = (p_next-p)/dt;
    2*dualq_mult(p_conj,p_dot)-Xi;
    
end
