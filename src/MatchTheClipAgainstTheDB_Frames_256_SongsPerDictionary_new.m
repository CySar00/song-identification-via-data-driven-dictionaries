close all; 
clear; 
clc; 

AddFunctionsFromOtherDirectories(); 

pathToDB = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\DB4'
MP3s = LoadMP3sFromDB(pathToDB);

pathToDictionaries = 'C:\Users\saravanos\Desktop\audioFingerprinting_NEW\DBs\Dictionaries_DB4';
Dictionaries = LoadDictionaries(pathToDictionaries); 

randomIdx = randi(size(MP3s,1),1); 
selectedMP3 = MP3s(randomIdx,:); 

Keypoints_songs = struct2cell(load('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\Centroids_DBs\DB4_DICT\Time\Songs\DictionaryPerSong\256_512\Frames\Keypoints_DominantAtoms.mat'));
Keypoints_songs  = Keypoints_songs{1}; 

AudioClip = ExtractTheAudioClip(selectedMP3, 10); 
audioClip = AudioClip{2}; 

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


% add pink noise to the audio clip 
cn =  dsp.ColoredNoise('purple',size(audioClip,1),size(audioClip,2),'OutputDataType','double'); 
cnn = cn();
audioClip5 = audioClip+ cnn;

AudioClip5{1}= AudioClip{1}; 
AudioClip5{2} = audioClip5; 
AudioClip5{3}= AudioClip{3}; 
audiowrite('C:\Users\saravanos\Desktop\audioFingerprinting_NEW\NoisyAudioClips\audioClip_pink.wav', audioClip5, 44100)



t1 = 80; 
t2 = 160; 

temp1 =zeros( size(audioClip));
j1=1;
for k = 81: size(audioClip,1)
    temp1(j1) = 1.2*audioClip(k-80); 
    j1=j1+1;
end

temp2 =zeros( size(audioClip));
j=1;
for i = 161:size(audioClip,1)
    temp2(j) = 1.2*audioClip(i-160); 
    j=j+1;
    
end 

audioClip6 = audioClip + temp1; 
audioClip6 = awgn(audioClip6, 10); 


AudioClip6{1} = AudioClip{1}; 
AudioClip6{2} = audioClip6; 
AudioClip6{3} = AudioClip{3}; 


audioClip7 = audioClip + temp2; 
audioClip7 = awgn(audioClip7, 20); 

AudioClip7{1} = AudioClip{1}; 
AudioClip7{2} = audioClip7; 
AudioClip7{3} = AudioClip{3}; 

audioClip8 = audioClip + temp2 + temp1; 
audioClip8 = awgn(audioClip8, 10); 

AudioClip8{1} = AudioClip{1}; 
AudioClip8{2} = audioClip8; 
AudioClip8{3} = AudioClip{3}; 



Keypoints_AudioClip = cell(size(Dictionaries,1)-1, 1); 
Keypoints_AudioClip1 = cell(size(Dictionaries,1)-1, 1); 
Keypoints_AudioClip2 = cell(size(Dictionaries,1)-1, 1); 
Keypoints_AudioClip3 = cell(size(Dictionaries,1)-1, 1); 
Keypoints_AudioClip4 = cell(size(Dictionaries,1)-1, 1); 
Keypoints_AudioClip5 = cell(size(Dictionaries,1)-1, 1); 
Keypoints_AudioClip6 = cell(size(Dictionaries,1)-1, 1); 
Keypoints_AudioClip7 = cell(size(Dictionaries,1)-1, 1); 
Keypoints_AudioClip8 = cell(size(Dictionaries,1)-1, 1); 



for i = 1:size(Dictionaries,1)-1
    D_i = Dictionaries(i,2); 
    D_i = D_i{1}; 
    
    [~, ~, keypoints, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D_i);
    
    
    [~, ~, keypoints1, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D_i);
    [~, ~, keypoints2, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D_i);
    [~, ~, keypoints3, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D_i);
    [~, ~, keypoints4, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D_i);
    [~, ~, keypoints5, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D_i);
    [~, ~, keypoints6, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D_i);
    [~, ~, keypoints7, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D_i);
    [~, ~, keypoints8, ~, ~]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D_i);
    
    
    
    
    
    Keypoints_AudioClip{i} = keypoints(2:end,:);
    
    KEYPOINTS(:, i) = keypoints(2:end, 3); 
    
    KEYPOINTS1(:, i) = keypoints(2:end, 3); 
    KEYPOINTS2(:, i) = keypoints(2:end, 3); 
    KEYPOINTS3(:, i) = keypoints(2:end, 3); 
    KEYPOINTS4(:, i) = keypoints(2:end, 3); 
    KEYPOINTS5(:, i) = keypoints(2:end, 3); 
    KEYPOINTS6(:, i) = keypoints(2:end, 3); 
    KEYPOINTS7(:, i) = keypoints(2:end, 3); 
    KEYPOINTS8(:, i) = keypoints(2:end, 3); 
    
    
    
    
    
end 
[J1, I1 ] = max(KEYPOINTS, [], 2); 
I1 = I1(2:end,:); 
[~,~,ic] = unique(I1, 'rows');
seperated_data1 = arrayfun(@(x) I1(ic==x,:), unique(ic), 'UniformOutput', 0);


[J11, I11 ] = max(KEYPOINTS1, [], 2); 
I11 = I11(2:end,:); 
[~,~,ic] = unique(I11, 'rows');
seperated_data11 = arrayfun(@(x) I11(ic==x,:), unique(ic), 'UniformOutput', 0);

[J12, I12 ] = max(KEYPOINTS2, [], 2); 
I12 = I12(2:end,:); 
[~,~,ic] = unique(I12, 'rows');
seperated_data12 = arrayfun(@(x) I12(ic==x,:), unique(ic), 'UniformOutput', 0);


[J13, I13 ] = max(KEYPOINTS3, [], 2); 
I13 = I13(2:end,:); 
[~,~,ic] = unique(I11, 'rows');
seperated_data13 = arrayfun(@(x) I13(ic==x,:), unique(ic), 'UniformOutput', 0);

[J14, I14 ] = max(KEYPOINTS4, [], 2); 
I14 = I14(2:end,:); 
[~,~,ic] = unique(I11, 'rows');
seperated_data14 = arrayfun(@(x) I14(ic==x,:), unique(ic), 'UniformOutput', 0);

[J15, I15 ] = max(KEYPOINTS5, [], 2); 
I15 = I15(2:end,:); 
[~,~,ic] = unique(I15, 'rows');
seperated_data15 = arrayfun(@(x) I15(ic==x,:), unique(ic), 'UniformOutput', 0);

[J16, I16 ] = max(KEYPOINTS6, [], 2); 
I16 = I16(2:end,:); 
[~,~,ic] = unique(I16, 'rows');
seperated_data16 = arrayfun(@(x) I16(ic==x,:), unique(ic), 'UniformOutput', 0);


[J17, I17 ] = max(KEYPOINTS7, [], 2); 
I17 = I17(2:end,:); 
[~,~,ic] = unique(I17, 'rows');
seperated_data17 = arrayfun(@(x) I17(ic==x,:), unique(ic), 'UniformOutput', 0);

[J18, I18 ] = max(KEYPOINTS8, [], 2); 
I18 = I18(2:end,:); 
[~,~,ic] = unique(I18, 'rows');
seperated_data18 = arrayfun(@(x) I18(ic==x,:), unique(ic), 'UniformOutput', 0);




[J2, I2 ] = min(KEYPOINTS, [], 2); 
I2 = I2(2:end,:); 
[~,~,ic2] = unique(I2, 'rows');
seperated_data2 = arrayfun(@(x) I2(ic2==x,:), unique(ic2), 'UniformOutput', 0);



for i = 1:length(seperated_data1)
    seperated_data_i = seperated_data1{i}; 
    
    
    seperated_data1_i = seperated_data11{i}; 
    seperated_data2_i = seperated_data12{i}; 
    seperated_data3_i = seperated_data13{i}; 
    seperated_data4_i = seperated_data14{i}; 
    seperated_data5_i = seperated_data15{i}; 
    seperated_data6_i = seperated_data16{i}; 
    seperated_data7_i = seperated_data17{i}; 
    seperated_data8_i = seperated_data18{i}; 
 
    
    
    
    LEN1(i) = length(seperated_data_i);
    
    
    LEN11(i) = length(seperated_data1_i);
    LEN12(i) = length(seperated_data2_i)
    LEN13(i) = length(seperated_data3_i)
    LEN14(i) = length(seperated_data4_i)
    LEN15(i) = length(seperated_data5_i)
    LEN16(i) = length(seperated_data6_i)
    LEN17(i) = length(seperated_data7_i)
    LEN18(i) = length(seperated_data8_i)
    
    
    
end 

for i = 1:length(seperated_data2)
    seperated_data_i = seperated_data2{i}; 
    LEN2(i) = length(seperated_data_i); 
    
end 

[sortedIdx, sortedLEN] = sort(LEN1);
[sortedIdx1, sortedLEN1] = sort(LEN11);

[sortedIdx2, sortedLEN2] = sort(LEN12);
[sortedIdx3, sortedLEN3] = sort(LEN13);
[sortedIdx4, sortedLEN4] = sort(LEN14);
[sortedIdx5, sortedLEN5] = sort(LEN15);
[sortedIdx6, sortedLEN6] = sort(LEN16);
[sortedIdx7, sortedLEN7] = sort(LEN17);
[sortedIdx8, sortedLEN8] = sort(LEN18);



[MIN1, IDX1 ] = min(LEN1); 



for i = 1:length(seperated_data1)
    seperated_data_i = seperated_data1{i}; 
    
    if length(seperated_data_i) == LEN1(2)
        idx1 = sortedIdx(2); 
    end 
    
    if length(seperated_data1_i) == LEN11(2)
        idx11 = sortedIdx1(2); 
    end 
    
    if length(seperated_data2_i) == LEN21(2)
        idx12 = sortedIdx1(2); 
    end 
    
    if length(seperated_data3_i) == LEN31(2)
        idx13 = sortedIdx1(2); 
    end 
    
    if length(seperated_data4_i) == LEN41(2)
        idx14 = sortedIdx4(2); 
    end 
    
    if length(seperated_data5_i) == LEN51(2)
        idx5 = sortedIdx5(2); 
    end 
    
    if length(seperated_data6_i) == LEN61(2)
        idx6 = sortedIdx6(2); 
    end 
    
    if length(seperated_data7_i) == LEN71(2)
        idx7 = sortedIdx7(2); 
    end 
    
    if length(seperated_data8_i) == LEN81(2)
        idx18 = sortedIdx8(2); 
    end 
    
    
    
    
    
    Indices1(i) = seperated_data_i(1); 
end 

sortedLEN2 = sort(LEN2);
[MIN2, IDX2 ] = min(LEN2); 
for i = 1:length(seperated_data1)
    seperated_data_i = seperated_data1{i}; 
    
    if length(seperated_data_i) == min(LEN2)
        idx22 = IDX2; 
    end 
    
    Indices2(i) = seperated_data_i(1); 
end 





keypoints_i = J1(2:end, :); 

windowIncr = 1; 

Frames = zeros(size(Keypoints_AudioClip, 1), 1); 
windowSize = size(KEYPOINTS,1);

Pearsons = cell(size(Dictionaries,1), size(MP3s,1)); 
for i = 1:size(Dictionaries, 1)
    
    if ismember(i, Indices1) 
    
    
    
        keypoints_i = KEYPOINTS(:, i); 
    
        for j = 1: size(MP3s, 1)
            Keypoints_song_j = Keypoints_songs{j}; 
            Keypoints_j = Keypoints_song_j(2:end, :); 
        
        
            numberOfWindows = (size(Keypoints_j,1) - windowSize)/windowIncr; 
        
            for k = 1:numberOfWindows 
                tmp = Keypoints_j(k : k + windowSize-1); 
                pearsons(k) = corr(tmp, keypoints_i); 
            end 
            Pearsons{i,j} = pearsons; 
        end 
    else
        Pearsons{i,j} = zeros(100, 1); 
    end 
end 


for i= 1:size(Dictionaries,1)
    for j = 1:size(MP3s,1)
        pearsons_j = Pearsons{i,j}; 
        
        if ~isempty(pearsons_j)
        
            Pearsons1(i,j) = max(pearsons_j); 
        else
            Pearsons1(i,j) = 0;
        end 
    end 
    
    
end 

for i = 1:size(Dictionaries,1)
    MAXES(i) = max(Pearsons1(i,:)); 
end 
[~, idx2] = max(MAXES); 

 



