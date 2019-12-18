function [new_image] = concat_image(global_image, image2_origin, image2)

    truc1 = global_image(image2_origin(1):image2_origin(1)-1+size(image2, 1), ...
                image2_origin(2):image2_origin(2)-1+size(image2, 2), :);
    
            truc2 = double(image2);

    truc3 = (truc1 + truc2)/2;


    global_image(image2_origin(1):image2_origin(1)-1+size(image2, 1), ...
                image2_origin(2):image2_origin(2)-1+size(image2, 2), :) = ...
    (global_image(image2_origin(1):image2_origin(1)-1+size(image2, 1), ...
                image2_origin(2):image2_origin(2)-1+size(image2, 2), :) + double(image2))/2;

new_image = global_image;

end
