clear all; 
clc; 
close 


AddFunctionsFromOtherDirectories(); 

% load the songs from the database 
pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB4';
mp3s = LoadMP3sFromDB(pathToDB); 

% load the dictionary 256 x 520 
D = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\128\DB4\Songs\D_128_256_100_100.mat')));
frameSize = size(D,1); 
atoms  = size(D,2); 

numberOfSongs = size(mp3s,1); 
centroids_frames = cell(numberOfSongs, 3); 
centroids_overall = cell(numberOfSongs, 3); 

keypoints_frames = cell(numberOfSongs,3); 
keypoints_framesConstraints = cell(numberOfSongs,3) 
keypoints_overall = cell(numberOfSongs,3); 


energies  = zeros(1, length(mp3s)); 
for i = 1 : length(mp3s)
    mp3_i = mp3s(i,:); 
    
    audio_signal_i = mp3_i{2}; 
    envelope_i = abs(hilbert(audio_signal_i)); 
    
    energy_i = mean(sum(envelope_i.^2));
    energies(:,i)= energy_i; 
   
end 





for i = 1:size(mp3s,1)
    mp3_i = mp3s(i,:);
    
    [~, ~, keypoints_frames_i, keypoints_framesConstraints_i, keypoints_overall_i, ~, ~, ~, ~, ~, ~] = AddSongToDatabase(i, mp3_i, D); 
   
    if keypoints_frames_i(1,1)==0 && keypoints_frames_i(1,2)==0
        keypoints_frames_i = keypoints_frames_i(2:end, :); 
    end 
    
    figure(i), 
    subplot(2,1,1), plot(keypoints_frames_i(:,3), 'm*'); 
    
    
    keypoints_frames{i,1}= keypoints_frames_i(:,1); 
    keypoints_frames{i,2}= keypoints_frames_i(:,2); 
    keypoints_frames{i,3}= keypoints_frames_i(:,3); 
    
    keypoints_framesConstraints{i,1}= keypoints_framesConstraints_i(:,1); 
    keypoints_framesConstraints{i,2}= keypoints_framesConstraints_i(:,2); 
    keypoints_framesConstraints{i,3}= keypoints_framesConstraints_i(:,3); 

    
    keypoints_overall{i,1}=keypoints_overall_i(:,1); 
    keypoints_overall{i,2}=keypoints_overall_i(:,2); 
    keypoints_overall{i,3}=keypoints_overall_i(:,3); 
  
    
    

    
end 

save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Centroids_DBs\DB4\Time\Songs\128_256\Frames\Keypoints_DominantAtoms.mat', 'keypoints_frames'); 
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Centroids_DBs\DB4\Time\Songs\128_256\Frames\Keypoints_DominantAtomsWithConstraints.mat', 'keypoints_framesConstraints'); 

save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Centroids_DBs\DB4\Time\Songs\128_256\Overall\Keypoints_OverallActiveAtoms.mat', 'keypoints_overall'); 
