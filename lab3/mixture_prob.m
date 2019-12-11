function prob = mixture_prob(image, K, L, mask)
% Let I be a set of pixels and V be a set of K Gaussian components in 3D (R,G,B).
% Store all pixels for which mask=1 in a Nx3 matrix
% Randomly initialize the K components using masked pixels
% Iterate L times
%   Expectation: Compute probabilities P_ik using masked pixels
%   Maximization: Update weights, means and covariances using masked pixels
% Compute probabilities p(c_i) in Eq.(3) for all pixels I.


[height, width] = size(image, 1, 2);
Ivec = single(reshape(image, height*width, 3));
Mvec = single(reshape(mask, height*width, 1));


% Store all pixels for which mask=1 in a Nx3 matrix
Ivec = Ivec(Mvec == 1, :);


% Randomly initialize the K components using masked pixels
[segm, centers] = kmeans_segm(Ivec, K, 1, 14, true);

w = transpose(sum(segm == 1:K) / length(Ivec));

mu = centers;

cov = cell(K, 1);
for k = 1:K
    cov{k} = eye(3)*10;
end


% ---


P  = zeros(length(Ivec), K);

% Expectation: Compute probabilities P_ik using masked pixels
for i = 1:length(Ivec)
    c_i = Ivec(i);
    
    for k = 1:K
        
        % denominator
        d_sum = 0; 
        for j = 1 :K
            d_sum = d_sum + w(j) * 1/sqrt((2*pi)^3 * norm(cov{j})) * exp(-1/2*(c_i - mu(j)) * cov{j}^-1 * (c_i - mu(j)));
        end
        
        P(i, k) = w(k) * 1/sqrt((2*pi)^3 * norm(cov{k})) * exp(-1/2*(c_i - mu(k)) * cov{k}^-1 * (c_i - mu(k))) ...
            / d_sum;
    end 
end


bp

% f[x_]:= k*x + m
