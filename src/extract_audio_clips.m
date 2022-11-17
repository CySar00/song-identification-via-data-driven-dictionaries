close all; 
clear all; 
clc; 

AddFunctionsFromOtherDirectories();

pathToDB = 'C:\Users\saravanos\Desktop\Νέος φάκελος\audiofiles';
mp3s = LoadMP3sFromDB(pathToDB);


for i = 1:100
    randomIdx = randi(size(mp3s,1),1); 
    selectedMP3 = mp3s(randomIdx,:); 
    
    AudioClip = ExtractTheAudioClip(selectedMP3, 10); 
    audioClip = AudioClip{2}; 
    
    audiowrite(['C:\Users\saravanos\Desktop\AudioClips\Ten\NoNoise\clip_', num2str(i),'.wav'], audioClip, 44100)

    audioClip1 = awgn(audioClip,20);
    audiowrite(['C:\Users\saravanos\Desktop\AudioClips\Ten\AWGN_20dB\clip_', num2str(i),'.wav'], audioClip1, 44100)

    audioClip2 = awgn(audioClip,15);
    audiowrite(['C:\Users\saravanos\Desktop\AudioClips\Ten\AWGN_15dB\clip_', num2str(i),'.wav'], audioClip2, 44100)

    audioClip3 = awgn(audioClip,10);
    audiowrite(['C:\Users\saravanos\Desktop\AudioClips\Ten\AWGN_10dB\clip_', num2str(i),'.wav'], audioClip3, 44100)

    % add pink noise to the audio clip 
    cn =  dsp.ColoredNoise('purple',size(audioClip,1),size(audioClip,2),'OutputDataType','double'); 
    cnn = cn();
    audioClip4 = audioClip+ cnn;
    audiowrite(['C:\Users\saravanos\Desktop\AudioClips\Ten\Violet\clip_', num2str(i),'.wav'], audioClip3, 44100)

    
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
    for k = 161:size(audioClip,1)
        temp2(j) = 1.2*audioClip(k-160); 
        j=j+1;
    
    end 

    audioClip6 = audioClip + temp1; 
    audioClip6 = awgn(audioClip6, 10); 
    audiowrite(['C:\Users\saravanos\Desktop\AudioClips\Ten\Sim_Bg_1\clip_', num2str(i),'.wav'], audioClip6, 44100)




    audioClip7 = audioClip + temp2; 
    audioClip7 = awgn(audioClip7, 10); 
    audiowrite(['C:\Users\saravanos\Desktop\AudioClips\Ten\Sim_Bg_2\clip_', num2str(i),'.wav'], audioClip7, 44100)

  
    audioClip8 = audioClip + temp2 + temp1; 
    audioClip8 = awgn(audioClip8, 10); 
    audiowrite(['C:\Users\saravanos\Desktop\AudioClips\Ten\Sim_Bg_3\clip_', num2str(i),'.wav'], audioClip8, 44100)



    
    
    
    
    




end 