function IoU = jaccard(seg, gt)
    % Intersection over Union
    intersection = nnz(seg & gt);
    union = nnz(seg | gt);
    IoU = intersection / union;
end
