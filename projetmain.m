
%AX = B

% (x, y)
imshow('img.png');
%1er quadrangle
A1 = [0 50]; B1 = [50 0]; C1 = [0 -50]; D1 = [-50 0];
%2e quadrangle
A2 = [-50 50]; B2 = [50 50]; C2 = [50 50]; D2 = [-50 50];

Matrix = [];

Matrix = [Matrix ; construireLigneX(A1, A2)];
Matrix = [Matrix ; construireLigneY(A1, A2)];

Matrix = [Matrix ; construireLigneX(B1, B2)];
Matrix = [Matrix ; construireLigneY(B1, B2)];

Matrix = [Matrix ; construireLigneX(C1, C2)];
Matrix = [Matrix ; construireLigneY(C1, C2)];

Matrix = [Matrix ; construireLigneX(D1, D2)];
Matrix = [Matrix ; construireLigneY(D1, D2)];

B = [A2(1) A2(2) B2(1) B2(2) C2(1) C2(2) D2(1) D2(2)]';

H = ((Matrix'*Matrix)\Matrix')*B;
