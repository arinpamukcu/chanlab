clc;
clear all;
close all;
% Written by Arin Pamukcu
% Last edit May 10, 2020 by Arin Pamukcu

filename = 'Raw_Trial403_8007.xlsx';
sheet = 1;
range = 'A40:AF18005';

data = xlsread(filename, sheet, range);
data(isnan(data)) = 0;
% data are time (row) by variable (columns) matrix
% time: seconds sampled at 10hz
% variable: 32 different variables, refer to main document
% 
% baseline = [data(1:3001,:)];
% Vbaseline = mean(baseline(:,8));

%% Determine the time period for experiment

% % if stim period is between 5-14 mins
% % you will have 1000 data points: 10(hz samplerate)*10(sec)*10(min)
% baseline = [data(1:3001,:)];
% pre = [data(2901:3000,:);data(3501:3600,:);data(4101:4200,:);data(4701:4800,:);data(5301:5400,:);
%     data(5901:6000,:);data(6501:6600,:);data(7101:7200,:);data(7701:7800,:);data(8301:8400,:)];
% stim = [data(3001:3100,:);data(3601:3700,:);data(4201:4300,:);data(4801:4900,:);data(5401:5500,:);
%     data(6001:6100,:);data(6601:6700,:);data(7201:7300,:);data(7801:7900,:);data(8401:8500,:)];
% post = [data(3101:3200,:);data(3701:3800,:);data(4301:4400,:);data(4901:5000,:);data(5501:5600,:);
%     data(6101:6200,:);data(6701:6800,:);data(7301:7400,:);data(7901:8000,:);data(8501:8600,:)];

% if stim period is 15-24 mins
% you will have 1000 data points: 10(hz samplerate)*10(sec)*10(min)
% baseline = [data(1:3001,:)];
% pre = [data(8901:9000,:);data(9501:9600,:);data(10101:10200,:);data(10701:10800,:);data(11301:11400,:);
%     data(11901:12000,:);data(12501:12600,:);data(13101:13200,:);data(13701:13800,:);data(14301:14400,:)];
% stim = [data(9001:9100,:);data(9601:9700,:);data(10201:10300,:);data(10801:10900,:);data(11401:11500,:);
%     data(12001:12100,:);data(12601:12700,:);data(13201:13300,:);data(13801:13900,:);data(14401:14500,:)];
% post = [data(9101:9200,:);data(9701:9800,:);data(10301:10400,:);data(10901:11000,:);data(11501:11600,:);
%     data(12101:12200,:);data(12701:12800,:);data(13301:13400,:);data(13901:14000,:);data(14501:14600,:)];

% if stim period is 20-29 mins
% you will have 1000 data points: 10(hz samplerate)*10(sec)*10(min)
% baseline = [data(1:3001,:)];
% pre = [data(11901:12000,:);data(12501:12600,:);data(13101:13200,:);data(13701:13800,:);data(14301:14400,:);
%     data(14901:15000,:);data(15501:15600,:);data(16101:16200,:);data(16701:16800,:);data(17301:17400,:)];
% stim = [data(12001:12100,:);data(12601:12700,:);data(13201:13300,:);data(13801:13900,:);data(14401:14500,:);
%     data(15001:15100,:);data(15601:15700,:);data(16201:16300,:);data(16801:16900,:);data(17401:17500,:)];
% post = [data(12101:12201,:);data(12701:12801,:);data(13301:13401,:);data(13901:14001,:);data(14501:14601,:);
%     data(15101:15201,:);data(15701:15801,:);data(16301:16401,:);data(16901:17001,:);data(17501:17601,:)];

% % if stim period is 5-9 mins
% % you will have 500 data points: 10(hz samplerate)*10(sec)*5(min)
% baseline = [data(1:3001,:)];
% pre = [data(2901:3000,:);data(3501:3600,:);data(4101:4200,:);data(4701:4800,:);data(5301:5400,:)];
% stim = [data(3001:3100,:);data(3601:3700,:);data(4201:4300,:);data(4801:4900,:);data(5401:5500,:)];
% post = [data(3101:3200,:);data(3701:3800,:);data(4301:4400,:);data(4901:5000,:);data(5501:5600,:)];

% % if stim period is 25-29 mins
% % you will have 500 data points: 10(hz samplerate)*10(sec)*5(min)
% baseline = [data(1:3001,:)];
% pre = [data(14901:15000,:);data(15501:15600,:);data(16101:16200,:);data(16701:16800,:);data(17301:17400,:)];
% stim = [data(15001:15100,:);data(15601:15700,:);data(16201:16300,:);data(16801:16900,:);data(17401:17500,:)];
% post = [data(15101:15200,:);data(15701:15800,:);data(16301:16400,:);data(16901:17000,:);data(17501:17600,:)];

% % if stim period is 5-9, 15-20 mins
% % you will have 500 data points: 10(hz samplerate)*10(sec)*5(min)
baseline = [data(1:3001,:)];
pre = [data(2901:3000,:);data(3501:3600,:);data(4101:4200,:);data(4701:4800,:);data(5301:5400,:);
    data(8901:9000,:);data(9501:9600,:);data(10101:10200,:);data(10701:10800,:);data(11301:11400,:)];
stim = [data(3001:3100,:);data(3601:3700,:);data(4201:4300,:);data(4801:4900,:);data(5401:5500,:);
    data(9001:9100,:);data(9601:9700,:);data(10201:10300,:);data(10801:10900,:);data(11401:11500,:)];
post = [data(3101:3200,:);data(3701:3800,:);data(4301:4400,:);data(4901:5000,:);data(5501:5600,:);
    data(9101:9200,:);data(9701:9800,:);data(10301:10400,:);data(10901:11000,:);data(11501:11600,:)];

% % if stim period is 5-9 mins + 25-29 mins
% % you will have 500 data points: 10(hz samplerate)*10(sec)*5(min)
% baseline = [data(1:3001,:)];
% pre = [data(2901:3000,:);data(3501:3600,:);data(4101:4200,:);data(4701:4800,:);data(5301:5400,:);
%     data(14901:15000,:);data(15501:15600,:);data(16101:16200,:);data(16701:16800,:);data(17301:17400,:)];
% stim = [data(3001:3100,:);data(3601:3700,:);data(4201:4300,:);data(4801:4900,:);data(5401:5500,:);
%     data(15001:15100,:);data(15601:15700,:);data(16201:16300,:);data(16801:16900,:);data(17401:17500,:)];
% post = [data(3101:3200,:);data(3701:3800,:);data(4301:4400,:);data(4901:5000,:);data(5501:5600,:);
%     data(15101:15200,:);data(15701:15800,:);data(16301:16400,:);data(16901:17000,:);data(17501:17600,:)];


%% Get velocity (cm/s), distance (cm), aceleration (cm/s2)

close all;

% get velocity (cm/s)
Vbaseline = mean(baseline(:,8));
Vpre = pre(:,8);
meanVpre = mean(Vpre);
Vstim = stim(:,8);
meanVstim = mean(Vstim);
Vpost = post(:,8);
meanVpost = mean(Vpost);
Vfoldchange = mean(stim(:,8)./pre(:,8)-1);
Vpercentchange = (Vfoldchange*100)-100;

% figure;
% plot(Vpre); hold on; plot(Vstim); hold on; plot(Vpost);
% xlabel("time (s)");
% ylabel("velocity (cm/s)");

data_velocity = {'Velocity, pre','Velocity, stim','Velocity, post','Velocity, fold change','Velocity, percent change';Vpre,Vstim,Vpost,Vfoldchange,Vpercentchange};

%% Get Mobility vs Immobility vs Fine movement

close all;

% get variables for pre time period
Mob_pre = zeros(length(Vpre),1);
IMob_pre = zeros(length(Vpre),1);
% Fine_pre = zeros(length(Vpre),1);
for k = 1:length(Vpre)
    if Vpre(k,1) > 1   % threshold for mobility is above 2 m/s
        Mob_pre(k,1) = Mob_pre(k,1)+1;
    elseif Vpre(k,1) <= 1   % threshold for immobility is below 1 m/s
        IMob_pre(k,1) = IMob_pre(k,1)+1;
%     else
%         Fine_pre(k,1) = Fine_pre(k,1)+1;  % anything else is considered fine movement
%         k = k+1;
    end
end

Mob_pre_fraction = sum(sum(Mob_pre(:,1)))/10;
IMob_pre_fraction = sum(sum(IMob_pre(:,1)))/10;
% Fine_pre_fraction = sum(sum(Fine_pre(:,1)))/10;
%plot(Mo_pre); hold on; plot(IMo_pre); hold on; plot(Fm_pre)

% get variables for stim time period
Mob_stim = zeros(length(Vstim),1);
IMob_stim = zeros(length(Vstim),1);
Fine_stim = zeros(length(Vstim),1);
for m = 1:length(Vstim)
    if Vstim(m,1) > 1   % threshold for mobility is above 2 m/s
        Mob_stim(m,1) = Mob_stim(m,1)+1;
    elseif Vstim(m,1) <= 1   % threshold for immobility is below 1 m/s
        IMob_stim(m,1) = IMob_stim(m,1)+1;
%     else
%         Fine_stim(m,1) = Fine_stim(m,1)+1;  % anything else is considered fine movement
%         m = m+1;
    end
end

Mob_stim_fraction = sum(sum(Mob_stim(:,1)))/10;
IMob_stim_fraction = sum(sum(IMob_stim(:,1)))/10;
% Fine_stim_fraction = sum(sum(Fine_stim(:,1)))/10;

% get variables for post time period
Mob_post = zeros(length(Vpost),1);
IMob_post = zeros(length(Vpost),1);
Fine_post = zeros(length(Vpost),1);
for t = 1:length(Vpost)
    if Vpost(t,1) > 1   % threshold for mobility is above 2 m/s
        Mob_post(t,1) = Mob_post(t,1)+1;
    elseif Vpost(t,1) <= 1   % threshold for immobility is below 1 m/s
        IMob_post(t,1) = IMob_post(t,1)+1;
%     else
%         Fine_post(t,1) = Fine_post(t,1)+1;  % anything else is considered fine movement
%         t = t+1;
    end
end

Mob_post_fraction = sum(sum(Mob_post(:,1)))/10;
IMob_post_fraction = sum(sum(IMob_post(:,1)))/10;
% Fine_post_fraction = sum(sum(Fine_post(:,1)))/10;

data_mobility1 = {'Mobility, pre','Mobility, stim','Mobility, post','Immobility, pre','Immobility, stim','Immobility, post';
    Mob_pre_fraction,Mob_stim_fraction,Mob_post_fraction,IMob_pre_fraction,IMob_stim_fraction,IMob_post_fraction};

%% Quantify frequency and durtion of immobility & mobility

close all; % close variables, figs, cmd window.

% load('TestData.mat') % Load the column data

% CHANGE THIS TO GET DATA FOR PRE,STIM,POST: IMob_pre, IMob_stim, IMob_post
data = logical(IMob_pre); % Convert numeric to logical elemnts

% data = [1 1 0 0 1 0 1 0 0 1 0 1 1]; % For testing on smaller arrays

len = length(data); % Get legth of column data

startbout = data(1); % Get the 1st logically-converted element

% Create and iniate matrices and counters for mobile and immobile bouts
Immobile = [];
Mobile = [];
countbout = 0;
lastbout = startbout;


for jj = 1:len
    if data(jj) == lastbout && jj ~= len
        countbout = countbout + 1;
    elseif data(jj) == lastbout && jj == len
        countbout = countbout + 1;
        switch data(jj)
            case 1
                Immobile = [Immobile; countbout];
                countbout = 1;
                lastbout = data(jj);
            case 0
                Mobile = [Mobile; countbout];  
                countbout = 1;
                lastbout = data(jj);
        end 
    elseif data(jj) ~= lastbout && jj ~= len
        switch lastbout 
            case 1
                Immobile = [Immobile; countbout];
            case 0
                Mobile = [Mobile; countbout];  
        end
        countbout = 1;
        lastbout = data(jj);
        
      elseif data(jj) ~= lastbout jj == len
        switch lastbout 
            case 1
                Immobile = [Immobile; countbout];
                Mobile = [Mobile; 1]; 
            case 0
                Mobile = [Mobile; countbout]; 
                Immobile = [Immobile; 1];
        end
        countbout = 1;
        lastbout = data(jj);        
    end   
end

Immobile;
Mobile;
data;

IMmobBouts = length(Immobile); IMobDuration = sum(Immobile);
MobBouts = length(Mobile); MobDuration = sum(Mobile);

data_mobility2 = {'Mobile bouts','Immobile bouts','Mobile duration','Immobile duration';
    MobBouts,IMmobBouts,MobDuration,IMobDuration};


%% Get xy coordinates for movement tracks

close all;

Xpre = pre(:,3);
Ypre = pre(:,4);
Xstim = stim(:,3);
Ystim = stim(:,4);
Xpost = post(:,3);
Ypost = post(:,4);

% % plot data in different figures
% plot(Xpre, Ypre);
% xlabel("x-pre");
% ylabel("y-pre");
% 
% figure;
% plot(Xstim, Ystim);
% xlabel("x-stim");
% ylabel("y-stim");
% 
% figure;
% plot(Xpost, Ypost);
% xlabel("x-post");
% ylabel("y-post");

% plot movement tracks data in the same figure
figure;
plot(Xpre, Ypre); hold on; plot(Xstim, Ystim); hold on; plot(Xpost, Ypost);
xlabel("x coord");
ylabel("y coord");



%% Center vs surround analysis

% Center zones: Z6, Z7, Z10, Z11
% Surround zones: Z1, Z2, Z3, Z4, Z5, Z8, Z9, Z12, Z13, Z14, Z15, Z16

Center_pre = sum(sum(pre(:,[21,22,25,26])))/4;
Surround_pre = sum(sum(pre(:,[16,17,18,19,20,23,24,27,28,29,30,31])))/12;
Center_stim = sum(sum(stim(:,[21,22,25,26])))/4;
Surround_stim = sum(sum(stim(:,[16,17,18,19,20,23,24,27,28,29,30,31])))/12;
Center_post = sum(sum(post(:,[21,22,25,26])))/4;
Surround_post = sum(sum(post(:,[16,17,18,19,20,23,24,27,28,29,30,31])))/12;
