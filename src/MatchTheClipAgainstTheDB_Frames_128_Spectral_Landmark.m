close all; 
clear all; 
clc; 

AddFunctionsFromOtherDirectories(); 
pathToDBDir=''; 
mp3s = LoadMP3sFromDB(pathToDBDir);

D = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Frequency\129\DB4\Songs\D_128_256_100_100.mat')));

HashMaps_Frames = struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB4\Frequency\Songs\128_256\HashMap_Frames.mat', 'HashMaps1'));
HashMaps_Frames = HashMaps_Frames{1}; 

HashMaps_Overall= struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB4\Frequency\Songs\128_256\HashMaps_Overall.mat', 'HashMaps2'));
HashMaps_Overall = HashMaps_Overall{1}; 

SongsAndTitles = struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\HashMaps_DBs\DB4\Frequency\Songs\128_256\SongTitlesAndIDs.mat', 'SongTitlesAndIDs')); 


randomIdx = randi(size(mp3s,1),1); 
selectedMP3 = mp3s(randomIdx,:); 

AudioClip = ExtractTheAudioClip(selectedMP3, 10); 
audioClip = AudioClip{2}; 

[~,~,~,~,~,~, HashTable1, HashTable2 ] = createTheAudioClipsFingerprints(AudioClip,D); 
[songID1,JaccardCoefficients1] = MatchTheAudioClipAgainstTheDatabase(HashTable1, HashMaps_Frames); 

[songID2,JaccardCoefficients2] = MatchTheAudioClipAgainstTheDatabase(HashTable2, HashMaps_Overall); 

audioClip1 = awgn(audioClip,20);

AudioClip1{1}= AudioClip{1}; 
AudioClip1{2} = audioClip1; 
AudioClip1{3}= AudioClip{3}; 

[~,~,~,~,~,~, HashTable11, HashTable12 ] = createTheAudioClipsFingerprints(AudioClip1,D); 

songID11 = MatchTheAudioClipAgainstTheDatabase(HashTable11, HashMaps_Frames); 
songID12 = MatchTheAudioClipAgainstTheDatabase(HashTable12, HashMaps_Overall); 

audioClip2 = awgn(audioClip,15); 
AudioClip2{1}= AudioClip{1}; 
AudioClip2{2} = audioClip2; 
AudioClip2{3}= AudioClip{3}; 

[~,~,~,~,~,~, HashTable21, HashTable22 ] = createTheAudioClipsFingerprints(AudioClip2,D); 

songID21 = MatchTheAudioClipAgainstTheDatabase(HashTable21, HashMaps_Frames); 
songID22 = MatchTheAudioClipAgainstTheDatabase(HashTable22, HashMaps_Overall); 


audioClip3 = awgn(audioClip,10);
AudioClip3{1}= AudioClip{1}; 
AudioClip3{2} = audioClip2; 
AudioClip3{3}= AudioClip{3}; 

[~,~,~,~,~,~, HashTable31, HashTable32 ] = createTheAudioClipsFingerprints(AudioClip3,D); 

songID31 = MatchTheAudioClipAgainstTheDatabase(HashTable31, HashMaps_Frames); 
songID32 = MatchTheAudioClipAgainstTheDatabase(HashTable32, HashMaps_Overall); 











