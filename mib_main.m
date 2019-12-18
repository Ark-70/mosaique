%% Clean
close all, clear all, clc;

%% Param

DEBUG_IMG = 1;
USER_RECT_ON = 1; % activate ginput() entries
IMG_1_PATH = 'backg1.jpg';
IMG_2_PATH = 'backg2.jpg';

%% init

img1 = imread(IMG_1_PATH);
mib1 = mib_construct(img1);

img2 = imread(IMG_2_PATH);
mib2 = mib_construct(img2);

% if(DEBUG_IMG)
%     figure, imshow(mib1.image);
%     figure, imshow(mib2.image);
% end
% 

%% Construct H

rec1x = [1 size(img1,2) size(img1,2) 1];
rec1y = [1 1 size(img1,1) size(img1,1)];

rec2x = [1 600 600 1];
rec2y = [1 1 200 200];

if(USER_RECT_ON)
    
%     [rec1x, rec1y] = ginput(4);
%     [rec2x, rec2y] = ginput(4);
      rec1x = [131.611842105263;241.032894736842;377.809210526316;133.638157894737];
      rec1y = [134.743421052632;138.796052631579;170.203947368421;201.611842105263];
      rec2x = [163.939108061750;282.343910806175;392.652658662093;118.398799313894];
      rec2y = [20.4965694682675;116.637221269297;263.378216123499;144.973413379074];

    figure(10), imshow(mib1.image);
    hold on;
    scatter(round(rec1x), round(rec1y), 'go');
    hold off;
    drawnow; 
    
    figure(11), imshow(mib2.image);
    hold on;
    scatter(round(rec2x), round(rec2y), 'yo');
    hold off;  
end

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
figure, imshow(fusioned_mib.mask/(nb_colors-1)); colormap(gray(nb_colors)); colorbar


figure, imshow(uint8(fusioned_mib.image));

% faire une fusion dbz