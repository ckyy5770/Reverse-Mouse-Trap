% input should be a component image
squareSize=2;
im1=imread('.\findComponent_07_size300\ReverseMousetrap_07blue2.png');
fh=figure;
tagMatComp=fuzzification(im1,squareSize);
[shapeInfo,logicalComp]=shapeRecognition(tagMatComp,1);
drawShape(shapeInfo,logicalComp);
frm=getframe(fh);
a=frm.cdata;