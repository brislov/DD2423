function [segmentation, centers] = kmeans_segm(image, K, L, seed)
% K         number of cluster centers
% L         number of iterations


% Randomly initialize the K cluster centers
rng(seed);
centers = zeros(K, 3);
for k = 1:K
    centers(k, 1:3) = randi([0 255], 1, 3);
end


% Compute all distances between pixels and cluster centers
distances = zeros(size(image, 1), size(image, 2), K);
for i = 1:size(image, 1)
    for j = 1:size(image, 2)
        pixel = image(i, j, :);
        pixel = double(transpose(pixel(:)));
        for k = 1:K
            distances(i, j, k) = pdist2(centers(k, :), pixel);
        end   
    end
end


% Iterate L times
for n = 1:L
    
    
    % Assign each pixel to the cluster center for which the distance is minimum
    segmentation = zeros(size(image, 1, 2));
    for i = 1:size(image, 1)
        for j = 1:size(image, 2)
            [~, k_index] = min(distances(i, j, :));
            segmentation(i, j) = k_index;
        end
    end
    
    % Recompute each cluster center by taking the mean of all pixels assigned to it
    for k = 1:K
        t = 1;
        for i = 1:size(image, 1)
            for j = 1:size(image, 2)
                if k == segmentation(i, j)
                    t = t + 1;
                    rgb = image(i, j, :);
                    rgb = double(transpose(rgb(:)));
                    centers(k, :) = centers(k, :) + rgb;
                end
            end
        end
        centers(k, :) = centers(k, :) / t; % get new center
    end
    
    
    % Recompute all distances between pixels and cluster centers
    for i = 1:size(image, 1)
        for j = 1:size(image, 2)
            pixel = image(i, j, :);
            pixel = double(transpose(pixel(:)));
            for k = 1:K
                distances(i, j, k) = pdist2(centers(k, :), pixel);
            end
        end
    end
    
    
end
