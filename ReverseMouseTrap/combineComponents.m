function [ tagMatCombine ] = combineComponents( componentListBlack,componentListBlue )
%SHOWCOMPONENT Summary of this function goes here
%   Detailed explanation goes here

[tagX,tagY]=size(componentListBlack{1,3});
tagMatCombine=zeros(tagX,tagY)+5;

% for black components
[componentNum,~]=size(componentListBlack);
for i=1:componentNum 
    shapeInfo=componentListBlack{i,4};
    % if the shape is unknown, just draw the original shape
    if shapeInfo(2)==3 
        logicMatBlack=componentListBlack{i,3};
        for s=1:tagX
            for t=1:tagY
                if logicMatBlack(s,t)
                    tagMatCombine(s,t)=4; %black tag
                end
            end
        end
    elseif shapeInfo(2)==2
        % draw rectangle using shape info
        tagMatCombine=drawRect2Tag(tagMatCombine,4,[shapeInfo(3),shapeInfo(4)],shapeInfo(5),shapeInfo(6),shapeInfo(7));
    else
        % shapeInfo(2)==3
        % draw circle using shape info
        tagMatCombine=drawCircle2Tag(tagMatCombine,4,[shapeInfo(3),shapeInfo(4)],shapeInfo(8));
    end
end

% for blue components
[componentNum,~]=size(componentListBlue);
for i=1:componentNum 
    shapeInfo=componentListBlue{i,4};
    % if the shape is unknown, just draw the original shape
    if shapeInfo(2)==3 
        logicMatBlue=componentListBlue{i,3};
        for s=1:tagX
            for t=1:tagY
                if logicMatBlue(s,t)
                    tagMatCombine(s,t)=2; %blue tag
                end
            end
        end
    elseif shapeInfo(2)==2
        % draw rectangle using shape info
        tagMatCombine=drawRect2Tag(tagMatCombine,2,[shapeInfo(3),shapeInfo(4)],shapeInfo(5),shapeInfo(6),shapeInfo(7));
    else
        % shapeInfo(2)==3
        % draw circle using shape info
        tagMatCombine=drawCircle2Tag(tagMatCombine,2,[shapeInfo(3),shapeInfo(4)],shapeInfo(8));
    end
end

end

