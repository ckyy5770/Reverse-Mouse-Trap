function [  ] = drawShape( shapeInfo, originalImg)
%DRAWSHAPE Summary of this function goes here
%   Detailed explanation goes here
if shapeInfo(2)==1
    % circle
    imshow(originalImg);
    hold on
    viscircles([shapeInfo(3),shapeInfo(4)],shapeInfo(8));
    hold off
elseif shapeInfo(2)==2
    % rectangle
    drawRectangleonImageAtAngle_1(originalImg,[shapeInfo(3);shapeInfo(4)],shapeInfo(5), shapeInfo(6),shapeInfo(7));
else
    % unknown
end


end

