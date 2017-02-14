function [ componentList ] = initComponentList( componentNum, listColor)
%INITCOMPONENTLIST Summary of this function goes here
%   each picture should maintain a component list, in which every
%   component's information could be stored

% componentList: {1-color, 2-componentID, 3-logicMatComp, 4-shapeInfo, 5-stateInfo}

componentList=cell(componentNum,5);
componentList{1}=listColor;

end

