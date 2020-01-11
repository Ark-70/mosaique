%% Clean
close all, clear all, clc;

%% Param

[file,path] = uigetfile({'(*.png;*.tif;*.jpg;*.jpeg;*.bmp)',...
           ' Image files (*.png, *.tif, *.jpg, *.jpeg, *.bmp)'; ...
           '*.*',  'All Files (*.*)'},...
           'Select all the images you would like to assemble',...
           'MultiSelect', 'on');

DEBUG_IMG = 1;
USER_RECT_ON = 1; % activate ginput() entries

IMG_PATHS = string(file); % marche en version 2019 en tout cas
imgs = {};
original_mibs = zeros(length(file));
mibs = zeros(length(file));
fusioned_mib = 1; % One mib to rule them all

%% init

for i=1:length(IMG_PATHS)
    img_tmp = imread(IMG_PATHS(i));
    imgs{i} = img_tmp;

end

% imgs{1} = imread(IMG_PATHS(1));
% original_mibs(1) = mib_construct(imgs(1));
%
% imgs(2,:,:) = imread(IMG_PATHS(2));
% original_mibs(2) = mib_construct(imgs(2));

mibs = original_mibs;

% if(DEBUG_IMG)
%     figure, imshow(mib(1).image);
%     figure, imshow(mib(2).image);
% end
%

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
scatter(round(rec1x), round(rec1y), 'ro', 'LineWidth', 2);
hold off;
drawnow; 

figure(11), imshow(mib2.image);
hold on;
scatter(round(rec2x), round(rec2y), 'bo', 'LineWidth', 2);
hold off;  
drawnow;

H = construct_homographic_matrix(rec1x, rec1y, rec2x, rec2y);

%% Apply H

mibs(1) = mib_apply_homography(mibs(1), H);

if(DEBUG_IMG)
    figure, imshow(mibs(1).image);
    figure, imshow(mibs(1).mask);
end

%% Fusion MIB

fusioned_mib = mib_fusion(mibs(1), mibs(2));
nb_colors = max(fusioned_mib.mask(:))+1;
figure, imshow(fusioned_mib.mask/(nb_colors-1)); colormap(gray(nb_colors)); colorbar


figure, imshow(uint8(fusioned_mib.debuging_image));

% faire une fusion dbz
