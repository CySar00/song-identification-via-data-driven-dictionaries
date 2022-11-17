function SparseCoefficientMatrix = CalculateTheSignalsSparseRepresentation(AudioFrames, D, varargin)
%
%   Input:: 
%       SparseCoefficientMarix   
%       D 
%
%       numberOfSparseCoefficients 
%       epsilon 
%
%       errorFunction 
%       Options 
%
%   Output 
%       SparseCoefficientMatrix 

   
    lengthOfVarargin=length(varargin); 
    if lengthOfVarargin<1 
        varargin{1}= randi(size(D,2)-1); 
    end 
    numberOfSparseCoefficients= varargin{1}; 
    
    
    if lengthOfVarargin<2 
        varargin{2}= []; 
    end 
    errorFunction = varargin{2}; 
    
    if lengthOfVarargin<3
        varargin{3}=[]; 
    end 
    Options = varargin{3}; 
    
    %SparseCoefficientMatrix=cell(1,1); 
    
    X=AudioFrames;
    
    Y=zeros(size(D,2), size(AudioFrames,2)); 
    %{
    for i=1:size(AudioFrames,2)
        i
        Y(:,i)= OMP(X(:,i), D, numberOfSparseCoefficients, errorFunction, Options);
    end 
    %}
      for i=1:size(AudioFrames,2)
        i
        Y(:,i)= OMP(X(:,i), D, numberOfSparseCoefficients);
    end 
    
    SparseCoefficientMatrix=Y; 
    

end 