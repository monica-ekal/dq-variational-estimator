function [I] = getI(J)
%{
Elements of the inertia matrix from J in the product G(w)*J
%}
    I = [J(1) J(4) J(5);
         J(4) J(2) J(6);
         J(5) J(6) J(3)];
end

