function [new_mib] = mib_apply_homography(mib, H)

    H
    H_inv = inv(H)

    box1 = struct();

    box1.p1 = mib.box.o;
    box1.p3 = mib.box.d;
    box1.p2 = [box1.p1(1) box1.p3(2)]; % on veut [p1.y et p3.x]
    box1.p4 = [box1.p3(1) box1.p1(2)]; % on veut [p3.y et p1.x]
    box1.height = box1.p3(1);
    box1.width = box1.p3(2);

    box2 = struct();

    box2.p1 = H * [box1.p1(2) box1.p1(1) 1]';
    box2.p3 = H * [box1.p3(2) box1.p3(1) 1]';
    box2.p2 = [box2.p1(1) box2.p3(2)]; % on veut [p1.y et p3.x]
    box2.p4 = [box2.p3(1) box2.p1(2)]; % on veut [p3.y et p1.x]
    % je vais avoir s en trop

    box2.width = round(box2.p3(2)/box2.p3(3)); % on divise par s
    box2.height = round(box2.p3(1)/box2.p3(3)); % on divise par s
    fprintf('p1 %i\n',box2.p1);
    fprintf('p2 %i\n',box2.p2);
    fprintf('p3 %i\n',box2.p3);
    fprintf('p4 %i\n',box2.p4);

    new_mib.mask = zeros(box2.width, box2.height);

    box2.p3(1:2) = round(box2.p3(1:2));
    box2.p1(1:2) = round(box2.p1(1:2));

    for x = 1:box2.height  % largeur
        for y = 1:box2.width% hauteur

            % true_x = x si on avait fait commencer la box à (0,0), on aurait dû décaler pour avoir des vrais x correspondants à la mib d'origine
            % true_y = x

            newCoor = H_inv * [x y 1]';
            s = newCoor(3);
            new_x = round(newCoor(1)/s);
            new_y = round(newCoor(2)/s);

            if( 0 < new_x && new_x <= box1.width && 0 < new_y && new_y <= box1.height ) % avec box1.p3(2) largeur(box1)
                Correspondance_trouvee = newCoor
                new_mib.mask(y, x) = 1;
                new_mib.image(y, x, :) = mib.image(new_y, new_x, :);
            end
        end
    end

end
