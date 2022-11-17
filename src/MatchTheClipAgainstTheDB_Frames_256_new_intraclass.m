close all; 
clear
clc; 

AddFunctionsFromOtherDirectories();


D = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\D_256_512_100_100.mat';

D = cell2mat(struct2cell(load(D))); 

Q= 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\Labels_256_512_100_100.mat';
Q = cell2mat(struct2cell(load(Q))); 

W = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\W_256_512_100_100.mat';
W = cell2mat(struct2cell(load(W))); 

pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB4';
mp3s = LoadMP3sFromDB(pathToDB);

randomIdx = randi(size(mp3s,1),1); 
selectedMP3 = mp3s(randomIdx,:); 

Keypoints_songs = struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Centroids_DBs\DB4\Time\Songs\128_256\Frames\Keypoints_DominantAtoms.mat'));
Keypoints_songs  = Keypoints_songs{1}; 

Frames = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\Frames_256_512_100_100.mat'))); 

% centroids of dominant atoms 

AudioClip = ExtractTheAudioClip(selectedMP3, 10); 
audioClip = AudioClip{2}; 

[~, y, keypoints, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D);
 keypoints = keypoints(2:end, :);
numberOfClipsFrames = size(keypoints,1); 

yw = W*y 
windowSize = size(yw,2);

tmpIdx = 1;

windowIncr = 1; 

for i = 1:size(Frames,1)
    numberOfWindows_i = (Frames(i) - numberOfClipsFrames)/windowIncr; 
    Windows(i,:) = numberOfWindows_i; 
end 



numberOfWindows = (size(Q,2) - windowSize)/windowIncr ; 

for i = 1:numberOfWindows
    
    Qq = Q(:, i : i + windowSize-1);
    diff = Qq - yw ;
    
    
    if any(abs(diff)~= yw )
        Indices(tmpIdx) = i; 
        tmpIdx = tmpIdx + 1;
    end 
    
    
    
    
end 







