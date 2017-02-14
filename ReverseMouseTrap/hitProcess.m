function [ updateState,updateCount ] = hitProcess( blueList,blackList,hittedColor,hittedID,hittingID,hittingPoint,updateState,updateCount )
%HITPROCESS Summary of this function goes here
%   Detailed explanation goes here

if hittedColor==1 % hit black
    orientation=blackList{hittedID,4}(7);
    updateCount=updateCount+1;
    updateState=add2updateList(updateState,updateCount,hittingID,180+orientation,0,0);
else
    % hit blue
    if blueList{hittedID,5}(1)==1
        % hitted has a pivot
        updateCount=updateCount+1;
        updateState=add2updateList(updateState,updateCount,hittedID,-90,0,0);
        updateCount=updateCount+1;
        updateState=add2updateList(updateState,updateCount,hittingID,90,0,0);
    else
        % hitted does not have a pivot
        updateCount=updateCount+1;
        updateState=add2updateList(updateState,updateCount,hittedID,blueList{hittingID,5}(8),0,0);
        updateCount=updateCount+1;
        updateState=add2updateList(updateState,updateCount,hittingID,90,0,0);
    end
    
end

