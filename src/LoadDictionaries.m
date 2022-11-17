function [Dictionaries, numberOfDirectories] = LoadDictionaries(pathToDBDirectory)
%
%   Input:: 
%       pathToDBDirectory 
%
%   Output:: 
%       mp3s 

    Dictionaries={}; 
    
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
    
    dictIndex = 0; 
    for i=1:numberOfDirectories 
        currentDirectory = listOfSubDirectories{i}; 
        fprintf('Processing the directory %s \n', currentDirectory);
        
        filePattern = sprintf('%s/*.mat', currentDirectory); 
        
        baseFileName =dir(filePattern); 
        
        numberOfFiles = length(baseFileName);
        
        for j = 1 : numberOfFiles 
            dictIndex = dictIndex + 1; 
            
            dictName = baseFileName(j).name;
            
            dictFile = fullfile(currentDirectory, dictName); 
            
            D = cell2mat(struct2cell(load(dictFile))); 
            
            Dictionaries{dictIndex, 1} = dictName; 
            Dictionaries{dictIndex, 2} = D; 
            
            
        end 
        
        
    end 

end 