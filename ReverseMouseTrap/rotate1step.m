function [ listBlue ] = rotate1step( listBlue,ComponentID,isClock )
%ROTATE1STEP Summary of this function goes here
%   Detailed explanation goes here

center=[listBlue{ComponentID,5}(2),listBlue{ComponentID,5}(3)];

% setting move angle
if isClock
    theta=-4*(pi/180);
else
    theta=4*(pi/180);
end

R = [cos(theta) sin(theta);...
    -sin(theta) cos(theta)];

logicalMat=listBlue{ComponentID,3};
[x,y]=size(logicalMat);
newMat=logical(zeros(x,y));
for i=1:x
    for j=1:y
        if logicalMat(i,j)
            coor=R*([j;i]-center')+center';
            coor=ceil(coor);
            newMat(coor(2),coor(1))=true;
        end
    end
end

listBlue{ComponentID,3}=newMat;


