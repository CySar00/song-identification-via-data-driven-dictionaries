function LandmarkPairs = ExtractTheSignalsLandmarkPairs(Keypoints, varargin)
%EXTRACTTHESIGNALSLANDMARKPAIRS Summary of this function goes here
%   Detailed explanation goes here


    lengthOfVarargin = length(varargin); 
    if lengthOfVarargin < 1 
        varargin{1} = 64;
    end 
    plusFrames = varargin{1}; 

    if lengthOfVarargin < 2 
        varargin{2} = 32;
    end 
    plusAtoms = varargin{2}; 
    
     if lengthOfVarargin < 3 
        varargin{2} = 3;
    end 
    numberOfClosestKeypoints = varargin{3}; 
    
    numberOfLandmarkPairs = 0;
    for i=1:size(Keypoints,1)
        anchorPoint_frameIndex= Keypoints(i,1); 
        anchorPoint_atomIndex = Keypoints(i,2); 
        
        targetZone_startFrameIndex = anchorPoint_frameIndex; 
        targetZone_endFrameIndex = anchorPoint_frameIndex+plusFrames;
        
        targetZone_startAtomIndex = anchorPoint_atomIndex-plusAtoms; 
        targetZone_endAtomIndex = anchorPoint_atomIndex+plusAtoms; 
        
        possibleKeypoints=find(...
            Keypoints(:,1)>targetZone_startFrameIndex &...
            Keypoints(:,1)<targetZone_endFrameIndex &...
            ...
            Keypoints(:,2)>targetZone_startAtomIndex &...
            Keypoints(:,2)<targetZone_endAtomIndex...
            ); 
        
        if length(possibleKeypoints)>numberOfClosestKeypoints
            possibleKeypoints = possibleKeypoints(1:numberOfClosestKeypoints); 
        end 
        
        for keypoint = 1:length(possibleKeypoints)
            numberOfLandmarkPairs = numberOfLandmarkPairs+1; 
            
            LandmarkPairs(numberOfLandmarkPairs,1)=anchorPoint_frameIndex;
            LandmarkPairs(numberOfLandmarkPairs,2)= anchorPoint_atomIndex;
            LandmarkPairs(numberOfLandmarkPairs,3)= Keypoints(possibleKeypoints(keypoint),2); 
            LandmarkPairs(numberOfLandmarkPairs,4)= Keypoints(possibleKeypoints(keypoint),1)-anchorPoint_frameIndex;
            
        end 
            
    end 
 
    if numberOfLandmarkPairs==0
        LandmarkPairs=zeros(1,4); 
    end 
    
    


end

