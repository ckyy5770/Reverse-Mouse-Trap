function [ image ] = colorClassification( image )
%COLORCLASSIFICATION Classify colors of pixels into 5 basic colors.
%   Detailed explanation goes here

% classify colors in picture into those 5 basic colors:
yellowRGB=[255,255,0];
blueRGB=[0,0,255];
greenRGB=[0,255,0];
blackRGB=[0,0,0];
whiteRGB=[255,255,255];

% and some similar colors
% blue
% -basic color
cyanRGB=[0,0,255];
% alternative color
%cyanRGB=[0,255,255];

% every row in colorBox is a basic color's RGB.
colorBox=[yellowRGB;blueRGB;greenRGB;blackRGB;whiteRGB;...
    cyanRGB];...%index 6 is also blue
[colorNum,~]=size(colorBox);

% by camparing which color's RGB is nearest to the given point.
[width,height,~]=size(image);

% for each pixel:
for i=1:width
    for j=1:height
        % fetch the colorRGB in this pixel.
        colorRGB=[image(i,j,1),image(i,j,2),image(i,j,3)];
        % initialize distList which is used to store distance info
        % between the pixel's RGB and the basic color. 
        distList=zeros(1,colorNum);
        % calculate the distance to each basic color.
        for r=1:colorNum
            distList(r)=norm(colorBox(r,:)-double(colorRGB));
        end
        % find the color nearest to given pixel.
        [~,minDistIndex]=min(distList);
        %index 6 is also blue
        if minDistIndex==6
            minDistIndex=2;
        end
        % change the color in the pixel to its nearest basic color.
        image(i,j,1)=uint8(colorBox(minDistIndex,1));
        image(i,j,2)=uint8(colorBox(minDistIndex,2));
        image(i,j,3)=uint8(colorBox(minDistIndex,3));
    end
end
end

