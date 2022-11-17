close all; 
clear all; 
clc;

AddFunctionsFromOtherDirectories();

pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB1_NEW'

mp3s = LoadMP3sFromDB(pathToDB); 
numberOfSamples = 256;


frameLength = numberOfSamples;
numberOfAtoms = 2*frameLength
    
D0= rand(frameLength, numberOfAtoms); 
D0= D0./repmat(sqrt(sum(D0.^2,1)), frameLength, 1); 


for i = 11:length(mp3s)
    
    audioFrames_i = segmentTheAudioSignalIntoAudioFrames(mp3s(i,:), 8000, numberOfSamples); 
    
    title = mp3s(i,1); 
    title = title{1}; 
    
    [~,Di] = KSVD(audioFrames_i, D0, randi(size(D0,2)-1), eps, [], [], 100);
    
    out = ['C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\Dictionaries_DB4\Dictionary_' title '.mat'];
    
    
    save(['C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\Dictionaries_DB4\Dictionary_', title ,'.mat'],'Di'); 
    clear Di 
    
    
    
end    
