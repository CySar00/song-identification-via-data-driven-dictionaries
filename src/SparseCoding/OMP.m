function y  = OMP(x, D, varargin)
%
%   Input:: 
%       x 
%       D 
%
%       numberOfSparseCoefficients 
%       epsilon 
%       errorFunction 
%       Options 
%
%   Output:: 
%       y 

    lengthOfVarargin=length(varargin); 
    if lengthOfVarargin<1
        varargin{1}= randi(size(D,2)-1); 
    end 
    numberOfSparseCoefficients = varargin{1}; 
    
    if lengthOfVarargin<2 
        varargin{2}=-Inf; 
    end 
    epsilon = varargin{2};
    
    if iscell(numberOfSparseCoefficients)
        epsilon = numberOfSparseCoefficients{1}; 
        numberOfSparseCoefficients = size(x,1); 
    
    elseif numberOfSparseCoefficients ~=round(numberOfSparseCoefficients)
        epsilon  = numberOfSparseCoefficients; 
        numberOfSparseCoefficients = size(x,1); 
    end 
    
    if epsilon==0
        warning('warning!!! the target residual cannot be equal to zero!!! Changing value to "eps"');
        epsilon =eps; 
    end 
    
    if lengthOfVarargin<3 
        varargin{3}= []; 
    end 
    errorFunction =varargin{3}; 
    
    if ~isempty(errorFunction) && ~isa(errorFunction, 'function_handle')
        error('The input of the variable "errorFunction" must be a function handle or left empty'); 
    end 
    
    if lengthOfVarargin<4 
        varargin{4}= []; 
    end 
    Options = varargin{4}; 
    
    function output=setOptions(field, default)
        if ~isfield(Options, field)
            Options.(field)= default; 
        end 
        output = Options.(field); 
    end 

    slowMode= setOptions('slowMode',false); 

    if iscell(D)
        LARGESCALE= true; 
        Df = D{1}; 
        Dt = D{2}; 
    else 
        LARGESCALE=false; 
        Df = @(x) D*x; 
        Dt = @(x) D.'*x; 
    end 

    %   -- Initialization ::
    %   Set y=0 so that r=x
    r=x; 
    Dr = Dt(x); 
    
    y=zeros(size(D,2),1); 
    unitVector =zeros(size(D,2),1); 
    
    maxNumberOfIterations = numberOfSparseCoefficients; 
    
    Indices = zeros(maxNumberOfIterations,1); 
    SortedIndices = zeros(maxNumberOfIterations,1); 
    Residuals=zeros(maxNumberOfIterations,1); 
    
    D_k=zeros(size(D)); 
    D_2k=zeros(size(D)); 
    
    R= zeros(size(D,2)); 
    Residuals(1)=norm(r,2); 
    k=1;
    while k<=maxNumberOfIterations && Residuals(k)>=epsilon 
        [maxValue, maxIndex]= max(abs(Dr)); 
        hat_k= maxIndex; 
        
        Indices(k)= hat_k; 
        SortedIndices(1:k)= sort(Indices(1:k)); 
        
        if LARGESCALE 
            unitVector(hat_k)=1; 
            d_k = Df(hat_k); 
            unitVector(hat_k)=0; 
        else 
            d_k =D(:,hat_k); 
        end 
        D_k(:,k)=d_k; 
        
        if slowMode 
            y_k = D_k(:,1:k)\x; 
            y(Indices(1:k))=y_k; 
            
            r= x-D_k(:,1:k)*y_k; 
        else 
            if isreal(x)
                for i=1:k-1
                    R(i,k)= (d_k.'*D_2k(:,i)); 
                    d_k = d_k - R(i,k)*D_2k(:,i); 
                end 
            else 
                for i=1:k-1
                    R(i,k)= (D_2k(:,i).'*d_k); 
                    d_k = d_k-R(i,k)*D_2k(:,i); 
                end 
            end 
            d_k = d_k/(sqrt(d_k.'*d_k)+eps);
            
            D_2k(:,k)=d_k; 
            
            y_k = D_2k(:,1:k).'*x; 
            y(Indices(1:k))=y_k; 
            
            r= x-D_2k(:,1:k)*y_k; 
            
        end 
        
        if ~slowMode && k==maxNumberOfIterations 
            y_k= D_k(:,1:k)\x; 
            
            [~,warningID]= lastwarn;
            if strcmp(warningID, 'MATLAB:rankDeficientMatrix') || strcmp(warningID, 'MATLAB:singularMatrix')
                y_k = pinv(D_k(:,1:k))*x; 
            end 
            y(Indices(1:k))=y_k; 
            
            r= x-D_k(:,1:k)*y_k; 
        end 
        
        if k<maxNumberOfIterations 
            Dr = Dt(r); 
        end 
        
        k=k+1; 
        Residuals(k)=norm(r,2); 
    end 
    
end 
