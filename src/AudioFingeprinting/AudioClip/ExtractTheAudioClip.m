function AudioClip = ExtractTheAudioClip(mp3, clipDuration)

    if nargin<2
        clipDuration = 10; 
    end 
    
    audioSignal = cell2mat(mp3(2)); 
    fs = cell2mat(mp3(3)); 
    
    %   convert the audio signal from stereo to mono 
    if size(audioSignal,2)>1
        audioSignal = sum(audioSignal,2)/2;
    end 
    mp3Length = length(audioSignal); 
    
    tt_ = 0:(1/fs): (mp3Length-1)/fs; 
    
    audioClip_startIndex = randi( round( (mp3Length-1)/fs)); 
    audioClip_endIndex = audioClip_startIndex+clipDuration; 
    
    
    if audioClip_startIndex > ((mp3Length-1)/fs)-clipDuration
        indices_ = tt_>=audioClip_startIndex; 
        
        audioClip= audioSignal(indices_); 
        audioClip = [audioClip; zeros( clipDuration*fs-length(audioClip),1)];
    
    else 
        indices_  = tt_>=audioClip_startIndex & tt_<audioClip_endIndex; 
        audioClip = audioSignal(indices_); 
    end 
    
    AudioClip = cell(1,3); 
    
    AudioClip{1}= mp3(1); 
    AudioClip{2}= audioClip;
    AudioClip{3} = fs; 
    
    %sound(audioClip, fs); 
    


end

