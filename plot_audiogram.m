function [data] = plot_audiogram(nplot,plotindv,errbartype)
%plot_audiogram Plots audiometric thresholds from excel spreadsheet
%   Loads audiometric thresholds from excel spreadsheet then plots (& outputs data). 
%   Add or remove rows (participants) and columns (frequencys) as necessary in spreadsheet.
%   Arguments are:
%   nplots = single (1) or subplots (2)
%   plotdinv = overlay individual data (1) or not (0)
%   errbartype = no (0) nanstdev (1) or SEM (2) errorbars
%       e.g. plot mean + SD subplots without individual data : plot_audiogram(2,0,1)
%       e.g. plot mean + SEM subplots with individual data : plot_audiogram(2,1,2)

%% Default if no arguments 
if nargin<1
    nplot=2;
    errbartype=2;
    plotindv=1;
end

%% Load data from excel spreadsheet
% user selects excel file
disp('Select Audiogram Spreadsheet .xlsx file')
[file,path] = uigetfile('*.xlsx',...
    'Select Audiogram Spreadsheet .xlsx file', ...
    'MultiSelect', 'off');
data=readtable([path,file],'ReadRowNames',false,'ReadVariableNames',true);

% count nfreqs tested
nfreqs=size(data,2)-2;
% extract freq strings from table
freq_string=data.Properties.VariableNames(3:end);
% remove x's from strings
freq_string=erase(freq_string,"x");
% organize thresholds
leftdBHL=table2array(data(1:2:end,3:end));
rightdBHL=table2array(data(2:2:end,3:end));
% calculate error
if errbartype==0
    errL=NaN(1,nfreqs);
    errR=NaN(1,nfreqs);
elseif errbartype==1
    errL=nanstd(leftdBHL);
    errR=nanstd(rightdBHL);
elseif errbartype==2;
    errL=nanstd(leftdBHL)/sqrt(length(leftdBHL));
    errR=nanstd(rightdBHL)/sqrt(length(rightdBHL));
end
% set plotting parameters
markersize=8;
fsize=13;

%% Plot data, single plot
if nplot==1
    figure('position',[300 300 500 500],'paperpositionmode','auto');
    % plot left
    errorbar(1:nfreqs,nanmean(leftdBHL),errL,'b-x','LineWidth',1.5,'MarkerSize',markersize)
    hold on
    % plot right
    errorbar(1:nfreqs,nanmean(rightdBHL),errR,'r-o','LineWidth',1.5,'MarkerSize',markersize)
    % plot individual data
    if plotindv==1
        plot(1:nfreqs,leftdBHL,'k--','MarkerSize',markersize)
        plot(1:nfreqs,rightdBHL,'k-.','MarkerSize',markersize)
    end
    set(gca, 'YDir','reverse')
    grid on
    axis square
    yticks(-20:10:120)
    ylim([-15 115]) 
    xlim([0 nfreqs+1])
    xticks([1:nfreqs])
    xticklabels(freq_string)
    set(gca, 'XAxisLocation', 'bottom')
    xlabel('\bfFREQUENCY \rm(kHz)','FontSize',fsize)
    ylabel('\bfPURE-TONE THRESHOLD \rm(dB HL)','FontSize',fsize)
    %% Plot data, subplots
elseif nplot==2
    figure('position',[300 300 900 400],'paperpositionmode','auto');
    subplot(1,2,1)
    % plot left
    errorbar(1:nfreqs,nanmean(leftdBHL),errL,'b-x','LineWidth',1.5,'MarkerSize',markersize)
    hold on
    % plot individual data
    if plotindv==1
        plot(1:nfreqs,leftdBHL,'k--','MarkerSize',markersize)
    end
    set(gca, 'YDir','reverse')
    grid on
    axis square
    yticks(-20:10:120)
    ylim([-15 115]) 
    xlim([0 nfreqs+1])
    xticks([1:nfreqs])
    xticklabels(freq_string)
    set(gca, 'XAxisLocation', 'bottom')
    xlabel('\bfFREQUENCY \rm(kHz)','FontSize',fsize)
    ylabel('\bfPURE-TONE THRESHOLD \rm(dB HL)','FontSize',fsize)
    % plot right
    subplot(1,2,2)
    errorbar(1:nfreqs,nanmean(rightdBHL),errR,'r-o','LineWidth',1.5,'MarkerSize',markersize)
    hold on
    % plot individual data
    if plotindv==1
        plot(1:nfreqs,rightdBHL,'k-.','MarkerSize',markersize)
    end
    set(gca, 'YDir','reverse')
    grid on
    axis square
    yticks(-20:10:120)
    ylim([-15 115]) 
    xlim([0 nfreqs+1])
    xticks([1:nfreqs])
    xticklabels(freq_string)
    set(gca, 'XAxisLocation', 'bottom')
    xlabel('\bfFREQUENCY \rm(kHz)','FontSize',fsize)
    ylabel('\bfPURE-TONE THRESHOLD \rm(dB HL)','FontSize',fsize)
end
end