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
D = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Frequency\129\DB4\Songs\D_128_256_100_100.mat')));

% hash keys of db 
HashMaps_DB  = struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB4\Frequency\Songs\128_256\HashMaps_FramesConstrainst.mat')); 
HashMaps_DB = HashMaps_DB{1}; 

randomIdx = randi(size(mp3s,1),1); 
selectedMP3 = mp3s(randomIdx,:); 

tic 
AudioClip = ExtractTheAudioClip(selectedMP3,10); 
%[audioFrames, sparseRepresentation, Keypoints, LandmarkPairs, HashTable_AudioClip]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D); 

[audioFrames, sparseRepresentation, Keypoints1, Keypoints3, Keypoints2,  LandmarkPairs1, LandmarkPairs3, LandmarkPairs2, HashTable1, HashTable3, HashTable2]= createTheAudioClipsFingerprints(AudioClip, D); 
HashTable_AudioClip = HashTable3; 


%MatchesBetweenAudioClipAndDB= findMatchesBetweenAudioClipAndDB( HashTable_AudioClip, HashMaps_DB); 
    
%[songTitle, songID, confidence]= identifySong( MatchesBetweenAudioClipAndDB, songIDs); 
  

hashKeys = HashTable_AudioClip(:,1);
A= hashKeys; 
      
k=1
for i = 1:length(HashMaps_DB)
    
        hashMap_song_i = HashMaps_DB{1,i};
        keys_i = cell2mat(keys(hashMap_song_i)); 
        keys_i = keys_i';
        values_i = cell2mat(values(hashMap_song_i));
       
        B = keys_i; 
        C = zeros(size(B)); 
        C(1:length(A))=A;
        
        
        
        HashKeys = zeros(size(keys_i)); 
        
        % sliding windows ????? 
        windowLength = size(hashKeys,1); 
        windowIncr = 1;
    
        numberOfWindows = (size(keys_i,1) - windowLength)/windowIncr; 
        
        
   
        Jaccards(i) = JaccardCoefficient(B,C);
        LevDistance(i) = levenshteinDistance(B,A); 
       
        
        
        
       
     end

[~,idx]= min(Jaccards);
MatchesBetweenAudioClipAndDB= findMatchesBetweenAudioClipAndDB( HashTable_AudioClip, HashMaps_DB); 
    
[songTitle, songID, confidence]= identifySong( MatchesBetweenAudioClipAndDB, songIDs); 

toc; 
