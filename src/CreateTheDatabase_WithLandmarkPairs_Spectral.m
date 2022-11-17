close all; 
clearvars; 
clc; 

AddFunctionsFromOtherDirectories(); 
pathToDBDir=''; 
mp3s = LoadMP3sFromDB(pathToDBDir);


D1 = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Frequency\129\DB4\Songs\D_128_256_100_100.mat')));


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
    
    

 
    
[ filteredMagnitudes, SparseRepresentation, Keypoints_frames, Keypoints_framesc, Keypoints_overall,...
    LandmarkPairs_frames, LandmarkPairs_framesc, LandmarkPairs_overall, HashTable_frames, ...
    HashTable_framesc, HashTable_overall, HashMap_frames,HashMap_framesc, ...
    HashMap_overall...
    ] = addSongToDatabase(songID, mp3_i, D1)
 
    HashMaps1{i}=HashMap_frames; 
    HashMaps3{i}=HashMap_framesc; 
  
    HashMaps2{i}=HashMap_overall;
   
    SongTitlesAndIDs{1,i}= songID; 
    SongTitlesAndIDs{2,i}= cell2mat(mp3_i(1)); 
    
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

save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB4\Frequency\Songs\128_256\HashMap_Frames.mat', 'HashMaps1');
save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB4\Frequency\Songs\128_256\HashMaps_FramesConstrainst.mat', 'HashMaps3');

save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB4\Frequency\Songs\128_256\HashMaps_Overall.mat', 'HashMaps2');

save('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB4\Frequency\Songs\128_256\SongTitlesAndIDs.mat', 'SongTitlesAndIDs'); 