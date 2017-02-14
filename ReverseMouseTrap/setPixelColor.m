function [ image ] = setPixelColor( image,colorTag,rangeX,rangeY )
%SETPIXELCOLOR Summary of this function goes here
%   Detailed explanation goes here

% color tag:
% 1:yellow [255,255,0]
% 2:blue [0,0,255]
% 3:green [0,255,0]
% 4:black [0,0,0]
% 5:white [255,255,255]

if colorTag==1
    for i=rangeX(1):rangeX(2)
        for j=rangeY(1):rangeY(2)
            image(i,j,1)=255;
            image(i,j,2)=255;
            image(i,j,3)=0;
        end
    end
elseif colorTag==2
    for i=rangeX(1):rangeX(2)
        for j=rangeY(1):rangeY(2)
            image(i,j,1)=0;
            image(i,j,2)=0;
            image(i,j,3)=255;
        end
    end
elseif colorTag==3
    for i=rangeX(1):rangeX(2)
        for j=rangeY(1):rangeY(2)
            image(i,j,1)=0;
            image(i,j,2)=255;
            image(i,j,3)=0;
        end
    end
elseif colorTag==4
    for i=rangeX(1):rangeX(2)
        for j=rangeY(1):rangeY(2)
            image(i,j,1)=0;
            image(i,j,2)=0;
            image(i,j,3)=0;
        end
    end
elseif colorTag==5
    for i=rangeX(1):rangeX(2)
        for j=rangeY(1):rangeY(2)
            image(i,j,1)=255;
            image(i,j,2)=255;
            image(i,j,3)=255;
        end
    end
end
end

