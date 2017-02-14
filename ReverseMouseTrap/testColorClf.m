readList=initReadList(1:24);
[readListSize,~]=size(readList);
for i=1:readListSize
    im=imageRead(readList{i});
    im1=colorClassification(im);
    figure,imshow(im1);
    writePath=initWritePath(readList{i},'colorClf_1b');
    imageWrite(im1,writePath);
end