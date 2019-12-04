%% Param
close all, clear all, clc;

%% init

img = imread('backg.jpg');
figure, imshow(img);
mib = mib_construct(img);

%% Construct H

rec1x = [1 size(img,2) size(img,2) 1];
rec1y = [1 1 size(img,1) size(img,1)];

rec2x = [1 600 600 1];
rec2y = [1 1 200 200];

H = construct_homographic_matrix(rec1x, rec1y, rec2x, rec2y);

%% Apply H

new_mib = mib_apply_homography(mib, H);
figure, imshow(new_mib.image)
