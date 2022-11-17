close all; 
clear all; 
clc; 

AddFunctionsFromOtherDirectories(); 

pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB4\DB4_DICT'; 
mp3s = LoadMP3sFromDB(pathToDB); 

numberOfFrames = zeros(size(mp3s,1), 1); 
frameLengths = zeros(size(mp3s,1), 1); 
AudioFrames = zeros(size(mp3s,1), 1); 

for i = 1 : length(mp3s)
      mp3_i = mp3s(i,:); 
    
    audioFrames_i =segmentTheAudioSignalIntoAudioFrames(mp3_i, 8000, numberOfFrameSamples);  
    AudioFrames{i}= audioFrames_i; 
    
    numberOfFrames(i)= size(audioFrames_i,2); 
    frameLengths(i)= size(audioFrames_i,1); 
end 

totalNumberOfFrames = sum(numberOfFrames);
frameLength= mean(frameLengths); 
X = zeros(frameLengh, totalNumberOfFrames); 

idx = 1 ;
for i = 1:length(numberOfFrames)
    audioFrames = cell2mat(AudioFrames(i)); 
  
    tempIdx = idx; 
    idx = idx + numberOfFrames(i); 
   
    X(:,tempIdx:idx-1) : audioFrames(
    
    
end 

