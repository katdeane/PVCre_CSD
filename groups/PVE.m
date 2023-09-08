%%% Group PVE = PV Experiment

animals = {'PVE01'}; %'PVE01','PVE02','PVE03' etc

% notes:
% PVE01 died during the Noiseburst measurement directly after click trains

%% Channels and Layers

channels = {...
    '[4 31]'... %01
    };

%           01                
Layer.II = {'[1:2]'}; 
%           01     
Layer.IV = {'[3:9]'};
%           01        
Layer.Va = {'[10:17]'};
%           01  
Layer.Vb = {'[18:24]'}; 
%           01    
Layer.VI = {'[25:28]'}; 



%% Conditions
% if empty: {[]},... %subjectID

Cond.NoiseBurst1 = {...
	{'04'}... %PVE01
    };

Cond.gapASSR = {...
	{'05'}... %PVE01
    };

Cond.ClickTrain = {...
	{'06'}... %PVE01
	};

Cond.NoiseBurst2 = {...
	{[]}... %PVE01
    };

Cond.Spontaneous = {...
	{[]},... %PVE01
	};
