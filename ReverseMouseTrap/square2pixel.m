function [ rangeX, rangeY ] = square2pixel( arrayXY,squareSize )
%SQUARE2PIXEL Summary of this function goes here
%   Detailed explanation goes here

start=(arrayXY(1)-1)*squareSize+1;
rangeX=[start,start+squareSize-1];
start=(arrayXY(2)-1)*squareSize+1;
rangeY=[start,start+squareSize-1];

end

