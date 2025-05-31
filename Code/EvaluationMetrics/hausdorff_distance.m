function HD = hausdorff_distance(seg, gt)
    % Hausdorff Distance
    seg_contour = bwboundaries(seg);
    gt_contour = bwboundaries(gt);
    if ~isempty(seg_contour) && ~isempty(gt_contour)
        distances = pdist2(seg_contour{1}, gt_contour{1});
        HD = max([max(min(distances, [], 2)), max(min(distances, [], 1))]);
    else
        HD = NaN;
    end
end
