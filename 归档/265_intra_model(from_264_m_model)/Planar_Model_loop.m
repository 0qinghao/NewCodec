% function [TOP, LEFT, TOPLEFT] = Planar_Model_loop(PU, PX, PY)
function [pred_1d] = Planar_Model_loop(PU, PX, PY)

    % Intra Planar Prediction
    % Inputs :
    %   PU = Prediction Unit Size
    %   PX = Left Neighboring Pixels
    %   PY = Top  Neighboring Pixels

    % Output:
    %   Intra_Planar : Planar Predicted Output PU

    % 暂时用最边缘的像素替代外侧扩展的那个
    tr = PY(PU + 1);
    bl = PX(PU + 1);
    for i = 1:PU
        for j = 1:1
            w_t = PU - 1 - (i - 1);
            w_bl = PU - w_t;
            w_l = PU - 1 - (j - 1);
            w_tr = PU - w_l;
            Intra_Planar(i, j) = round((w_t * PY(j + 1) + w_bl * bl + w_l * PX(i + 1) + w_tr * tr) / 2 / PU);
        end
    end
    for i = 1:1
        for j = 1:PU
            w_t = PU - 1 - (i - 1);
            w_bl = PU - w_t;
            w_l = PU - 1 - (j - 1);
            w_tr = PU - w_l;
            Intra_Planar(i, j) = round((w_t * PY(j + 1) + w_bl * bl + w_l * PX(i + 1) + w_tr * tr) / 2 / PU);
        end
    end

    if (PU ~= 1)
        TOP = Intra_Planar(1, 2:PU);
        LEFT = Intra_Planar(2:PU, 1);
        TOPLEFT = Intra_Planar(1, 1);
        pred_1d = [LEFT(end:-1:1)', TOPLEFT, TOP];
    else
        pred_1d = Intra_Planar(1, 1);
    end
end
