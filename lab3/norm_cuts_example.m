% colour_bandwidth = 20.0; % color bandwidth
% radius = 3;              % maximum neighbourhood distance
% ncuts_thresh = 0.2;      % cutting threshold
% min_area = 200;          % minimum area of segment
% max_depth = 8;           % maximum splitting depth
% scale_factor = 0.4;      % image downscale factor
% image_sigma = 2.0;       % image preblurring scale

colour_bandwidth = 11.0;  % color bandwidth
radius = 5;              % maximum neighbourhood distance
ncuts_thresh = 0.2;      % cutting threshold
min_area = 150;          % minimum area of segment
max_depth = 4;           % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2.0;       % image preblurring scale

I = imread('tiger3.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
Inew = mean_segments(Iback, segm);
Iob = overlay_bounds(Iback, segm);
imwrite(Inew,'result/normcuts1.png')
imwrite(Iob,'result/normcuts2.png')

figure(2)
subplot(121)
imshow(Inew)
subplot(122)
imshow(Iob)
