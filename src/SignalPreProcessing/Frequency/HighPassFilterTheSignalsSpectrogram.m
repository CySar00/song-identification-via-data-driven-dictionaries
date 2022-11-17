function filteredMagnitudes = HighPassFilterTheSignalsSpectrogram(spectralMagnitudes, halfPole)
%HIGHPASSFILTERTHESIGNALSSPECTROGRAM Summary of this function goes here
%   Detailed explanation goes here

    if nargin<2 
        halfPole = 0.98;
    end 

    filteredMagnitudes =zeros(size(spectralMagnitudes)); 
    filteredMagnitudes(:,1)= spectralMagnitudes(:,1); 
    
     for f=1:size(filteredMagnitudes,1)
        for t =2:size(filteredMagnitudes,2)
            filteredMagnitudes(f,t)= (spectralMagnitudes(f,t)-spectralMagnitudes(f,t-1))+halfPole*filteredMagnitudes(f,t-1); 
            
        end 
     end 


end

