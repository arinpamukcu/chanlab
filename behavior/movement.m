clc;
clear all;
close all;

data = xlsread('OpenField_PV_3181.xlsx','A4:AF1479');
%data = readtable('OpenField_PV_3181.xlsx','Range','A4:AF1479');

time = data(:,1);
velocity = data(:,4);
plot(time, velocity);
xlabel("time (s)");
ylabel("velocity (cm/s)");

time = data(1:60);
velocity_stim = data(276:1475,4);
trials = reshape(velocity_stim,[60,20]);

plot(time, trials(:,1:5));

velocity_mode = mode(velocity);
%for m in velocity;
%    if m >= velocity_mode  
