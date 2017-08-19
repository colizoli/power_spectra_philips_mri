# power_spectra_philips_mri
Computes power spectra of heart rate and respiration rate from Philips' MRI output files (.log) <br>
Two MATLAB scripts are provided.

#### Process_Philips_Log.m
Extracts the data from the .log (text) files and saves a .mat workspace file with heart rate and respiration data

#### Power_Spectra_Physiology.m
Does the frequency decomposition and plots the data

### IMPORTANT NOTES
* These scripts use one subject's data from a 3T Philip's Achieva MRI system.<br>
* The subject was scanned in 4 sessions, with 7 runs per session.<br>
* The alphabetical order of the LOG files is the temporal order: SUBJECT_SessionNumber_RunNumber.log
* All LOG files are in the current working directory
* In this experiment, we stopped scans by hand because run time was dependent on reaction times (yielding a different number of samples per run)
* In each file on line 30000, there is a '#' that needed to be deleted before 'dlmread' will import all the data...
I'm not sure why it is there but it is in every file.
* The gradient information in each LOG file is ignored
