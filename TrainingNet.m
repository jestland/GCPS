function [netTransfer, accuracy_validate] = TrainingNet(layers, path)
%%
%load data
imds = imageDatastore(path, 'IncludeSubfolders', true, 'LabelSource','foldernames');
%
%separate set
[imdsTrain, imdsValidation] = splitEachLabel(imds, 0.8, 'randomized');
%
%training options setting
options = trainingOptions('adam', ...
    'MaxEpochs',3, ...                  
    'MiniBatchSize',32, ...             
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',20, ...       
    'Verbose',false, ...;
    'Plots','training-progress');
%     'MiniBatchSize',16, ...             
%%%%%%%%%%another training ways%%%%%%%%%%%%%
% options = trainingOptions('adam', ...
%     'MiniBatchSize',100, ...
%     'MaxEpochs',5, ...
%     'InitialLearnRate',2e-4, ...
%     'Shuffle','every-epoch', ...
%     'ValidationData',imdsValidation, ...
%     'ExecutionEnvironment',"auto", ...
%     'ValidationFrequency',30, ...
%     'Verbose',false, ...
%     'Plots','training-progress');


%training
netTransfer = trainNetwork(imdsTrain,layers,options);
%
%% validation
YPred_validate = classify(netTransfer,imdsValidation);
accuracy_validate = mean(YPred_validate == imdsValidation.Labels);
end
