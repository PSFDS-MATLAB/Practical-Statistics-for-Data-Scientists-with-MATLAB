function mean_diff = perm_func(x, n1, n2)
    n = n1 + n2;
    perm_ind = randperm(n);
    idx_a = perm_ind(1:n1);
    idx_b = perm_ind(n1+1:n);
    
    mean_diff = mean(x(idx_b)) - mean(x(idx_a));
end

