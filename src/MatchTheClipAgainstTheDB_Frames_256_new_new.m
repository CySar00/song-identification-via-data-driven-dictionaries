AddFunctionsFromOtherDirectories();

D = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\128\DB1\Songs\D_128_256_100_100.mat')));

T = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\128\DB1\Songs\T_128_256_100_100.mat')));
W = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\128\DB1\Songs\W_128_256_100_100.mat')));
X = cell2mat(struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Dictionaries\Time\128\DB1\Songs\X_128_256_100_100.mat')));



% randomly select a song from the database 
pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB1';
mp3s = LoadMP3sFromDB(pathToDB);

randomIdx = randi(size(mp3s,1),1); 
selectedMP3 = mp3s(randomIdx,:); 


% centroids of dominant atoms 

AudioClip = ExtractTheAudioClip(selectedMP3, 10); 
audioClip = AudioClip{2}; 

audioClip1 = awgn(audioClip,10);

%{
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


%}
