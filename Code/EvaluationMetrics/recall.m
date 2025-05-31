function Recall = recall(seg, gt)
    % Recall calculation
    true_positives = nnz(seg & gt);
    false_negatives = nnz(~seg & gt);
    Recall = true_positives / (true_positives + false_negatives);
end
