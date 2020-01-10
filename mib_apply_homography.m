function [new_mib] = mib_apply_homography(mib, H)
    DEBUG = 1;

    H
    H_inv = inv(H)

    box1 = struct();

    box1.p1 = mib.box.p1;
    box1.p3 = mib.box.p3;
    box1.p2 = [box1.p1(1) box1.p3(2)]; % on veut [p1.y et p3.x]
    box1.p4 = [box1.p3(1) box1.p1(2)]; % on veut [p3.y et p1.x]
    box1.height = box1.p3(1);
    box1.width = box1.p3(2);

    box2 = struct();

    box1.p1H = H * [box1.p1(2) box1.p1(1) 1]'; % [x y s] (x et y sont retournés)
    box1.p2H = H * [box1.p2(2) box1.p2(1) 1]';
    box1.p3H = H * [box1.p3(2) box1.p3(1) 1]';
    box1.p4H = H * [box1.p4(2) box1.p4(1) 1]';

    box2.p1 = [ min(box1.p1H(2)/box1.p1H(3), box1.p2H(2)/box1.p2H(3)) min(box1.p1H(1)/box1.p1H(3), box1.p4H(1)/box1.p4H(3)) ]
    box2.p3 = [ max(box1.p3H(2)/box1.p3H(3), box1.p4H(2)/box1.p4H(3)) max(box1.p3H(1)/box1.p3H(3), box1.p2H(1)/box1.p2H(3)) ]

    box2.p2 = [box2.p1(1) box2.p3(2)]; % on veut [p1.y et p3.x]
    box2.p4 = [box2.p3(1) box2.p1(2)]; % on veut [p3.y et p1.x]

    box2.width  = round( (box2.p3(2)) - (box2.p1(2)) );
    box2.height = round( (box2.p3(1)) - (box2.p1(1)) );
    fprintf('p1 %i\n',box2.p1);
    fprintf('p2 %i\n',box2.p2);
    fprintf('p3 %i\n',box2.p3);
    fprintf('p4 %i\n',box2.p4);

    if(DEBUG)
        hauteurbox1 = box1.height
        largeurbox1 = box1.width

        box1p1H = box1.p1H
        box1p3H = box1.p3H

        box2p1H = box2.p1
        box2p3H = box2.p3

    end

    new_mib.mask = zeros(box2.height, box2.width);
    new_mib.box.p1 = box2.p1;
    new_mib.box.p3 = box2.p3;

    box2.p3(1:2) = round(box2.p3(1:2));
    box2.p1(1:2) = round(box2.p1(1:2));
    % box2.p3(1:2) = round([box2.p3(2) box2.p3(1)]);
    % box2.p1(1:2) = round([box2.p1(2) box2.p1(1)]);

    for x = 1:box2.width % largeur
        for y = 1:box2.height % hauteur

            % true_x = x si on avait fait commencer la box à (0,0), on aurait dû décaler pour avoir des vrais x correspondants à la mib d'origine
            % true_y = y

            true_x = x+box2.p1(2); % offset
            true_y = y+box2.p1(1);

            newCoor = H_inv * [true_x true_y 1]';
            s = newCoor(3);
            new_x = round(newCoor(1)/s);
            new_y = round(newCoor(2)/s);

            if( 0 < new_x && new_x <= box1.width && 0 < new_y && new_y <= box1.height ) % avec box1.p3(2) largeur(box1)
%                 Correspondance_trouvee = newCoor
                new_mib.mask(y, x) = 1;
                new_mib.image(y, x, :) = mib.image(new_y, new_x, :);
            end
        end
    end

end
