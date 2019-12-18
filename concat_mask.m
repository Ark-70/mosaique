function [new_mask] = concat_mask(global_mask, mask2_origin, mask2)

    global_mask(mask2_origin(1):mask2_origin(1)-1+size(mask2, 1), ...
                mask2_origin(2):mask2_origin(2)-1+size(mask2, 2)) = ...
    global_mask(mask2_origin(1):mask2_origin(1)-1+size(mask2, 1), ...
                mask2_origin(2):mask2_origin(2)-1+size(mask2, 2)) + mask2;

new_mask = global_mask;
                
end
