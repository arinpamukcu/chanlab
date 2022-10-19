% Script finds (1) access with -10mV voltage step; (2) opto evoked EPSC.
%
% Written by Arin Pamukcu
% Last updated May 18, 2019

clear all
close all

filename = '19808003_SC3.abf';

% Define time points of ephys protocol
sealteststep = -0.01;  % -10 mV voltage step
tracestart = 1;
traceend = 600000;
AMPAbaselinestart = 12000;
AMPAbaselineend = 20000;
NMDAbaselinestart = 312000;
NMDAbaselineend = 320000;
AMPAstart = 20450;  % LED stim time is 11624-11645
AMPAend = 25450;
% AMPAstimstart = 20374;
% AMPAstimend = 20394;
NMDAstart = 320450;  % LED stim time is 11624-11645
NMDAend = 330450;
% NMDAstimstart = 320374;
% NMDAstimend = 320394;
stablestart = 1;  % write sweep no of first stable sweeps
stableend = 15;  % write sweep no of last stable sweeps (subtract excluded no of sweeps)
%sweeps2exclude = [];  % write sweeps to exclude, separated by space

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Acquire data into <data> variable
[d,si] = abfload(filename,'sweeps','a');

% Reshape file into matrix, exclude unwanted sweeps
[dp,nc,ns] = size(d); %d is a 3d matrix of <data pts> by <no of channels> by <no of sweeps>
dnew = reshape(d,dp,ns); %dnew is a 2d matrix of <data pts> by <no of sweeps>
% dnew(:,sweeps2exclude) = [];

% % FIGURE-1: Plot all traces
% plot(tracestart:traceend,dnew(:,stablestart:stableend)); 

% Find baseline holding current for each trace
AMPAbaseline = median(dnew(AMPAbaselinestart:AMPAbaselineend,stablestart:stableend));
NMDAbaseline = median(dnew(NMDAbaselinestart:NMDAbaselineend,stablestart:stableend));

% To find access resistance (Ra), get steady state current after -10 mV step
%steadycurrent = mean(dnew(AMPAbaselinestart:AMPAbaselineend,:)) - baseline;

% Measure AMPA peak values
[AMPApks,AMPAlocs] = min(dnew(AMPAstart:AMPAend,stablestart:stableend));
AIpeak = AMPAbaseline - AMPApks;
AIpeak_time = AMPAstart + AMPAlocs;
% risetAI(:,:) = peakAI_time(:,:) - AMPAstimstart;
AMPApeak = median(AIpeak,2);
AMPA_time = median(AIpeak_time,2)/(stableend-stablestart+1);
 
% Measure NMDA peak values
[NMDApks,NMDAlocs] = max(dnew(NMDAstart:NMDAend,stablestart:stableend));
% peakNI = NMDAbaseline - NMDApks;
% peakNI_time = NMDAstart + NMDAlocs;
% peakNI_adjusted_time = peakNI_time + 500;
% NI_adjusted = dnew(peakNI_adjusted_time);
% peakNI_adjusted = NMDAbaseline - NI_adjusted;
NIpeak = NMDApks - NMDAbaseline;
NIpeak_time = NMDAstart + NMDAlocs;
NIpeak_adjusted_time = NIpeak_time + 500; %NMDA current measuref from 50ms after peak

for n=stablestart:stableend
    NI_adjusted(:,n) = dnew(NIpeak_adjusted_time(:,n),n);
end

NIpeak_adjusted = NI_adjusted - NMDAbaseline;
NMDApeak = median(NIpeak_adjusted);
NMDA_time = median(NIpeak_adjusted_time)/(stableend-stablestart+1);
    
% % Calculate the time when peak decreases to 10%
% [fallNMDA,lowtimeNMDA,uptimeNMDA] = falltime(dnew(NMDA_time:traceend),:);
% decay10timeNMDA = NMDA_time + lowtimeNMDA;

% FIGURE-2: plot AMPA and NMDA peak on figure
figure;
for n=stablestart:stableend
       plot(tracestart:traceend,dnew(:,n)); hold on;
       plot(AIpeak_time(:,n),dnew(AIpeak_time(:,n),n),'r*');
       plot(NIpeak_time(:,n),dnew(NIpeak_time(:,n),n),'r*');
       plot(NIpeak_adjusted_time(:,n),dnew(NIpeak_adjusted_time(:,n),n),'m*');
       plot(AMPAbaselinestart,dnew(AMPAbaselinestart,n),'b*');
       plot(AMPAbaselineend,dnew(AMPAbaselineend,n),'b*');
       plot(NMDAbaselinestart,dnew(NMDAbaselinestart,n),'b*');
       plot(NMDAbaselineend,dnew(NMDAbaselineend,n),'b*');
end

for i=stablestart:stableend;
    ratioAMPANMDA(:,i) = AIpeak(:,i)/NIpeak_adjusted(:,i);
    ratioAMPANMDAmedian = median(ratioAMPANMDA,2);
end

% % FIGURE-3: Plot data that can be used for eg trace
% plotTrace = dnew(20350:20750,1);
% figure; plot(plotTrace);

% % FIGURE-4: Plot data that can be used for eg trace
% AMPAtrace = [dnew(20300:25300,stablestart:stableend) - dnew(20300,stablestart:stableend)];
% AMPAtraceREV = -AMPAtrace;
% NMDAtrace = dnew(320300:325300,stablestart:stableend) - dnew(320300,stablestart:stableend);
% NMDAtracetime = adjustedNI_time + 320300;
% figure;
% plot(AMPAtraceREV);hold on;plot(NMDAtrace);
% figure;
% plot(AMPAtrace);hold on;plot(NMDAtrace);
% % plot(NMDAtracetime(:,1),dnew(NMDAtracetime(:,1),stablestart:stableend),'g*');

% Values to copy and paste on excel or gSheets
copy2excel = {'AMPA peak','NMDA peak','AMPA/NMDA ratio'; AMPApeak,NMDApeak,ratioAMPANMDAmedian};
