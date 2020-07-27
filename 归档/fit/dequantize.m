function outputData = dequantize(in, color_num)
    % TODO: 4*4块的量化矩阵可以试着对比一下8*8DCT时的基函数, 应该有对应上的16个, 把他们的对应位置的量化值取出来
    global quantLumMatrix;
    global quantChromMatrix;
    L = numel(in);
    switch L
        case 16
            QLumtemp = reshape(quantLumMatrix, 8, 8)';
            QChromtemp = reshape(quantChromMatrix, 8, 8)';
            index4x4 = [[1:2:8]', [1:2:8]' + 16, [1:2:8]' + 32, [1:2:8]' + 48];
            QLumMat = QLumtemp(index4x4);
            QChromMat = QChromtemp(index4x4);
        case 64
            QLumMat = reshape(quantLumMatrix, 8, 8)';
            QChromMat = reshape(quantChromMatrix, 8, 8)';
    end

    if (color_num == 1)
        outputData = round(in .* QLumMat);
    elseif (color_num == 2 || color_num == 3)
        outputData = round(in .* QChromMat);
    end

    % % global divLumMatrix;
    % % global divChromMatrix;
    % global quantLumMatrix;
    % global quantChromMatrix;

    % if strcmp(code, 'lum')
    %     t = round(in .*  quantLumMatrix);
    %     outputData = reshape(t, 8, 8)';
    % elseif strcmp(code, 'chrom')
    %     t = round(in .*  quantChromMatrix);
    %     outputData = reshape(t, 8, 8)';
    % end

    % out = outputData;
end
