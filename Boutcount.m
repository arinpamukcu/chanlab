%% Boutcount 
% Boutcount is function to exact the number of bouts and duration for 
% 10 Hz sampled video that determins if activity <= 1 cm/s or > 1 cm/s 
% and assinged either a 1 or a 0. Each data entry of either 1 or 0 
% there represents a period of 100 ms when thre was either movement of 
% <= 1 cm/s (a "1" representing immobility) or > 1 cm/s (a "0" representing 
% mobility). 
%
% This function determines how many consecutive 1s or 0s there were, 
% that define a "bout" of either immobility or mobility as well as 
% how much time was sent for each bout.
%
% Written by Harry Xenias
% May 11, 2020
%

%% Load test data

clear; close all; clc; % clear/close variables, figs, cmd window.

load('TestData.mat') % Load the column data

data = logical(TestData); % Convert numeric to logical elemnts

%data = [1 1 0 0 1 0 1 0 0 1 0 1 1]; % For testing on smaller arrays

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

Immobile
Mobile
data;

num_Immobilebouts = length(Immobile)
num_Mmobilebouts = length(Mobile)




