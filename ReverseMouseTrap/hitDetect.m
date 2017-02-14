function [ found,hittedColor,hittedID,hittingID,hittingPoint ] = hitDetect( tagMat,listBlue,listBlack, componentID )
%HITDETECT Summary of this function goes here
%  color:1-black 2-blue

[x,y]=size(tagMat);
logicalMat=listBlue{componentID,3};

[blacklist,bluelist]=makeListWithout(listBlue,listBlack,componentID);
tagMatCombine=combineOneList(blacklist,bluelist);

hittedColor=0;
hittedID=0;
hittingID=0;
hittingPoint=[0,0];

found=false;
for i=1:x
    for j=1:y
        if logicalMat(i,j)
            if tagMatCombine(i,j)~=0
                % hit detected
                % hit which component?
                hittedColor=floor((tagMatCombine(i,j)/10));
                hittedID=tagMatCombine(i,j)-hittedColor*10;
                hittingPoint=[i,j];
                found=true;
                hittingID=componentID;
            end
        end
        if found==true
            break;
        end
    end
    if found==true
        break;
    end
end

end

