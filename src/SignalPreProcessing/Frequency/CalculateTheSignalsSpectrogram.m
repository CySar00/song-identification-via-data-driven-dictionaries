function [STFTs, magnitudes, magnitudesWithNoNoise,...
    normalizedMagnitudesWithNoNoise,...
    filteredMagnitudes] =...
    CalculateTheSignalsSpectrogram(mp3, varargin)
%
%   Input:: 
%       mp3 
%
%       samplingRate_toResample 
%       frame 
%       overlapFactor 
%
%       windowType 
%       windowLength 
%       windowAmplitude 
%       windowSFlag 
%
%       B 
%       halfPole 
%
%   Output:: 
%       STFTs 
%       magnitudes 
%       magnitudesWithNoNoise 
%       normalizedMagnitudesWithNoNoise 

    mp3_Title =mp3(1); 
    mp3_audioSignal = cell2mat(mp3(2)); 
    mp3_samplingRate = cell2mat(mp3(3)); 
    
    lengthOfVarargin=length(varargin); 
    if lengthOfVarargin<1 
        varargin{1}= 8000; 
    end 
    samplingRate_toResample =varargin{1}; 
    
    if lengthOfVarargin<2 
        varargin{2}= 256; 
    end 
    frame = varargin{2};
    
    if lengthOfVarargin<3
        varargin{3}= 0.5; 
    end 
    overlapFactor = varargin{3} ; 
    
    if lengthOfVarargin<4 
        varargin{4}= 'hamming';
    end 
    windowType = lower(varargin{4}); 
    
    if lengthOfVarargin<5
        varargin{5}= round(samplingRate_toResample*frame/samplingRate_toResample); 
    end 
    windowLength = varargin{5}; 
    
    if lengthOfVarargin<6 
        varargin{6}=1; 
    end 
    windowAmplitude = varargin{6}; 
    
    if lengthOfVarargin<7
        varargin{7}= 'periodic'; 
    end 
    windowSFlag = lower(varargin{7}); 
    
    if lengthOfVarargin<8
        varargin{8}=10^8; 
    end 
    B= varargin{8}; 
    
    if lengthOfVarargin<9
        varargin{9}= 0.98;
    end 
    halfPole = varargin{9}; 
    
    [STFTs, magnitudes, magnitudesWithNoNoise,...
        normalizedMagnitudesWithNoNoise]=...
        CalculateTheAudioSignalsSpectrogram(mp3,...
        samplingRate_toResample, frame, overlapFactor,...
        windowType, windowLength, windowAmplitude, windowSFlag,...
        B...
        ); 
    
    filteredMagnitudes = HighPassFilterTheSignalsSpectrogram(normalizedMagnitudesWithNoNoise, halfPole);
    
        
end 