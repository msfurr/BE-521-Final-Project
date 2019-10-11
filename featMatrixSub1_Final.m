%% Subject 1 Feat Matrix

%% Find number of windows for EEG data

fs = sampleRateEEG_1;
xLen = noSamplesEEG;
winLen = 0.1; % seconds (100 ms)
winDisp = 0.05; % seconds (50 ms)

% Number of Windows for 50 ms displacement (50 ms overlap with 100 ms
% window)
numWins = @(xLen, fs, winLen, winDisp) ((xLen/fs - winLen) / winDisp) + 1;
numWins(xLen, fs, winLen, winDisp);

%% Create features from example (6 total)

% Feat 1: Average Time-Domain Voltage

meanVoltage = @(y) mean(abs(y));

fs = sampleRateEEG_1;
winLen = 0.1;
winDisp = 0.05;
meanVoltFeat = zeros(62, 5999);

for i = 1:noChannelsEEG_1
    
    meanVoltFeat(i, :) = MovingWinFeat(EEG_1(i, :), fs, winLen, ...
        winDisp, meanVoltage)';
    
end

%%

% Feat 2

xLen = noSamplesEEG;
winLen = 0.1;
winDisp = 0.05;

numOverlap = winDisp * sampleRateEEG_1;
nfft = 1:1000;
fs = sampleRateEEG_1;

numWinsEEG_1 = numWins(xLen, fs, winLen, winDisp);

freqFeat = @(x) freqFeat_1(x);

for i = 1:noChannelsEEG_1
    
    freqMag_1(i, :) = MovingWinFeat(EEG_1(i, :), fs, winLen, ...
        winDisp, freqFeat)';
    
end

%%

% Feat 3

xLen = noSamplesEEG;
winLen = 0.1;
winDisp = 0.05;

numOverlap = winDisp * sampleRateEEG_1;
nfft = 1:1000;
fs = sampleRateEEG_1;

numWinsEEG_1 = numWins(xLen, fs, winLen, winDisp);

freqFeat = @(x) freqFeat_2(x);

for i = 1:noChannelsEEG_1
    
    freqMag_2(i, :) = MovingWinFeat(EEG_1(i, :), fs, winLen, ...
        winDisp, freqFeat)';
    
end

%%

% Feat 4

xLen = noSamplesEEG;
winLen = 0.1;
winDisp = 0.05;

numOverlap = winDisp * sampleRateEEG_1;
nfft = 1:1000;
fs = sampleRateEEG_1;

numWinsEEG_1 = numWins(xLen, fs, winLen, winDisp);

freqFeat = @(x) freqFeat_3(x);

for i = 1:noChannelsEEG_1
    
    freqMag_3(i, :) = MovingWinFeat(EEG_1(i, :), fs, winLen, ...
        winDisp, freqFeat)';
    
end

%%

% Feat 5

xLen = noSamplesEEG;
winLen = 0.1;
winDisp = 0.05;

numOverlap = winDisp * sampleRateEEG_1;
nfft = 1:1000;
fs = sampleRateEEG_1;

numWinsEEG_1 = numWins(xLen, fs, winLen, winDisp);

freqFeat = @(x) freqFeat_4(x);

for i = 1:noChannelsEEG_1
    
    freqMag_4(i, :) = MovingWinFeat(EEG_1(i, :), fs, winLen, ...
        winDisp, freqFeat)';
    
end

%%

% Feat 6

xLen = noSamplesEEG;
winLen = 0.1;
winDisp = 0.05;

numOverlap = winDisp * sampleRateEEG_1;
nfft = 1:1000;
fs = sampleRateEEG_1;

numWinsEEG_1 = numWins(xLen, fs, winLen, winDisp);

freqFeat = @(x) freqFeat_5(x);

for i = 1:noChannelsEEG_1
    
    freqMag_5(i, :) = MovingWinFeat(EEG_1(i, :), fs, winLen, ...
        winDisp, freqFeat)';
    
end

%% Create Feature Matrix

feat_1 = meanVoltFeat';
feat_2 = freqMag_1';
feat_3 = freqMag_2';
feat_4 = freqMag_3';
feat_5 = freqMag_4';
feat_6 = freqMag_5';

featMatrix_Sub1 = [feat_1 feat_2 feat_3 feat_4 feat_5 feat_6];