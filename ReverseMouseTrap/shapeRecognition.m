function [ shapeInfo,logicalComp] = shapeRecognition( tagMatComp, componentID )
%SHAPERECOGNITION Summary of this function goes here
%   Detailed explanation goes here

% knowledge space {circle, rectangle} (filled)
% what my AI system think is rather naive:
% if the component satify the property of a filled circle, then it is a
% filled circle; else it must be a filled rectangle or some combination 
% of no more than three filled rectangles.

% shapeInfo:[shapeID, shapeCategory, centerX, centerY width, height, angle, radii]
% 1-shapeID: should be the same as componentID
% 2-shapeCategory: circle=1, rectangle=2, unknown=3.
% 3-centerX: the center of the shape x-axis
% 4-centerY: the center of the shape y-axis
% 5-width, 6-height & 7-angle: properties only for rectangles, zeros if the shape is a circle
% 8-radii: property only for circle, zero if the shape is rectangle
shapeInfo=zeros(1,8);
shapeInfo(1)=componentID;

% convert component's tag mat to a logical format where all white color
% points marked as "false" and other color points marked as "true"
logicalComp=tagMatComp2Logical(tagMatComp);

% get all infomation we need using "regionprops" fuction
stats=regionprops('table',logicalComp,'Centroid','MajorAxisLength','MinorAxisLength',...
    'Area','Orientation');

% if the 'MajorAxisLength'/'MinorAxisLenth'>2, it must be a rectangle,
% otherwise the drawing quality should be too bad.   
if(stats.MajorAxisLength/stats.MinorAxisLength>2)
    % this component should be a rectangle.
    % we can use center,width,height,angle to record it.
    shapeInfo(2)=2; %shapeCategory, rectangle=2
    shapeInfo(3)=stats.Centroid(1); %center-x
    shapeInfo(4)=stats.Centroid(2); %center-y   
    % get the angle of this rectangle and rotate it to regular position
    angle=stats.Orientation;
    if angle>0
        rotatedIm=imrotate(logicalComp,180-angle);
    else
        rotatedIm=imrotate(logicalComp,-angle);
    end
    % use BoundingBox to find the best bounding of this rectangle
    statsRot=regionprops('table',rotatedIm,'BoundingBox');
    
    shapeInfo(5)=max(statsRot.BoundingBox([3,4])); %width
    shapeInfo(6)=min(statsRot.BoundingBox([3,4])); %height
    shapeInfo(7)=angle; %angle
else
    % this component should a rectangle or a circle
    % we use both a rectangle and a circle to fit it, the best fitting is 
    % considered to be the shape
    
    % rectangle fitting
    % get the angle of this rectangle and rotate it to regular position
    angle=stats.Orientation;
    if angle>0
        rotatedIm=imrotate(logicalComp,180-angle);
    else
        rotatedIm=imrotate(logicalComp,-angle);
    end
    % use BoundingBox to find the best bounding of this rectangle
    statsRot=regionprops('table',rotatedIm,'BoundingBox');
    
    width=max(statsRot.BoundingBox([3,4])); %width
    height=min(statsRot.BoundingBox([3,4])); %height
    
    areaRec=width*height;
    
    % circle fitting
    diameter=(stats.MajorAxisLength+stats.MinorAxisLength)/2;
    areaCir=pi*(diameter/2)^2;
    
    % compare the area of fitting shape with original shape, the area of 
    % best fitting shape should be closer to the original shape.
    if(abs(areaRec-stats.Area)<abs(areaCir-stats.Area))
        % this is a rectangle
         shapeInfo(2)=2; %shapeCategory, rectangle=2
         shapeInfo(3)=stats.Centroid(1); %center-x
         shapeInfo(4)=stats.Centroid(2); %center-y
         shapeInfo(5)=width;
         shapeInfo(6)=height;
         shapeInfo(7)=stats.Orientation;
    else
        % this is a circle
        shapeInfo(2)=1; %shapeCategory, circle=1
        shapeInfo(3)=stats.Centroid(1); %center-x
        shapeInfo(4)=stats.Centroid(2); %center-y
        shapeInfo(8)=diameter/2; %radii
        % add this for detect string
        shapeInfo(5)=diameter;
        shapeInfo(6)=diameter;
        shapeInfo(7)=0;
    end
    
end

end

