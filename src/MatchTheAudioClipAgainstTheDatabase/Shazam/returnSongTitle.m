function songTitle = returnSongTitle(songID, songIDsAndTitles)
%
%   Input:: 
%       songIDs 
%       songIDsAndTitles 
%
%   Output:: 
%       songTitle 
    
    

    isSongID = cellfun( @(x)isequal(x,songID), songIDsAndTitles); 
    
    [rowOfIndex, columnOfIndex] = find(isSongID) ; 
    songTitle = songIDsAndTitles{rowOfIndex,2};
    
      
    
end 