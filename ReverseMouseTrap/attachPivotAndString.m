function [ componentListBlue ] = attachPivotAndString( componentListBlue,componentListYellow,componentListGreen )
%ATTACHPIVOTANDSTRING Summary of this function goes here
%   Detailed explanation goes here

% pivot
if ~isempty(componentListYellow{1,2})
    % yellow list could be empty
    [yellowNum,~]=size(componentListYellow);
    for i=1:yellowNum
        shapeInfoYellow=componentListYellow{i,4};
        centerYellow=[shapeInfoYellow(3);shapeInfoYellow(4)];
        
        [blueNum,~]=size(componentListBlue);
        for j=1:blueNum
            shapeInfoBlue=componentListBlue{j,4};
            center=[shapeInfoBlue(3);shapeInfoBlue(4)];
            width=shapeInfoBlue(5);
            height=shapeInfoBlue(6);
            angle=shapeInfoBlue(7);
            [x,y]=drawRectangleonImageAtAngle(center,width,height,angle);
            [in,on]=inpolygon(centerYellow(1),centerYellow(2),x,y);
            
            if in||on
                % if yellow center is in this blue component, the blue component
                % gets a pivot
                componentListBlue{j,5}(1)=1;
                componentListBlue{j,5}(2)=centerYellow(1);
                componentListBlue{j,5}(3)=centerYellow(2);
            end
        end
        
    end
end
% string
if ~isempty(componentListGreen{1,2})
    % green list could be empty
    [greenNum,~]=size(componentListGreen);
    for i=1:greenNum
        logicalMatGreen=componentListGreen{i,3};
        %terminate=false;
        [X,Y]=size(logicalMatGreen);
        for s=1:X
            for t=1:Y
                if logicalMatGreen(s,t)
                    [blueNum,~]=size(componentListBlue);
                    for j=1:blueNum
                        shapeInfoBlue=componentListBlue{j,4};
                        center=[shapeInfoBlue(3);shapeInfoBlue(4)];
                        width=shapeInfoBlue(5);
                        height=shapeInfoBlue(6);
                        angle=shapeInfoBlue(7);
                        [x,y]=drawRectangleonImageAtAngle(center,width,height,angle);
                        [in,on]=inpolygon(t,s,x,y);
                        if in||on
                            % if anygreen point is inside a blue component, the
                            % blue component gets a string
                            
                            % if the green point is on the left of the
                            % component set 5 =1; else set 6 =1
                            componentListBlue{j,5}(4)=1;
                            if (t<shapeInfoBlue(3))
                                componentListBlue{j,5}(5)=1;
                            else
                                componentListBlue{j,5}(6)=1;
                            end
                            %terminate=true;
                        end
                    end
                end
                
            end
        end
        
    end
end
end

