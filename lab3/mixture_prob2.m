function prob = mixture_prob(image, K, L, mask)


% Dimensions of the input image
[imheight, imwidth, imdepth] = size(image);
if (imdepth~=3)
    error('Image must have depth=3, RGB')
end
N = imheight*imwidth;

% 1. Let I be a set of pixels and V be a set of K Gaussian components in 3D (R,G,B).
% Reshape image and mask
Ivec = reshape(im2double(image), N, imdepth);
Mvec = reshape(mask, N, 1);
w = zeros(1, K);

Sigma = cell(K,1);

% 2. Store all pixels for which mask=1 in a Nx3 matrix
Imasked = Ivec(Mvec == 1, :);

% 3. Randomly initialize the K components using masked pixels
[segmentation, centers] = kmeans_segm(Imasked, K, L, 14, true);
for k = 1 : K
    w(k) = sum(segmentation == k) / size(segmentation, 1);
%     Sigma(k) = {rand*eye(imdepth)};
end
g = zeros(size(Imasked, 1), K);
p = zeros(size(Imasked, 1), K);
Sigma(:) = {rand*eye(imdepth)};

% 4. Iterate L times
for iter = 1:1
    % 4.1. Expectation: Compute probabilities P_ik using masked pixels
    for k = 1:K
        mu_k = centers(k, :);
        Sigma_k = Sigma{k};
        diff_k = bsxfun(@minus, Imasked, mu_k);
        g(:, k) = 1 / sqrt((2 * pi)^3 * det(Sigma_k)) * exp(-(1/2) * sum((diff_k / Sigma_k .* diff_k), 2));
    end
    p = bsxfun(@times, g, w);
    normfactor = sum(p, 2);
    p = bsxfun(@rdivide, p, normfactor);
    
    % 4.2. Maximization: Update weights, means and covariances using masked pixels
    w = sum(p, 1) / size(p, 1);
    for k = 1 : K
        psum_k = sum(p(:, k), 1);
        centers(k, :) = (p(:, k)' * Imasked) / psum_k;
        diff_k = bsxfun(@minus, Imasked, centers(k, :));
%         Sigma{k} = sum((p(:, k)*(diff_k*diff_k')), 1) / psum(k);
        Sigma{k} = (diff_k' * bsxfun(@times, diff_k, p(:, k))) / psum_k;
    end
end
% 5. Compute probabilities p(c_i) in Eq.(3) for all pixels I.
gfinal = zeros(N, K);
for k = 1 : K
    mu_k = centers(k, :);
    diff_k = bsxfun(@minus, Ivec, mu_k);
    gfinal(:, k) = 1 / sqrt((2 * pi)^3 * det(Sigma{k})) * exp(-(1/2) * sum((diff_k / Sigma{k} .* diff_k), 2));
end

probvec = sum(bsxfun(@times, gfinal, w), 2);
prob = reshape(probvec, imheight, imwidth, 1);

end

