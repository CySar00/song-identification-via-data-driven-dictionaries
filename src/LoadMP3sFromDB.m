function [mp3s, numberOfDirectories] = LoadMP3sFromDB(pathToDBDirectory)
%
%   Input:: 
%       pathToDBDirectory 
%
%   Output:: 
%       mp3s 

    mp3s={}; 
    
    parentDirectory =pathToDBDirectory; 
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
    for i=1:numberOfDirectories 
        currentDirectory = listOfSubDirectories{i}; 
        fprintf('Processing the directory %s \n', currentDirectory);
        
        filePattern = sprintf('%s/*.mp3', currentDirectory); 
        baseFileName =dir(filePattern); 
        numberOfFiles = length(baseFileName);
        
        for j=1:numberOfFiles 
            mp3Index = mp3Index +1; 
            
            currentFileName= baseFileName(j).name; 
            currentFile = fullfile(currentDirectory, currentFileName) 
            
            
            [mp3_audioSignal, mp3_samplingRate]= audioread(currentFile); 
            mp3s{mp3Index,1} = currentFileName; 
            mp3s{mp3Index,2} = mp3_audioSignal; 
            mp3s{mp3Index,3} = mp3_samplingRate; 
            
        
        end 
    end 

end 