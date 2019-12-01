function [ H ] = construct_homographic_matrix ( xfrom, yfrom, xto, yto )
    nx = length(xfrom);
    ny = length(yfrom);
    A = zeros(2*nx, 8);
    V = zeros(8, 1);
    for i = 1:nx
        V(2*i-1, 1) = xto(i);
        V(2*i, 1) = yto(i);

        A(2*i-1, :) = [xfrom(i) yfrom(i) 1 0 0 0 -xfrom(i)*xto(i) -yfrom(i)*xto(i)];
        A(2*i, :) =   [0 0 0 xfrom(i) yfrom(i) 1 -xfrom(i)*yto(i) -yfrom(i)*yto(i)];

    end

    X = A\V;
    H = reshape( [X;1], [3,3])';

end
