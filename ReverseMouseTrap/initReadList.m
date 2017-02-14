function [ readList ] = initReadList( numArray )
%INITREADLIST generate read file list given image number
%   input: number array
%   output: a 1-d cell in which one row is a file path+name str. 

path='./testImages/';
filename='ReverseMousetrap_**.png';
% find the first '*' in file name.
numberStartFrom=find(filename=='*',1);
% not sure the input array is a row or a column
[a,b]=size(numArray);
arraySize=max(a,b);
% init readList
readList=cell(arraySize,1);
for i=1:arraySize
    % edit file name according to given image number
    if numArray(i)<10
        number=strcat('0',num2str(numArray(i)));
    else
        % suppose image number <100
        number=num2str(numArray(i));
    end
    filename(numberStartFrom:numberStartFrom+1)=number;
    % add the file into readList
    readList{i}=strcat(path,filename);
end

end

