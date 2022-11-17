close all; 
clear all; 
clc; 

AddFunctionsFromOtherDirectories();

D_128_258  = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\128\DB4\Songs\D_128_256_100_100.mat'; 
D_128_258 = cell2mat(struct2cell(load(D_128_258))); 

D_256_512  = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB1\D_256_512_100_100_iterations.mat'; 
D_256_512 = cell2mat(struct2cell(load(D_256_512))); 

D_256_1024  = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\D_256_1024_100_100.mat';
D_256_1024 = cell2mat(struct2cell(load(D_256_1024))); 

D_256_2048  = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\D_256_2048_100_100.mat';
D_256_2048 = cell2mat(struct2cell(load(D_256_2048))); 

D_512_1024 = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\512\DB4\Songs\D_1024_2048_100_100.mat'; 
D_512_1024 = cell2mat(struct2cell(load(D_512_1024))); 

D_1024_2048 = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\1024\DB4\Songs\D_1024_2048_100_100.mat\';
D_1024_2048 = cell2mat(struct2cell(load(D_1024_2048))); 

DB4_Keypoints_256_512 = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Centroids_DBs\DB4\Time\Songs\256_512\Frames\Keypoints_DominantAtoms.mat';
DB4_Keypoints_256_512 = struct2cell(load(DB4_Keypoints_256_512));
DB4_Keypoints_256_512 = DB4_Keypoints_256_512{1};
Keypoints_songs =DB4_Keypoints_256_512 ;


DB4_DICT = DB4_Keypoints_256_512(1:35,:);

pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB4';
mp3s = LoadMP3sFromDB(pathToDB);

randomIdx = randi(size(mp3s,1),1); 
selectedMP3 = mp3s(randomIdx,:); 

AudioClip = ExtractTheAudioClip(selectedMP3, 10); 
t99= tic 

[~, ~, keypoints, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D_256_512); 
numberOfClipsFrames = size(keypoints,1); 
t9 = toc(t99)

t11 = tic
for i = 1: size(Keypoints_songs,1)
    keypoints_song_i = Keypoints_songs{i,3}; 
    
    atoms_idx_song_i = Keypoints_songs{i,2};
    
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
        tempAtoms  = atoms_idx_song_i(j: j+windowLength-1); 
        
        pearson = corr(keypoints(:,3), tempKeypoints);
       
        pearsons(j)=pearson;
     
    end 
     
    pearsonCoeff(i)= max( pearsons);

            
end 
   
[minValue_p, minIdx_p] = max(pearsonCoeff);
t1 = toc(t11); 


t22 = tic
numberOfClipsFrames = size(keypoints,1); 
for i = 1: size(Keypoints_songs,1)
    keypoints_song_i = Keypoints_songs{i,3}; 
    
    atoms_idx_song_i = Keypoints_songs{i,2};
    
    windowLength = size(keypoints,1); 
    windowIncr = 1; 
    
    numberOfWindows = (size(keypoints_song_i,1) - windowLength)/windowIncr; 
    
    numberOfTenSecondFrames = floor(size(keypoints_song_i,1)/size(keypoints,1)); 
    tempSum1 = 0;
    tempSum2=0;
         
    hammings = zeros(numberOfWindows,1); 
    for j = 1:numberOfWindows
        tempKeypoints = keypoints_song_i(j : j+windowLength-1);
        tempAtoms  = atoms_idx_song_i(j: j+windowLength-1); 
        
        atoms = keypoints(:,2); 
        hamm = sum(sum(pdist2(atoms,tempAtoms, 'hamming')))
      
        hammings(j)= hamm;

    end 
     
    hammingDist(i)= min(hammings); 
            
end 
[minValue_h, minIdx_h] = min(hammingDist); 
t2 = toc(t22); 

DB1_Keypoints_256_512 = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Centroids_DBs\DB1_NEW\Time\Songs\256_512\Frames\Keypoints_DominantAtoms.mat';
DB1_Keypoints_256_512 = struct2cell(load(DB1_Keypoints_256_512));
DB1_Keypoints_256_512 = DB1_Keypoints_256_512{1};
Keypoints_songs = DB1_Keypoints_256_512;


t33 = tic 
for i = 1: size(Keypoints_songs,1)
    keypoints_song_i = Keypoints_songs{i,3}; 
    
    atoms_idx_song_i = Keypoints_songs{i,2};
    
    windowLength = size(keypoints,1); 
    windowIncr = 1; 
    
    numberOfWindows = (size(keypoints_song_i,1) - windowLength)/windowIncr; 
    
    numberOfTenSecondFrames = floor(size(keypoints_song_i,1)/size(keypoints,1)); 
    tempSum1 = 0;
    tempSum2=0;
         
    for j = 1:numberOfWindows
        tempKeypoints = keypoints_song_i(j : j+windowLength-1);
        tempAtoms  = atoms_idx_song_i(j: j+windowLength-1); 
        
        pearson = corr(keypoints(:,3), tempKeypoints);
       
        pearsons(j)=pearson;
      
    end 
     
    pearsonCoeff(i)= max( pearsons);
            
end 
   
[minValue_p, minIdx_p] = max(pearsonCoeff);
t3 = toc(t33); 


t44 =tic

for i = 1: size(Keypoints_songs,1)
    keypoints_song_i = Keypoints_songs{i,3}; 
    
    atoms_idx_song_i = Keypoints_songs{i,2};
    
    windowLength = size(keypoints,1); 
    windowIncr = 1; 
    
    numberOfWindows = (size(keypoints_song_i,1) - windowLength)/windowIncr; 
    
    numberOfTenSecondFrames = floor(size(keypoints_song_i,1)/size(keypoints,1)); 
    tempSum1 = 0;
    tempSum2=0;
         
    hammings = zeros(numberOfWindows,1); 
    for j = 1:numberOfWindows
        tempKeypoints = keypoints_song_i(j : j+windowLength-1);
        tempAtoms  = atoms_idx_song_i(j: j+windowLength-1); 
        
        atoms = keypoints(:,2); 
        hamm = sum(sum(pdist2(atoms,tempAtoms, 'hamming')))
      
        hammings(j)= hamm;

    end 
     
    hammingDist(i)= min(hammings); 
            
end 
[minValue_h, minIdx_h] = min(hammingDist); 
t4 = toc(t44); 



DB4_Keypoints_256_512 = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Centroids_DBs\DB1\Time\Songs\256_512\Frames\Keypoints_DominantAtoms.mat';
DB4_Keypoints_256_512 = struct2cell(load(DB4_Keypoints_256_512));
DB4_Keypoints_256_512 = DB4_Keypoints_256_512{1};
Keypoints_songs = DB4_Keypoints_256_512;



t55= tic 
for i = 1: size(Keypoints_songs,1)
    keypoints_song_i = Keypoints_songs{i,3}; 
    
    atoms_idx_song_i = Keypoints_songs{i,2};
    
    windowLength = size(keypoints,1); 
    windowIncr = 1; 
    
    numberOfWindows = (size(keypoints_song_i,1) - windowLength)/windowIncr; 
    
    numberOfTenSecondFrames = floor(size(keypoints_song_i,1)/size(keypoints,1)); 
    tempSum1 = 0;
    tempSum2=0;
         
    pearsons = zeros(numberOfWindows,1); 
    for j = 1:numberOfWindows
        tempKeypoints = keypoints_song_i(j : j+windowLength-1);
        tempAtoms  = atoms_idx_song_i(j: j+windowLength-1); 
        
        pearson = corr(keypoints(:,3), tempKeypoints);
       
        pearsons(j)=pearson;
 
    end 
     
    pearsonCoeff(i)= max( pearsons);
            
end 
   
[minValue_p, minIdx_p] = max(pearsonCoeff);
t5 = toc(t55); 


t66= tic
for i = 1: size(Keypoints_songs,1)
    keypoints_song_i = Keypoints_songs{i,3}; 
    
    atoms_idx_song_i = Keypoints_songs{i,2};
    
    windowLength = size(keypoints,1); 
    windowIncr = 1; 
    
    numberOfWindows = (size(keypoints_song_i,1) - windowLength)/windowIncr; 
    
    numberOfTenSecondFrames = floor(size(keypoints_song_i,1)/size(keypoints,1)); 
    tempSum1 = 0;
    tempSum2=0;
         
    for j = 1:numberOfWindows
        tempKeypoints = keypoints_song_i(j : j+windowLength-1);
        tempAtoms  = atoms_idx_song_i(j: j+windowLength-1); 
        
        atoms = keypoints(:,2); 
        hamm = sum(sum(pdist2(atoms,tempAtoms, 'hamming')))
      
        hammings(j)= hamm;

    end 
     
    hammingDist(i)= min(hammings); 
            
end 
[minValue_h, minIdx_h] = min(hammingDist); 
t6 = toc(t66); 

Keypoints_songs =DB4_DICT ;

t77 = tic
for i = 1: size(Keypoints_songs,1)
    keypoints_song_i = Keypoints_songs{i,3}; 
    
    atoms_idx_song_i = Keypoints_songs{i,2};
    
    windowLength = size(keypoints,1); 
    windowIncr = 1; 
    
    numberOfWindows = (size(keypoints_song_i,1) - windowLength)/windowIncr; 
    
    numberOfTenSecondFrames = floor(size(keypoints_song_i,1)/size(keypoints,1)); 
    tempSum1 = 0;
         
    pearsons = zeros(numberOfWindows,1); 
    for j = 1:numberOfWindows
        tempKeypoints = keypoints_song_i(j : j+windowLength-1);
        tempAtoms  = atoms_idx_song_i(j: j+windowLength-1); 
        
        pearson = corr(keypoints(:,3), tempKeypoints);
       
        %hamm = pdist2(keypoints(:,2), tempKeypoints); 
        pearsons(j)=pearson;
   
    end 
     
    pearsonCoeff(i)= max( pearsons);
            
end 
   
[minValue_p, minIdx_p] = max(pearsonCoeff);
t7 = toc(t77); 


t88=tic
for i = 1: size(Keypoints_songs,1)
    keypoints_song_i = Keypoints_songs{i,3}; 
    
    atoms_idx_song_i = Keypoints_songs{i,2};
    
    windowLength = size(keypoints,1); 
    windowIncr = 1; 
    
    numberOfWindows = (size(keypoints_song_i,1) - windowLength)/windowIncr; 
    
    numberOfTenSecondFrames = floor(size(keypoints_song_i,1)/size(keypoints,1)); 
    tempSum1 = 0;
    tempSum2=0;
         
    hammings = zeros(numberOfWindows,1); 
    for j = 1:numberOfWindows
        tempKeypoints = keypoints_song_i(j : j+windowLength-1);
        tempAtoms  = atoms_idx_song_i(j: j+windowLength-1); 
        
        atoms = keypoints(:,2); 
    end 
     
    hammingDist(i)= min(hammings); 
            
end 
[minValue_h, minIdx_h] = min(hammingDist); 
t8 = toc(t88); 


