function [ phi_k,psi_k ] = PhikPsiK_calc( rhist,qhist )
%{
Getting the values of phi and psi from positions and quaternions.
%}

if(size(rhist,2)>=2)
    data_length = size(qhist,2);
    DQ = zeros(8, data_length);
    f_k = zeros(8, data_length-1);

    for i = 1:size(qhist,2)
        DQ(:,i) = dualq_calc(rhist(:,i),qhist(:,i));
    end

    for i = 1:size(qhist,2)-1
        f_k(:,i) = dualq_mult(dualq_conjugate(DQ(:,i)),DQ(:,i+1));
    end

    phi_k = f_k(1:3,:);
    psi_k = f_k(5:7,:);
end

end

