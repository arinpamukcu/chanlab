% Script finds (1) access with -10mV voltage step; (2) opto evoked EPSC.
%
% Written by Arin Pamukcu
% Last editted Aug 6, 2016

clear all
close all

filename = '17n14022_AP4.abf';

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
stablestart = 1; %write sweep no of first stable sweeps
stableend = 5; %write sweep no of last stable sweeps (subtract excluded no of sweeps)
sweeps2exclude = []; %write sweeps to exclude, separated by space

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Acquire data into <data> variable
[d,si] = abfload(filename,'sweeps','a');

% Reshape file into matrix, exclude unwanted sweeps
[dp,nc,ns] = size(d); %d is a 3d matrix of <data pts> by <no of channels> by <no of sweeps>
dnew = reshape(d,dp,ns); %dnew is a 2d matrix of <data pts> (columns) by <no of sweeps> (rows)
dnew(:,sweeps2exclude) = [];

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

% % if access resistance changes more than 20% form the beginning until the end of the recording, stop calculating rest
% if Raccess(stablestart)*0.8 >= Raccess(stableend)
%     return;
% end

% Measure peak values
[pk,pk_loc] = min(dnew(LEDstimstart:LEDstimend,:));

% dnewInv = -1*(dnew);
% plot(dnewInv(:,stablestart:stableend));
% [pks,pk_loc] = findpeaks(dnewInv(LEDstimstart:LEDstimend));

epsc = pk - baseline;
epsc_time = LEDstimstart + pk_loc;
 
plot(epsc_time,dnew(epsc_time,stablestart:stableend),'r*');
figure; plot(epsc); hold on; 
plot(stablestart:stableend,epsc(:,stablestart:stableend),'r*'); 

% Calculate current peak and time of peak
epsc_avg = median(epsc(:,(stablestart:stableend)));
epsc_time_avg = median(epsc_time(:,(stablestart:stableend)))/10;

% Find charge (from I = dQ/dt, integrate current(I) to find charge(Q), i.e. find the area under the current(I) curve until 90% decay)
charge_temp = NaN(1,stableend);
% int_dnew = NaN(1,stableend);
% int_baseline = NaN(1,stableend);
baseline_temp = repmat(baseline,traceend,1);   %create matrix of repeated baseline vector values
for m=1:stableend
    % charge(1,m) = trapz(dnew(LEDstimstart:traceend,m),baseline_temp(LEDstimstart:traceend,m));
    int_dnew(1,m) = trapz(dnew(LEDstimstart:15000,m));
    int_baseline(1,m) = trapz(baseline_temp(LEDstimstart:15000,m));
    charge_temp(1,m) = int_baseline(:,m) - int_dnew(:,m);
    charge = median(charge_temp); % UNITS??????
end

% Values to copy and paste on excel or gSheets
copy2excel = {'Iholding','Raccess','EPSC','EPSC_time','charge';holdingI,avg_Raccess,epsc_avg,epsc_time_avg,charge};
