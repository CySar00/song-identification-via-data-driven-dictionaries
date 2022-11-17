function [MatchesBetweenAudioClipAndDB]= findMatchesBetweenAudioClipAndDB(HashTable_AudioClip, HashMaps_DB)
%
%
%   Input:: 
%       HashTable_AudioClip
%       HashMap_DB
%
%   Output:: 
%       MatchesBetweenAudioClipAndDB 

    %   number of songs (in the database)
    numberOfSongs = length(HashMaps_DB);
    
    %   size of the audio clip's hash table 
    sizeOfAudioClipHashTable= size(HashTable_AudioClip,1); 
    
    %   scan through the audio clip's hash table 
    numberOfMatches=0; 
    for i=1:sizeOfAudioClipHashTable 
        hashValue_AudioClip_i = HashTable_AudioClip(i,1); 
        offset_AudioClip_i = HashTable_AudioClip(i,2); 
        
        HashValue_AudioClip_i = hashValue_AudioClip_i+1; 
        
        %   scan through the database 
        for j=1:numberOfSongs 
            %   extract the j-th hash map of the database 
            HashMap_j =HashMaps_DB{j}; 
            
            %   extract the j-th hash map's key and value set (i.e the j-th
            %   hash map's hash values and offsets)
            keySet_HashMapj = cell2mat( keys(HashMap_j)); 
            valueSet_HashMapj = cell2mat(values(HashMap_j)); 
            
            hashValues_HashMapj = keySet_HashMapj;
            offsets_HashMapj= valueSet_HashMapj; 
            
            indices_HashMapj= find( hashValues_HashMapj== HashValue_AudioClip_i) 
            
            for k=1:length(indices_HashMapj)
                numberOfMatches=numberOfMatches+1; 
                
                offset_HashMapj = offsets_HashMapj(indices_HashMapj(k)); 
                
                differenceBetweenOffsets = offset_AudioClip_i-offset_HashMapj; 
                
                MatchesBetweenAudioClipAndDB(numberOfMatches,1)=j; 
                MatchesBetweenAudioClipAndDB(numberOfMatches,2)=HashValue_AudioClip_i; 
                MatchesBetweenAudioClipAndDB(numberOfMatches,3)= differenceBetweenOffsets;
            end
            
        end 
        
    
    end 

end 