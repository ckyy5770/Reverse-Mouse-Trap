function [ tagMat ] = fuzzification( image,squareSize)
%FUZZIFICATION make the picture blur.
%   Detailed explanation goes here

% build color box again with only 5 basic color
yellowRGB=[255,255,0];
blueRGB=[0,0,255];
greenRGB=[0,255,0];
blackRGB=[0,0,0];
whiteRGB=[255,255,255];
colorBox=uint8([yellowRGB;blueRGB;greenRGB;blackRGB;whiteRGB]);
[basicColorNum,~]=size(colorBox);

[width,height,~]=size(image);

% if there are some reminder after divide into squares, just dicard them.
if mod(width,squareSize)~=0
    width=width-mod(width,squareSize);
end
if mod(height,squareSize)~=0
    height=height-mod(height,squareSize);
end

% how many squares we have in each raw & column
squareWidth=width/squareSize;
squareHeight=height/squareSize;

% init tagMat
tagMat=zeros(squareWidth,squareHeight);

% for each square
for i=1:squareWidth
    for j=1:squareHeight
        % we get its xy range in the image
        [rangeX,rangeY]=square2pixel([i,j],squareSize);
        % for each pixel within that range
        counterBox=zeros(1,basicColorNum);
        for s=rangeX(1):rangeX(2)
            for t=rangeY(1):rangeY(2)
                % color tag:
                % 1:yellow [255,255,0]
                % 2:blue [0,0,255]
                % 3:green [0,255,0]
                % 4:black [0,0,0]
                % 5:white [255,255,255]
                for k=1:basicColorNum
                    if (image(s,t,1)==colorBox(k,1))&&(image(s,t,2)==colorBox(k,2))&&(image(s,t,3)==colorBox(k,3))
                        counterBox(k)=counterBox(k)+1;
                        break;
                    end
                end   
            end
        end
        [~,tagMat(i,j)]=max(counterBox);
    end
end
end

