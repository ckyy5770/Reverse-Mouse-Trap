function [ tagMat ] = drawCircle2Tag( tagMat,color,center,radii)
%DRAWCIRCLE2TAG Summary of this function goes here
%   Detailed explanation goes here

center=round(center);
radii=round(radii);

for i=(center(1)-radii):(center(1)+radii)
    for j=(center(2)-radii):(center(2)+radii)
        if norm([i,j]-center)<floor(radii)
            tagMat(i,j)=color;
        end
    end
end

end

