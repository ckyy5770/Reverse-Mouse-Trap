function [ blacklist ,bluelist ] = makeListWithout( listBlue,listBlack,componentID )
%MAKELISTWITHOUT Summary of this function goes here
%   Detailed explanation goes here


[num,~]=size(listBlue);
bluelist=cell(2,num-1);
count=0;
for i=1:num
    if i==componentID
        continue;
    else
        count=count+1;
        bluelist{1,count}=listBlue{i,3};
        bluelist{2,count}=i;
    end
end
[num,~]=size(listBlack);
blacklist=cell(2,num);
for i=1:num
    blacklist{1,i}=listBlack{i,3};
    blacklist{2,i}=i;
end
end

