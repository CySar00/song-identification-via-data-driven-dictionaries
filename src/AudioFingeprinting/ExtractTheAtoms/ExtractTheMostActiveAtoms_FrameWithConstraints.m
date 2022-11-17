function Keypoints = ExtractTheMostActiveAtoms_FrameWithConstraints(sparseRepresentation, k, p )

    if nargin < 3
        p = 0.7;
    end 


    if nargin < 2 
        k=1; 
    end 
    numberOfKeypoints = k; 
   
    if p>1 && p<0
        error('The variable p must be between a positive number between 1 and 0'); 
    end 
    
    k=1; 
    for i = 1:size(sparseRepresentation,2)
        sparseRepresentation_i = sparseRepresentation(:,i); 
        
        [ sortedAtoms, sortedIndices] = sort(sparseRepresentation_i, 'descend'); 
        sum1 = p*abs(sum(sortedAtoms)); 
        for j = 1:numberOfKeypoints 
            
            if abs(sortedAtoms(j)) > sum1
                k=k+1; 
                
                Keypoints(k,1)= i; 
                Keypoints(k,2) = sortedIndices(j); 
                Keypoints(k,3) = sortedAtoms(j); 
            end 
                    
            
            
            
            
        end 
        
    end 
  
    Keypoints = sortrows(Keypoints,2);

    
    


end 