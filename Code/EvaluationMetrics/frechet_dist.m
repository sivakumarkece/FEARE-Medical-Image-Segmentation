function dist = frechet_dist(P, Q)
    % Implementation of Frechet Distance
    n = size(P, 1);
    m = size(Q, 1);
    ca = -ones(n, m);
    ca(1, 1) = norm(P(1, :) - Q(1, :));
    for i = 2:n
        ca(i, 1) = max(ca(i-1, 1), norm(P(i, :) - Q(1, :)));
    end
    for j = 2:m
        ca(1, j) = max(ca(1, j-1), norm(P(1, :) - Q(j, :)));
    end
    for i = 2:n
        for j = 2:m
            ca(i, j) = max(min([ca(i-1, j), ca(i-1, j-1), ca(i, j-1)]), norm(P(i, :) - Q(j, :)));
        end
    end
    dist = ca(n, m);
end
