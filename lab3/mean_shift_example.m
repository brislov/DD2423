clear


scale_factor = 0.5;       % image downscale factor
spatial_bandwidth = 10.0;  % spatial bandwidth
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

% N = 5;
% SBs = [4 6 4 6];
% CBs = [4 4 6 6];
% 
% for n = 1:N
%     segm = mean_shift_segm(I, SBs(n), CBs(n), num_iterations);
%     Inew = mean_segments(Iback, segm);
%     Iob = overlay_bounds(Iback, segm);
%     
%     supt = suptitle(sprintf('spatial bandwidth=%.1f, colour bandwidth=%.1f', SBs(n), CBs(n)));
% 
%     subplot(121)
%     imshow(Inew)
%     subplot(122)
%     imshow(Iob)
%     
%     waitforbuttonpress
% end



% % Questions 5
% SBs = [4 12 20];
% for n = 1:length(SBs)
%     [Inew, Iob] = foo(I, SBs(n), colour_bandwidth, num_iterations);
%     subplot(length(SBs), 2, 2*n - 1)
%     imshow(Inew)
%     title(sprintf('spatial-bw=%i', SBs(n)))
%     subplot(length(SBs), 2, 2*n)
%     imshow(Iob)
% end
% h = suptitle(sprintf('scale=%.1f, colour-bw=%i, iterations=%i, sigma=%.1f', scale_factor, colour_bandwidth, num_iterations, image_sigma));
% set(h, 'FontSize', 12)

% CBs = [4 12 20];
% for n = 1:length(CBs)
%     [Inew, Iob] = foo(I, spatial_bandwidth, CBs(n), num_iterations);
%     subplot(length(CBs), 2, 2*n - 1)
%     imshow(Inew)
%     title(sprintf('colour-bw=%i', CBs(n)))
%     subplot(length(CBs), 2, 2*n)
%     imshow(Iob)
% end
% h = suptitle(sprintf('scale=%.1f, spatial-bw=%i, iterations=%i, sigma=%.1f', scale_factor, spatial_bandwidth, num_iterations, image_sigma));
% set(h, 'FontSize', 12)
    
    
function [Inew, Iob] = foo(I, spatial_bandwidth, colour_bandwidth, num_iterations)
segm = mean_shift_segm(I, spatial_bandwidth, colour_bandwidth, num_iterations);
Iback = I;
Inew = mean_segments(Iback, segm);
Iob = overlay_bounds(Iback, segm);
end