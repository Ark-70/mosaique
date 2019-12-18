function [mib_fusion] = mib_fusion(mib1, mib2)

%     mib_fusion = struct();
    mib_fusion.box.p1 = 1;

    mib_fusion.box.p1 = [ min(mib1.box.p1(1), mib2.box.p1(1)) min(mib1.box.p1(2), mib2.box.p1(2)) ]
    mib_fusion.box.p3 = [ max(mib1.box.p3(1), mib2.box.p3(1)) max(mib1.box.p3(2), mib2.box.p3(2)) ]

    mib_fusion.height = mib_fusion.box.p3(1) - mib_fusion.box.p1(1)+1;
    mib_fusion.width = mib_fusion.box.p3(2) - mib_fusion.box.p1(2)+1;

    mib_fusion.mask = zeros(ceil(mib_fusion.height), ceil(mib_fusion.width));
    mib_fusion.image = zeros(ceil(mib_fusion.height), ceil(mib_fusion.width), 3);

%     mib_fusion.mask(floor(mib1.box.p1(1)):end, floor(mib1.box.p1(2)):end) = mib_fusion.mask(floor(mib1.box.p1(1)):end, floor(mib1.box.p1(2)):end)


    % a mettre p1:p3
    p1_from_0(1) = floor(mib1.box.p1(1)-mib_fusion.box.p1(1))+1;
    p1_from_0(2) = floor(mib1.box.p1(2)-mib_fusion.box.p1(2))+1;
    % p3_from_0(1) = ceil(mib1.box.p3(1)-mib_fusion.box.p1(1))+1;
    % p3_from_0(2) = ceil(mib1.box.p3(2)-mib_fusion.box.p1(2))+1;
    %
    % mib_fusion.mask(p1_from_0(1):p1_from_0(1)-1+size(mib1.mask, 1), p1_from_0(2):p1_from_0(2)-1+size(mib1.mask, 2)) = mib1.mask;
    mib_fusion.mask = concat_mask(mib_fusion.mask, p1_from_0, mib1.mask);
    mib_fusion.image = concat_image(mib_fusion.image, p1_from_0, mib1.image);
    
    p1_from_0(1) = floor(mib2.box.p1(1)-mib_fusion.box.p1(1))+1;
    p1_from_0(2) = floor(mib2.box.p1(2)-mib_fusion.box.p1(2))+1;
%     p3_from_0(1) = ceil(mib2.box.p3(1)-mib_fusion.box.p1(1))+1;
%     p3_from_0(2) = ceil(mib2.box.p3(2)-mib_fusion.box.p1(2))+1;

    mib_fusion.mask = concat_mask(mib_fusion.mask, p1_from_0, mib2.mask);
%     mib_fusion.mask(p1_from_0(1):p1_from_0(1)-1+size(mib2.mask, 1), p1_from_0(2):p1_from_0(2)-1+size(mib2.mask, 2)) = mib2.mask;
    % ca vaut 1 au milieu et pas 2



    mib_fusion.image = concat_image(mib_fusion.image, p1_from_0, mib2.image);


end
