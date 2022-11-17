close all;
clear all; 
clc; 

AddFunctionsFromOtherDirectories(); 

pathToDBDirectory = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB4';
[mp3s, numberOfClasses] = LoadMP3sFromDB(pathToDBDirectory);

numberOfClasses = numberOfClasses-1; 

numberOfSongs=size(mp3s,1); 
numberOfFrames =zeros(numberOfSongs,1); 
frameLengths = zeros(numberOfSongs,1); 
frequencyBins = zeros(numberOfSongs,1); 

numberOfFrameSamples = 256;
for i=1:numberOfSongs 
    mp3_i = mp3s(i,:); 
    
    %audioFrames_i =segmentTheAudioSignalIntoAudioFrames(mp3_i, 8000, numberOfFrameSamples);  
    %AudioFrames{i}= audioFrames_i; 
    
    [~,~,~,~,filteredMagnitudes_i]= CalculateTheSignalsSpectrogram(mp3_i, 8000, numberOfFrameSamples); 
    FilteredMagnitudes{i}= filteredMagnitudes_i; 
    
    frequencyBins(i)=size(filteredMagnitudes_i,1); 
    
    numberOfFrames(i)= size(filteredMagnitudes_i,2); 
end 
frequencyBins = mean(frequencyBins);

X = zeros(frequencyBins, sum(numberOfFrames)); 
idx = 1;
for i = 1:numberOfSongs
    currentNumberOfFrames = numberOfFrames(i); 
    
    filteredMagnitudes= cell2mat(FilteredMagnitudes(i));
    
    temp = idx; 
    idx = idx + currentNumberOfFrames; 
    X(:,temp:idx-1)=filteredMagnitudes; 
      
end 
labels = CreateSongLabels_spectral(pathToDBDirectory, numberOfSongs, sum(numberOfFrames), numberOfFrameSamples);

% learn the label consistent dictionary
H_train = labels;
training_feats = X;

sparsitythres = 30; % sparsity prior
sqrt_alpha = 4; % weights for label constraint term
sqrt_beta = 2; % weights for classification err term
dictsize = round(frequencyBins*4); % dictionary size
iterations = 100; % iteration number
iterations4ini = 100; % iteration number for initialization


% get initial dictionary Dinit and Winit
fprintf('\nLC-KSVD initialization... ');
[Dinit,Tinit,Winit,Q_train] = initialization4LCKSVD(training_feats,H_train,dictsize,iterations4ini,sparsitythres);
fprintf('done!');

% run LC K-SVD Training (reconstruction err + class penalty)
fprintf('\nDictionary learning by LC-KSVD1...');
[D1,X1,T1,W1] = labelconsistentksvd1(training_feats,Dinit,Q_train,Tinit,H_train,iterations,sparsitythres,sqrt_alpha);
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Frequency\129\DB4\Songs\D_128_512_100_100.mat', 'D1');


save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Frequency\129\DB4\Songs\W_128_512_100_100.mat', 'W1');

save('.\trainingdata\dictionarydata1.mat','D1','X1','W1','T1');

fprintf('done!');


