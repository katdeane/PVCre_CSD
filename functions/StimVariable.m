function [stimList, thisUnit, stimDur, stimITI, thisTag] = ...
    StimVariable(Condition,sr_mult)

% for the various scripts that need this information dynamically, this
% function reads the current stim type and produces consistant variable
% data across the pipeline

% sr_mult variable let's us control the sampling rate for CSD and Spike
% output. CSD is consistently set at sr 1000 / sr_mult = 1. Spiking data
% currently set to sr 3000 / sr_mult = 3.

if ~exist('sr_mult','var')
    sr_mult = 1; % 1k sampling rate
end

if matches(Condition,'NoiseBurst1') || ...
        matches(Condition,'NoiseBurst2')
    stimList = 70;
    thisUnit = 'dB';
    stimDur  = 100*sr_mult; % ms
    stimITI  = 1000*sr_mult; % 1000 ms included but 3000 ITI actual
    thisTag  = 'noise'; 
    
elseif matches(Condition,'Spontaneous') || ...
        matches(Condition,'postSpont')
    stimList = 1;
    thisUnit = [];
    stimDur  = 1000*sr_mult; % ms
    stimITI  = 1000*sr_mult;
    thisTag  = 'spont'; 
    
elseif matches(Condition,'ClickTrain')
    stimList = 40;
    thisUnit = 'Hz';
    stimDur  = 2000*sr_mult; % ms
    stimITI  = 1000*sr_mult;  % 1000 ms included but 3000 ITI actual
    thisTag  = 'ClickRatePV';
    
    
elseif matches(Condition,'gapASSR')
    % 10 gaps every 25 ms from onset to onset (40 hz)
    % 250 ms noise, 250 ms gap-noise, etc. , 250 noise
    % 6 presentations of gap-noise
    % noiseonset = [0, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000];
    % gaponset = [250, 750, 1250, 1750, 2250, 2750, 3250, 3750, 4250, 4750];
    stimList = [4, 6, 8, 10];
    thisUnit = '[ms] gap width';
    stimDur  = 3250*sr_mult; % ms
    stimITI  = 500*sr_mult;  % 500 ITI actual
    thisTag  = 'GapASSRRatePV';

end