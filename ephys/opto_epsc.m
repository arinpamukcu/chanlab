% Script finds (1) access with -10mV voltage step; (2) opto evoked EPSC.
% CANNOT CALCULATE WHEN PEAK CHANGES FROM INWARD TO OUTWARD. NEED TO CHANGE
% MIN() TO MAX() IN PEAK CALCULATION :(((
%
% Written by Arin Pamukcu
% Last editted Aug 6, 2016

clear all;
close all;

filename = '19n06001_AP4.abf';

% Define time points of recording protocol
voltageSealtest = -0.01; %-10 mV voltage step
voltageHolding = -0.05; %hold the cell at -50 mV
timeTracestart = 1;
timeTraceend = 50000;
% timeAccessminstart = 500;
% timeAccessminend = 800;
% timeAccesssteadystart = 1400;
% timeAccesssteadyend = 1600;
timeBasestart = 4000;
timeBaseend = 9000;
timeStimstart = 11000; %11000, LED stim time is 11624-11645
timeStimend = 12000; % 11700
traceStablestart = 5; %write sweep no of first stable sweeps
traceStableend = 5; %write sweep no of last stable sweeps (subtract excluded no of sweeps)
sweeps2exclude = []; %write sweeps to exclude, separated by space

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Acquire data into <data> variable
[d,si] = abfload(filename,'sweeps','a');

% Reshape file into matrix, exclude unwanted sweeps
[dp,nc,ns] = size(d); %d is a 3d matrix of <data pts> by <no of channels> by <no of sweeps>
dnew = reshape(d,dp,ns); %dnew is a 2d matrix of <data pts> by <no of sweeps>
dnew(:,sweeps2exclude) = [];

% Plot traces
% figure; plot(timeTracestart:timeTraceend,dnew(:,traceStablestart:traceStableend));

% % Sweeps to plot traces
% traces = dnew((11500:13500),[9 42 67]);
% figure;plot(traces);

% % subtracted NMDA trace
% NMDA = traces(:,[1]) - traces(:,[2]);
% hold on;plot(NMDA);
% xlabel('Time (ms)');
% ylabel('Current (pA)');

% Find holding current at -50 mV holding potential
currentBaseline = median(dnew(timeBasestart:timeBaseend,:));
currentHolding = median(currentBaseline(:,(traceStablestart:traceStableend)));

% % Find membrane resistance (Rm)
% resistanceMembrane = voltageHolding ./ ((currentBaseline) .* 1e-12);
% resistanceMembrane_mean = mean(resistanceMembrane ./ 1e6);
% % 
% % Find access resistance (Ra)
% % (1) get min of current upon -10 mV step, 
% % (2) get steady state current after -10 mV step,
% % substract (2) from (1)
% currentAccessMin = min(dnew(timeAccessminstart:timeAccessminend,:));
% currentAccessSteady = mean(dnew(timeAccesssteadystart:timeAccesssteadyend,:));
% currentAccess = currentAccessSteady - currentAccessMin;
% 
% % Access resistance (in mega ohms)
% resistanceAccess = abs(voltageSealtest ./ ((currentAccess) .* 1e-12));
% resistanceAccess_mean = mean(resistanceAccess ./ 1e6);
% 
% % Total resistance (in mega ohms)
% resistanceTotal = resistanceMembrane + resistanceAccess;
% resistanceTotal_mean = mean(resistanceTotal ./ 1e6);

% if access resistance changes more than 20% form the beginning until the
% end of the recording, stop calculating rest
%if Raccess(stablestart)*0.8 >= Raccess(stableend)
    %return;
%end

% Find peak onset
%onset = findchangepts(dnew(640:660,:));

% Measure peak values
[pks,locs] = min(dnew(timeStimstart:timeStimend,:));
currentPeak_amplitude = pks - currentBaseline;
currentPeak_time = timeStimstart + locs;
 
% Plot calculated peaks on the traces
hold on; plot(currentPeak_time(:,traceStablestart:traceStableend),pks(:,traceStablestart:traceStableend),'r*');

% Plot only peak values
figure; plot(currentPeak_amplitude);
hold on; plot(traceStablestart:traceStableend,currentPeak_amplitude(:,traceStablestart:traceStableend),'r*'); 

% Calculate current peak and time of peak
currentEPSC_amplitude = median(currentPeak_amplitude(:,(traceStablestart:traceStableend)));
currentEPSC_time = median(currentPeak_time(:,(traceStablestart:traceStableend)))/10;

% Copy single trace for plotting
plotTrace = dnew(11000:16000,4);
figure; plot(plotTrace);

% % Values to copy and paste on excel or gSheets
% copy2excel = {'Iholding','Rmembrane','Raccess','-EPSC','EPSC_time';currentHolding,resistanceMembrane_mean,resistanceAccess_mean,-1*currentEPSC_amplitude,currentEPSC_time};
disp('JOB DONE');
Footer
