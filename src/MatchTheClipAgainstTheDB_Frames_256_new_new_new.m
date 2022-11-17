close all; 
clear all; 
clc; 

AddFunctionsFromOtherDirectories();

D = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB1\Songs\D_256_512_100_100.mat')));
W = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB1\W_256_512_100_100_iterations.mat')));

% randomly select a song from the database 
pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB1';
mp3s = LoadMP3sFromDB(pathToDB);

randomIdx = randi(size(mp3s,1),1); 
selectedMP3 = mp3s(randomIdx,:); 

AudioClip = ExtractTheAudioClip(selectedMP3, 10); 
audioClip = AudioClip{2}; 

[AudioFrames, SparseRepresentation] = CreateTheAudioClipsSparseRepresentation(AudioClip, D); 
Y= SparseRepresentation; 

W_ = [W, zeros(20,1)]; 


