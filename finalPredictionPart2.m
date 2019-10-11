
noSamplesECOG = length(test_ecog{1}(:,1));

%%

x_test = 1:50:noSamplesECOG;
pad_test = zeros(2,1);
xx_test = 1:1:noSamplesECOG;

%%

% Subject 1
for i=1:5
    
    % Prediction on test set
    yhat_Final = R_1 * coef_1(:, i) + coef0_1(i, :);
    y_Final = [pad_test ; yhat_Final];
    Prediction_1(i, :) = spline(x_test, y_Final, xx_test);
    
end

%%

% Subject 2
for i=1:5
    
    % Prediction on test set
    yhat_Final = R_2 * coef_2(:, i) + coef0_2(i, :);
    y_Final = [pad_test ; yhat_Final];
    Prediction_2(i, :) = spline(x_test, y_Final, xx_test);
    
end

% Subject 3
for i=1:5
    
    % Prediction on test set
    yhat_Final = R_3 * coef_3(:, i) + coef0_3(i, :);
    y_Final = [pad_test ; yhat_Final];
    Prediction_3(i, :) = spline(x_test, y_Final, xx_test);
    
end