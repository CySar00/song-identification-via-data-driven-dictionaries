function Keypoints = ExtractTheMostAcitveAtoms_Overall(sparseRepresentation, k)
%EXTRACTTHEMOSTACITVEATOMS_OVERALL Summary of this function goes here
%   Detailed explanation goes here

    if nargin<2 
        k = 10000; 
    end
    numberOfKeypoints = k; 
    
    Keypoints = zeros(numberOfKeypoints,3); 
    [sortedSparseCoefficients, indices]= sort(sparseRepresentation(:),'descend');
    [yy, xx]= ind2sub(size(sparseRepresentation), indices); 
    
    for i=1:numberOfKeypoints 
        Keypoints(i,1)= xx(i); 
        Keypoints(i,2)= yy(i); 
        Keypoints(i,3)= sortedSparseCoefficients(i); 
    end 
    Keypoints = sortrows(Keypoints,2);


end

