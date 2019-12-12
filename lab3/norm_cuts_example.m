clear


% I = imread('orange.jpg');
% colour_bandwidth = 18.0; % color bandwidth
% radius = 3;              % maximum neighbourhood distance
% ncuts_thresh = 0.06;     % cutting threshold
% min_area = 100;          % minimum area of segment
% max_depth = 7;           % maximum splitting depth
% scale_factor = 0.4;      % image downscale factor
% image_sigma = 2.0;       % image preblurring scale

I = imread('tiger1.jpg');
colour_bandwidth = 16.0;
radius = 7;
ncuts_thresh = 0.040;
min_area = 105; 
max_depth = 10;          
scale_factor = 0.4;      
image_sigma = 2.1;

% I = imread('tiger2.jpg');
% colour_bandwidth = 8.0;
% radius = 4;
% ncuts_thresh = 0.04;
% min_area = 100; 
% max_depth = 8;          
% scale_factor = 0.4;      
% image_sigma = 2.0;


I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
Inew = mean_segments(Iback, segm);
Iob = overlay_bounds(Iback, segm);


figure(7)
subplot(121)
imshow(Inew)
subplot(122)
imshow(Iob)
