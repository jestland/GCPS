% clear all;
% close all;
% clc


gpuDevice
SNR = -14:2:14;
%% 
load('Net/Trained_STFT/GoogLeNet.mat');
load('Net/Trained_STFT/ResNet18.mat');
tic

%%%%%%%%%%%%%%%%%%%%% GoogLeNet %%%%%%%%%%%%%%%%%%%
% path_test_TFINoise = 'stft224/Set_TFINoise/Testset/snr';
% [RecognitionRate_GoogLeNet, imds_TFINoise, Ypred_TFINoise, ClassificationRate_GoogLeNet] = SNRTest(GoogLeNet, SNR, path_test_TFINoise);

%%%%%%%%%%%%%%%%%%%%%%%%%% ResNet18 %%%%%%%%%%%%%%%%%%%%%%%%%%%
% path_test_TFINoise = 'stft224/Set_TFINoise/Testset/snr';
% [RecognitionRate_ResNet18, imds_TFINoise, Ypred_TFINoise, ClassificationRate_ResNet18] = SNRTest(ResNet18, SNR, path_test_TFINoise);

toc