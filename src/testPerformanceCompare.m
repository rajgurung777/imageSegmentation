% Author: Amit Gurung
% Date: 13th August 2019
% This is part of the work for the paper "Image Segmentation using
% Multi-Threshold technique by Histogram Sampling"

% This script prints the running time of Otsu's Method and our approach.


clear

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

t=5 %Chose the number of threshold values

if (size(x,3) ~= 1)    % for color image size(im,3)==3
    I = rgb2gray(x);   %converting to grayscale
elseif (size(x,3) == 1)
    I = x;
end
n=10; tsum=0;
for i=1:n
    tic
    thOtsu = multithresh(x,t);  %Otsu's Multi-threshold techinque
    OtsuTime = toc;
    tsum = tsum + OtsuTime;
end
OtsuAgv = tsum/n
%msg='Time Taken by Otsu = '

tsum=0;
for i=1:n
    tic
    thOur = OurAlgoThresholds(x,t);
    OurTime = toc;
    tsum = tsum + OurTime;
end
OurAgv = tsum/n
%msg='Time Taken by Our approach = '

