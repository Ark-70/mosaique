function [ligne] = construireLigneY(p1, p2);
    x1 = p1(1);
    x2 = p1(2);
    y1 = p2(1);
    y2 = p2(2);

    ligne = [0 0 0 x1 y1 1 -y2*x1 -y1*y2];

end
