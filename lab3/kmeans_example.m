clear

K = 4;               % number of clusters used
L = 10;              % number of iterations
seed = 14;           % seed used for random initialization
scale_factor = 1.0;  % image downscale factor
image_sigma = 1.0;   % image preblurring scale

% I = imread('orange.jpg');
% I = imread('tiger1.jpg');
% I = imread('tiger2.jpg');
% I = imread('tiger3.jpg');
% I = imread('nissan.jpg');
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

figure(1)
subplot(131)
imshow(I)
subplot(132)
imshow(Inew)
subplot(133)
imshow(Iob)

figure(2)
subplot(121)
myscatter3(I, true)
subplot(122)
myscatter3(Inew, true)

figure(3)
myscatter3(I, true)
set(gca,'visible','off')