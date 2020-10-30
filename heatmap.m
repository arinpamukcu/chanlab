clc;
clear all;
close all;
% Written by Arin Pamukcu
% Last edit May 10, 2020 by Arin Pamukcu

filename = 'Raw_Trial410_8009.xlsx';
sheet = 1;
range = 'A40:AF18005';

data = xlsread(filename, sheet, range);
data(isnan(data)) = 0;

%% Determine the time period for experiment

% % if stim period is between 5-14 mins
% % you will have 1000 data points: 10(hz sampling)*10(sec)*10(min)
% baseline = [data(1:3001,:)];
% pre = [data(2902:3001,:);data(3502:3601,:);data(4102:4201,:);data(4702:4801,:);data(5302:5401,:);
%     data(5902:6001,:);data(6502:6601,:);data(7102:7201,:);data(7702:7801,:);data(8302:8401,:)];
% stim = [data(3002:3101,:);data(3602:3701,:);data(4202:4301,:);data(4802:4901,:);data(5402:5501,:);
%     data(6002:6101,:);data(6602:6701,:);data(7202:7301,:);data(7802:7901,:);data(8402:8501,:)];
% post = [data(3102:3201,:);data(3702:3801,:);data(4302:4401,:);data(4902:5001,:);data(5502:5601,:);
%     data(6102:6201,:);data(6702:6801,:);data(7302:7401,:);data(7902:8001,:);data(8502:8601,:)];

% if stim period is 15-24 mins
% you will have 1000 data points: 10(hz sampling)*10(sec)*10(min)
baseline = [data(1:3001,:)];
pre = [data(8902:9001,:);data(9502:9601,:);data(10102:10201,:);data(10702:10801,:);data(11302:11401,:);
    data(11902:12001,:);data(12502:12601,:);data(13102:13201,:);data(13702:13801,:);data(14302:14401,:)];
stim = [data(9002:9101,:);data(9602:9701,:);data(10202:10301,:);data(10802:10901,:);data(11402:11501,:);
    data(12002:12101,:);data(12602:12701,:);data(13202:13301,:);data(13802:13901,:);data(14402:14501,:)];
post = [data(9102:9201,:);data(9702:9801,:);data(10302:10401,:);data(10902:11001,:);data(11502:11601,:);
    data(12102:12201,:);data(12702:12801,:);data(13302:13401,:);data(13902:14001,:);data(14502:14601,:)];

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

x = ((28-(28/sqrt(2)))/2);

figure;
plot(data(:,3), data(:,4));
xlabel("x coord");
ylabel("y coord");

%% Heatmap

Xsmax = Xmax-x;
Xsmin = Xmin+x;
Ysmax = Ymax-x;
Ysmin = Ymin+x;

% Xlinspace = linspace(Xcenter-14, Xcenter+14, 7);
% Ylinspace = linspace(Ycenter-14, Ycenter+14, 7);
% [Xspaced,Yspaced] = meshgrid(Xlinspace,Ylinspace);
% 
% data_interpolated = scatteredInterpolant(data_pre(:,1),data_pre(:,2));
%
% figure;
% contour(Xlinspace,Ylinspace,XXX);

grid = 28;
xidx = (1 + round((data_pre(:,1) - Xcenter-14) ./ Xdiff * (grid-1)))*(-1);
yidx = (1 + round((data_pre(:,2) - Ycenter-14) ./ Ydiff * (grid-1)))*(-1);
density = accumarray([yidx, xidx], 1, [grid,grid]);  %note y is rows, x is cols
imagesc(density, 'xdata', [minvals(1), maxvals(1)], 'ydata', [minvals(2), maxvals(2)]);



