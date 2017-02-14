function [ updateState ] = add2updateList( updateState,updateCount,id,angle,cancelStr,stable )
%ADD2UPDATELIST Summary of this function goes here
%   Detailed explanation goes here


updateState(updateCount,1)=id;
updateState(updateCount,2)=angle;
updateState(updateCount,3)=cancelStr;
updateState(updateCount,4)=stable;

end

