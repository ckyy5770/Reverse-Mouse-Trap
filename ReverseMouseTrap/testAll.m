%5 basic color recognition

%global settings
squareSize=2;


readList=initReadList([22]);
%readList=initReadList(1:1);
[readListSize,~]=size(readList);
for i=1:readListSize
    im=imageRead(readList{i});
    % im1 is the picture after color classification
    im1=colorClassification(im);
    tagMat=fuzzification(im1,squareSize);
    % im2 is the picture after fuzzification
    im2=square2image(tagMat,squareSize);
    %figure, imshow(im1);
    %figure, imshow(im2);
    % find blue component(tag=2, size>300)
    [componentMat,componentNum]=findComponent(tagMat,2,300);
    % init component list
    listBlue=initComponentList(componentNum,'blue');
    % for each component, generate a tag mat named tagMatComp
    for j=1:componentNum
        tagMatComp=tagMat2tagMatComp(tagMat,componentMat,j);
        [shapeInfo,logicalComp]=shapeRecognition(tagMatComp,j);
        listBlue=addComponent2List(listBlue,j,logicalComp, shapeInfo, zeros(1,10));
    end
    % find black component(tag=4, size>300)
    [componentMat,componentNum]=findComponent(tagMat,4,300);
    % init component list
    listBlack=initComponentList(componentNum,'black');
    % for each component, generate a tag mat named tagMatComp
    for j=1:componentNum
        tagMatComp=tagMat2tagMatComp(tagMat,componentMat,j);
        [shapeInfo,logicalComp]=shapeRecognition(tagMatComp,j);
        listBlack=addComponent2List(listBlack,j,logicalComp, shapeInfo, zeros(1,10));
    end
    % find yellow component(tag=1, size>100)
    [componentMat,componentNum]=findComponent(tagMat,1,100);
    % init component list yellow
    listYellow=initComponentList(componentNum,'yellow');
    % for each component, generate a tag mat named tagMatComp
    for j=1:componentNum
        tagMatComp=tagMat2tagMatComp(tagMat,componentMat,j);
        [shapeInfo,logicalComp]=shapeRecognition(tagMatComp,j);
        listYellow=addComponent2List(listYellow,j,logicalComp, shapeInfo, zeros(1,10));
    end
    
    % find green component(tag=3, size>100)
    [componentMat,componentNum]=findComponent(tagMat,3,50);
    % init component list yellow
    listGreen=initComponentList(componentNum,'green');
    % for each component, generate a tag mat named tagMatComp
    for j=1:componentNum
        tagMatComp=tagMat2tagMatComp(tagMat,componentMat,j);
        [shapeInfo,logicalComp]=shapeRecognition(tagMatComp,j);
        listGreen=addComponent2List(listGreen,j,logicalComp, shapeInfo, zeros(1,10));
    end
    
    % first two black are unknown type.
    listBlack{1,4}(2)=3;
    listBlack{2,4}(2)=3;
    
    % attach pivot and string point to blue component.
    listBlue=attachPivotAndString(listBlue,listYellow,listGreen);
    % connect strings
    listBlue=stringConection(listBlue);
    
    tagMatCombine=combineComponentsTest(listBlack,listBlue,listYellow,listGreen);
    im3=square2image(tagMatCombine,squareSize);
    
    figure
    hdl=imshow(im3);
    
    % init state
    % set the blue ball initial state to 'unstable-1', move angle -90
    listBlue{1,5}(7)=1;
    listBlue{1,5}(8)=90;
    
    s=0
    while(1)
        s=s+1
        [blueNum,~]=size(listBlue);
        updateState=zeros(blueNum,4);
        updateCount=0;
        % for every blue component, if unstable, move for 1 step.
        for t=1:blueNum
            if listBlue{t,5}(7)==1
                % unstable
                state=listBlue{t,5};
                % fetch some info from state
                pivot=false;
                string=false;
                stringSide=0; %1-left,2-right
                stringTo=0;
                moveAngle=0;
                
                if state(1)==1
                    pivot=true;
                end
                if state(4)==1
                    string=true;
                end
                if string
                    if state(5)==1
                        stringSide=1;
                    else
                        stringSide=2;
                    end
                    stringTo=state(9);
                end
                moveAngle=state(8);
                
                % if there are no strings or pivots
                if ~string && ~pivot
                    % in this case, just move the component toward the
                    % angle for 1 step
                    listBlue=move1step(listBlue,t,moveAngle);
                    [found,hittedColor,hittedID,moveAngle,hittingID,hittingPoint]=hitDetect(tagMat,listBlue,listBlack,t, moveAngle);
                    if found
                        if hittedColor==1
                            % if hitted a black component
                            % change the moveAngle to the black component's
                            % angle
                            updateCount=updateCount+1;
                            updateState(updateCount,1)=t;
                            updateState(updateCount,2)=listBlack{hittedID,4}(7)+180;
                        else
                            % hitted a blue component
                            if listBlue{hittedID,5}(1)==1
                                % this component has a pivot
                                % see the hitting one is one the right or
                                % left of the pivot
                                if hittingPoint(2)<listBlue{hittedID,5}(3)
                                    left=true;
                                else
                                    left=false;
                                end
                                updateCount=updateCount+1;
                                updateState(updateCount,1)=hittedID;
                                
                                if left&&moveAngle<0
                                    updateState(updateCount,2)=1;
                                elseif left&&moveAngle>0
                                    updateState(updateCount,2)=-1;
                                elseif ~left&&moveAngle<0
                                    updateState(updateCount,2)=-1;
                                else
                                    updateState(updateCount,2)=1;
                                end
                                
                                updateCount=updateCount+1;
                                updateState(updateCount,1)=t;
                                updateState(updateCount,2)=90;
                                
                                
                            end
                            
                        end
                    end
                else
                    % there exist a string or a pivot in this component
                    if ~string && pivot
                        % rotate the component
                        % in this case the value of moveAngle indicates the
                        % direction toward which rotate
                        if moveAngle<0
                            listBlue=rotate1step(listBlue,t,true);
                        else
                            listBlue=rotate1step(listBlue,t,false);
                        end
                        
                        [found,hittedColor,hittedID,moveAngle,hittingID,hittingPoint]=hitDetect(tagMat,listBlue,listBlack,t, moveAngle);
                        if found
                            if hittedColor==1
                                % if hitted a black component
                                % change the moveAngle to the black component's
                                % angle
                                updateCount=updateCount+1;
                                updateState(updateCount,1)=t;
                                updateState(updateCount,2)=listBlack{hittedID,4}(7)+180;
                            else
                                % hitted a blue component
                                if listBlue{hittedID,5}(1)==1
                                    % this component has a pivot
                                    % see the hitting one is one the right or
                                    % left of the pivot
                                    if hittingPoint(2)<listBlue{hittedID,5}(3)
                                        left=true;
                                    else
                                        left=false;
                                    end
                                    updateCount=updateCount+1;
                                    updateState(updateCount,1)=hittedID;
                                    
                                    if left&&moveAngle<0
                                        updateState(updateCount,2)=1;
                                    elseif left&&moveAngle>0
                                        updateState(updateCount,2)=-1;
                                    elseif ~left&&moveAngle<0
                                        updateState(updateCount,2)=-1;
                                    else
                                        updateState(updateCount,2)=1;
                                    end
                                    
                                    updateCount=updateCount+1;
                                    updateState(updateCount,1)=t;
                                    updateState(updateCount,2)=90;
                                    
                                    
                                end
                                
                            end
                        end
                        
                        
                        
                    end
                    
                    if string && ~pivot
                        % in this case, just move the component toward the
                        % angle for 1 step
                        listBlue=move1step(listBlue,t,moveAngle);
                        
                        [found,hittedColor,hittedID,moveAngle,hittingID,hittingPoint]=hitDetect(tagMat,listBlue,listBlack,t, moveAngle);
                        if found
                            if hittedColor==1
                                % if hitted a black component
                                % change the moveAngle to the black component's
                                % angle
                                updateCount=updateCount+1;
                                updateState(updateCount,1)=t;
                                updateState(updateCount,2)=listBlack{hittedID,4}(7)+180;
                            else
                                % hitted a blue component
                                if listBlue{hittedID,5}(1)==1
                                    % this component has a pivot
                                    % see the hitting one is one the right or
                                    % left of the pivot
                                    if hittingPoint(2)<listBlue{hittedID,5}(3)
                                        left=true;
                                    else
                                        left=false;
                                    end
                                    updateCount=updateCount+1;
                                    updateState(updateCount,1)=hittedID;
                                    
                                    if left&&moveAngle<0
                                        updateState(updateCount,2)=1;
                                    elseif left&&moveAngle>0
                                        updateState(updateCount,2)=-1;
                                    elseif ~left&&moveAngle<0
                                        updateState(updateCount,2)=-1;
                                    else
                                        updateState(updateCount,2)=1;
                                    end
                                    
                                    updateCount=updateCount+1;
                                    updateState(updateCount,1)=t;
                                    updateState(updateCount,2)=90;
                                    
                                    
                                end
                                
                            end
                        end
                        updateCount=updateCount+1;
                        updateState(updateCount,1)=stringTo;
                        updateState(updateCount,2)=-90;
                        % cancel string
                        updateState(updateCount,3)=1;
                        listBlue{t,5}(4)=0;
                    end
                    
                    if string && pivot
                        
                        % rotate the component
                        % in this case the value of moveAngle indicates the
                        % direction toward which rotate
                        if moveAngle<0
                            listBlue=rotate1step(listBlue,t,true);
                        else
                            listBlue=rotate1step(listBlue,t,false);
                        end
                        
                        [found,hittedColor,hittedID,moveAngle,hittingID,hittingPoint]=hitDetect(tagMat,listBlue,listBlack,t, moveAngle);
                        if found
                            if hittedColor==1
                                % if hitted a black component
                                % change the moveAngle to the black component's
                                % angle
                                updateCount=updateCount+1;
                                updateState(updateCount,1)=t;
                                updateState(updateCount,2)=listBlack{hittedID,4}(7)+180;
                            else
                                % hitted a blue component
                                if listBlue{hittedID,5}(1)==1
                                    % this component has a pivot
                                    % see the hitting one is one the right or
                                    % left of the pivot
                                    if hittingPoint(2)<listBlue{hittedID,5}(3)
                                        left=true;
                                    else
                                        left=false;
                                    end
                                    updateCount=updateCount+1;
                                    updateState(updateCount,1)=hittedID;
                                    
                                    if left&&moveAngle<0
                                        updateState(updateCount,2)=1;
                                    elseif left&&moveAngle>0
                                        updateState(updateCount,2)=-1;
                                    elseif ~left&&moveAngle<0
                                        updateState(updateCount,2)=-1;
                                    else
                                        updateState(updateCount,2)=1;
                                    end
                                    
                                    updateCount=updateCount+1;
                                    updateState(updateCount,1)=t;
                                    updateState(updateCount,2)=90;
                                    
                                    
                                end
                                
                            end
                        end
                        
                        
                        
                        
                        updateCount=updateCount+1;
                        updateState(updateCount,1)=stringTo;
                        updateState(updateCount,2)=-90;
                        % cancel string
                        updateState(updateCount,3)=1;
                        listBlue{t,5}(4)=0;
                    end
                    
                end
                
            end
        end
        
        % update states
        for t=1:updateCount
            listBlue=updateST(listBlue,updateState,updateCount);
        end
        
        % print picture
        tagMatCombine=combineComponentsTest(listBlack,listBlue,listYellow,listGreen);
        
        im=square2image(tagMatCombine,squareSize);
        writePath=initWritePathAppendix(readList{i},'testAll',strcat('_',num2str(s)));
        imageWrite(im,writePath);
    end
    
end

