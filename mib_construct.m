function [mib] = mib_construct(img)
    mib = struct()

    mib.image = img;
    mib.mask = ones(size(img));
    mib.box.o = [1 1]; % origine (y,x)
    mib.box.d = [size(img,1) size(img,2)]; % destination (y,x)

    % box =
    %    x y
    % p1[   ]
    % p2[   ]
end
