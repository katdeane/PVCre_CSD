% Pipeline - PV Cre Study

% This is the master script for the project, run by Mawaheb Kassir
% at University of California, Riverside in Khaleel Razak's lab in
% the Psychology Department. 

% The overall goal of this study is to characterize A1 laminar differences
% after PV silencing with DREADD. 

%% Get started

clear; clc;

% set working directory; change for your station
if exist('F:\PVCre_CSD','dir')
    cd('F:\PVCre_CSD'); 
elseif exist('D:\PVCre_CSD','dir')
    cd('D:\PVCre_CSD'); 
else
    error('add your local repository as shown above')
end

homedir = pwd; % call up the working directory
addpath(genpath(homedir)); % add the whole directory to path

% set consistently needed variables
Groups = {'PVE'}; % probably 'PVC' for control group
Condition = {'NoiseBurst1' 'gapASSR' 'ClickTrain' 'NoiseBurst2' 'Spontaneous'};

%% Data generation per subject ⊂◉‿◉つ

% per subject CSD Script
DynamicCSD(homedir, Condition)

%% Group pics (⌐▨_▨)

% generate group averaged CSDs based on stimuli (does not BF sort)
for iGro = 1:length(Groups)
    for iST = 1:length(Condition)
        disp(['Average CSDs for ' Groups{iGro} ' ' Condition{iST}])
        tic
        AvgCSDfig(homedir, Groups{iGro}, Condition{iST})
        toc
    end
end


%% trial-averaged AVREC and layer trace generation / peak detection ┏ʕ •ᴥ•ʔ┛

for iGro = 1:length(Groups)
    for iST = 1:length(Condition)
        disp(['Single traces for ' Groups{iGro} ' ' Condition{iST}])
        tic 
        Avrec_Layers(homedir, Groups{iGro}, Condition{iST})
        toc
    end
end

%% Group AVREC and layer traces / average peak detection ʕ ◕ᴥ◕ ʔ

disp('Producing group-averaged traces for each group')
for iGro = 1:length(Groups)
    for iST = 1:length(Condition)
        disp(['Group traces for ' Group{iGro} ' ' Condition{iST}])
        tic 
        Group_Avrec_Layers(homedir, Groups{iGro}, Condition{iST})
        toc
    end
end


%% CWT analysis 

% Output:   Runs CWT analysis using the Wavelet toolbox. 
params.sampleRate = 1000; % Hz
params.frequencyLimits = [5 params.sampleRate/2]; % Hz
params.voicesPerOctave = 8;
params.timeBandWidth = 54;
params.layers = {'II','IV','Va','Vb','VI'}; 
params.condList = {'NoiseBurst','ClickTrain','Chirp','gapASSR'}; % subset
params.groups = {'MWT','MKO'}; % for permutation test

% Only run when data regeneration is needed:
runCwtCsd(homedir,'MWT',params);
runCwtCsd(homedir,'MKO',params);


% specifying Power: trials are averaged and then power is taken from
% the complex WT output of runCwtCsd function above. Student's t test
% and Cohen'd d effect size are the stats used for observed and
% permutation difference
% specifying Phase: phase is taken per trial. mwu test and r effect
% size are the stats used
% Output:   Figures for means and observed difference of comparison;
%           figures for observed t values, clusters
%           output; boxplot and significance of permutation test
PermutationTest(homedir,'Power',params)
PermutationTest(homedir,'Phase',params)

%% CWT analysis on LFP 

runCwtCsd_LFP('MWT',params,homedir,{'5.28', '36.76'});
runCwtCsd_LFP('MKO',params,homedir,{'5', '40'});

for iFreq = 1:length(BatFreq)

    % specifying Power: trials are averaged and then power is taken from
    % the complex WT output of runCwtCsd function above. Student's t test
    % and Cohen'd d effect size are the stats used for observed and
    % permutation difference
    % specifying Phase: phase is taken per trial. mwu test and r effect
    % size are the stats used
    % Output:   Figures for means and observed difference of comparison; 
    %           figures for observed t values, clusters
    %           output; boxplot and significance of permutation test 
    PermutationTest_LFP(homedir,BatFreq{iFreq},MouseFreq{iFreq},'Power')
    PermutationTest_LFP(homedir,BatFreq{iFreq},MouseFreq{iFreq},'Phase')

end
