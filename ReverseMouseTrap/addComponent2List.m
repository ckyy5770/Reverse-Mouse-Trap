function [ componentList ] = addComponent2List( componentList, componentID, logicMatComp, shapeInfo, stateInfo )
%ADDCOMPONENT2LIST Summary of this function goes here
%   Detailed explanation goes here

componentList{componentID,2}=componentID;
componentList{componentID,3}=logicMatComp;
componentList{componentID,4}=shapeInfo;
componentList{componentID,5}=stateInfo;

end

