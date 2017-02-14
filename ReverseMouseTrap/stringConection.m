function [ componentListBlue ] = stringConection( componentListBlue )
%STRINGCONECTION Summary of this function goes here
%   Detailed explanation goes here

% we only consider there is one string or none.

stringPoint=zeros(1,2);
count=0;
[blueNum,~]=size(componentListBlue);
for i=1:blueNum
    if componentListBlue{i,5}(4)==1
        count=count+1;
        stringPoint(count)=i;
    end
end

if max(stringPoint)~=0
    componentListBlue{stringPoint(1),5}(9)=stringPoint(2);
    componentListBlue{stringPoint(2),5}(9)=stringPoint(1);
end

end

