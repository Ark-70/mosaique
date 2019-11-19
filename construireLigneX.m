function [ligne] = construireLigneX(p1, p2);
    x1 = p1(1);
    x2 = p1(2);
    y1 = p2(1);
    y2 = p2(2);

    ligne = [x1 y1 1 0 0 0 -x2*x1 -y1*x2];

end
