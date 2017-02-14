%5 basic color recognition 

%global settings
squareSize=2;


readList=initReadList([22]);
%readList=initReadList(1:1);
[readListSize,~]=size(readList);
for i=1:readListSize
    im=imageRead(readList{i});
    % im1 is the picture after color classification
    im1=colorClassification(im);
    tagMat=fuzzification(im1,squareSize);
    % im2 is the picture after fuzzification
    im2=square2image(tagMat,squareSize);
    %figure, imshow(im1);
    %figure, imshow(im2);
    % find blue component(tag=2, size>300)
    [componentMat,componentNum]=findComponent(tagMat,2,300);
    % init component list
    listBlue=initComponentList(componentNum,'blue');
    % for each component, generate a tag mat named tagMatComp
    for j=1:componentNum
        tagMatComp=tagMat2tagMatComp(tagMat,componentMat,j);
        [shapeInfo,logicalComp]=shapeRecognition(tagMatComp,j);
        listBlue=addComponent2List(listBlue,j,logicalComp, shapeInfo, zeros(1,10));
    end
    % find black component(tag=4, size>300)
    [componentMat,componentNum]=findComponent(tagMat,4,300);
    % init component list
    listBlack=initComponentList(componentNum,'black');
    % for each component, generate a tag mat named tagMatComp
    for j=1:componentNum
        tagMatComp=tagMat2tagMatComp(tagMat,componentMat,j);
        [shapeInfo,logicalComp]=shapeRecognition(tagMatComp,j);
        listBlack=addComponent2List(listBlack,j,logicalComp, shapeInfo, zeros(1,10));
    end
    % find yellow component(tag=1, size>100)
    [componentMat,componentNum]=findComponent(tagMat,1,100);
    % init component list yellow
    listYellow=initComponentList(componentNum,'yellow');
    % for each component, generate a tag mat named tagMatComp
    for j=1:componentNum
        tagMatComp=tagMat2tagMatComp(tagMat,componentMat,j);
        [shapeInfo,logicalComp]=shapeRecognition(tagMatComp,j);
        listYellow=addComponent2List(listYellow,j,logicalComp, shapeInfo, zeros(1,10));
    end
    
    % find green component(tag=3, size>100)
    [componentMat,componentNum]=findComponent(tagMat,3,50);
    % init component list yellow
    listGreen=initComponentList(componentNum,'green');
    % for each component, generate a tag mat named tagMatComp
    for j=1:componentNum
        tagMatComp=tagMat2tagMatComp(tagMat,componentMat,j);
        [shapeInfo,logicalComp]=shapeRecognition(tagMatComp,j);
        listGreen=addComponent2List(listGreen,j,logicalComp, shapeInfo, zeros(1,10));
    end
    
    % first two black are unknown type.
    listBlack{1,4}(2)=3;
    listBlack{2,4}(2)=3;
    
    % attach pivot and string point to blue component.
    listBlue=attachPivotAndString(listBlue,listYellow,listGreen);
  
    tagMatCombine=combineComponentsTest(listBlack,listBlue,listYellow,listGreen);
    im3=square2image(tagMatCombine,squareSize);
    
    
end