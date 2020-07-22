function [ v ] = invSkew( M)
%INVSKEW returns a vector given a skew symmetric matrix. It is the inverse
%of the skew operation
v = [M(3,2); M(1,3); M(2,1)];

end

