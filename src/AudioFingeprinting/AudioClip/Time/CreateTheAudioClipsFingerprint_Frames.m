function [AudioFrames, SparseRepresentation, Keypoints,...
    LandmarkPairs, HashTable]= CreateTheAudioClipsFingerprint_Frames(AudioClip, D, varargin)

    
    lengthOfVarargin = length(varargin); 
    
    if lengthOfVarargin < 1
        varargin{1}= 8000;
    end 
    fs_new = varargin{1};
    
    if lengthOfVarargin< 2
        varargin{2} = size(D,1);
    end 
    frame = varargin{2}; 
    
    if lengthOfVarargin < 3
        varargin{3} = 0.5;
    end 
    overlap = varargin{3}; 
    
    if lengthOfVarargin < 4
        varargin{4} = size(D,2); 
    end 
    atoms = varargin{4}; 
    
    if lengthOfVarargin < 5
        varargin{5} = randi(size(D,2));
    end 
    numberOfSparseCoefficients = varargin{5}; 
    
    if lengthOfVarargin < 6
        varargin{6}= eps;
    end 
    epsilon = varargin{6};
  
     
    if lengthOfVarargin < 7
        varargin{7}= [];
    end 
    errorFunction = varargin{7}; 
    
    if lengthOfVarargin < 8 
        varargin{8}= [];
    end 
    Options = varargin{8}; 
    
    if lengthOfVarargin < 9 
        varargin{9} = 1; 
    end 
    numberOfAtoms_Frame = varargin{9}; 
    
    
    if lengthOfVarargin < 10
        varargin{10}= 64; 
    end 
    plusFrames = varargin{10}; 
    
    if lengthOfVarargin < 11
        varargin{11}= 32; 
    end 
    plusAtoms = varargin{11}; 
    
   
    if lengthOfVarargin < 12
        varargin{12} = 3; 
    end 
    closestKeypoints = varargin{12}; 
    
    
    AudioFrames = segmentTheAudioSignalIntoAudioFrames(AudioClip, fs_new, frame, overlap); 
    
    SparseRepresentation = CalculateTheSignalsSparseRepresentation(AudioFrames, D, numberOfSparseCoefficients, epsilon, errorFunction, Options); 
    
    Keypoints =  ExtractTheMostActiveAtoms_Frame(SparseRepresentation, numberOfAtoms_Frame); 
    
    LandmarkPairs = ExtractTheSignalsLandmarkPairs(Keypoints, plusFrames, plusAtoms, closestKeypoints); 
    HashTable = HashTheAudioClipsLandmarkPairs(LandmarkPairs); 
    
    

end

