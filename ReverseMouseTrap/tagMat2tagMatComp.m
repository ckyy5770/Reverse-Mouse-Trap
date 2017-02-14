function [ tagMat ] = tagMat2tagMatComp( tagMat, componentMat, componentID)
%tagMat2tagMatComp get the tagMat for a given component
%   Detailed explanation goes here

[tagX, tagY]=size(tagMat);
for i=1:tagX
    for j=1:tagY
        if componentMat(i,j)~=componentID
            tagMat(i,j)=5; %white
        end
    end
end

end

