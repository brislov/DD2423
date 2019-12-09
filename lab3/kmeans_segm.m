function [segmentation, centers] = kmeans_segm(image, K, L, seed, rshapefmt)

% Reshapes image into a two dimensional matrix for better performance
if ~exist('rshapefmt','var')
    [nrows, ncols] = size(image, 1, 2);
    image = double(reshape(image, [nrows*ncols 3]));
    N = nrows*ncols;
else
    N = length(image);
end


% Implementation k-means++ initialization as described on wikipedia:
%
% 1. Choose one center uniformly at random from among the data points.
rng(seed);
centers = zeros(K, 3);
centers(1, :) = image(randi(N));

for k = 2:K
    % 2. For each data point x, compute D(x), the distance between x and 
    % the nearest center that has already been chosen.
    if k == 2
        D2 = pdist2(centers(1, :), image, 'squaredeuclidean');
    else
        D2 = min(pdist2(centers(1:k-1, :), image, 'squaredeuclidean'));
    end
    
    % 3. Choose one new data point at random as a new center, using a 
    % weighted probability distribution where a point x is chosen with
    % probability proportional to D(x)^2.
    probs = D2 / sum(D2);
    cumprobs = cumsum(probs);
    t = rand();
    [~, I] = max(cumprobs >= t); % yields index of first value larger than t
    
    centers(k, :) = image(I, :);
    
    % 4. Repeat Steps 2 and 3 until k centers have been chosen.
end
% 5. Now that the initial centers have been chosen, proceed using standard 
% k-means clustering.

% Compute all distances between pixels and cluster centers
distances = pdist2(centers, image);

% Iterate L times
segmentation = zeros(N, 1);
for l = 1:L
    % Assign each pixel to the cluster center for which the distance is minimum    
    means = zeros(size(centers));
    for i = 1:N
        [~, k] = min(distances(:, i));
        segmentation(i) = k;
        
        % Sum RGB values to calculate the mean
        means(k, :) = means(k, :) + image(i, :);
    end
    
    % Update cluster centers
    for k = 1:K
        centers(k, :) = means(k, :) / sum(segmentation == k);
    end
    
    % Recompute all distances between pixels and cluster centers
    distances = pdist2(centers, image);
end

if ~exist('rshapefmt','var')
    % Reshapes back to old format
    segmentation = reshape(segmentation, [nrows ncols]);
end
end