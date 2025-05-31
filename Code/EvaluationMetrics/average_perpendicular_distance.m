function APD = average_perpendicular_distance(seg, gt)
    % Average Perpendicular Distance
    seg_contour = bwboundaries(seg);
    gt_contour = bwboundaries(gt);
    if ~isempty(seg_contour) && ~isempty(gt_contour)
        distances = pdist2(seg_contour{1}, gt_contour{1});
        APD = mean(min(distances, [], 2));
    else
        APD = NaN;
    end
end
