function [ tagMatCombine ] = combineOneList( blacklist,bluelist )
%COMBINEONELIST Summary of this function goes here
%   Detailed explanation goes here
% 23- number 3 in blue list
% 14- number 4 in black list

[~,num]=size(blacklist);

[x,y]=size(blacklist{1,1});
tagMatCombine=zeros(x,y);
for t=1:num
    curMat=blacklist{1,t};
    for i=1:x
        for j=1:y
            if curMat(i,j)
                tagMatCombine(i,j)=tagMatCombine(i,j)+10*1+blacklist{2,t};
            end
        end
    end
end

[~,num]=size(bluelist);
for t=1:num
    curMat=bluelist{1,t};
    for i=1:x
        for j=1:y
            if curMat(i,j)
                tagMatCombine(i,j)=tagMatCombine(i,j)+10*2+bluelist{2,t};
            end
        end
    end
end


end

