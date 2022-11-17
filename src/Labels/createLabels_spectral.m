function labels = createLabels(pathToDB, numberOfClasses, numberOfFeatures, numberOfFrameSamples)

    labels = zeros(numberOfClasses, numberOfFeatures); 
    
    parentDirectory =pathToDB; 
    parentDirectory = fullfile(parentDirectory); 
    parentDirectory = uigetdir(parentDirectory); 
    
    if parentDirectory==0
        return;
    end 
    
    %   get a list of all the subdirectories 
    subDirectories= genpath(parentDirectory); 
    
    %   parse the list into a cell array 
    remain = subDirectories; 
    listOfSubDirectories = {}; 
    
    while true 
        [subDirectory, remain] = strtok(remain,';'); 
        
        if isempty(subDirectory)
            break; 
        end 
        listOfSubDirectories = [listOfSubDirectories subDirectory]; 
    end 
    numberOfDirectories = length(listOfSubDirectories)
    
    mp3Index =0; 
    k = 1 ; 
   
    idx = 1; 
    for i=1:numberOfDirectories 
        
        currentDirectory = listOfSubDirectories{i}; 
        fprintf('Processing the directory %s \n', currentDirectory);
        
        filePattern = sprintf('%s/*.mp3', currentDirectory); 
        baseFileName =dir(filePattern); 
        numberOfFiles = length(baseFileName)
        
        
        totalNumberOfFrames = 0;
        
        if numberOfFiles>0    
            
            for j=1:numberOfFiles 
                mp3Index = mp3Index +1; 
            
                currentFileName= baseFileName(j).name; 
                currentFile = fullfile(currentDirectory, currentFileName); 
            
                [mp3_audioSignal, mp3_samplingRate]= audioread(currentFile); 
                mp3s{mp3Index,1} = currentFileName; 
                mp3s{mp3Index,2} = mp3_audioSignal; 
                mp3s{mp3Index,3} = mp3_samplingRate; 
            
            
                [~, ~, ~, ~, audioFrames] =CalculateTheSignalsSpectrogram(mp3s(mp3Index,:), 8000, numberOfFrameSamples);
                
                [frameLength, numberOfFrames] = size(audioFrames); 
                
               % AudioFrames = zeros(frameLength, maxNumberOfFrames); 
               % AudioFrames(:,1:numberOfFrames)=audioFrames;
               
               totalNumberOfFrames = totalNumberOfFrames + numberOfFrames; 
               
            end 
            totalNumberOfFrames
            
            tempIdx = idx 
            idx = tempIdx + totalNumberOfFrames 
            
            for jj = tempIdx : idx-1
                labels(k, jj) = 1; 
            end 
            
            k 
        
            k=k+1; 
            
        end    
            
    end 
    
    v = k
    if idx > numberOfFeatures
        labels(:, 1:numberOfFeatures); 
    end 
    

end 