
function [J] = getJ(M11)

%{
Elements of J to convert the product I*w to G(w)*J
%}
    J = [M11(1,1);M11(2,2);M11(3,3);M11(1,2);M11(1,3);M11(2,3)];
end

