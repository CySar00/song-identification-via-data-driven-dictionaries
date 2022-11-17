close all; 
clear all; 
clc; 

addpath(genpath('.\OMPbox'));
addpath(genpath('.\ksvdbox'));


AddFunctionsFromOtherDirectories(); 

pathToDBDirectory = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB1';
[mp3s, numberOfClasses] = LoadMP3sFromDB(pathToDBDirectory);

numberOfClasses = numberOfClasses-1; 

numberOfSongs=size(mp3s,1); 
numberOfFrames =zeros(numberOfSongs,1); 
frameLengths = zeros(numberOfSongs,1); 
frequencyBins = zeros(numberOfSongs,1); 

numberOfFrameSamples = 512;
for i=1:numberOfSongs 
    mp3_i = mp3s(i,:); 
    
    %audioFrames_i =segmentTheAudioSignalIntoAudioFrames(mp3_i, 8000, numberOfFrameSamples);  
    %AudioFrames{i}= audioFrames_i; 
    
    [~,~,~,~,filteredMagnitudes_i]= CalculateTheSignalsSpectrogram(mp3_i, 8000, numberOfFrameSamples); 
    FilteredMagnitudes{i}= filteredMagnitudes_i; 
    
    frequencyBins(i)=size(filteredMagnitudes_i,1); 
    
    numberOfFrames(i)= size(filteredMagnitudes_i,2); 
end 
maxNumberOfFrames= max(numberOfFrames); 
%frameLength= mean(frameLengths); 

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


%{
X=zeros(frameLength, numberOfSongs*maxNumberOfFrames); 
for i=1:numberOfSongs 
    audioFrames= cell2mat(AudioFrames(i)); 
    
    X_i = zeros(frameLength, maxNumberOfFrames); 
    X_i(:, 1:size(audioFrames,2))= audioFrames; 
    
    X(:, (i-1)*maxNumberOfFrames+1 : i*maxNumberOfFrames)= X_i; 
end 
%}
labels = createLabels_spectral(pathToDBDirectory, numberOfClasses, sum(numberOfFrames), numberOfFrameSamples);

% learn the label consistent dictionary
H_train = labels;
training_feats = X;

sparsitythres = 30; % sparsity prior
sqrt_alpha = 4; % weights for label constraint term
sqrt_beta = 2; % weights for classification err term
dictsize = round(frequencyBins*2); % dictionary size
iterations = 50; % iteration number
iterations4ini = 20; % iteration number for initialization


% get initial dictionary Dinit and Winit
fprintf('\nLC-KSVD initialization... ');
[Dinit,Tinit,Winit,Q_train] = initialization4LCKSVD(training_feats,H_train,dictsize,iterations4ini,sparsitythres);
fprintf('done!');

% run LC K-SVD Training (reconstruction err + class penalty)
fprintf('\nDictionary learning by LC-KSVD1...');
[D1,X1,T1,W1] = labelconsistentksvd1(training_feats,Dinit,Q_train,Tinit,H_train,iterations,sparsitythres,sqrt_alpha);
save('.\trainingdata\dictionarydata1.mat','D1','X1','W1','T1');

save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Frequency\256\DB1\D_256_512.mat', 'D1');
fprintf('done!');

