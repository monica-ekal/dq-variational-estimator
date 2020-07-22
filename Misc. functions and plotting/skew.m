        function x_skew = skew(x)
            % vector to symmetric matrix, for writing cross products as matrix multiplication
            x_skew = [  0   -x(3)  x(2)
                     x(3)   0   -x(1)
                    -x(2)  x(1)  0];
        end
        