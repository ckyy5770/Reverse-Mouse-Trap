function [ componentMat, componentSize ] = findAllEntries( startEntries, tagMat, givenColor, componentMat, componentNum)
%FINDALLENTRIES Summary of this function goes here
%   startEntry should be like [x1,y1;x2,y2;x3,y3]

% fetch tagMat size
[tagX,tagY]=size(tagMat);

% entriesNum
[entriesNum,~]=size(startEntries);

% record the number of entries included in the component, indicating 
% the component size, if the size is too small, discard this component.
componentSize=1;

while(true)
    newStartEntries=zeros(10,2);
    newEntriesNum=0;
    % if there is no starting point, break
    if entriesNum==0
        break;
    end
    % for every starting point
    for i=1:entriesNum
        % check all points next to it to see if they should be included in
        % the component
        curX=(startEntries(i,1));
        curY=(startEntries(i,2));
        % boundary check X+1
        if curX+1<=tagX
            % if this point is belong to the component
            % mark componentMat
            % add this point as new start point
            if(tagMat(curX+1,curY)==givenColor && componentMat(curX+1,curY)==0)
                componentMat(curX+1,curY)=componentNum;
                newEntriesNum=newEntriesNum+1;
                newStartEntries(newEntriesNum,1)=curX+1;
                newStartEntries(newEntriesNum,2)=curY;
            end   
        end
        % boundary check Y+1
        if curY+1<=tagY
            if(tagMat(curX,curY+1)==givenColor && componentMat(curX,curY+1)==0)
                componentMat(curX,curY+1)=componentNum;
                newEntriesNum=newEntriesNum+1;
                newStartEntries(newEntriesNum,1)=curX;
                newStartEntries(newEntriesNum,2)=curY+1;
            end   
        end
        % boundary check X+1,Y+1
        if curX+1<=tagX && curY+1<=tagY
            if(tagMat(curX+1,curY+1)==givenColor && componentMat(curX+1,curY+1)==0)
                componentMat(curX+1,curY+1)=componentNum;
                newEntriesNum=newEntriesNum+1;
                newStartEntries(newEntriesNum,1)=curX+1;
                newStartEntries(newEntriesNum,2)=curY+1;
            end   
        end
        % boundary check X-1
        if curX-1>=0
            if(tagMat(curX-1,curY)==givenColor && componentMat(curX-1,curY)==0)
                componentMat(curX-1,curY)=componentNum;
                newEntriesNum=newEntriesNum+1;
                newStartEntries(newEntriesNum,1)=curX-1;
                newStartEntries(newEntriesNum,2)=curY;
            end   
        end
        % boundary check Y-1
        if curY-1>=0
            if(tagMat(curX,curY-1)==givenColor && componentMat(curX,curY-1)==0)
                componentMat(curX,curY-1)=componentNum;
                newEntriesNum=newEntriesNum+1;
                newStartEntries(newEntriesNum,1)=curX;
                newStartEntries(newEntriesNum,2)=curY-1;
            end
        end
        % boundary check X-1,Y-1
        if curX-1>=0 && curY-1>=0
            if(tagMat(curX-1,curY-1)==givenColor && componentMat(curX-1,curY-1)==0)
                componentMat(curX-1,curY-1)=componentNum;
                newEntriesNum=newEntriesNum+1;
                newStartEntries(newEntriesNum,1)=curX-1;
                newStartEntries(newEntriesNum,2)=curY-1;
            end   
        end
        % boundary check X+1,Y-1
        if curX+1<=tagX && curY-1>=0
            if(tagMat(curX+1,curY-1)==givenColor && componentMat(curX+1,curY-1)==0)
                componentMat(curX+1,curY-1)=componentNum;
                newEntriesNum=newEntriesNum+1;
                newStartEntries(newEntriesNum,1)=curX+1;
                newStartEntries(newEntriesNum,2)=curY-1;
            end   
        end
        % boundary check X-1,Y+1
        if curX-1>=0 && curY+1<=tagY
            if(tagMat(curX-1,curY+1)==givenColor && componentMat(curX-1,curY+1)==0)
                componentMat(curX-1,curY+1)=componentNum;
                newEntriesNum=newEntriesNum+1;
                newStartEntries(newEntriesNum,1)=curX-1;
                newStartEntries(newEntriesNum,2)=curY+1;
            end   
        end
    end
    entriesNum=newEntriesNum;
    startEntries=newStartEntries;
    componentSize=componentSize+newEntriesNum;
end

end

