function [ arrayXY ] = pixel2square( arrayXY,squareSize )
%PIXEL2SQUARE convert pixel position to square position
%   Detailed explanation goes here

arrayXY=ceil(arrayXY/squareSize);

end

