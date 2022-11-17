close all; 
clear all; 
clc; 

AddFunctionsFromOtherDirectories();

D1 =load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\D_256_1024_100_100.mat');
D1 = cell2mat(struct2cell(D1))


W1 = load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\W_256_1024_100_100.mat');
W1 = cell2mat(struct2cell(W1));

pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB4'; 
mp3s = LoadMP3sFromDB(pathToDB); 

randomIdx = randi(size(mp3s,1),1); 
selectedMP3 = mp3s(randomIdx,:); 


AudioClip = ExtractTheAudioClip(selectedMP3, 10); 
[AudioFrames, SparseRepresentation] = CreateTheAudioClipsSparseRepresentation(AudioClip, D1); 
Y_f = SparseRepresentation;


X1 = W1*Y_f;
X2 =X1;

maxIndices = [];
for i = 1 : size(X2,2)
    [maxValue, maxIdx] = max(X2(:,i))
    maxIndices(i)= maxIdx
   
end 
uniques = unique(maxIndices)

N = numel(uniques); 
count  = zeros(N,1); 

for k = 1:N
    count(k) = sum(maxIndices==uniques(k));
end 
[maxCount, maxIdx1] = max(count);