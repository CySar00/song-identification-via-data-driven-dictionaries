function [Y,D] = KSVD(X, D0, varargin)
%
%   Input:: 
%       X 
%       D0 
%
%       numberOfSparseCoeffcients
%       epsilon 
%       errorFunction 
%       Options 
%
%       maxNumberOfIterations 
%
%   Output:: 
%       Y
%       D
    
    lengthOfVarargin=length(varargin); 
    if lengthOfVarargin<1
        varargin{1}= randi(size(D0,2)-1); 
    end 
    numberOfSparseCoefficients = varargin{1}; 
    
    if lengthOfVarargin<2
        varargin{2}= eps; 
    end 
    epsilon = varargin{2}; 
    
    if lengthOfVarargin<3 
        varargin{3}= []; 
    end 
    errorFunction = varargin{3}; 
    
    if lengthOfVarargin<4
        varargin{4}= []; 
    end 
    Options = varargin{4}; 
    
    if lengthOfVarargin<5 
        varargin{5}= randi(size(D0,2)-1); 
    end 
    maxNumberOfIterations=varargin{5}; 
    
    %   initialization step
    %
    %   set D=D0
    D=D0; 
    
    for i=1:maxNumberOfIterations 
        i
        %   calculate the sparse coefficient matrix 'Y' 
        Y=zeros(size(D,2), size(X,2)); 
        for j=1:size(X,2)
            j
            Y(:,j)= OMP(X(:,j), D, numberOfSparseCoefficients, epsilon,errorFunction,Options);
        end 
        
        R= X-D*Y; 
        for k=1:size(D,2)
            indices = find(Y(k,:)~=0); 
            
            if isempty(indices)
                Error_k = X; 
                squareError_k = sum(Error_k.^2); 
                
                [d, I] = max(squareError_k); 
                
                bestElement= X(:,I); 
                bestElement = bestElement/sqrt(bestElement.'*bestElement); 
                
                D(:,k)= bestElement; 
                Y(k,indices)=0; 
            
            elseif ~isempty(indices)
                Error_k = R(:,indices) +D(:,k)*Y(k,indices); 
                
                [U,S,V]= svds(Error_k,1); 
                D(:,k)= U; 
                Y(k, indices)=S*V; 
                
            end 
        end 
        
    end 



end 