function hashTable = HashTheLandmarkPairs(songID, landmarkPairs)
%HASHTHELANDMARKRPAIRS Summary of this function goes here
%   Detailed explanation goes here

    hashTable=zeros(size(landmarkPairs,1),1); 
    
    for i=1:size(landmarkPairs,1)
        LandmarkPair_i =landmarkPairs(i,:); 
        
        hashKey= ConvertLandmarkPairToHashKey(LandmarkPair_i); 
        
        hashTable(i,1)=uint32(songID); 
        hashTable(i,2)= hashKey; 
        hashTable(i,3)= uint32(LandmarkPair_i(1));
    end


end

