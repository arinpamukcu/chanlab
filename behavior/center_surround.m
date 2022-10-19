clc;
clear all;
close all;
% Written by Arin Pamukcu
% Last edit May 10, 2020 by Arin Pamukcu

filename = 'Raw_Trial376_7752.xlsx';
sheet = 1;
range = 'A40:AF18005';
% range = 'A39:AF18004'; for QC's files

data = xlsread(filename, sheet, range);
% data(isnan(data)) = 0;

% data are time (row) by variable (columns) matrix
% time: seconds sampled at 10hz
% variable: 32 different variables, refer to main document f3or details

% baseline = [data(1:3001,:)];
% Vbaseline = mean(baseline(:,8));

figure;
plot(data(:,3), data(:,4)); xlabel("x coord"); ylabel("y coord");

%% Determine the time period for experiment

% % if stim period is 5-9 mins
% % you will have 500 data points: 10(hz sampling)*10(sec)*5(min)
% baseline = [data(1:3001,:)];
% pre = [data(2902:3001,:);data(3502:3601,:);data(4102:4201,:);data(4702:4801,:);data(5302:5401,:)];
% stim = [data(3002:3101,:);data(3602:3701,:);data(4202:4301,:);data(4802:4901,:);data(5402:5501,:)];
% post = [data(3102:3201,:);data(3702:3801,:);data(4302:4401,:);data(4902:5001,:);data(5502:5601,:)];

% % if stim period is 10-14 mins
% % you will have 500 data points: 10(hz sampling)*10(sec)*5(min)
% baseline = [data(1:3001,:)];
% pre = [data(5902:6001,:);data(6502:6601,:);data(7102:7201,:);data(7702:7801,:);data(8302:8401,:)];
% stim = [data(6002:6101,:);data(6602:6701,:);data(7202:7301,:);data(7802:7901,:);data(8402:8501,:)];
% post = [data(6102:6201,:);data(6702:6801,:);data(7302:7401,:);data(7902:8001,:);data(8502:8601,:)];

% % if stim period is 15-19 mins
% % you will have 1000 data points: 10(hz sampling)*10(sec)*10(min)
% baseline = [data(1:3001,:)];
% pre = [data(8902:9001,:);data(9502:9601,:);data(10102:10201,:);data(10702:10801,:);data(11302:11401,:)];
% stim = [data(9002:9101,:);data(9602:9701,:);data(10202:10301,:);data(10802:10901,:);data(11402:11501,:)];
% post = [data(9102:9201,:);data(9702:9801,:);data(10302:10401,:);data(10902:11001,:);data(11502:11601,:)];

% % if stim period is 20-24 mins
% % you will have 1000 data points: 10(hz sampling)*10(sec)*10(min)
% baseline = [data(1:3001,:)];
% pre = [data(11902:12001,:);data(12502:12601,:);data(13102:13201,:);data(13702:13801,:);data(14302:14401,:)];
% stim = [data(12002:12101,:);data(12602:12701,:);data(13202:13301,:);data(13802:13901,:);data(14402:14501,:)];
% post = [data(12102:12201,:);data(12702:12801,:);data(13302:13401,:);data(13902:14001,:);data(14502:14601,:)];

% % if stim period is 25-29 mins
% % you will have 500 data points: 10(hz sampling)*10(sec)*5(min)
% baseline = [data(1:3001,:)];
% pre = [data(14902:15001,:);data(15502:15601,:);data(16102:16201,:);data(16702:16801,:);data(17302:17401,:)];
% stim = [data(15002:15101,:);data(15602:15701,:);data(16202:16301,:);data(16802:16901,:);data(17402:17501,:)];
% post = [data(15102:15201,:);data(15702:15801,:);data(16302:16401,:);data(16902:17001,:);data(17502:17601,:)];

% % if stim period is between 5-14 mins
% % you will have 1000 data points: 10(hz sampling)*10(sec)*10(min)
% baseline = [data(1:3001,:)];
% pre = [data(2902:3001,:);data(3502:3601,:);data(4102:4201,:);data(4702:4801,:);data(5302:5401,:);
%     data(5902:6001,:);data(6502:6601,:);data(7102:7201,:);data(7702:7801,:);data(8302:8401,:)];
% stim = [data(3002:3101,:);data(3602:3701,:);data(4202:4301,:);data(4802:4901,:);data(5402:5501,:);
%     data(6002:6101,:);data(6602:6701,:);data(7202:7301,:);data(7802:7901,:);data(8402:8501,:)];
% post = [data(3102:3201,:);data(3702:3801,:);data(4302:4401,:);data(4902:5001,:);data(5502:5601,:);
%     data(6102:6201,:);data(6702:6801,:);data(7302:7401,:);data(7902:8001,:);data(8502:8601,:)];

% % if stim period is 15-24 mins
% % you will have 1000 data points: 10(hz sampling)*10(sec)*10(min)
% baseline = [data(1:3001,:)];
% pre = [data(8902:9001,:);data(9502:9601,:);data(10102:10201,:);data(10702:10801,:);data(11302:11401,:);
%     data(11902:12001,:);data(12502:12601,:);data(13102:13201,:);data(13702:13801,:);data(14302:14401,:)];
% stim = [data(9002:9101,:);data(9602:9701,:);data(10202:10301,:);data(10802:10901,:);data(11402:11501,:);
%     data(12002:12101,:);data(12602:12701,:);data(13202:13301,:);data(13802:13901,:);data(14402:14501,:)];
% post = [data(9102:9201,:);data(9702:9801,:);data(10302:10401,:);data(10902:11001,:);data(11502:11601,:);
%     data(12102:12201,:);data(12702:12801,:);data(13302:13401,:);data(13902:14001,:);data(14502:14601,:)];

% % if stim period is 20-29 mins
% % you will have 1000 data points: 10(hz sampling)*10(sec)*10(min)
% baseline = [data(1:3001,:)];
% pre = [data(11902:12001,:);data(12502:12601,:);data(13102:13201,:);data(13702:13801,:);data(14302:14401,:);
%     data(14902:15001,:);data(15502:15601,:);data(16102:16201,:);data(16702:16801,:);data(17302:17401,:)];
% stim = [data(12002:12101,:);data(12602:12701,:);data(13202:13301,:);data(13802:13901,:);data(14402:14501,:);
%     data(15002:15101,:);data(15602:15701,:);data(16202:16301,:);data(16802:16901,:);data(17402:17501,:)];
% post = [data(12102:12201,:);data(12702:12801,:);data(13302:13401,:);data(13902:14001,:);data(14502:14601,:);
%     data(15102:15201,:);data(15702:15801,:);data(16302:16401,:);data(16902:17001,:);data(17502:17601,:)];

%% Get xy coordinates for movement tracks

close all;

Xmin = min(data(:,3));
Xmax = max(data(:,3));
Xcenter = (Xmax+Xmin)/2;
Xdiff = Xmax-Xmin;
Ymin = min(data(:,4));
Ymax = max(data(:,4));
Ycenter = (Ymax+Ymin)/2;
Ydiff = Ymax-Ymin;

Xpre = pre(:,3);
Ypre = pre(:,4);
Xstim = stim(:,3);
Ystim = stim(:,4);
Xpost = post(:,3);
Ypost = post(:,4);
data_pre = [Xpre,Ypre];
data_stim = [Xstim,Ystim];
data_post = [Xpost,Ypost];

% x = ((Ydiff+Xdiff)+sqrt((Ydiff+Xdiff).^2)-2(Ydiff+Xdiff))/4;
% y = ((Ydiff+Xdiff)-sqrt((Ydiff+Xdiff).^2)-2(Ydiff+Xdiff))/4;
% b = Xdiff+Ydiff/2;
% x = ((b-(b/sqrt(2)))/2);
x = ((28-(28/sqrt(2)))/2);

% % plot movement tracks data in the same figure
% figure;
% % plot(Xpre, Ypre); hold on; plot(Xstim, Ystim); hold on; plot(Xpost, Ypost);
% plot(data(:,3), data(:,4)); xlabel("x coord"); ylabel("y coord");


%% Center-surround using xy

Xsmax = Xmax-x;
Xsmin = Xmin+x;
Ysmax = Ymax-x;
Ysmin = Ymin+x;

Center_pre = zeros(length(Xpost),1);
Surround_pre = zeros(length(Xpost),1);
for m = 1:length(Xpost)
    if Xsmin < Xpre(m,1) && Xpre(m,1) < Xsmax && Ysmin < Ypre(m,1) && Ypre(m,1) < Ysmax
        Center_pre(m,1) = Center_pre(m,1)+1;
    else  
        Surround_pre(m,1) = Surround_pre(m,1)+1;
    end
end

Center_stim = zeros(length(Xpost),1);
Surround_stim = zeros(length(Xpost),1);
for n = 1:length(Xpost)
    if Xsmin < Xstim(n,1) && Xstim(n,1) < Xsmax && Ysmin < Ystim(n,1) && Ystim(n,1) < Ysmax
        Center_stim(n,1) = Center_stim(n,1)+1;
    else  
        Surround_stim(n,1) = Surround_stim(n,1)+1;
    end
end

Center_post = zeros(length(Xpost),1);
Surround_post = zeros(length(Xpost),1);
for t = 1:length(Xpost)
    if Xsmin < Xpost(t,1) && Xpost(t,1) < Xsmax && Ysmin < Ypost(t,1) && Ypost(t,1) < Ysmax
        Center_post(t,1) = Center_post(t,1)+1;
    else 
        Surround_post(t,1) = Surround_post(t,1)+1;
    end
end


%% Center vs surround analysis, per mouse

% Center zones: Z6, Z7, Z10, Z11
% Surround zones: Z1, Z2, Z3, Z4, Z5, Z8, Z9, Z12, Z13, Z14, Z15, Z16

% % determine each quadrant corresponding to center vs surround
% Center_pre = pre(:,[21,22,25,26]);
% Surround_pre = pre(:,[16,17,18,19,20,23,24,27,28,29,30,31]);
% Center_stim = stim(:,[21,22,25,26]);
% Surround_stim = stim(:,[16,17,18,19,20,23,24,27,28,29,30,31]);
% Center_post = post(:,[21,22,25,26]);
% Surround_post = post(:,[16,17,18,19,20,23,24,27,28,29,30,31]);

% add all values to get gow many ms animal spent at each quadrant
Sum_Center_pre = sum(sum(Center_pre));
Sum_Surround_pre = sum(sum(Surround_pre));
Sum_Center_stim = sum(sum(Center_stim));
Sum_Surround_stim = sum(sum(Surround_stim));
Sum_Center_post = sum(sum(Center_post));
Sum_Surround_post = sum(sum(Surround_post));

data_centersurround = {'Center_pre','Center_stim','Center_post','Surround_pre','Surround_stim','Surround_post';
    Sum_Center_pre,Sum_Center_stim,Sum_Center_post,Sum_Surround_pre,Sum_Surround_stim,Sum_Surround_post};

%% Center vs surround analysis, per trial

% make all data one
Ones_Center_pre = sum(Center_pre, 2);
Ones_Surround_pre = sum(Surround_pre, 2);
Ones_Center_stim = sum(Center_stim, 2);
Ones_Surround_stim = sum(Surround_stim, 2);
Ones_Center_post = sum(Center_post, 2);
Ones_Surround_post = sum(Surround_post, 2);

% use for 10 trials
% Center_pre_trials = logical(Ones_Center_pre);
Trials_Center_pre = reshape(Ones_Center_pre, [100,10]);
Trials_Surround_pre = reshape(Ones_Surround_pre, [100,10]);
Trials_Center_stim = reshape(Ones_Center_stim, [100,10]);
Trials_Surround_stim = reshape(Ones_Surround_stim, [100,10]);
Trials_Center_post = reshape(Ones_Center_post, [100,10]);
Trials_Surround_post = reshape(Ones_Surround_post, [100,10]);

% % use for 5 trials
% % Center_pre_trials = logical(Ones_Center_pre); 
% Trials_Center_pre = reshape(Ones_Center_pre, [100,5]);
% Trials_Surround_pre = reshape(Ones_Surround_pre, [100,5]);
% Trials_Center_stim = reshape(Ones_Center_stim, [100,5]);
% Trials_Surround_stim = reshape(Ones_Surround_stim, [100,5]);
% Trials_Center_post = reshape(Ones_Center_post, [100,5]);
% Trials_Surround_post = reshape(Ones_Surround_post, [100,5]);

% Sum per trials
Trialsum_Center_pre = sum(Trials_Center_pre)';
Trialsum_Surround_pre = sum(Trials_Surround_pre)';
Trialsum_Center_stim = sum(Trials_Center_stim)';
Trialsum_Surround_stim = sum(Trials_Surround_stim)';
Trialsum_Center_post = sum(Trials_Center_post)';
Trialsum_Surround_post = sum(Trials_Surround_post)';

data_centersurround_pertrials = [Trialsum_Center_pre,Trialsum_Center_stim,Trialsum_Center_post,Trialsum_Surround_pre,Trialsum_Surround_stim,Trialsum_Surround_post];
