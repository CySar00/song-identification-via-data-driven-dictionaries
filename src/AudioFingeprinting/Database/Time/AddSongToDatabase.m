function [ AudioFrames, SparseRepresentation, Keypoints_frames,  Keypoints_framesConstraints,...
    Keypoints_overall, ...
    LandmarkPairs_frames,  LandmarkPairs_framesConstraints, LandmarkPairs_overall,...
    HashTable_frames,    HashTable_framesConstraints , HashTable_overall,... 
    HashMap_frames,HashMap_framesConstraints, HashMap_overall] = AddSongToDatabase(songID, mp3, D, varargin)

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
        varargin{10}= 15000;
    end 
    numberOfAtoms_Overall = varargin{10};
    
    if lengthOfVarargin < 11
        varargin{11}= 64; 
    end 
    plusFrames = varargin{11}; 
    
    if lengthOfVarargin < 12
        varargin{12} = 32; 
    end 
    plusAtoms = varargin{12}; 
    
    if lengthOfVarargin < 13
        varargin{13} = 3; 
    end 
    closestKeypoints = varargin{13}; 
    
    if lengthOfVarargin<14
        varargin{14} = 0.6; 
    end 
    p = varargin{14}; 
    
    AudioFrames = segmentTheAudioSignalIntoAudioFrames(mp3, fs_new, frame, overlap); 
    
    % compute the signals sparse representation 
    SparseRepresentation = CalculateTheSignalsSparseRepresentation(AudioFrames, D, numberOfSparseCoefficients, epsilon, errorFunction, Options);
    
    Keypoints_frames = ExtractTheMostActiveAtoms_Frame(SparseRepresentation, numberOfAtoms_Frame);
    LandmarkPairs_frames = ExtractTheSignalsLandmarkPairs(Keypoints_frames, plusFrames, plusAtoms, closestKeypoints);
    HashTable_frames = HashTheLandmarkPairs(songID, LandmarkPairs_frames);
    HashMap_frames = ConvertTableToMap(HashTable_frames);
    
    Keypoints_framesConstraints = ExtractTheMostActiveAtoms_FrameWithConstraints(SparseRepresentation, numberOfAtoms_Frame, p );
    LandmarkPairs_framesConstraints = ExtractTheSignalsLandmarkPairs(Keypoints_framesConstraints, plusFrames, plusAtoms, closestKeypoints);
    HashTable_framesConstraints = HashTheLandmarkPairs(songID, LandmarkPairs_framesConstraints);
    HashMap_framesConstraints = ConvertTableToMap(HashTable_framesConstraints);
  
    
    Keypoints_overall = ExtractTheMostAcitveAtoms_Overall(SparseRepresentation, numberOfAtoms_Overall);
    LandmarkPairs_overall =  ExtractTheSignalsLandmarkPairs(Keypoints_overall, plusFrames, plusAtoms, closestKeypoints);
    HashTable_overall = HashTheLandmarkPairs(songID, LandmarkPairs_overall);
    HashMap_overall = ConvertTableToMap(HashTable_overall);
   
    

end 