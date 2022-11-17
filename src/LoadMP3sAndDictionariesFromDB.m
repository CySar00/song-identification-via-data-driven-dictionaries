function [mp3s, numberOfDirectories] = LoadMP3sAndDictionariesFromDB(pathToDBDirectory)
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
    dictIndex = 0; 
    for i=1:numberOfDirectories 
        currentDirectory = listOfSubDirectories{i}; 
        fprintf('Processing the directory %s \n', currentDirectory);
        
        filePattern1 = sprintf('%s/*.mp3', currentDirectory); 
        filePattern2 = sprintf('%s/*.mat', currentDirectory); 
        
        baseFileName1 =dir(filePattern1); 
        baseFileName2 = dir(filePattern2); 
        
        numberOfFiles1 = length(baseFileName1);
        numberOfFiles2 = length(baseFileName2); 
        
        for j = 1 : numberOfFiles1 
            mp3Index = mp3Index + 1; 
            
            mp3FileName = baseFileName1(j).name; 
            dictName = baseFileName2(j).name;
            
            mp3File = fullfile(currentDirectory, mp3FileName);
            dictFile = fullfile(currentDirectory, dictName); 
            
            [mp3_audioSignal, mp3_samplingRate] = audioread(mp3File); 
            D = cell2mat(struct2cell(load(dictFile))); 
            
            mp3s{mp3Index, 1} = mp3FileName; 
            mp3s{mp3Index, 2}= mp3_audioSignal; 
            mp3s{mp3Index, 3} = D; 
            mp3s{mp3Index, 4}= mp3_samplingRate;
            
            
        end 
        
        
        
        
        
    end 

end 