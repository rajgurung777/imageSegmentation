function [thimg] = multiSegmentation(x,th) 
%where x is the image and th (1xn) containts the 'n' threshold values
%The function returns thimg: the segmented image

if (size(x,3) ~= 1)    % for color image size(im,3)==3
    I = rgb2gray(x);   %converting to grayscale
elseif (size(x,3) == 1)
    I = x;
end

[m,n] = size(I);
ddd=I;
[r,c]=size(th); % 1xcol where r=1
for i = 1 : m
    for j = 1 : n
        if (c==2)
            if (I(i,j) <= th(1))
                ddd(i,j) = I(i,j);
            end 
            if ((I(i,j) > th(1)) && (I(i,j) <= th(2)))
                ddd(i,j) = th(1);    
            end
            if (I(i,j) > th(2))
                ddd(i,j) = I(i,j);
            end                 
        elseif (c>2)
            if (I(i,j) <= th(1))
                ddd(i,j) = I(i,j);
            end                
            for x=2: (c-1)
                if ((I(i,j) > th(x-1)) && (I(i,j) <= th(x)))
                    ddd(i,j) = th(x-1);    
                end
            end        
            if (I(i,j) > th(c))
                ddd(i,j) = I(i,j);
            end        
        end
    end
end
%figure, imshow(I);  % I is the original grey-scale image
%figure, imshow(ddd); %ddd is the multi-threshold segmented image
%int = 0;
thimg = ddd;
end