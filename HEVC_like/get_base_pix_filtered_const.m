function [base_pix, base_pix_filtered, dec_base_pix, b4_enc_base_pix] = get_base_pix_filtered_const(yuv_block, SIZE, quality)
    % yuv_block: 原始像素块
    % quality: 量化参数1-100
    % base_pix: accurate value
    % dec_base_pix: rebuild value
    % b4_enc_base_pix: to huffman
    initGlobals(quality);
    [~, ~, dd] = size(yuv_block);

    switch SIZE
        case 20
            I1 = [[22:5:40]', 100 + [22:5:40]', 200 + [22:5:40]', 300 + [22:5:40]'];
            I2 = [[23:5:40]', 100 + [23:5:40]', 200 + [23:5:40]', 300 + [23:5:40]'];
            I3 = [[24:5:40]', 100 + [24:5:40]', 200 + [24:5:40]', 300 + [24:5:40]'];
            I4 = [[42:5:60]', 100 + [42:5:60]', 200 + [42:5:60]', 300 + [42:5:60]'];
            I5 = [[43:5:60]', 100 + [43:5:60]', 200 + [43:5:60]', 300 + [43:5:60]'];
            I6 = [[44:5:60]', 100 + [44:5:60]', 200 + [44:5:60]', 300 + [44:5:60]'];
            I7 = [[62:5:80]', 100 + [62:5:80]', 200 + [62:5:80]', 300 + [62:5:80]'];
            I8 = [[63:5:80]', 100 + [63:5:80]', 200 + [63:5:80]', 300 + [63:5:80]'];
            I9 = [[64:5:80]', 100 + [64:5:80]', 200 + [64:5:80]', 300 + [64:5:80]'];
            base_index = {I1 I2 I3 I4 I5 I6 I7 I8 I9};
            B = zeros(SIZE / 5, SIZE / 5, dd);
            base_pix = {B B B B B B B B B};
        case 40
            I1 = [[42:5:80]', 200 + [42:5:80]', 400 + [42:5:80]', 600 + [42:5:80]', 800 + [42:5:80]', 1000 + [42:5:80]', 1200 + [42:5:80]', 1400 + [42:5:80]'];
            I2 = [[43:5:80]', 200 + [43:5:80]', 400 + [43:5:80]', 600 + [43:5:80]', 800 + [43:5:80]', 1000 + [43:5:80]', 1200 + [43:5:80]', 1400 + [43:5:80]'];
            I3 = [[44:5:80]', 200 + [44:5:80]', 400 + [44:5:80]', 600 + [44:5:80]', 800 + [44:5:80]', 1000 + [44:5:80]', 1200 + [44:5:80]', 1400 + [44:5:80]'];
            I4 = [[82:5:120]', 200 + [82:5:120]', 400 + [82:5:120]', 600 + [82:5:120]', 800 + [82:5:120]', 1000 + [82:5:120]', 1200 + [82:5:120]', 1400 + [82:5:120]'];
            I5 = [[83:5:120]', 200 + [83:5:120]', 400 + [83:5:120]', 600 + [83:5:120]', 800 + [83:5:120]', 1000 + [83:5:120]', 1200 + [83:5:120]', 1400 + [83:5:120]'];
            I6 = [[84:5:120]', 200 + [84:5:120]', 400 + [84:5:120]', 600 + [84:5:120]', 800 + [84:5:120]', 1000 + [84:5:120]', 1200 + [84:5:120]', 1400 + [84:5:120]'];
            I7 = [[122:5:160]', 200 + [122:5:160]', 400 + [122:5:160]', 600 + [122:5:160]', 800 + [122:5:160]', 1000 + [122:5:160]', 1200 + [122:5:160]', 1400 + [122:5:160]'];
            I8 = [[123:5:160]', 200 + [123:5:160]', 400 + [123:5:160]', 600 + [123:5:160]', 800 + [123:5:160]', 1000 + [123:5:160]', 1200 + [123:5:160]', 1400 + [123:5:160]'];
            I9 = [[124:5:160]', 200 + [124:5:160]', 400 + [124:5:160]', 600 + [124:5:160]', 800 + [124:5:160]', 1000 + [124:5:160]', 1200 + [124:5:160]', 1400 + [124:5:160]'];
            %九个点的位置索引
            base_index = {I1 I2 I3 I4 I5 I6 I7 I8 I9};
            B = zeros(SIZE / 5, SIZE / 5, dd);
            base_pix = {B B B B B B B B B};
    end
    dec_base_pix = B;
    b4_enc_base_pix = B;
    base_pix_filtered = B;

    for i = 1:dd
        for j = 1:9
            base_pix{j}(:, :, i) = yuv_block(base_index{j} + (i - 1) * SIZE^2);
        end
    end
    for i = 1:dd
        % for j = 1:9
        %求均值
        base_pix_filtered(:, :, i) = (base_pix{1}(:, :, i) + base_pix{2}(:, :, i) + base_pix{3}(:, :, i) + base_pix{4}(:, :, i) + base_pix{5}(:, :, i) ...
            +base_pix{6}(:, :, i) + base_pix{7}(:, :, i) + base_pix{8}(:, :, i) + base_pix{9}(:, :, i)) / 9;
        dct_temp = dct2(base_pix_filtered(:, :, i) - 128);
        b4_enc_base_pix(:, :, i) = quantize(dct_temp, i);

        deQ_temp = dequantize(b4_enc_base_pix(:, :, i), i);
        dec_base_pix(:, :, i) = round(idct2(deQ_temp) + 128);
        % end
    end

    base_pix = base_pix{5};
end
