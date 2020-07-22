function [Gk] = Gk_calc(phi)

Gk = [phi(1)   0      0      phi(2)      phi(3)        0;
         0       phi(2)  0      phi(1)        0          phi(3);
         0        0      phi(3)   0         phi(1)       phi(2)];
end