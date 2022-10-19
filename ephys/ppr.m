% Script finds (1) access with -10mV voltage step; (2) opto evoked EPSC.
%
% Written by Arin Pamukcu
% Last editted Aug 6, 2016

clear all;
close all;

filename = '17620004_AP4.abf';

% Define time points of recording protocol
sealteststep = -0.01; %-10 mV voltage step
tracestart = 1;
traceend = 40000;
steadystart = 1400;
steadyend = 1600;
baselinestart = 5000;
baselineend = 10000;
LEDstimstart = 11650;
LEDstimend = 11690;
pkstart = 50000;
pkend = 100000;
stablestart = 1; %write sweep no of first stable sweeps
stableend = 1; %write sweep no of last stable sweeps (subtract excluded no of sweeps)
sweeps2exclude = []; %write sweeps to exclude, separated by space

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Acquire data into <data> variable
[d,si] = abfload(filename,'sweeps','a');

% Reshape file into matrix, exclude unwanted sweeps
[dp,nc,ns] = size(d); %d is a 3d matrix of <data pts> by <no of channels> by <no of sweeps>
dnewz = reshape(d,dp,ns); %dnew is a 2d matrix of <data pts> (columns) by <no of sweeps> (rows)
dnewz(:,sweeps2exclude) = [];
dnew = dnewz * -1 ;

% Plot traces
plot(dnew(:,stablestart:stableend)); hold on;

% Find baseline holding current for each trace
baseline = median(dnew(baselinestart:baselineend,:));
holdingI = median(baseline(:,(stablestart:stableend)));

% To find access resistance (Ra), get steady state current after -10 mV step
steadycurrent = mean(dnew(steadystart:steadyend,:)) - baseline;

% Poor man's access calculation (resistance in mega-ohms)
Raccess = abs(sealteststep ./ ((steadycurrent) .* 1e-12)) ./ 1e6;
avg_Raccess = mean(Raccess);

% Measure peak values
%[pks,pklocs] = min(dnew(pkstart:pkend,:));
for i = stablestart:stableend;
    [pks,pklocs] = findpeaks(dnew(:,i),'MinPeakDistance',500,'MinPeakHeight',500);
    epsc = pks - baseline(:,i);
end

% dnewInv = -1*(dnew);
% plot(dnewInv(:,stablestart:stableend));
% [pks,pk_loc] = findpeaks(dnewInv(LEDstimstart:LEDstimend));
 
plot(pklocs,dnew(pklocs,stablestart:stableend),'r*');
%figure; plot(epsc); hold on; 
%plot(stablestart:stableend,epsc(:,stablestart:stableend),'r*'); 

% paired pulse ratio
ppr = pks(2) / pks(1);

% Values to copy and paste on excel or gSheets
copy2excel = {'peaks','ppr';epsc,ppr};
