clear

% % Question 1
% K = 8;               % number of clusters used
% L = 10;              % number of iterations
% seed = 14;           % seed used for random initialization
% scale_factor = 1.0;  % image downscale factor
% image_sigma = 1.0;   % image preblurring scale

% % Question 2
% K = 9;               % number of clusters used
% seed = 14;           % seed used for random initialization
% scale_factor = 1.0;  % image downscale factor
% image_sigma = 1.0;   % image preblurring scale

% % Question 3
% K = 5;               % number of clusters used
% seed = 14;           % seed used for random initialization
% scale_factor = 1.0;  % image downscale factor
% image_sigma = 1.0;   % image preblurring scale

% % Question 3
% K = 5;               % number of clusters used
% seed = 14;           % seed used for random initialization
% scale_factor = 1.0;  % image downscale factor
% image_sigma = 1.0;   % image preblurring scale

% % Question 4
% K = 8;               % number of clusters used
% L = 10;              % number of iterations
% seed = 14;           % seed used for random initialization
% scale_factor = 1.0;  % image downscale factor
% image_sigma = 6.0;   % image preblurring scale


% I = imread('orange.jpg');
% I = imread('tiger1.jpg');
% I = imread('tiger2.jpg');
I = imread('tiger3.jpg');
I = imresize(I, scale_factor);
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);


% % Question 1
% figure(1)
% [Inew, Iob] = foo(I, K, L, seed);
% subplot(121)
% myscatter3(I, true)
% subplot(122)
% myscatter3(Inew, true)


% % Question 2
% figure(2)
% L = [1 10];
% for n = 1:length(L)
%     [Inew, ~] = foo(I, K, L(n), seed);
%     subplot(1, length(L), n)
%     imshow(Inew)
%     title(sprintf('L=%i', L(n)))
% end
% h = suptitle(sprintf('K=%i, seed=%i, scale=%.1f, sigma=%.1f', K, seed, scale_factor, image_sigma));
% set(h, 'FontSize', 12)


% % Question 3
% figure(3)
% L = [1 2 3 4 5];
% for n = 1:length(L)
%     [Inew, Iob] = foo(I, K, L(n), seed);
%     subplot(length(L), 2, 2*n - 1)
%     imshow(Inew)
%     title(sprintf('L=%i', L(n)))
%     subplot(length(L), 2, 2*n)
%     imshow(Iob)
% end
% h = suptitle(sprintf('K=%i, seed=%i, scale=%.1f, sigma=%.1f', K, seed, scale_factor, image_sigma));
% set(h, 'FontSize', 12)


% % Question 4
% figure(4)
% [Inew, Iob] = foo(I, K, L, seed);
% subplot(121)
% imshow(Inew)
% subplot(122)
% imshow(Iob)
% h = suptitle(sprintf('K=%i, L=%i, seed=%i, scale=%.1f, sigma=%.1f', K, L, seed, scale_factor, image_sigma));
% set(h, 'FontSize', 12)


function [Inew, Iob] = foo(I, K, L, seed)
tic
[segm, ~] = kmeans_segm(I, K, L, seed);
toc
Iback = I;
Inew = mean_segments(Iback, segm);
Iob = overlay_bounds(Iback, segm);
end
