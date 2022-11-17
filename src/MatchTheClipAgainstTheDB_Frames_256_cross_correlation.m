close all; 
clear all; 
clc; 

AddFunctionsFromOtherDirectories();

D = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\D_256_512_100_100.mat')));

% randomly select a song from the database 
pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB4';
mp3s = LoadMP3sFromDB(pathToDB);

randomIdx = randi(size(mp3s,1),1); 
selectedMP3 = mp3s(randomIdx,:); 

% keypoints of dominant atoms 
Keypoints_songs = struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Centroids_DBs\DB4\Time\Songs\256_512\Frames\Keypoints_DominantAtoms.mat'));
Keypoints_songs  = Keypoints_songs{1}; 

% centroids of dominant atoms 

AudioClip = ExtractTheAudioClip(selectedMP3, 10); 
audioClip = AudioClip{2}; 


[~, ~, keypoints, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D); 
numberOfClipsFrames = size(keypoints,1); 

windowLength = size(keypoints,1); 
windowIncr = 1; 
for i = 1 : size(mp3s,1)
    
    Keypoints_i = Keypoints_songs{i,3}; 
    
    numberOfWindows = (size(Keypoints_i,1) - windowLength)/windowIncr;
    
    idx = 1 
    for j = 1 : numberOfWindows
        tmp = Keypoints_i( j : j + windowLength - 1); 
        
        Idx1 = idx 
        idx = idx + windowLength - 1 
        X(Idx1 : idx, :)= tmp; 
    end 
    XX{i} = X; 
    
end 

for i = 1 :length(XX)
    X_i = XX{i}; 
    
    dist = DTW(keypoints(:,3), X_i); 
    Distances(i)= dist; 
end 
[~, minIdx] = min(Distances); 




