clear all; 
clc; 
close 


AddFunctionsFromOtherDirectories(); 

% load the songs from the database 
pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB1'
mp3s = LoadMP3sFromDB(pathToDB); 

% load the dictionary 128 x 256
D1 = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Frequency\129\DB1\D_128_256.mat')));
frameSize = 256; 
atoms  = size(D1,2); 

HashMaps_frames = cell(size(mp3s,1), 3);
HashMaps_overall = cell(size(mp3s,1), 3);
for i = 1:length(mp3s)
    mp3_i = mp3s(i,:); 
    [~, ~, ~, ~, ~, ~, ~, ~, HashMap_frames, HashMap_overall] = addSongToDatabase(i, mp3_i, D1, 8000, frameSize);
    
    HashMaps_Frames{i,1} = i; 
    HashMaps_Frames{i,2}= mp3_i(1); 
    HashMaps_Frames{i,3}= HashMap_frames; 
    
    HashMaps_Overall{i,1} = i; 
    HashMaps_Overall{i,2}= mp3_i(1); 
    HashMaps_Overall{i,3}= HashMap_overall; 
    
    
end 
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB1\Frequency\129\HashMaps_Frames.mat', 'HashMaps_Frames');
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB1\Frequency\129\HashMaps_Overall.mat', 'HashMaps_Overall');


% load the dictionary 128 x 256
D1 = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Frequency\256\DB1\D_256_512.mat')));
frameSize = 512; 
atoms  = size(D1,2); 

hashMaps_Frames = cell(size(mp3s,1), 3);
hashMaps_Overall = cell(size(mp3s,1), 3);
for i = 1:length(mp3s)
    mp3_i = mp3s(i,:); 
    [~, ~, ~, ~, ~, ~, ~, ~, HashMap_frames, HashMap_overall] = addSongToDatabase(i, mp3_i, D1, 8000, frameSize);
    
    hashMaps_Frames{i,1} = i; 
    hashMaps_Frames{i,2}= mp3_i(1); 
    hashMaps_Frames{i,3}= HashMap_frames; 
    
    hashMaps_Overall{i,1} = i; 
    hashMaps_Overall{i,2}= mp3_i(1); 
    hashMaps_Overall{i,3}= HashMap_overall; 
    
    
end 
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB1\Frequency\256\HashMaps_Frames.mat', 'hashMaps_Frames');
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB1\Frequency\256\HashMaps_Overall.mat', 'hashMaps_Overall');



