close all; 
clear all; 
clc; 

AddFunctionsFromOtherDirectories(); 

pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB4_with_Dictionaries';


MP3s = LoadMP3sAndDictionariesFromDB(pathToDB);

numberOfSongs = size(MP3s, 1); 
Keypoints_Frames = cell(numberOfSongs,1); 

for i = 1:size(MP3s,1)
    MP3_i = MP3s(i,:); 
    
    mp3_i =cell(1,3); 
    mp3_i{1} = MP3_i{1}; 
    mp3_i{2} = MP3_i{2}; 
    mp3_i{3} = MP3_i{4}; 
    
    D = MP3_i{3}; 
    
   [~, ~, keypoints_frames_i, keypoints_overall_i, ~, ~, ~, ~, ~, ~] = AddSongToDatabase(i, mp3_i, D); 
   
   if keypoints_frames_i(1,1)==0 && keypoints_frames_i(1,2)==0
        keypoints_frames_i = keypoints_frames_i(2:end, :); 
    end 
    
    figure(i), 
    subplot(2,1,1), plot(keypoints_frames_i(:,3), 'm*'); 
    
    
    keypoints_frames{i,1}= keypoints_frames_i(:,1); 
    keypoints_frames{i,2}= keypoints_frames_i(:,2); 
    keypoints_frames{i,3}= keypoints_frames_i(:,3); 
   
end

save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Centroids_DBs\DB4_DICT\Time\Songs\DictionaryPerSong\256_512\Frames\Keypoints_DominantAtoms.mat', 'keypoints_frames'); 