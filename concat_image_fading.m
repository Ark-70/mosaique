function [new_image] = concat_image_fading(mib1, image2_origin, mib2)

DEBUG_TRANSPARENCY = false;

    global_image = mib1.image;
    image2 = mib2.image;
    

    truc1 = global_image(image2_origin(1):image2_origin(1)-1+size(image2, 1), ...
                image2_origin(2):image2_origin(2)-1+size(image2, 2), :);

            truc2 = double(image2);

    truc3 = (truc1 + truc2)/2;

if(DEBUG_TRANSPARENCY)
    global_image(image2_origin(1):image2_origin(1)-1+size(image2, 1), ...
                image2_origin(2):image2_origin(2)-1+size(image2, 2), :) = ...
    (global_image(image2_origin(1):image2_origin(1)-1+size(image2, 1), ...
                image2_origin(2):image2_origin(2)-1+size(image2, 2), :) + double(image2))/2;
else
    global_image(image2_origin(1):image2_origin(1)-1+size(image2, 1), ...
                image2_origin(2):image2_origin(2)-1+size(image2, 2), :) = ...
    (global_image(image2_origin(1):image2_origin(1)-1+size(image2, 1), ...
                image2_origin(2):image2_origin(2)-1+size(image2, 2), :) +...
                double(image2)) ./(mib1.mask(image2_origin(1):image2_origin(1)-1+size(image2, 1), ...
                image2_origin(2):image2_origin(2)-1+size(image2, 2), :));
    
    global_image(isnan(global_image))=0;
end
            
new_image = global_image;

end
