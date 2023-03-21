  % Author: Amit Gurung
% Date: 13th August 2019
% This is part of the work for the paper "Image Segmentation using
% Multi-Threshold technique by Histogram Sampling"

% This script generates multiple threshold values


function [mythresholds] = OurAlgoThresholds(im, t)
%where im is the image and t is the required number of threshold values
%The function returns mythresholds: 1xt row-vector containing 't' number of
% threshold values

if (size(im,3) ~= 1)    % for color image size(im,3)==3
    imgry = rgb2gray(im);   %converting to grayscale
elseif (size(im,3) == 1)
    imgry = im;
end

mythreshold(1,t)=zeros();

%Deciding the right number of partitions or regions
% if (t <= 4)
%     r = 16;
% elseif (t>4 && t <= 8)
%     r = 32;
% elseif (t > 8 && t <= 10)
%     r = 64;
% elseif (t>10)
%     r = 128;
% end
if (t < 32)
    r = 32;
elseif (t > 32)
    r = 64;
elseif (t>64)
    r = 128;
end


%Step-1: Compute Histogram of the grey-scale Image
tic
[pixelCount, grayLevels] = imhist(imgry);
toc
%Pre-config for Step-2
setA(256,2)=zeros(1,1);  %256 rows and 2 cols [pixel-value,valley]
indx=0;
%decreasing=0; 
previousDecr=0;
%increasing=0; previousIncr=0;
%==================================
%Pre-config for Step-3
pix = 256/r; % Number of pixels per partition (2,4,8,16,32,64)
p=0;
s=pixelCount(1);
setB(r,1)=zeros(1);
%========================================
for i=grayLevels(1): grayLevels(256)    
    %Step-2: Determine Valley points in the Histogram
    if (i>0)
        if pixelCount(i+1) <= pixelCount(i)         
            decreasing=1;
            increasing=0;
        else
            increasing=1;
            decreasing=0;
        end    
        if (previousDecr ==1 && increasing==1 && i>2)   %there is a change
            indx = indx + 1;
            setA(indx,1) = i-1;
            setA(indx,2) = pixelCount(i);        
        end      
        previousDecr = decreasing;
    end    
    %Step-3: Determine Min-Frequency from each partitions
    if (mod(i,pix) == 0 && i ~= 255 )
        p=p+1;
        s = pixelCount(i+1);
    end     
    if (pixelCount(i+1)<= s)
        s = pixelCount(i+1); %Actual frequency
        setB(p,1) = i; %Actual Pixel-value
        setB(p,2) = s;
    end    
end
%Step-4: Compare and create setC with common points
a=1; b=1;
smallfit = r;
if (indx < smallfit)
    smallfit = indx;
end
setC(smallfit,2)=zeros(1,1);
in=0;
while (a<indx && b<r)
    if (setA(a,1) == setB(b,1))
        in = in +1;
        setC(in,1)=setA(a,1);
        setC(in,2)=setA(a,2);
        a=a+1; b=b+1;
    elseif (setA(a,1) < setB(b,1))
       a=a+1;
    elseif (setA(a,1) > setB(b,1))
       b=b+1;
    end
end


%Step-5: Apply multiple levels of filtering
%Now perform filtering from the candidate values in setC
%Criteria-1A (threshold values should be evenly distributed)
% if (t<10)
%     dist=10;
% else
%     dist=5;
% end
% setC1a(in,2)=zeros(1,1);
% f1=1; index1=0;
% while (f1 <= (in-1))
%     dist1 = setC(f1+1,1) - setC(f1,1);
%     if (dist1 <= dist)
%         dd='Add currect and Skip next point.';
%         index1 = index1 + 1;
%         setC1a(index1,1) = setC(f1,1);
%         setC1a(index1,2) = setC(f1,2);
%         f1 = f1+1; %the next f1++ will skip
%     else
%         index1 = index1 + 1;
%         setC1a(index1,1) = setC(f1,1);
%         setC1a(index1,2) = setC(f1,2);
%     end
%     f1 = f1 + 1;
% end
% %For the last missed out element
% index1 = index1 + 1;
% setC1a(index1,1) = setC(f1,1);
% setC1a(index1,2) = setC(f1,2);


%Step-5: Creating the Final List of threshold
mean(1,t)=zeros();
%[ro,col] = size(setC1a) %this will not hold the correct number
ro = in;
n = floor(ro/t);
sum=0; tn=n; tt=0; ind=0;count=0;
for i= 1 : ro %discarding the first
    sum = sum + setC(i,1);    
    count= count + 1;
    if (i==tn && tt==0)
        ind = ind +1;       
        mean(1,ind) = sum/count;
        sum=0; count=0; tn=n*(ind+1);
        if (i==((t-1)*n))
            tt=1;
            mythreshold(1,t) = setC(i+1,1);  %Last threshold take the first candidate value from the class
        end
    end
end
%if (t>2)  %
%    ind=ind+1;
%    mean(1,ind) = sum/(ro - (t-1)*n); %Last class will have more candidates
%end
%Finally, the best threshold will be setC1a(1,i) >= mean(1, i)
tindex= 1;
for i=1 : ro
   if (setC(i,1) >= mean(1,tindex))   %thresholds are taken as the immediate next of the mean from each class except the last threshold   
       mythreshold(1,tindex) = setC(i,1);
       if (t == 1) %to support global threshold
           break;
       end
       tindex= tindex + 1;       
   end
   if (tindex == t && t ~= 1)
       break;       
   end      
end
mythresholds = mythreshold;
end