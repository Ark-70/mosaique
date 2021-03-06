close all, clear all, clc;
%AX = B

% (x, y)
bg = imread('backg.jpg');


figure, imshow(bg);
[rec1x rec1y] = ginput(4);
%1er quadrangle
% A1 = [0 50]; B1 = [50 0]; C1 = [0 -50]; D1 = [-50 0];
%2e quadrangle
A1(1) = rec1x(1);
A1(2) = rec1y(1);
B1(1) = rec1x(2);
B1(2) = rec1y(2);
C1(1) = rec1x(3);
C1(2) = rec1y(3);
D1(1) = rec1x(4);
D1(2) = rec1y(4);
%
% rec1x = [B1(1) C1(1) D1(1) A1(1)];
% rec1y = [B1(2) C1(2) D1(2) A1(2)];


portrait = imread('img.png');
% figure, imshow(portrait);

A2 = [1 1]; B2 = [size(portrait, 2) 1]; C2 = [size(portrait, 2) size(portrait, 1)]; D2 = [1 size(portrait, 1)];

Matrix = [];

Matrix = [Matrix ; construireLigneX(A1, A2)];
Matrix = [Matrix ; construireLigneY(A1, A2)];

Matrix = [Matrix ; construireLigneX(B1, B2)];
Matrix = [Matrix ; construireLigneY(B1, B2)];

Matrix = [Matrix ; construireLigneX(C1, C2)];
Matrix = [Matrix ; construireLigneY(C1, C2)];

Matrix = [Matrix ; construireLigneX(D1, D2)];
Matrix = [Matrix ; construireLigneY(D1, D2)];

rec2 = [A2(1) A2(2) B2(1) B2(2) C2(1) C2(2) D2(1) D2(2)]';
rec2x = [A2(1) B2(1) C2(1) D2(1)];
rec2y = [A2(2) B2(2) C2(2) D2(2)];

H = (((Matrix'*Matrix)^-1)*Matrix')*rec2;
%H = Matrix\rec2;

H_matrix = [H' 1];
H_matrix = reshape(H_matrix, 3, 3)';
% H_matrix = H_matrix^-1;

%%%%%%%%% REDEFINITION H

H_matrix = construct_homographic_matrix(rec2x, rec2y, rec1x, rec1y)

%%%%%%%%% REDEFINITION H/

height_bg = size(bg, 1);
width_bg = size(bg, 2);

height_portrait = size(portrait, 1);
width_portrait = size(portrait, 2);

bg_new = bg;

for x=1:width_bg
    for y=1:height_bg

        newCoor = inv(H_matrix) * [x;y;1]; % 1 == rajout d'une dimension
        s = newCoor(3);
        new_x = floor(newCoor(1)/s);
        new_y = floor(newCoor(2)/s);

        if( 0 < new_x && new_x < width_portrait && 0 < new_y && new_y < height_portrait )
            newCoor

            bg_new(y, x, :) = portrait(new_y, new_x, :);
        end

    end
end

figure, imshow(bg_new);
