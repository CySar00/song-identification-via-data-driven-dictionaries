function HashTable = HashTheAudioClipsLandmarkPairs(LandmarkPairs)
%
%   Input:: 
%       LandmarkPairs 
%
%   Output:: 
%       HashTable

    HashTable =zeros(size(LandmarkPairs,1),2); 
    
    for i=1:size(LandmarkPairs,1)
        landmarkPair_i = LandmarkPairs(i,:); 
        
        hashKey =  ConvertTheAudioClipsLandmarkPairToHashKey(landmarkPair_i); 
        
        HashTable(i,1)= hashKey; 
        HashTable(i,2)= uint32(landmarkPair_i(1));
    
    end 

end

