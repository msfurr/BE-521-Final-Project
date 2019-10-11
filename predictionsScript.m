%% Predict values using lasso feature reduction

% Updated April 26th 1:53 PM
% Edits: removed alpha = 0.75 in lasso
% Update April 30th: added smooth filtering of off movement

% DESCRIPTION: uses lasso to reduce redundant feature weights and
% optimize the linear predictions

% INPUT: R train, R test, training glove data 
% OUTPUT: lasso coefficients, training predictions, training errors, test
% predictions.

% We use the training lasso coefficients to make predictions on the test
% data.  


% NOTE: this took me about 20 minutes to run for one subject 1 finger so it
% may take 1 hour 40 min to run all 5. Training the lasso is the longest
% step.

% HELP: https://www.mathworks.com/help/stats/lasso.html
% The CV=10 means that it does a 10-fold cross-validation to find to
% optimize the value of lambda. I used it because the examples on the
% website used it. 

%% Load data (using R matrices created previously)
% Note: variable and mat file names might be different

clear

load('finalAlgorithmData.mat')

%% Define variables to interpolate signal to 1000Hz

x = 1:50:300000; % in ms
pad = zeros(2,1); % to make 6,000 points instead of 5,998
xx = 1:1:300000; % final dataset size

x_test = 1:50:147500; 
pad_test = zeros(2,1);
xx_test = 1:1:147500;

%% LASSO feature reduction for Subject 1

% The tic toc prints the duration of each loop

for i=1:5
    tic
    
    [B, FitInfo] = lasso(R_1_Train, decimateSignal_1(i, 2:end), 'CV', 10);
    
    toc
    
    idxLambda1SE = FitInfo.Index1SE;
    coef_1(:, i) = B(:, idxLambda1SE);
    coef0_1(i, :) = FitInfo.Intercept(idxLambda1SE);
    
    % Predict on training set and check training error
    yhat = R_1_Train * coef_1(:, i) + coef0_1(i, :); %training prediction
    y = [pad ; yhat];
    train_prediction_1(i, :) = spline(x, y, xx); %training prediction
    train_rhos1(i) = min(min(corrcoef(dataGlove_1(i, :), ... 
        train_prediction_1(i, :)))); %training correlation
    
    % Prediction on test set
    yhat_test = R_1 * coef_1(:, i) + coef0_1(i, :); %test prediction
    y_test = [pad_test ; yhat_test];
    test_prediction_1(i, :) = spline(x_test, y_test, xx_test);
    
end

% Smooth it and make new predictions where smoothed if below 1 and raw if
% above that
for i=1:5
    filtered_1_test(i,:) = smoothdata(test_prediction_1(i,:),'gaussian',500);
    for j=1:147500
        if test_prediction_1(i, j) > 1
            new_prediction_1(i,j) = test_prediction_1(i, j);
        else
            new_prediction_1(i,j) = filtered_1_test(i,j);
        end
    end
end

%% LASSO feature reduction for subject 2

% The tic toc prints the duration of each loop

for i=1:5
        
    tic
    
    [B, FitInfo] = lasso(R_2_Train, decimateSignal_2(i, 2:end), 'CV', 10);
    
    toc
    
    idxLambda1SE = FitInfo.Index1SE;
    coef_2(:, i) = B(:, idxLambda1SE);
    coef0_2(i, :) = FitInfo.Intercept(idxLambda1SE);
    
    % Predict on training set and check training error
    yhat = R_2_Train * coef_2(:, i) + coef0_2(i, :); %training prediction
    y = [pad ; yhat];
    train_prediction_2(i, :) = spline(x, y, xx); %training prediction
    train_rhos2(i) = min(min(corrcoef(dataGlove_2(i, :), ... 
        train_prediction_2(i, :)))); %training correlation
    
    % Prediction on test set
    yhat_test = R_2 * coef_2(:, i) + coef0_2(i, :); %test prediction
    y_test = [pad_test ; yhat_test];
    test_prediction_2(i, :) = spline(x_test, y_test, xx_test);
    
end

% Smooth it and make new predictions where smoothed if below 1 and raw if
% above that
for i=1:5
    filtered_2_test(i,:) = smoothdata(test_prediction_2(i,:),'gaussian',500);
    for j=1:147500
        if test_prediction_2(i, j) > 1
            new_prediction_2(i,j) = test_prediction_2(i, j);
        else
            new_prediction_2(i,j) = filtered_2_test(i,j);
        end
    end
end
%% LASSO feature reduction for subject 3

% The tic toc prints the duration of each loop

for i=5
    %NOTE: 1-4 done 04/30 AM
    
    tic
    
    [B, FitInfo] = lasso(R_3_Train, decimateSignal_3(i, 2:end), 'CV', 10);
    
    toc
    
    idxLambda1SE = FitInfo.Index1SE;
    coef_3(:, i) = B(:, idxLambda1SE);
    coef0_3(i, :) = FitInfo.Intercept(idxLambda1SE);
    
    % Predict on training set and check training error
    yhat = R_3_Train * coef_3(:, i) + coef0_3(i, :); %training prediction
    y = [pad ; yhat];
    train_prediction_3(i, :) = spline(x, y, xx); %training prediction
    train_rhos3(i) = min(min(corrcoef(dataGlove_3(i, :), ... 
        train_prediction_3(i, :)))); %training correlation
    
    % Prediction on test set
    yhat_test = R_3 * coef_3(:, i) + coef0_3(i, :); %test prediction
    y_test = [pad_test ; yhat_test];
    test_prediction_3(i, :) = spline(x_test, y_test, xx_test);
    
end

% Smooth it and make new predictions where smoothed if below 1 and raw if
% above that
for i=1:5
    filtered_3_test(i,:) = smoothdata(test_prediction_3(i,:),'gaussian',500);
    for j=1:147500
        if test_prediction_3(i, j) > 1
            new_prediction_3(i,j) = test_prediction_3(i, j);
        else
            new_prediction_3(i,j) = filtered_3_test(i,j);
        end
    end
end

%% Save All Data and Load into predicted_dg array

% save('Apr30_AM')
% save('LassoPredictions_Apr30','train_prediction_1', 'train_prediction_2', ...
%    'train_prediction_3', 'test_prediction_1', 'test_prediction_2', ...
%    'test_prediction_3')

% save('SmootLassoPredictionsApr30','new_prediction_1', 'new_prediction_2','new_prediction_3')
% predicted_dg = cell(3,1);
% predicted_dg{1} = new_prediction_1';
% predicted_dg{2} = new_prediction_2';
% predicted_dg{3} = new_prediction_3';
% save('Apr30_3PM','predicted_dg')
