function [filteredMagnitudes, SparseRepresentation, Keypoints1, Keypoints3,  Keypoints2, LandmarkPairs1, ...
   LandmarkPairs3, LandmarkPairs2, HashTable1, HashTable3 ,HashTable2 ] =...
    createTheAudioClipsFingerprints(AudioClip, D, varargin)

 lengthOfVarargin = length(varargin); 
    
    if lengthOfVarargin < 1
        varargin{1}= 8000;
    end 
    fs_new = varargin{1};
    
    if lengthOfVarargin< 2
        varargin{2} = size(D,1);
    end 
    frame = 256; 
    
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
        varargin{10} = 150; 
    end 
    numberOfAtoms_Overall = varargin{10}; 
   
        
    if lengthOfVarargin < 11
        varargin{11}= 64; 
    end 
    plusFrames = varargin{11}; 
    
    if lengthOfVarargin < 12
        varargin{12}= 32; 
    end 
    plusAtoms = varargin{12}; 
    
   
    if lengthOfVarargin < 13
        varargin{13} = 3; 
    end 
    closestKeypoints = varargin{13}; 
    
    
    [~, ~, ~, ~, filteredMagnitudes] = CalculateTheSignalsSpectrogram(AudioClip, fs_new, frame,overlap);
    
    SparseRepresentation = CalculateTheSignalsSparseRepresentation(filteredMagnitudes, D, numberOfSparseCoefficients, epsilon, errorFunction, Options); 
    
    Keypoints1 = ExtractTheMostActiveAtoms_Frame(SparseRepresentation, numberOfAtoms_Frame);
    Keypoints3 = ExtractTheMostActiveAtoms_FrameWithConstraints(SparseRepresentation, numberOfAtoms_Frame);
   
    Keypoints2 =ExtractTheMostAcitveAtoms_Overall(SparseRepresentation, numberOfAtoms_Overall);
    
    LandmarkPairs1 = ExtractTheSignalsLandmarkPairs(Keypoints1, plusFrames, plusAtoms, closestKeypoints); 
    HashTable1 = HashTheAudioClipsLandmarkPairs(LandmarkPairs1); 
    
    LandmarkPairs3 = ExtractTheSignalsLandmarkPairs(Keypoints3, plusFrames, plusAtoms, closestKeypoints); 
    HashTable3 = HashTheAudioClipsLandmarkPairs(LandmarkPairs3); 
   
    
    LandmarkPairs2 = ExtractTheSignalsLandmarkPairs(Keypoints2, plusFrames, plusAtoms, closestKeypoints); 
    HashTable2 = HashTheAudioClipsLandmarkPairs(LandmarkPairs2); 
    
    
   

end

