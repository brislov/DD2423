function [segmentation, centers] = kmeans_segm(image, K, L, seed)

% K         number of cluster centers
% L         number of iterations
% seed      for initializing randomization

% To compute pair-wise differences there is a convenientMatlabfunction, 
% pdist2, that can be used.

% Let X be a set of pixels and V be a set of K cluster centers in 3D (R,G,B).



% Randomly initialize the K cluster centers
centers = zeros(K, 3);
for k = 1:K
    centers(k, 1:3) = unidrnd(255, 1, 3);
end


% Compute all distances between pixels and cluster centers
% todo: improve this
distances = zeros(K, size(image, 1), size(image, 2));
for k = 1:K
    for i = 1:size(image, 1)
        for j = 1:size(image, 2)
            pixel = image(i, j, :);
            pixel = double(transpose(pixel(:)));
            distances(k, i, j) = pdist2(centers(k, :), pixel);
        end
    end
end


%  Iterate L times
%     Assign each pixel to the cluster center for which the distance is minimum
%     Recompute each cluster center by taking the mean of all pixels assigned to it
%     Recompute all distances between pixels and cluster centers


segmentation = 0; % remove
