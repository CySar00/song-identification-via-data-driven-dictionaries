function Keypoints = ExtractTheMostActiveAtoms_Frame(sparseRepresentation, k)

    if nargin < 2 
        k=1; 
    end 
    numberOfKeypoints = k; 
    
    k = 1; 
    for i = 1:size(sparseRepresentation,2)
        sparseRepresentation_i = sparseRepresentation(:,i); 
        
        [sortedSparseRepresentation_i, indices_i] = sort(sparseRepresentation_i, 'descend');
        for j = 1:numberOfKeypoints 
            k= k+1; 
            Keypoints(k,1)= i; 
            Keypoints(k,2) = indices_i(j); 
            Keypoints(k,3) = sortedSparseRepresentation_i(j); 
        end 
        
    end 
    Keypoints = sortrows(Keypoints,2);



end

