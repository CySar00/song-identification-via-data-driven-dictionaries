close all; 
clear all; 
clc; 

addpath(genpath('.\OMPbox'));
addpath(genpath('.\ksvdbox'));


AddFunctionsFromOtherDirectories(); 

pathToDBDirectory = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB4';
[mp3s, numberOfClasses] = LoadMP3sFromDB(pathToDBDirectory);

numberOfClasses = numberOfClasses-1; 

numberOfSongs=size(mp3s,1); 
numberOfClasses = numberOfSongs
numberOfFrames =zeros(numberOfSongs,1); 
frameLengths = zeros(numberOfSongs,1); 

numberOfFrameSamples = 256;
for i=1:numberOfSongs 
    mp3_i = mp3s(i,:); 
    
    audioFrames_i =segmentTheAudioSignalIntoAudioFrames(mp3_i, 8000, numberOfFrameSamples);  
    AudioFrames{i}= audioFrames_i; 
    
    numberOfFrames(i)= size(audioFrames_i,2); 
    frameLengths(i)= size(audioFrames_i,1); 
end 
maxNumberOfFrames= max(numberOfFrames); 
frameLength= mean(frameLengths); 

%{
X = zeros(frameLength, sum(numberOfFrames)); 
idx = 1;
for i = 1:numberOfSongs
    currentNumberOfFrames = numberOfFrames(i); 
    audioFrames = cell2mat(AudioFrames(i)); 
    
    temp = idx; 
    idx = idx + currentNumberOfFrames; 
    X(:,temp:idx-1)=audioFrames; 
      
end 
%}


X=zeros(frameLength, numberOfSongs*maxNumberOfFrames); 
frames = zeros(size(mp3s,1),1);
idx = 1; 
for i=1:numberOfSongs 
    audioFrames= cell2mat(AudioFrames(i)); 
    
    X_i = zeros(frameLength, maxNumberOfFrames); 
    X_i(:, 1:size(audioFrames,2))= audioFrames; 
    frames(i) = size(audioFrames,2); 
    
    tmp = idx; 
    idx = idx + size(audioFrames,2); 
    
    X(:, tmp : idx-1 ) = audioFrames; 
    frames(i) = idx-1;
    
    %X(:, (i-1)*maxNumberOfFrames+1 : i*maxNumberOfFrames)= X_i; 
end 

labels = createLabels(pathToDBDirectory, numberOfClasses, numberOfSongs*maxNumberOfFrames);

% learn the label consistent dictionary
H_train = labels;
training_feats = X;


sparsitythres = 30; % sparsity prior
sqrt_alpha = 4; % weights for label constraint term
sqrt_beta = 2; % weights for classification err term
dictsize = round(numberOfFrameSamples*2); % dictionary size
iterations = 50; % iteration number
iterations4ini = 20; % iteration number for initialization


% get initial dictionary Dinit and Winit
fprintf('\nLC-KSVD initialization... ');
[Dinit,Tinit,Winit,Q_train] = initialization4LCKSVD(training_feats,H_train,dictsize,iterations4ini,sparsitythres);
fprintf('done!');

% run LC K-SVD Training (reconstruction err + class penalty)
fprintf('\nDictionary learning by LC-KSVD1...');
[D1,X1,T1,W1] = labelconsistentksvd1(training_feats,Dinit,Q_train,Tinit,H_train,iterations,sparsitythres,sqrt_alpha);


save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\D_256_512_100_100_iterations.mat', 'D1');
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\W_256_512_100_100_iterations.mat', 'W1');
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\T_256_512_100_100_iterations.mat', 'T1');
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\X_256_512_100_100_iterations.mat', 'X1');
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Q_256_512_100_100_iterations.mat', 'H_train');




save('.\trainingdata\dictionarydata1.mat','D1','X1','W1','T1');



fprintf('done!');


