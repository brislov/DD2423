clear


tools = few256;
house = godthem256;


% % Sobel operator along x and y
% deltax = [-1 0 1; -2 0 2; -1 0 1];
% deltay = [-1 -2 -1; 0 0 0; 1 2 1];
% 
% dxtools = conv2(tools, deltax, 'valid');
% dytools = conv2(tools, deltay, 'valid');


% Question 1
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


% Question 2
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


% Question 3
% variance = [1 2 4];
% houses = {house, ...
%           discgaussfft(house, variance(1)), ...
%           discgaussfft(house, variance(2)), ...
%           discgaussfft(house, variance(3))};
% 
% figure(1)
% subplot(141)
% showgrey(houses{1})
% title('house')
% subplot(142)
% showgrey(houses{2})
% title(sprintf('w/ smoothing (v=%i)', variance(1)))
% subplot(143)
% showgrey(houses{3})
% title(sprintf('w/ smoothing (v=%i)', variance(2)))
% subplot(144)
% showgrey(houses{4})
% title(sprintf('w/ smoothing (v=%i)', variance(3)))
% 
% gradmagnhouses = {Lv(houses{1}), Lv(houses{2}), Lv(houses{3}), ...
%                   Lv(houses{4})};
% 
% figure(2)
% subplot(141)
% histogram(gradmagnhouses{1})
% title('gradmagnhouse')
% subplot(142)
% histogram(gradmagnhouses{2})
% title(sprintf('w/ smoothing (v=%i)', variance(1)))
% subplot(143)
% histogram(gradmagnhouses{3})
% title(sprintf('w/ smoothing (v=%i)', variance(2)))
% subplot(144)
% histogram(gradmagnhouses{4})
% title(sprintf('w/ smoothing (v=%i)', variance(3)))
% 
% figure(3)
% thresholds = [0.1 0.2 0.3] .* 10^5;       
% for i = 1 : length(gradmagnhouses)
%     for j = 1 : length(thresholds)
%         subplot(length(gradmagnhouses), length(thresholds), ...
%                 length(thresholds)*(i - 1) + j)
%         showgrey((gradmagnhouses{i} - thresholds(j)) > 0)
%         title(sprintf('t=%i', thresholds(j)))   
%     end  
% end


% Questions 4-6
% figure(1)
% scales = [0.0001 1.0 4.0 16.0 64.0];
% for i = 1 : length(scales)
%     subplot(2, 3, i)
%     contour(Lvvtilde(discgaussfft(house, scales(i)), 'same'), [0 0])
%     axis('image')
%     axis('ij')
%     title(sprintf('scale = %.4f', scales(i)))
% end
% 
% figure(2)
% for i = 1 : length(scales)
%     subplot(2, 3, i)
%     showgrey(Lvvvtilde(discgaussfft(house, scales(i)), 'same') < 0)
%     axis('image')
%     axis('ij')
%     title(sprintf('scale = %.4f', scales(i)))
% end 
% 
% figure(3)
% for i = 1 : length(scales)
%     subplot(2, 3, i)
%     showgrey(Lvvvtilde(discgaussfft(tools, scales(i)), 'same') < 0)
%     title(sprintf('scale = %.4f', scales(i)))
% end


% Question 7
% scales = [0.001 1.0 4.0 16.0 64.0];
% 
% figure(1)
% for i = 1 : length(scales)
%     subplot(1, length(scales), i)
%     overlaycurves(house, extractedge(house, scales(i), 2 * 10^3, 'same'))
%     title(sprintf('scale=%f',scales(i)))
% end
% 
% figure(2)
% for i = 1 : length(scales)
%     subplot(1, length(scales), i)
%     overlaycurves(tools, extractedge(tools, scales(i), 100, 'same'))
%     title(sprintf('scale=%f',scales(i)))
% end


% Questions 8-9
% img = binsubsample(binsubsample(houghtest256));
% scale = 1;
% threshold = 100;
% nlines = 4;
% 
% % img = houghtest256;
% % scale = 1;
% % threshold = 100;
% % nlines = 7;
% 
% % img = few256;
% % scale = 16;
% % threshold = 100;
% % nlines = 10;
% 
% % img = phonecalc256;
% % scale = 16;
% % threshold = 2*10^3;
% % nlines = 20;
% 
% % img = godthem256;
% % scale = 4;
% % threshold = 2*10^3;
% % nlines = 30;
% 
% nrho = 270;
% ntheta = 180;
% verbose = 0;
% 
% [linepar, acc] = houghedgeline(img, scale, threshold, nrho, ntheta, nlines, verbose);


% Question 9, computational time
% nvals = [100 200 300 400 500 600 700 800 900 1000];
% N = 3;
% avg_times = zeros(1, length(nvals));
% 
% for i = 1:length(nvals)
%     time = 0;
%     nrho = nvals(i);
%     ntheta = nvals(i);
%     for j = 1:N
%         tic
%         houghedgeline(img, scale, threshold, nrho, ntheta, nlines, verbose);
%         time = time + toc;
%     end
%     avg_times(i) = time/N;
% end
% 
% plot(nvals, avg_times, '-o')
% xlabel('value for nrho & ntheta')
% ylabel('duration [s]')
% title('Duration for nrho & ntheta values (nrho=ntheta)')
