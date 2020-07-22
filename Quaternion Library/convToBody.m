    function [v_body] = convToBody(q,v)
        v_body = qmult([-q(1:3);q(4)],qmult([v;0],q));
        v_body = v_body(1:3);
    end

    
