function prob = mixture_prob(image, K, L, mask)

[height, width] = size(image, 1, 2);
Ivec = reshape(im2double(image), height*width, 3);
Mvec = reshape(mask, height*width, 1);


% 1. Store all pixels for which mask=1 in a Nx3 matrix
Imsk = Ivec(Mvec == 1, :);


% 2. Randomly initialize the K components using masked pixels
[segm, centers] = kmeans_segm(Imsk, K, 1, 14, true);

w = sum(segm == 1:K) / length(Imsk);

cov = cell(K, 1);
cov(:) = {eye(3)*10}; % use random number instead of 10? 


% 3. Iterate L times
wg = zeros(length(Imsk), K);
prob = zeros(length(Imsk), K);
for l = 1:L

    % 4. Expectation: Compute probabilities P_ik using masked pixels
    for k = 1:K
        wg(:, k) = w(k) * mvnpdf(Imsk, centers(k, :), cov{k});
    end
    for k = 1:K
        prob(:, k) = wg(:, k) ./ sum(wg, 2);
    end
    
    
    % 5. Maximization: Update weights, means and covariances using masked pixels
    w = sum(prob) / length(Imsk);
    for k = 1:K
        norm = sum(prob(:, k));
        centers(k, :) = prob(:, k)' * Imsk / norm;

        diff = Imsk - centers(k, :);
        top = diff' *(diff .* repmat(prob(:,k),[1 3]));
        cov{k} = top / norm;
    end
end


% 6. Compute probabilities p(c_i) in Eq.(3) for all pixels I
wg = zeros(length(Ivec), K);
for k = 1:K
    wg(:, k) = w(k) * mvnpdf(Ivec, centers(k, :), cov{k});
end
prob = sum(wg, 2);

prob = reshape(prob, height, width, 1);
end
