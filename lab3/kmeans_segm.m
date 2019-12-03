function [segmentation, centers] = kmeans_segm(image, K, L, seed)

% Reshapes image into a two dimensional matrix along the columns (improve
% performance)
[nrows, ncols] = size(image, 1, 2);
image = double(reshape(image, [nrows*ncols 3]));


% The exact algorithm is as follows:
% 
%   1. Choose one center uniformly at random from among the data points.
%   2. For each data point x, compute D(x), the distance between x and the 
%      nearest center that has already been chosen.
%   3. Choose one new data point at random as a new center, using a 
%      weighted probability distribution where a point x is chosen with 
%      probability proportional to D(x)^2.
%   4. Repeat Steps 2 and 3 until k centers have been chosen.
%   5. Now that the initial centers have been chosen, proceed using 
%      standard k-means clustering.

rng(seed)
centers = zeros(K, 3);
centers(1, :) = image(randi(nrows*ncols));

for k = 2:K
    
    % compute distance between x and the closest centroid
    if k == 2
        D2 = pdist2(centers(1, :), image, 'squaredeuclidean');
    else
        D2 = min(pdist2(centers(1:k-1, :), image, 'squaredeuclidean'));
    end
    
    probs = D2 / sum(D2);
    cumprobs = cumsum(probs);
   
    t = rand();
    [~, I] = max(cumprobs >= t); % gives first index where this is true
    
    centers(k, :) = image(I, :);
end 


% Randomly initialize the K cluster centers
% centers2 = randi([0 255], [K 3]);


figure(1)
subplot(121)
plot3(image(:, 1), image(:, 2), image(:, 3), 'o')
subplot(122)
plot3(centers(:, 1), centers(:, 2), centers(:, 3), 'o')



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
    