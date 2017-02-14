function [ tagMat ] = drawRect2Tag( tagMat,color,center,width, height,angle )
%DRAWRECT2TAG Summary of this function goes here
%   Detailed explanation goes here

center=round(center);
width=round(width);
height=round(height);

% rotate it
R=[cos(angle),-sin(angle); sin(angle),cos(angle)];
for i=(center(1)-round(width/2)):(center(1)+round(width/2))
    for j=(center(2)-round(height/2)):(center(2)+round(height/2))
        % calculate rotated coordinate
        coor=R*([i,j]'-center')+center';
        % draw
        tagMat(round(coor(1)),round(coor(2)))=color;
    end
end

end

