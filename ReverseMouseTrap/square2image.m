function [ image ] = square2image( tagMat, squareSize)
%SQUARE2IMAGE Summary of this function goes here
%   Detailed explanation goes here

[x,y]=size(tagMat);
image=uint8(zeros(x*squareSize,y*squareSize,3));
% for each square
for i=1:x
    for j=1:y
        % get its range in image
        [rangeX,rangeY]=square2pixel([i,j],squareSize);
        % change all pixel's RGB to tag color;
        image=setPixelColor(image,tagMat(i,j),rangeX,rangeY);
    end
end
end

