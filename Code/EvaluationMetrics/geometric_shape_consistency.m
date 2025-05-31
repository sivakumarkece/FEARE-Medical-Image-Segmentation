function geometric_shape_metrics = geometric_shape_consistency(seg, gt)
    % Geometric Shape Metrics
    seg_contour = bwboundaries(seg);
    gt_contour = bwboundaries(gt);
    if ~isempty(seg_contour) && ~isempty(gt_contour)
        n_points = min(size(seg_contour{1}, 1), size(gt_contour{1}, 1));
        seg_contour_resized = seg_contour{1}(1:n_points, :);
        gt_contour_resized = gt_contour{1}(1:n_points, :);
        geometric_shape_metrics = mean(abs(seg_contour_resized(:) - gt_contour_resized(:)));
    else
        geometric_shape_metrics = NaN;
    end
end
