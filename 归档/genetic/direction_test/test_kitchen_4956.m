function [err, pred, sae, dir, w1, w2, preview] = test_kitchen_4956(direction_num)
    clear err pred sae dir w1 w2 preview
    inputName = './../../HEVC_like/kitchen.ppm';
    rgb = imread(inputName);
    yuv = double(jpeg_rgb2ycbcr(rgb));
    lum = yuv(:, :, 1);
    err = {}; pred = {}; sae = {}; dir = {}; preview = {}; w1 = {}; w2 = {};
    blk_cnt = 1;
    for rr = 1:3
        for x = 49:8:56
            for y = 49:8:56
                y
                src = yuv(x:x + 7, y:y + 7, rr);
                % T = yuv(x - 1, y:y + 15, rr);
                % L = yuv(x:x + 15, y - 1, rr);
                % LT = yuv(x - 1, y - 1, rr);
                if rr == 1
                    T = [68 69 68 74 66 62 67 63 57 58 53 56 52 50 49 51];
                    L = [67; 64; 68; 67; 71; 65; 73; 66; 73; 66; 68; 70; 66; 67; 69; 73];
                    LT = 66;
                end
                if rr == 2
                    T = [123 123 123 123 123 123 123 123 123 124 124 124 124 124 124 124];
                    L = [122; 122; 122; 122; 122; 122; 122; 122; 122; 122; 122; 122; 122; 122; 122; 123];
                    LT = 123;
                end
                if rr == 3
                    T = repmat(131, 1, 16);
                    L = repmat(131, 16, 1);
                    LT = 131;
                end

                [err{blk_cnt}, pred{blk_cnt}, sae{blk_cnt}, dir{blk_cnt}, w1{blk_cnt}, w2{blk_cnt}] = direction_weight_select_4(L, T, LT, src, direction_num);
                preview{blk_cnt} = [LT, T(1:8); [L(1:8), src]];

                blk_cnt = blk_cnt + 1;
            end
        end
    end
    sae = cell2mat(sae);
    dir = cell2mat(dir);
end

function [err, pred, sae, dir, w1, w2] = direction_weight_select_4(L, T, LT, src, direction_num)
    parfor N = 1:direction_num
        theta = 45 + ((225 - 45) / (direction_num - 1)) * (N - 1);
        [ref1_val{N}, ref2_val{N}] = get_ref1_2(L, T, LT, theta);

        % M = 1;
        % for w1 = -2:0.05:2
        %     [err_allw{M}, pred_allw{M}, sae_allw(M)] = pred_by_w(src, ref1_val{N}, ref2_val{N}, w1);
        %     w1_all(M) = w1;
        %     M = M + 1;
        % end
        % M = 1;
        % for w1 = -2:0.05:2
        %     for w2 = -2:0.05:2
        %         [err_allw{M}, pred_allw{M}, sae_allw(M)] = pred_by_w_nolimit(src, ref1_val{N}, ref2_val{N}, w1, w2);
        %         w1_all(M) = w1;
        %         w2_all(M) = w2;
        %         M = M + 1;
        %     end
        % end
        [err_allw, pred_allw, sae_allw, w1_all, w2_all] = pred_by_w_nolimit(src, ref1_val{N}, ref2_val{N});

        [sae_best(N), ind_best] = min(sae_allw);
        err_best{N} = err_allw{ind_best};
        pred_best{N} = pred_allw{ind_best};
        w1_best(N) = w1_all(ind_best);
        w2_best(N) = w2_all(ind_best);
    end

    [sae, dir] = min(sae_best);
    pred = pred_best{dir};
    err = err_best{dir};
    w1 = w1_best(dir);
    w2 = w2_best(dir);
end

function [ref1_val, ref2_val] = get_ref1_2(L, T, LT, theta)
    v_mat = [1, 1, 1, 1, 1, 1, 1, 1; 2, 2, 2, 2, 2, 2, 2, 2; 3, 3, 3, 3, 3, 3, 3, 3; 4, 4, 4, 4, 4, 4, 4, 4; 5, 5, 5, 5, 5, 5, 5, 5; 6, 6, 6, 6, 6, 6, 6, 6; 7, 7, 7, 7, 7, 7, 7, 7; 8, 8, 8, 8, 8, 8, 8, 8];
    h_mat = v_mat';
    if theta <= 90
        % 暂时不考虑 90 度没法算的问题，因为不会出现这个角度
        offset = v_mat / tand(theta);
        proj_pos = h_mat + offset;
        ref1_index = floor(proj_pos);
        ref2_index = ceil(proj_pos);
        ref1_val = T(ref1_index);
        ref2_val = T(ref2_index);
    elseif theta >= 180
        % 暂时不考虑 180 度没法算的问题，因为不会出现这个角度
        offset = h_mat * tand(theta - 180);
        proj_pos = v_mat + offset;
        ref1_index = floor(proj_pos);
        ref2_index = ceil(proj_pos);
        ref1_val = L(ref1_index);
        ref2_val = L(ref2_index);
    else
        % 要考虑投影到上方还是左方，还要考虑 LT 这个参考点
        offset_h = v_mat / tand(180 - theta);
        proj_pos_h = h_mat - offset_h;
        offset_v = h_mat * tand(180 - theta);
        proj_pos_v = v_mat - offset_v;
        proj_T_flag = proj_pos_h >= 0;
        % proj_L_falg = not(proj_T_flag);
        for i = 1:8
            for j = 1:8
                if proj_T_flag(i, j)
                    ref1_index = floor(proj_pos_h(i, j));
                    ref2_index = ceil(proj_pos_h(i, j));
                    if ref1_index == 0
                        ref1_val(i, j) = LT;
                    else
                        ref1_val(i, j) = T(ref1_index);
                    end
                    ref2_val(i, j) = T(ref2_index);
                else
                    ref1_index = floor(proj_pos_v(i, j));
                    ref2_index = ceil(proj_pos_v(i, j));
                    if ref1_index == 0
                        ref1_val(i, j) = LT;
                    else
                        ref1_val(i, j) = L(ref1_index);
                    end
                    ref2_val(i, j) = L(ref2_index);
                end
            end
        end
    end
end

function [err_allw, pred_allw, sae_allw, w1_all, w2_all] = pred_by_w(src, ref1_val, ref2_val, w1)
    w2 = 1 - w1;
    pred = round(w1 * ref1_val + w2 * ref2_val);
    err = src - pred;
    sae = sum(sum(abs(err)));
end

function [err_allw, pred_allw, sae_allw, w1_all, w2_all] = pred_by_w_nolimit(src, ref1_val, ref2_val)
    M = 1;
    for w1 = linspace(-2, 2, 128)
        for w2 = linspace(-2, 2, 128)
            % for w1 = -2:0.05:2
            %     for w2 = -2:0.05:2
            % pred_allw{M} = w1 * ref1_val + w2 * ref2_val;
            pred_allw{M} = round(w1 * ref1_val + w2 * ref2_val);
            err_allw{M} = src - pred_allw{M};
            sae_allw(M) = sum(abs(err_allw{M}), [1, 2]);

            w1_all(M) = w1;
            w2_all(M) = w2;

            if (sae_allw(M) == 0)
                return
            end

            M = M + 1;
        end
    end
end

% function [err, pred, sae] = pred_by_w_nolimit(src, ref1_val, ref2_val)
%     src_offset = src - 128;
%     ref1_val_offset = ref1_val - 128;
%     ref2_val_offset = ref2_val - 128;
%     minabs = min([abs(ref1_val_offset(:)); abs(ref2_val_offset(:))]);
%     U = 128 / minabs;
%     L = -127 / minabs;

%     M = 1;
%     for w1 = linspace(L,U,256)
%         for w2 = linspace(L,U,256)
%             pred = w1 * ref1_val + w2 * ref2_val;
%             err = src - pred;
%             sae = sum(sum(abs(err)));
%             M = M + 1;
%         end
%     end
% end
