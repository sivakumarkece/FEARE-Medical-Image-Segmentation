function FD = frechet_distance(seg, gt)
    % Frechet Distance
    seg_contour = bwboundaries(seg);
    gt_contour = bwboundaries(gt);
    if ~isempty(seg_contour) && ~isempty(gt_contour)
        FD = frechet_dist(seg_contour{1}, gt_contour{1});
    else
        FD = NaN;
    end
end
