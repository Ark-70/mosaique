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



%% Construct H

rec1x = [1 size(img1,2) size(img1,2) 1];
rec1y = [1 1 size(img1,1) size(img1,1)];

rec2x = [1 600 600 1];
rec2y = [1 1 200 200];


%     figure, imshow(mib1.image);
if(USER_RECT_ON)
    [rec1x, rec1y] = ginput(4);
end
% figure, imshow(mib2.image);
if(USER_RECT_ON)
    [rec2x, rec2y] = ginput(4);
end
if(~USER_RECT_ON)
      rec1x = [133.365384615385;364.365384615385;379.913461538462;118.557692307692];
      rec1y = [134.139423076923;128.216346153846;291.100961538462;338.485576923077];
      rec2x = [164.951114922813;418.964837049743;302.584048027444;22.2581475128645];
      rec2y = [22.5205831903944;185.453687821612;436.431389365352;345.350771869640];
end

figure(10), imshow(mib1.image);
hold on;
scatter(round(rec1x), round(rec1y), 70, 'ro', 'LineWidth', 2.5);
hold off;
drawnow; 

figure(11), imshow(mib2.image);
hold on;
scatter(round(rec2x), round(rec2y), 70, 'go', 'LineWidth', 2.5);
hold off;  
drawnow;

H = construct_homographic_matrix(rec1x, rec1y, rec2x, rec2y);

%% Apply H

new_mib1 = mib_apply_homography(mib1, H);

if(DEBUG_IMG)
    figure, imshow(new_mib1.image);
    figure, imshow(new_mib1.mask);
end

%% Fusion MIB

fusioned_mib = mib_fusion(new_mib1, mib2);
nb_colors = max(fusioned_mib.mask(:))+1;
figure, imshow(fusioned_mib.mask/(nb_colors-1)); colormap(gray(nb_colors)); colorbar('Ticks',[1/6,3/6,5/6], 'TickLabels',{'0','1','2'})


figure, imshow(uint8(fusioned_mib.debuging_image));

% faire une fusion dbz
