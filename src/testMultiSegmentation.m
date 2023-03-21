% Author: Amit Gurung
% Date: 13th August 2019
% This is part of the work for the paper "Image Segmentation using
% Multi-Threshold technique by Histogram Sampling"

% This script generates the threshold values using our approach and by Otsu's Method inbuilt in MATLAB.
% This script all calls functions to compute PSNR, SSIM and FeatureSIM. The
% first two functions are built in MATLAB (Version 2014 and above), whereas
% the FeatureSIM is attached here.

clear

%Tested
x = imread('Benchmarks/lenaColor.png');
%x = imread('Benchmarks/cameraman.tif');
%x = imread('Benchmarks/hunter.tif');
%x = imread('Benchmarks/baboon.png');
%x = imread('Benchmarks/fruits.png');
%x = imread('Benchmarks/mountain.png');
%x = imread('Benchmarks/airplane.png');
%x = imread('Benchmarks/boat.png');
%x = imread('Benchmarks/101_1.tif');
%x = imread('Benchmarks/105_2.tif');  
%x = imread('Benchmarks/zelda.png'); 
%x = imread('Benchmarks/franzjosef_ast_2011228_lrg.jpg'); 


t=2; %Chose the number of threshold values


if (size(x,3) ~= 1)    % for color image size(im,3)==3
    I = rgb2gray(x);   %converting to grayscale
elseif (size(x,3) == 1)
    I = x;
end


th = multithresh(x,t);  %Otsu's Multi-threshold techinque
th
otsuSegmented = multiSegmentation(x,th);

th = OurAlgoThresholds(x,t);
th
ourSegmented = multiSegmentation(x,th);


figure, imshow(I);  % I is the original grey-scale image
%title('Original Image');

figure, imshow(otsuSegmented); %ddd is the multi-threshold segmented image
%title('Image Segmented using Otsu');

figure, imshow(ourSegmented); %ddd is the multi-threshold segmented image
%title('Image Segmented using Our Algorithm');

%pnsr(segmentedImage, ReferenceImage)
otsuPSNR = psnr(otsuSegmented,I)
ourPSNR = psnr(ourSegmented,I)

otsuSSIM = ssim(otsuSegmented, I)
ourSSIM = ssim(ourSegmented, I)

otsuFSIM = FeatureSIM(I, otsuSegmented)
ourFSIM = FeatureSIM(I, ourSegmented)

