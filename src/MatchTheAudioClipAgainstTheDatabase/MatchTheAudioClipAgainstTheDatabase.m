function [songID, JaccardCoefficients] = MatchTheAudioClipAgainstTheDatabase(hashTable_clip, hashMaps_songs)

    JaccardCoefficients = zeros(length(hashMaps_songs),1); 

    hashKeys_clip = hashTable_clip(1,:); 
   
    for i = 1:length(hashMaps_songs)
        hashMap_song_i = hashMaps_songs{1,i};
        
        keys_i = cell2mat(keys(hashMap_song_i)); 
        jaccardCoeff_i = JaccardCoefficient(hashKeys_clip, keys_i); 
        
        JaccardCoefficients(i)= jaccardCoeff_i;
        
         
    end 
    [maxCoeff, maxIdx] = max(JaccardCoefficients); 
    songID = maxIdx;

end

