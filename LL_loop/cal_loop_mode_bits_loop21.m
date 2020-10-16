% function loop_mode_bits = cal_loop_mode_bits(mode_blk_loop)
function mode_bits_loop = cal_loop_mode_bits_loop21(mode_blk_loop, mode_frame_temp, i, j)
    [PU, ~] = size(mode_blk_loop);
    mode_1d = mode_blk_loop(1:PU, PU);

    % if (i > 1 && j > 1)
    %     pre_loop_mode = mode_frame_temp(i - 1, j - 1);
    % if (j > 1)
    %     pre_loop_mode = mode_frame_temp(i, j - 1);
    if (i > 1)
        pre_loop_mode = mode_frame_temp(i - 1, j);
    else
        pre_loop_mode = 1;
    end

    mode_1d_diff = diff([pre_loop_mode, mode_1d']);
    mode_bits_loop = huffman_testsize(mode_1d_diff);
end
