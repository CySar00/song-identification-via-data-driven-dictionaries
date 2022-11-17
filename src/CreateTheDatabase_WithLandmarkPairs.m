close all; 
clearvars; 
clc; 

AddFunctionsFromOtherDirectories(); 
pathToDBDir=''; 
mp3s = LoadMP3sFromDB(pathToDBDir);


D1 = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\256\DB4\Songs\D_256_512_100_100.mat')));


%{
SongTitlesAndIDs=cell(2,6); 
HashMaps1=cell(1,6);
HashMaps2=cell(1,6);
HashMaps3=cell(1,6);
HashMapsFromDataTable2=cell(1,6);
%}

songID=0; 
for i=1:size(mp3s,1); 
    songID=songID+1;
    mp3_i = mp3s(i,:);
    
    
    [AudioFrames, SparseCoefficientMatrix,...
        Keypoints1, Keypoints3, Keypoints2,...
        LandmarkPairs1, LandmarkPairs3, LandmarkPairs2,...
        HashTable1, HashTable3, HashTable2, ...
        HashMap1, HashMap3, HashMap2]=...
        ...
        AddSongToDatabase(songID, mp3_i,D1);
 
    HashMaps1{i}=HashMap1; 
    HashMaps2{i}=HashMap2;
    
    HashMaps3{i}=HashMap3; 
 
    
    SongTitlesAndIDs{1,i}= songID; 
   %{ 
    AudioFrames = SegmentTheMP3IntoAudioFrames(mp3_i); 
    SparseCoefficientMatrix= CalculateTheMP3sSparseCoefficientMatrix(AudioFrames,D1); 
    
    %Keypoints1=  FindTheMP3sSparseKeypoints(SparseCoefficientMatrix); 
    %LandmarkPairs1= FindTheMP3sSparseLandmarkPairs(Keypoints1);
    %[Keypoints2, Keypoints3] =FindTheMP3sSparseKeypoints_(SparseCoefficientMatrix); 
    
    dataTable1 =FowardSmoothTheMP3sSparseMatrix(SparseCoefficientMatrix); 
    dataTable2= BackwardSmoothTheMP3sSparseMatrix(SparseCoefficientMatrix,dataTable1);
    %}
end 

save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB4\Time\Songs\256_512\HashMap_Frames.mat', 'HashMaps1');
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB4\Time\Songs\256_512\HashMaps_Overall.mat', 'HashMaps2');
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB4\Time\Songs\256_512\HashMaps_FramesWithConstraints.mat', 'HashMaps3');

save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB4\Time\Songs\256_512\SongTitlesAndIDs.mat', 'SongTitlesAndIDs'); 