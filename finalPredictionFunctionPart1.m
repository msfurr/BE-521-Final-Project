%% Gather all data

load('finalData.mat')

noSamplesECOG = length(test_ecog{1}(1,:));

x_test = 1:50:noSamplesECOG;
pad_test = zeros(2,1);
xx_test = 1:1:noSamplesECOG;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Create features

% Subject 1 Feature Matrix

% Find number of windows for EEG data

fs = 1000;
xLen = noSamplesECOG;
winLen = 0.1; % seconds (100 ms)
winDisp = 0.05; % seconds (50 ms)

% Number of Windows for 50 ms displacement (50 ms overlap with 100 ms
% window)
numWins = @(xLen, fs, winLen, winDisp) ((xLen/fs - winLen) / winDisp) + 1;
testWindows = numWins(xLen, fs, winLen, winDisp);

% Feat 1: Average Time-Domain Voltage

meanVoltage = @(y) mean(abs(y));

fs = 1000;
winLen = 0.1;
winDisp = 0.05;

for i = 1:62
    
    meanVoltFeat(i, :) = MovingWinFeat(test_ecog{1}(:,i), fs, winLen, ...
        winDisp, meanVoltage)';
    
end

% Feat 2

fs = 1000;
xLen = noSamplesECOG;
winLen = 0.1;
winDisp = 0.05;

numOverlap = winDisp * fs;
nfft = 1:1000;

freqFeat = @(x) freqFeat_1(x);

for i = 1:62
    
    freqMag_1(i, :) = MovingWinFeat(test_ecog{1}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Feat 3

fs = 1000;
xLen = noSamplesECOG;
winLen = 0.1;
winDisp = 0.05;

numOverlap = winDisp * fs;
nfft = 1:1000;

freqFeat = @(x) freqFeat_2(x);

for i = 1:62
    
    freqMag_2(i, :) = MovingWinFeat(test_ecog{1}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Feat 4

fs = 1000;
xLen = noSamplesECOG;
winLen = 0.1;
winDisp = 0.05;

numOverlap = winDisp * fs;
nfft = 1:1000;

freqFeat = @(x) freqFeat_3(x);

for i = 1:62
    
    freqMag_3(i, :) = MovingWinFeat(test_ecog{1}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Feat 5

fs = 1000;
xLen = noSamplesECOG;
winLen = 0.1;
winDisp = 0.05;

numOverlap = winDisp * fs;
nfft = 1:1000;

freqFeat = @(x) freqFeat_4(x);

for i = 1:62
    
    freqMag_4(i, :) = MovingWinFeat(test_ecog{1}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Feat 6

fs = 1000;
xLen = noSamplesECOG;
winLen = 0.1;
winDisp = 0.05;

numOverlap = winDisp * fs;
nfft = 1:1000;

freqFeat = @(x) freqFeat_5(x);

for i = 1:62
    
    freqMag_5(i, :) = MovingWinFeat(test_ecog{1}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Create Feature Matrix

feat_1 = meanVoltFeat';
feat_2 = freqMag_1';
feat_3 = freqMag_2';
feat_4 = freqMag_3';
feat_5 = freqMag_4';
feat_6 = freqMag_5';

featMatrix_Sub1 = [feat_1 feat_2 feat_3 feat_4 feat_5 feat_6];

clear meanVoltFeat freqMag_1 freqMag_2 freqMag_3 freqMag_4 freqMag_5;

% Subject 2 Feature Matrix

% Feat 1: Average Time-Domain Voltage

for i = 1:48
    
    meanVoltFeat(i, :) = MovingWinFeat(test_ecog{2}(:,i), fs, winLen, ...
        winDisp, meanVoltage)';
    
end

% Feat 2

for i = 1:48
    
    freqMag_1(i, :) = MovingWinFeat(test_ecog{2}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Feat 3

for i = 1:48
    
    freqMag_2(i, :) = MovingWinFeat(test_ecog{2}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Feat 4

for i = 1:48
    
    freqMag_3(i, :) = MovingWinFeat(test_ecog{2}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Feat 5

for i = 1:48
    
    freqMag_4(i, :) = MovingWinFeat(test_ecog{2}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Feat 6

for i = 1:48
    
    freqMag_5(i, :) = MovingWinFeat(test_ecog{2}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Create Feature Matrix

feat_1 = meanVoltFeat';
feat_2 = freqMag_1';
feat_3 = freqMag_2';
feat_4 = freqMag_3';
feat_5 = freqMag_4';
feat_6 = freqMag_5';

featMatrix_Sub2 = [feat_1 feat_2 feat_3 feat_4 feat_5 feat_6];

clear meanVoltFeat freqMag_1 freqMag_2 freqMag_3 freqMag_4 freqMag_5;

% Subject 3 Feature Matrix

% Feat 1: Average Time-Domain Voltage

for i = 1:64
    
    meanVoltFeat(i, :) = MovingWinFeat(test_ecog{3}(:,i), fs, winLen, ...
        winDisp, meanVoltage)';
    
end

% Feat 2

for i = 1:64
    
    freqMag_1(i, :) = MovingWinFeat(test_ecog{3}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Feat 3

for i = 1:64
    
    freqMag_2(i, :) = MovingWinFeat(test_ecog{3}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Feat 4

for i = 1:64
    
    freqMag_3(i, :) = MovingWinFeat(test_ecog{3}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Feat 5

for i = 1:64
    
    freqMag_4(i, :) = MovingWinFeat(test_ecog{3}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Feat 6

for i = 1:64
    
    freqMag_5(i, :) = MovingWinFeat(test_ecog{3}(:,i), fs, winLen, ...
        winDisp, freqFeat)';
    
end

% Create Feature Matrix

feat_1 = meanVoltFeat';
feat_2 = freqMag_1';
feat_3 = freqMag_2';
feat_4 = freqMag_3';
feat_5 = freqMag_4';
feat_6 = freqMag_5';

featMatrix_Sub3 = [feat_1 feat_2 feat_3 feat_4 feat_5 feat_6];

clear meanVoltFeat freqMag_1 freqMag_2 freqMag_3 freqMag_4 freqMag_5;