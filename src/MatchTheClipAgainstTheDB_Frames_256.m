clear all; 
close all; 
clc; 

AddFunctionsFromOtherDirectories(); 

% load the dictionary 
D = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB1\D_256_512.mat')));

% load the hash maps 
HashMaps_Songs = struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB1\Time\256\HashMaps_Frames.mat'));
HashMaps_Songs = HashMaps_Songs{1}; 

% randomly select a song from the database 
pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB1';
mp3s = LoadMP3sFromDB(pathToDB);

randomIdx = randi(size(mp3s,1),1); 
selectedMP3 = mp3s(randomIdx,:); 

AudioClip = ExtractTheAudioClip(selectedMP3, 10); 
[audioFrames, sparseRepresentation, Keypoints, LandmarkPairs, HashTable]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D); 

% match the audio clip against the database 
[songID, coeffs] = MatchTheAudioClipAgainstTheDatabase(HashTable, HashMaps_Songs); 


for i = 1:length(HashMaps)
    hashMap_i = HashMaps{i}; 
    
    
    
    
    
    
end 
