function DSC = dice(seg, gt)
    % Dice Similarity Coefficient
    intersection = nnz(seg & gt);
    DSC = 2 * intersection / (nnz(seg) + nnz(gt));
end
