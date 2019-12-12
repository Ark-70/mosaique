%% Clean
close all, clear all, clc;

%% Param

DEBUG_IMG = 1;
USER_RECT_ON = 0; % activate ginput() entries
IMG_1_PATH = 'backg1.jpg';
IMG_2_PATH = 'backg2.jpg';

%% init

img1 = imread(IMG_1_PATH);
mib1 = mib_construct(img1);

img2 = imread(IMG_2_PATH);
mib2 = mib_construct(img2);


if(DEBUG_IMG)
    figure, imshow(mib1.image);
    figure, imshow(mib2.image);
end


%% Construct H

rec1x = [1 size(img1,2) size(img1,2) 1];
rec1y = [1 1 size(img1,1) size(img1,1)];

rec2x = [1 600 600 1];
rec2y = [1 1 200 200];

if(USER_RECT_ON)
    figure, imshow(mib1.image);
    [rec1x, rec1y] = ginput(4);
    figure, imshow(mib2.image);
    [rec2x, rec2y] = ginput(4);
end

H = construct_homographic_matrix(rec1x, rec1y, rec2x, rec2y);

%% Apply H

new_mib = mib_apply_homography(mib1, H);

if(DEBUG_IMG)
    figure, imshow(new_mib.image);
    figure, imshow(new_mib.mask);
end

%% Fusion MIB


