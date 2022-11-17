close all; 
clear all; 
clc; 

AddFunctionsFromOtherDirectories(); 
pathToDBDir=''; 
mp3s = LoadMP3sFromDB(pathToDBDir);

songIDs = cell(length(mp3s),1); 

for i=1:length(mp3s)
    songIDs{i,1}=i; 
    songIDs{i,2}  = mp3s{i,1}; 
    
end 


% dictionary 
D = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\128\DB4\Songs\D_128_256_100_100.mat')));

% hash keys of db 
HashMaps_Songs = struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB4\Time\Songs\128_256\HashMaps_FramesWithConstraints.mat'));
HashMaps_DB = HashMaps_Songs{1};


randomIdx = randi(size(mp3s,1),1); 
selectedMP3 = mp3s(randomIdx,:); 

tic 
AudioClip = ExtractTheAudioClip(selectedMP3, 10); 
[audioFrames, sparseRepresentation, Keypoints, LandmarkPairs, HashTable_AudioClip]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D); 

MatchesBetweenAudioClipAndDB= findMatchesBetweenAudioClipAndDB( HashTable_AudioClip, HashMaps_DB); 
    
[songTitle, songID, confidence]= identifySong( MatchesBetweenAudioClipAndDB, songIDs); 
  

toc; 
