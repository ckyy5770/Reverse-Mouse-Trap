function [ listBlue ] = move1step( listBlue,ComponentID,moveAngle )
%MOVE1STEP Summary of this function goes here
%   Detailed explanation goes here

theta=moveAngle*(pi/180);
% setting move dist
dist=10;

logicalMat=listBlue{ComponentID,3};
[x,y]=size(logicalMat);
newMat=logical(zeros(x,y));
for i=1:x
    for j=1:y
        if logicalMat(i,j)
            ri=ceil(sin(theta)*dist+i);
            rj=ceil(j-cos(theta)*dist);
            newMat(ri,rj)=true;
        end
    end
end

listBlue{ComponentID,3}=newMat;

end

