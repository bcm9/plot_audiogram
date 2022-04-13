# plot_audiogram
MATLAB function to plot audiometric thresholds from excel spreadsheet. Main code: plot_audiogram.m


Arguments
plot_audiogram(nplots,plotdinv,errbartype):

nplots = single (1) or subplots (2)

plotdinv = overlay individual data (1) or not (0)

errbartype= no (0), stdev (1) or SEM (2) errorbars


Example:

Organize data in excel spreadsheet as in audio_data_example. 

Add or remove rows (participants) and columns (frequencys) as necessary.

To plot mean + SDs in a single plot without individual data, type in command line: plot_audiogram(1,0,1)
To plot mean + SEMs in a subplots with individual data, type in command line: plot_audiogram(2,1,2)

Select excel spreadsheet.


Y-Axis Limits:

To change y-limits, edit ylim([-15 115]) in code.
