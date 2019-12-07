clear

n = 1;
for n = [5];

K = 5;               % number of clusters used
L = 3;               % number of iterations
seed = 14;           % seed used for random initialization
scale_factor = 1.0;  % image downscale factor
image_sigma = 10.0;   % image preblurring scale

% I = imread('orange.jpg');
I = imread('tiger1.jpg');
% I = imread('tiger2.jpg');
% I = imread('tiger3.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

tic
[ segm, centers ] = kmeans_segm(I, K, L, seed);
toc
Inew = mean_segments(Iback, segm);
Iob = overlay_bounds(Iback, segm);
imwrite(Inew,'result/kmeans1.png')
imwrite(Iob,'result/kmeans2.png')



% Question 2
figure(1)
supt = suptitle(sprintf('K=%i, L=%i, seed=%i, scale=%.1f, sigma=%.1f', K, L, seed, scale_factor, image_sigma));
set(supt, 'fontsize', 12)
subplot(121)
imshow(Inew)
subplot(122)
imshow(Iob)
n = n + 1;
waitforbuttonpress
end
