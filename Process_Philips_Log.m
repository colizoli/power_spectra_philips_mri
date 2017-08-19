%% Processs the Physiology LOG files from a Philips MRI scanner
% O. Colizoli, 2017
% Heart rate and respiration data extracted from .log to .MAT file
% Imports all scan logs ('*.log')
% Gets minimum number of samples across all files
% Cuts the rest off at the minimum number of samples
% Loads data into two matrices (ppudata, respdata)
% Saves workspace variables as 'phys.mat'

% NOTES:
% This script extracts one subject's data from a 3T Philip's Achieva MRI system
% The subject was scanned in 4 sessions, with 7 runs per session
% The alphabetical order of the LOG files is the temporal order: {SUBJECT}_{Session Num}_{Run Num}.log
% All LOG files are in the current working directory
% In this experiment, we stopped scans by hand because run time was dependent on reaction times (yielding a different number of samples per run)
% IMPORTANT: In each file on line 30000, there is a '#' that needed to be deleted before 'dlmread' will import all the data... 
    % not sure why it is there but it is in every file.
% The gradient information in each LOG file is ignored

%% Set parameters, load files

clear all; clc; close all;

sessions = 4;
runs     = 7;

headers = {'v1raw','v2raw','v1','v2','ppu','resp','gx','gy','gz','mark'};

files = dir('*.log'); % get list of all folders

%% Pull physiological data out and put into matrices

% Import text data into cell
physfiles = cell(length(files),1);
size_phys = NaN(length(files),2);

for i = 1:length(files)
    physfiles{i,1} = dlmread(files(i).name, '', 5, 0); % the first 5 lines are headers, .textdata (headers), .data (phys)
    size_phys(i,:) = size(physfiles{i,1});
end 

% Get minimum number of samples so that all runs have equal number of samples (for freq decomposition)
m = min(size_phys(:,1));
%mi = find(size_phys==m); % index of minimum

% min samples, runs, sessions
ppudata = NaN(m,runs,sessions); % heart rate
respdata = NaN(m,runs,sessions); % respiration rate

% put data into matrices
count_file = 1;
for s = 1:sessions
    for r = 1:runs
        ppudata(:,r,s) = physfiles{count_file}(1:m,5); % ppu data 5th column
        respdata(:,r,s) = physfiles{count_file}(1:m,6); % respiration data 6th column
        count_file = count_file + 1;
    end
end
save('phys.mat');
disp('Success! Now run Power_Spectra_Physiology.m');
