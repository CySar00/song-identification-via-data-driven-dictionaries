close all; 
clear; 
clc; 

AddFunctionsFromOtherDirectories(); 

pathToDBDirectory = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB4';

D = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\D_256_512_100_100.mat'; 
D = cell2mat(struct2cell(load(D))); 

mp3s = LoadMP3sFromDB(pathToDB); 
numberOfSongs = size(mp3s,1); 

for i = 1 : numberOfSongs 
    [~, ~, keypoints_frames_i, ~, ~, ~, ~, ~, ~, ~]= AddSongToDatabase(i, mp3_i, D); 
    
    
end 