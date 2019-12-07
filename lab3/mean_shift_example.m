scale_factor = 0.5;       % image downscale factor
spatial_bandwidth = 8.0; % spatial bandwidth
colour_bandwidth = 5.0;   % colour bandwidth
num_iterations = 40;      % number of mean-shift iterations
image_sigma = 1.0;        % image preblurring scale

I = imread('tiger3.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

% segm = mean_shift_segm(I, spatial_bandwidth, colour_bandwidth, num_iterations);
% Inew = mean_segments(Iback, segm);
% I = overlay_bounds(Iback, segm);
% imwrite(Inew,'result/meanshift1.png')
% imwrite(I,'result/meanshift2.png')
% subplot(1,2,1); imshow(Inew);
% subplot(1,2,2); imshow(I);

N = 5;
SBs = [4 6 4 6];
CBs = [4 4 6 6];

for n = 1:N
    segm = mean_shift_segm(I, SBs(n), CBs(n), num_iterations);
    Inew = mean_segments(Iback, segm);
    Iob = overlay_bounds(Iback, segm);
    
    supt = suptitle(sprintf('spatial bandwidth=%.1f, colour bandwidth=%.1f', SBs(n), CBs(n)));

    subplot(121)
    imshow(Inew)
    subplot(122)
    imshow(Iob)
    
    waitforbuttonpress
end

