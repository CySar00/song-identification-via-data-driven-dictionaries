AddFunctionsFromOtherDirectories();

D = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB1\Songs\D_256_512_100_100.mat')));

T = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB1\Songs\T_256_512_100_100.mat')));
W = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB1\Songs\W_256_512_100_100.mat')));


% randomly select a song from the database 
pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB1';
mp3s = LoadMP3sFromDB(pathToDB);

randomIdx = randi(size(mp3s,1),1); 
selectedMP3 = mp3s(randomIdx,:); 


% centroids of dominant atoms 

AudioClip = ExtractTheAudioClip(selectedMP3, 10); 
audioClip = AudioClip{2}; 

fs_new = 8000; 
frame = 256; 
overlap = 0.5;
audioFrames = segmentTheAudioSignalIntoAudioFrames(AudioClip, fs_new, frame, overlap); 
    

labels = zeros(size(mp3s,1), size(audioFrames,2)*size(mp3s,1));  
idx = 1;
for i = 1:size(mp3s,1)
   tempIdx = idx; 
   idx = idx + size(audioFrames,2); 
 
    
   labels(i, tempIdx : idx -1 ) = ones(1, size(audioFrames,2)); 
    
end 
G = D'*D; 
sparsity = 30; 
Gamma = omp(D'*audioFrames, G, sparsity); 

spCode = Gamma; 
scoreEst = W*spCode; 

[maxv_est, maxind_est] = max((max(scoreEst)));  % classifying  
%{
idx = 1; 
for i = 1:size(labels,1)
    tempIdx = idx; 
    idx = idx + size(audioFrames,2); 
    
    score_gt = labels(:,tempIdx : idx -1 );
    [maxv_gt, maxind_gt] = max(max(score_gt));
     
  

    
    
end 

%}
