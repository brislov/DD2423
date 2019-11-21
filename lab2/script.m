clear


% 1 Difference operators

% Sobel operator along x and y
% deltax = [-1 0 1; -2 0 2; -1 0 1];
% deltay = [-1 -2 -1; 0 0 0; 1 2 1];
% 
tools = few256;
% dxtools = conv2(tools, deltax, 'valid');
% dytools = conv2(tools, deltay, 'valid');

% q1 start
% figure(1)
% showgrey(tools)
% title('tools')
% 
% figure(2)
% subplot(121)
% showgrey(dxtools)
% title('dxtools')
% subplot(122)
% showgrey(dytools)
% title('dytools')
% 
% size(tools)
% size(dxtools)
% size(dytools)
% q1 end


% 2 Point-wise thresholding of gradient magnitudes

% q2-3 part 1
% gradmagntools = sqrt(dxtools.^2 + dytools.^2);
% 
% figure(1)
% showgrey(gradmagntools)
% title('gradmagntools')
% 
% figure(2)
% histogram(gradmagntools)
% title('gradmagntools')
% 
% figure(3)
% thresholds = [50 100 150 200];
% for i = 1:length(thresholds)
%     subplot(1, length(thresholds), i)
%     showgrey((gradmagntools - thresholds(i)) > 0)
%     title(sprintf('t = %i', thresholds(i)))
% end

% q2-3 part 2
% img = godthem256;
% imgblur = discgaussfft(img, 1);
% 
% figure(1)
% subplot(121)
% showgrey(img)
% title('Original image')
% subplot(122)
% showgrey(imgblur)
% title('w/ Gaussian blur')
% 
% gradmagnimg = Lv(img, 'valid');
% gradmagnimgblur = Lv(imgblur, 'valid');
% 
% figure(2)
% subplot(121)
% histogram(gradmagnimg)
% title('Gradient magnitude')
% subplot(122)
% histogram(gradmagnimgblur)
% title('w/ Gaussian blur')
% 
% figure(3)
% thresholds = [0.25 0.5 0.75] .* 10^5;
% for i = 1:length(thresholds)
%     subplot(1, length(thresholds), i)
%     showgrey((gradmagnimg - thresholds(i)) > 0)
%     title(sprintf('t = %i', thresholds(i)))
% end
% 
% figure(4)
% thresholds = [0.1 0.3 0.5] .* 10^5;
% for i = 1:length(thresholds)
%     subplot(1, length(thresholds), i)
%     showgrey((gradmagnimgblur - thresholds(i)) > 0)
%     title(sprintf('t = %i', thresholds(i)))
% end

% ???
% [x, y] = meshgrid(-5:5, -5:5);
% 
% Dx = [-1/2 0 1/2];
% Dy = [-1/2; 0; 1/2];
% 
% Dxx = [1 -2 1];
% Dxy = filter2(Dx, Dy, 'same');
% Dyy = [1; -2; 1];
% 
% Dxxx = filter2(Dx, Dxx, 'same');
% Dxxy = filter2(Dxx, Dy, 'same');
% 
% filter2(Dxxx, x.^3, 'valid')
% filter2(Dxx, x.^3, 'valid')
% filter2(Dxxy, x.^2.*y, 'valid')

house = godthem256;

figure(1)
scales = [0.0001 1.0 4.0 16.0 64.0];
for i = 1 : length(scales)
    subplot(2, 3, i)
    contour(Lvvtilde(discgaussfft(house, scales(i)), 'same'), [0 0])
    axis('image')
    axis('ij')
    title(sprintf('scale = %f', scales(i)))
end 

figure(2)
for i = 1 : length(scales)
    subplot(2, 3, i)
    contour(Lvvvtilde(discgaussfft(house, scales(i)), 'same'), [0 0])
    axis('image')
    axis('ij')
    title(sprintf('scale = %f', scales(i)))
end 

figure(3)
for i = 1 : length(scales)
    subplot(2, 3, i)
    showgrey(Lvvvtilde(discgaussfft(tools, scales(i)), 'same') < 0)
    axis('image')
    axis('ij')
    title(sprintf('scale = %f', scales(i)))
end 
