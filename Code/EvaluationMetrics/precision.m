function Precision = precision(seg, gt)
    % Precision calculation
    true_positives = nnz(seg & gt);
    false_positives = nnz(seg & ~gt);
    Precision = true_positives / (true_positives + false_positives);
end
