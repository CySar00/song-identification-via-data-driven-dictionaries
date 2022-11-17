close all; 
clear all; 
clc; 


AddFunctionsFromOtherDirectories(); 
pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB1';

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
classes = zeros(1, totalNumberOfFrames); 
idx = 1; 
for i = 1:size(mp3s,1)
    frames_i =cell2mat( AudioFrames(i,2));
    
    tempIdx = idx; 
    idx = idx+size(frames_i,2)-1;
    
    audioFrames(:, tempIdx : idx)= frames_i; 
    classes(:, tempIdx:idx) = i; 
        
end 

% set number of classes to number of frames 
labels = CreateSongLabels(pathToDB, totalNumberOfFrames, totalNumberOfFrames); 


% learning the dictionary 
% learn the label consistent dictionary
H_train = labels;
training_feats = audioFrames;

sparsitythres = 30; % sparsity prior
sqrt_alpha = 4; % weights for label constraint term
sqrt_beta = 2; % weights for classification err term
dictsize = round(numberOfSamples*8); % dictionary size
iterations = 30; % iteration number
iterations4ini = 100; % iteration number for initialization


% get initial dictionary Dinit and Winit
fprintf('\nLC-KSVD initialization... ');
[Dinit,Tinit,Winit,Q_train] = initialization4LCKSVD(training_feats,H_train,dictsize,iterations4ini,sparsitythres);
fprintf('done!');

% run LC K-SVD Training (reconstruction err + class penalty)
fprintf('\nDictionary learning by LC-KSVD1...');
[D1,X1,T1,W1] = labelconsistentksvd1(training_feats,Dinit,Q_train,Tinit,H_train,iterations,sparsitythres,sqrt_alpha);

save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\Frames\D_256_2048_100_100.mat', 'D1');
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\Frames\T_256_2048_100_100.mat', 'T1');
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\Frames\W_256_2048_100_100.mat', 'W1');
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\Frames\X_256_2048_100_100.mat', 'X1');

save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\Q_256_2048_100_100.mat', 'Q_train');


save('.\trainingdata\dictionarydata1.mat','D1','X1','W1','T1');

fprintf('done!');




