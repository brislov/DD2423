clear
% REMINDER!
% Reporting: When reporting this lab emphasis is placed on understanding 
% how the algorithms work(in general), the strengths and weaknesses of the 
% tested segmentation methods and to what extentand how they exploit 
% spatial similarities for segmentation.Reporting:When reporting this lab 
% emphasis is placed on understanding how the algorithms work(in general), 
% the strengths and weaknesses of the tested segmentation methods and to 
% what extentand how they exploit spatial similarities for segmentation.

% functions of interest:
% imread()
% imwrite()
% imresize()

% useful functions: imread(), imwrite(), imresize(), p2dist()

I = imread('test3x3.jpg');

[segmentation, centers] = kmeans_segm(I, 3, 0, 0);





