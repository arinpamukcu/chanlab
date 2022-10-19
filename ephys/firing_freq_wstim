% Script finds firing frequency of cell attached recordings in voltage
% clamp configuration.
%
% Written by Arin Pamukcu
% Last editted May 26, 2019

clear all; close all;

filename = '17d04008_AP4.abf';

starttime = 1;
endtime = 600000; %each sweep is 20 seconds
time = starttime:endtime;
baselinestart = 2000; %baseline is between 1.4-2.4 seconds (or 0.2-1.2)
baselineend = 12000;
basetime = baselinestart:baselineend;
stimstart = 54000; %stimulation is between 5.4-6.4 seconds (or 1.4-2.4)
stimend = 64000; % 64000 for 10 sec, 59000 for 5 sec
stim2sec = 56000; % 56000 for 2 sec
stimtime = stimstart:stimend;
stim2time = stimstart:stim2sec;
zime = time';

% Acquire data into <data> variable
[d,si] = abfload(filename,'sweeps','a');

% Reshape file into matrix, exclude unwanted sweeps
[dp,nc,ns] = size(d); %d is a 3d matrix of <data pts> by <no of channels> by <no of sweeps>
dnew = reshape(d,dp,ns); %dnew is a 2d matrix of <data pts> by <no of sweeps>
% dnostim = dnew(:,nostimsweeps);
%dnew = -1.*dnew2; %turn on if peaks are more apparent in opposite direction
num_trials = size(dnew,1); 

%% find peaks

% Find peaks of baseline and stim duration
[pksBase,locsBase] = findpeaks(dnew(baselinestart:baselineend,1),'MinPeakDistance',50,'MinPeakHeight',20);
[pksStim,locsStim] = findpeaks(dnew(stimstart:stimend,1),'MinPeakDistance',50,'MinPeakHeight',20);
[pksStim2,locsStim2] = findpeaks(dnew(stimstart:stim2sec,1),'MinPeakDistance',50,'MinPeakHeight',20);

% Firing frequency
freq_base = 10000* length(pksBase) / length(basetime); % convert time to seconds
freq_stim = 10000* length(pksStim) / length(stimtime); % convert time to seconds
freq_stim2 = 10000* length(pksStim2) / length(stim2time); % convert time to seconds
freq_foldchange = freq_stim/freq_base;
freq_foldchange2 = freq_stim2/freq_base;

% Values to copy and paste on excel or gSheets
copy2excel = {'freq at baseline','freq during stim','fold change', 'fold change 2sec';freq_base,freq_stim,freq_foldchange,freq_foldchange2};


%% check raw data by plotting baseline and stim periods from sweep 1

% FIGURE 1: plot peak found in firing data
% FIGURE 2: plot baseline period
% FIGURE 3: plot stim period
plot(dnew(:,1));
xlabel('Time (ms)'); ylabel('Current (pA)');
figure; 
plot(basetime,dnew(baselinestart:baselineend,1),basetime(locsBase),pksBase,'*r');
figure;
plot(stimtime,dnew(stimstart:stimend,1),stimtime(locsStim),pksStim,'*r');

% FIGURE 4: plot trace that can be used
% plotTrace = dnew(9400:409400,1);
% figure; plot(plotTrace);

%% create and plot instantaneous frequency

% FIGURE 5: plot instantaneous frequency 
fs = 2000; %sample rate of data is 10000
ifqdata = dnew(9400:309400);
figure; instfreq(dnew,fs);
[ifq,t] = instfreq(dnew,fs);
