function [ componentMat,componentNum] = findComponent( tagMat, givenColor, sizeBase)
%find component of given colorTag
%   input: tagMat, givenColor: given color's tag
%   output: componentMat: we mark different component with different number
%   tag on the same size mat as tagMat

% componentSizeList
componentSizeList=zeros(1,1000);
% fetch tagMat size
[tagX,tagY]=size(tagMat);
% init componentMat
componentMat=zeros(tagX,tagY);
componentNum=0;
% for every entry in tagMat
for i=1:tagX
    for j=1:tagY
        % if there is a given color entry but not marked,
        if tagMat(i,j)==givenColor && componentMat(i,j)==0
            % start a new component.
            componentNum=componentNum+1;
            % search for all entries included in this component.
            componentMat(i,j)=componentNum;
            [componentMat,componentSize]=findAllEntries([i,j], tagMat, givenColor, componentMat, componentNum);
            componentSizeList(1,componentNum)=componentSize;
        end
    end
end

% eliminate small component
% generate eliminate list
eliminateList=[];
eliminateNum=0;
for i=1:componentNum
    if componentSizeList(i)<sizeBase
        eliminateNum=eliminateNum+1;
        eliminateList(1,eliminateNum)=i;
    end
end
% generate save list
saveList=[];
saveNum=0;
for i=1:componentNum
    if componentSizeList(i)>=sizeBase
        saveNum=saveNum+1;
        saveList(1,saveNum)=i;
    end
end

% eliminate
for i=1:tagX
    for j=1:tagY
        if any(componentMat(i,j)==eliminateList)
            componentMat(i,j)=0;
        end
    end
end
componentNum=componentNum-eliminateNum;
% re-index
for i=1:tagX
    for j=1:tagY
        if componentMat(i,j)==0
            continue;
        else
            for t=1:componentNum
                if componentMat(i,j)==saveList(t)
                    componentMat(i,j)=t;
                end
            end
        end
    end
end
end

