function [ writePath ] = initWritePathAppendix( readPath, folderName, appendix)
%INITWRITEPATHAPPENDIX generate writePath just like initWritePath, but can
%add an appendix in the end of file name.
%   Detailed explanation goes here


% generate the path using folderName
path=strcat('./',folderName,'/');
filename='ReverseMousetrap_**';
% find the number of image in readPath
numberStartFrom=find(readPath=='_',1)+1;
number=readPath(numberStartFrom:numberStartFrom+1);
% find the number position in write filename
numberStartFrom=find(filename=='*',1);
% edit the number in file name
filename(numberStartFrom:numberStartFrom+1)=number;
% add appendix and extended name
filename=strcat(filename,appendix);
filename=strcat(filename,'.png');
% generate write path by combing the path and the name 
writePath=strcat(path,filename);



end

