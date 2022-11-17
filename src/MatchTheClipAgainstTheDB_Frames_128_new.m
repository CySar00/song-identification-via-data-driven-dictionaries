close all; 
clear all; 
clc; 

AddFunctionsFromOtherDirectories();

D = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\128\DB1\Songs\D_128_256_100_100.mat')));

% randomly select a song from the database 
pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB1';
mp3s = LoadMP3sFromDB(pathToDB);

randomIdx = randi(size(mp3s,1),1); 
selectedMP3 = mp3s(randomIdx,:); 

% keypoints of dominant atoms 
Keypoints_songs = struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Centroids_DBs\DB1_NEW\Time\Songs\128_256\Frames\Keypoints_DominantAtoms.mat'));
Keypoints_songs  = Keypoints_songs{1}; 

% centroids of dominant atoms 

AudioClip = ExtractTheAudioClip(selectedMP3, 10); 
audioClip = AudioClip{2}; 

audioClip1 = awgn(audioClip,20);

AudioClip1{1}= AudioClip{1}; 
AudioClip1{2} = audioClip1; 
AudioClip1{3}= AudioClip{3}; 

audioClip2 = awgn(audioClip,15); 
AudioClip2{1}= AudioClip{1}; 
AudioClip2{2} = audioClip2; 
AudioClip2{3}= AudioClip{3}; 

audioClip3 = awgn(audioClip,10);
AudioClip3{1}= AudioClip{1}; 
AudioClip3{2} = audioClip2; 
AudioClip3{3}= AudioClip{3}; 

audioClip4 = awgn(audioClip,5); 
AudioClip4{1}= AudioClip{1}; 
AudioClip4{2} = audioClip4; 
AudioClip4{3}= AudioClip{3}; 


[~, ~, keypoints, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D); 
numberOfClipsFrames = size(keypoints,1); 

[~, ~, keypoints1, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip1, D); 
numberOfClipsFrames1 = size(keypoints1,1); 

[~, ~, keypoints2, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip2, D); 
numberOfClipsFrames2 = size(keypoints2,1); 

[~, ~, keypoints3, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip3, D); 
numberOfClipsFrames3 = size(keypoints3,1); 

[~, ~, keypoints4, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip4, D); 
numberOfClipsFrames4 = size(keypoints4,1); 


euclideanDistance = zeros(size(Keypoints_songs,1), 1); 
pearsonCoeff = zeros(size(Keypoints_songs,1), 1); 

pearsonCoeff1 = zeros(size(Keypoints_songs,1), 1); 
pearsonCoeff2 = zeros(size(Keypoints_songs,1), 1); 
pearsonCoeff3 = zeros(size(Keypoints_songs,1), 1); 
pearsonCoeff4 = zeros(size(Keypoints_songs,1), 1); 



for i = 1: size(Keypoints_songs,1)
    keypoints_song_i = Keypoints_songs{i,3}; 
    
    windowLength = size(keypoints,1); 
    windowIncr = 1; 
    
    numberOfWindows = (size(keypoints_song_i,1) - windowLength)/windowIncr; 
    
    numberOfTenSecondFrames = floor(size(keypoints_song_i,1)/size(keypoints,1)); 
    tempSum1 = 0;
    tempSum2=0;
         
    pearsons = zeros(numberOfWindows,1); 
    euclideanDistances = zeros(numberOfWindows,1); 
    for j = 1:numberOfWindows
        tempKeypoints = keypoints_song_i(j : j+windowLength-1);
        
        pearson = corr(keypoints(:,3), tempKeypoints);
        
        pearson1 = corr(keypoints1(:,3), tempKeypoints);
        pearson2 = corr(keypoints2(:,3), tempKeypoints);
        pearson3 = corr(keypoints3(:,3), tempKeypoints);
        pearson4 = corr(keypoints4(:,3), tempKeypoints);
        
        
        tempSum = sqrt(sum(keypoints(:,3) - tempKeypoints).^2);
    
        %tempSum1=tempSum1+tempSum;
        %tempSum2=tempSum2+pearson;
        
        pearsons(j)=pearson;
        
        pearsons1(j)=pearson1;
        pearsons2(j)=pearson2;
        pearsons3(j)=pearson3;
        pearsons4(j)=pearson4;
        
        
        
        euclideanDistances(j)=tempSum;
        
    end 
    
    
    %{
    for j = 0:numberOfTenSecondFrames
        tempKeypoints = keypoints_song_i(j*numberOfClipsFrames+1:(j+1)*numberOfClipsFrames);
        
        
        pearson = corr(keypoints(:,3), tempKeypoints);
        tempSum = sqrt(sum(keypoints(:,3) - tempKeypoints).^2);
    
        size(tempKeypoints)
        
    end 
    %}
   
    euclideanDistance(i)= min(euclideanDistances) ;
    
    pearsonCoeff(i)= max( pearsons);
    
    pearsonCoeff1(i)= max( pearsons1);
    pearsonCoeff2(i)= max( pearsons2);
    pearsonCoeff3(i)= max( pearsons3);
    pearsonCoeff4(i)= max( pearsons4);
    
        
end 
   
[minValue, minIdx]= min(euclideanDistance);
[minValue_p, minIdx_p] = max(pearsonCoeff);

[minValue_p1, minIdx_p1] = max(pearsonCoeff1);
[minValue_p2, minIdx_p2] = max(pearsonCoeff2);
[minValue_p3, minIdx_p3] = max(pearsonCoeff3);
[minValue_p4, minIdx_p4] = max(pearsonCoeff4);