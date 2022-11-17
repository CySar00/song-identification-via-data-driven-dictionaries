function [songTitle, mostFrequentSongID, confidence] = identifySong( MatchesBetweenAudioClipAndDB, songIDsAndTitles)
%
%   Input:: 
%       MatchesBetweenAudioClipAndDB
%       songIDsAndTitles 
%
%   Output:: 
%       songTitle 

    SongIDsOfMatches = MatchesBetweenAudioClipAndDB(:,1); 
    HashValuesOfMatches = MatchesBetweenAudioClipAndDB(:,2); 
    OffsetsOfMatches = MatchesBetweenAudioClipAndDB(:,3); 
    
    %   find the most common offset and hash value 
    mostFrequentOffset = mode(OffsetsOfMatches); 
    mostFrequentHashValue =mode(HashValuesOfMatches); 
    
    %indices_= find ( OffsetsOfMatches==mostFrequentOffset & HashValuesOfMatches==mostFrequentHashValue); 
    indices_ = find(OffsetsOfMatches==mostFrequentOffset);
    SongIDs= SongIDsOfMatches(indices_); 
    
    SongIDs=sort(SongIDs, 'descend'); 
    
    %   find the most frequent song id 
    [mostFrequentSongID, occurences] = mode(SongIDs); 

    confidence = occurences/ length(SongIDs); 
    
    songTitle = returnSongTitle(mostFrequentSongID, songIDsAndTitles); 
    
    fprintf(' Song Title : %s \t Confidence Value : %0.3f \n', songTitle, confidence); 
end 
