%% Power Spectra Physiology - Philips MRI scanner
% O. Colizoli, 2017
% Heart rate and respiration power spectra
% Run after Process_Philips_Log.m
% Loads in MAT file generated in Process_Philips_Log.m
% Decompose the frequencies for each run
% Plots the power per frequency band for each run in each session and the
% average of the runs in each session in separate figures (and separately
% for heart rate and respiration - 4 figures in total)

% NOTES:
% This script plots one subject's example data from a 3T Philip's Achieva MRI system
% The subject was scanned in 4 sessions, with 7 runs per session

%% Set parameters, load data

clear all; clc; close all;

load phys

%% PSD
% Decomposition from 'Matlab for Neuroscientists'

sample_rate     = 496; % Hz (496 Hz verified with Philips, not 500 Hz)
samples         = m; % minimum taken

phys_type_data  = {ppudata,respdata};
phys_type       = {'HEART RATE','RESPIRATION'};
phys_lims       = {[0 5],[0 2]}; % you should see power in these frequency ranges

for p = 1:length(phys_type)
    
    X = phys_type_data{p};
    T = phys_type{p};
    lims = phys_lims{p};
    
    for j = 1:sessions % loop over sessions 

        for i = 1:runs % loop over runs
            [Pxx(:,i),W(:,i)] = pwelch(X(:,i,j),[],[],[],sample_rate,'power');
        end

        % each column is a frequency bin
        Pxxt{j} = transpose(Pxx);
        Wt{j}   = transpose(W);

        % Average across runs per frequency bin
        Avg_Pxxt{j} = mean(Pxxt{j});
    end

    % Plot
    figure; % each run as separate line
        suptitle([T ' All Runs']);
        for i = 1:sessions
            subplot(4,1,i); 
                plot(Wt{1}(1,:),Pxxt{i});
                xlim(lims);
                ylabel('Power');
                title(['Session ' num2str(i)]);
                if i == sessions
                    xlabel('Freq. (Hz)');
                end
        end

    figure; % average across all runs
        suptitle([T ' Average']);
        for i = 1:sessions
            subplot(4,1,i);
                plot(Wt{1}(1,:),Avg_Pxxt{i});
                xlim(lims);    
                ylabel('Power');
                title(['Session ' num2str(i)]);
                if i == sessions
                    xlabel('Freq. (Hz)');
                end
        end
    
end  % phys_type loop


    
    
    
