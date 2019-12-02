function [segmentation, centers] = kmeans_segm(image, K, L, seed)

% Reshapes image into a two dimensional matrix along the columns (improve
% performance)
[nrows, ncols] = size(image, 1, 2);
image = double(reshape(image, [nrows*ncols 3]));

% Randomly initialize the K cluster centers
rng(seed);
centers = randi([0 255], [K 3]);

% Compute all distances between pixels and cluster centers
distances = pdist2(centers, image);

segmentation = zeros(nrows*ncols, 1);

% Iterate L times
for l = 1:L
    
    % Assign each pixel to the cluster center for which the distance is minimum    
    means = zeros(K, 3);
    for i = 1:nrows*ncols
        [~, k] = min(distances(:, i));
        segmentation(i) = k;
        
        % Add RGB values to calculate the mean
        means(k, :) = means(k, :) + image(i, :);
    end
    
    % Update cluster centers
    for k = 1:K
        centers(k, :) = means(k, :) / sum(segmentation == k);
    end
    
    % Recompute all distances between pixels and cluster centers
    distances = pdist2(centers, image);
    
end

% Reshapes back to old format
segmentation = reshape(segmentation, [nrows ncols]);
    