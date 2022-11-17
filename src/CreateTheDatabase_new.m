close all; 
clear all; 
clc; 


AddFunctionsFromOtherDirectories(); 

pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB4'

D = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\512\DB4\Songs\D_1024_2048_100_100.mat')));

mp3s = LoadMP3sFromDB(pathToDB);

numberOfSongs = size(mp3s,1); 
centroids_frames = cell(numberOfSongs, 3); 
centroids_overall = cell(numberOfSongs, 3); 

keypoints_frames = cell(numberOfSongs,3); 
keypoints_overall = cell(numberOfSongs,3); 
for i = 1:size(mp3s,1)
    mp3_i = mp3s(i,:);
    
    [~, ~, keypoints_frames_i, keypoints_overall_i, ~, ~, ~, ~, ~, ~] = AddSongToDatabase(i, mp3_i, D); 
   
    if keypoints_frames_i(1,1)==0 && keypoints_frames_i(1,2)==0
        keypoints_frames_i = keypoints_frames_i(2:end, :); 
    end 
    
    figure(i), 
    subplot(2,1,1), plot(keypoints_frames_i(:,3), 'm*'); 
    
    
    keypoints_frames{i,1}= keypoints_frames_i(:,1); 
    keypoints_frames{i,2}= keypoints_frames_i(:,2); 
    keypoints_frames{i,3}= keypoints_frames_i(:,3); 
    
    keypoints_overall{i,1}=keypoints_overall_i(:,1); 
    keypoints_overall{i,2}=keypoints_overall_i(:,2); 
    keypoints_overall{i,3}=keypoints_overall_i(:,3); 
  
    
    

    
end 

%save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Centroids_DBs\DB4\Time\256_2048\CoSamp\Songs\Frames\Keypoints_DominantAtoms.mat', 'keypoints_frames'); 
%save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Centroids_DBs\DB4\Time\256_2048\CoSamp\Songs\Overall\Keypoints_OverallActiveAtoms.mat', 'keypoints_overall'); 
