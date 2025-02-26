function [size_all, blk_size_sum, split_frame, mode_frame, CTU_bits] = encode_main_loop(srcy)
    initGlobals(100);
    global zorder;
    zorder = gen_zorder_mat();

    [CTU, img_src] = split_CTU(srcy);
    [h, w] = size(srcy);
    img_rebuild = nan(h + 64, w + 64);
    split_frame = nan(h, w);
    mode_frame = nan(h, w);

    for i = 1:numel(CTU)
        % for i = 1:1
        [CTU_bits(i), img_rebuild, split_frame, mode_frame] = encode_CTU_loop(CTU(i), img_src, img_rebuild, split_frame, mode_frame);
    end

    [size_all, blk_size_sum] = summary_loop(CTU_bits, split_frame, mode_frame);
end
