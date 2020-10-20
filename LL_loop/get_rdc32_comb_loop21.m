function [img_rebuild, split_frame, mode_frame, rdc] = get_rdc32_comb_loop21(x, y, img_src, img_rebuild, split_frame, mode_frame, rdc_deep_layer, rdc_ind)
    PU = 32; %4 8 16 32 64

    % loop 部分
    [prederr_blk_loop, pred_blk_loop, mode_blk_loop] = mode_select_loop_loop21(img_src, img_rebuild, x, y, PU);
    % img_rebuild_temp_loop = prederr_blk_loop + pred_blk_loop;
    mode_frame_temp_loop = Mode_All(mode_frame, x, y, PU, mode_blk_loop);
    mode_bits_loop = cal_loop_mode_bits_loop21(mode_blk_loop, mode_frame_temp_loop, x, y);
    rdc_curr_temp_loop = cal_rdc(prederr_blk_loop, mode_bits_loop);
    % loop 部分
    % blk 部分
    [prederr_blk, pred_blk, ~, mode_blk] = mode_select_blk(img_src, img_rebuild, x, y, PU);
    % img_rebuild_temp_blk = prederr_blk + pred_blk;
    mode_frame_temp_blk = Mode_All(mode_frame, x, y, PU, mode_blk);
    [flag, Y, ~] = Mode1(0, mode_frame_temp_blk, x, y);
    if flag
        mode_bits = 3;
    else
        mode_bits = 6;
    end
    rdc_curr_temp_blk = cal_rdc(prederr_blk, mode_bits);
    % blk 部分

    rdc_deep = sum(rdc_deep_layer(rdc_ind * 4 - 3:rdc_ind * 4));
    if (min(rdc_curr_temp_blk, rdc_curr_temp_loop) <= rdc_deep)
        if (rdc_curr_temp_loop < rdc_curr_temp_blk)
            rdc = rdc_curr_temp_loop;
            mode_frame = mode_frame_temp_loop;
        else
            rdc = rdc_curr_temp_blk;
            mode_frame = mode_frame_temp_blk;
        end
        split_frame = Mode_All(split_frame, x, y, PU, PU);
    else
        rdc = rdc_deep;
        % mode_frame 保持不变
        % split_frame 保持不变
    end
    %assert(all(img_rebuild_temp_blk == img_rebuild_temp_loop, [1, 2]))
    % img_rebuild_temp(x:x + PU - 1, y:y + PU - 1) = img_rebuild_temp_blk;
end
