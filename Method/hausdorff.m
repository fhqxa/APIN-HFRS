function [dH] = hausdorff( A, B) 
if(size(A,2) ~= size(B,2)) 
    fprintf( 'WARNING: dimensionality must be the same\n' ); 
    dH = []; 
    return; 
end
%dH = max(compute_dist(A, B), compute_dist(B, A));
dH=compute_dist(A, B);
end
%% Compute distance
function[dist] = compute_dist(A, B) 
m = size(A, 1); 
n = size(B, 1); 
dim= size(A, 2); 
for k = 1:m 
    C = ones(n, 1) * A(k, :); 
    D = (C-B).* (C-B); 
    D = sqrt(D * ones(dim,1)); 
    dist(k) = min(D); 
end
dist = mean(dist);
end