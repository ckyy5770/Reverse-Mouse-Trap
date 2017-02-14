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
    figure, imshow(im1);
    figure, imshow(im2);
    % find blue component(tag=2, size>300)
    [componentMat,componentNum]=findComponent(tagMat,2,300);
    % for each component, generate a tag mat named tagMatComp
    for j=1:componentNum
        tagMatComp=tagMat2tagMatComp(tagMat,componentMat,j);
        % im3 is one blue component
        im3=square2image(tagMatComp,squareSize);
        figure, imshow(im3);
        writePath=initWritePathAppendix(readList{i},'findComponent_22_size300',strcat('blue',num2str(j)));
        imageWrite(im3,writePath);
    end
    
    % find black component(tag=4, size>300)
    [componentMat,componentNum]=findComponent(tagMat,4,300);
    % for each component, generate a tag mat named tagMatComp
    for j=1:componentNum
        tagMatComp=tagMat2tagMatComp(tagMat,componentMat,j);
        % im3 is one black component
        im3=square2image(tagMatComp,squareSize);
        figure, imshow(im3);
        writePath=initWritePathAppendix(readList{i},'findComponent_22_size300',strcat('black',num2str(j)));
        imageWrite(im3,writePath);
    end
end