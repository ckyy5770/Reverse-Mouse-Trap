function [ listBlue ] = updateST( listBlue,updateState,updateCount )
%UPDATE Summary of this function goes here
%   Detailed explanation goes here

for i=1:updateCount
    ID=updateState(i,1);
    if updateState(i,4)==1
        % change to stable
        listBlue{ID,5}(7)=0;
        break;
    else
        % change to unstable
        listBlue{ID,5}(7)=1;
    end
    
    if updateState(i,3)==1
        % cancel string
        listBlue{ID,5}(4)=0;      
    end
    
    listBlue{ID,5}(8)=updateState(i,2);
end

end

