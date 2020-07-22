function [v_world] = convToWorld(q,v)
        v_world = qmult(q,qmult([v;0],[-q(1:3);q(4)]));
        v_world = v_world(1:3);
    end