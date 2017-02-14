function [ tagMatCombine ] = combineComponentsTest( componentListBlack,componentListBlue,componentListYellow,componentListGreen )
%COMBINECOMPONENTSTETS Summary of this function goes here
%   Detailed explanation goes here


[tagX,tagY]=size(componentListBlack{1,3});
tagMatCombine=zeros(tagX,tagY)+5;

% for black components
[componentNum,~]=size(componentListBlack);
for i=1:componentNum
    shapeInfo=componentListBlack{i,4};
    % if the shape is unknown, just draw the original shape
    if shapeInfo(2)==3 ||shapeInfo(2)==2 ||shapeInfo(2)==1
        logicMatBlack=componentListBlack{i,3};
        for s=1:tagX
            for t=1:tagY
                if logicMatBlack(s,t)
                    tagMatCombine(s,t)=4; %black tag
                end
            end
        end
    else
        % draw circle using shape info
        
    end
end

% for blue components
[componentNum,~]=size(componentListBlue);
for i=1:componentNum
    shapeInfo=componentListBlue{i,4};
    % if the shape is unknown, just draw the original shape
    if shapeInfo(2)==3 ||shapeInfo(2)==2 ||shapeInfo(2)==1
        logicMatBlue=componentListBlue{i,3};
        for s=1:tagX
            for t=1:tagY
                if logicMatBlue(s,t)
                    tagMatCombine(s,t)=2; %blue tag
                end
            end
        end
        
    else
        
        % draw circle using shape info
        
    end
end

% for yellow components
if ~isempty(componentListYellow{1,2})
    % could be empty
    [componentNum,~]=size(componentListYellow);
    for i=1:componentNum
        shapeInfo=componentListYellow{i,4};
        % if the shape is unknown, just draw the original shape
        if shapeInfo(2)==3 ||shapeInfo(2)==2 ||shapeInfo(2)==1
            logicMatYellow=componentListYellow{i,3};
            for s=1:tagX
                for t=1:tagY
                    if logicMatYellow(s,t)
                        tagMatCombine(s,t)=1; %yellow tag
                    end
                end
            end
            
        else
            
            % draw circle using shape info
            
        end
    end
end
% for green components
if ~isempty(componentListGreen{1,2})
    % could be empty
    [componentNum,~]=size(componentListGreen);
    for i=1:componentNum
        shapeInfo=componentListGreen{i,4};
        % if the shape is unknown, just draw the original shape
        if shapeInfo(2)==3 ||shapeInfo(2)==2 ||shapeInfo(2)==1
            logicMatGreen=componentListGreen{i,3};
            for s=1:tagX
                for t=1:tagY
                    if logicMatGreen(s,t)
                        tagMatCombine(s,t)=3; %green tag
                    end
                end
            end
            
        else
            
            % draw circle using shape info
            
        end
    end
end
end

