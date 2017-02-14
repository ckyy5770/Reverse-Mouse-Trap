%global settings
squareSize=5;


readList=initReadList([22]);
%readList=initReadList(1:1);
[readListSize,~]=size(readList);
for i=1:readListSize
    im=imageRead(readList{i});
    im1=colorClassification(im);
    tagMat=fuzzification(im1,squareSize);
    im2=square2image(tagMat,squareSize);
    figure, imshow(im1);
    figure, imshow(im2);
    writePath=initWritePath(readList{i},'colorClf_basic_sqr5');
    imageWrite(im2,writePath);
end