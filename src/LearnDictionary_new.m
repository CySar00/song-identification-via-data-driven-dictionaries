close all; 
clear all; 
clc; 

AddFunctionsFromOtherDirectories(); 

pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB4';
mp3s = LoadMP3sFromDB(pathToDB); 

AudioFrames= cell(size(mp3s,1),2); 
numberOfSamples = 256;
totalNumberOfFrames = 0; 
for  i = 1:length(mp3s)
    audioFrames_i = segmentTheAudioSignalIntoAudioFrames(mp3s(i,:), 8000, numberOfSamples); 
    
    AudioFrames{i,1} = mp3s{i,1}; 
    AudioFrames{i,2} = audioFrames_i;
    
    totalNumberOfFrames = totalNumberOfFrames + size(audioFrames_i,2); 
end 

audioFrames = zeros(numberOfSamples, totalNumberOfFrames);
idx = 1; 
for i = 1:size(mp3s,1)
    frames_i =cell2mat( AudioFrames(i,2));
    
    tempIdx = idx; 
    idx = idx+size(frames_i,2)-1;
    
    audioFrames(:, tempIdx : idx)= frames_i;      
end 

D0 = rand(size(audioFrames,1), 2*size(audioFrames,1)); 
sparsitythres = randi(size(D0,2), 1); % sparsity prior
iterations = 100;


params.data = audioFrames;
params.Tdata = sparsitythres; % spasity term
params.iternum = iterations;
params.memusage = 'high';

% normalization
params.initdict = normcols(D0);

% ksvd process
[D,X,Error] = ksvd(params,'');
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\KSVD\D_256_512_100.mat', 'D'); 

