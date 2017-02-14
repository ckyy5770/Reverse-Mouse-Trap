function [ writePath ] = initWritePath( readPath, folderName )
%INITWRITELIST generate writePath according to readPath
%   Detailed explanation goes here

% generate the path using folderName
path=strcat('./',folderName,'/');
filename='ReverseMousetrap_**.png';
% find the number of image in readPath
numberStartFrom=find(readPath=='_',1)+1;
number=readPath(numberStartFrom:numberStartFrom+1);
% find the number position in write filename
numberStartFrom=find(filename=='*',1);
% edit the number in file name
filename(numberStartFrom:numberStartFrom+1)=number;
% generate write path by combing the path and the name 
writePath=strcat(path,filename);

end

