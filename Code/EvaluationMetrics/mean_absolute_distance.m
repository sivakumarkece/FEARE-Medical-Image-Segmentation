function MAD = mean_absolute_distance(seg, gt)
    % Mean Absolute Distance
    seg_centroid = regionprops(seg, 'Centroid');
    gt_centroid = regionprops(gt, 'Centroid');
    if ~isempty(seg_centroid) && ~isempty(gt_centroid)
        MAD = sqrt(sum((seg_centroid.Centroid - gt_centroid.Centroid) .^ 2));
    else
        MAD = NaN;
    end
end
