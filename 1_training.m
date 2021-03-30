clear all;
close all;
clc


gpuDevice
%% CNN network
% load('Net/GoogLeNet');% 224*224*3   input
% load('Net/ResNet18');% 224*224*3  input
%% Training
tic
%%%%%%%%%%%%%%%%%%%%%%%% GoogLeNet %%%%%%%%%%%%%%%%%%%%%%%%
path_TFINoise = strcat('wvd224/Set_TFINoise/TrainSet'); 
[GoogLeNet, accuracy_TFINoise] = TrainingNet(GoogLeNet, path_TFINoise);
save ('Net/Trained_STFT/GoogLeNet.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% ResNet18 %%%%%%%%%%%%%%%%%%%%%%%%
% path_TFINoise = strcat('wvd224/Set_TFINoise/TrainSet');
% [ResNet18, accuracy_TFINoise] = TrainingNet(ResNet18, path_TFINoise);
% save ('Net/Trained_STFT/ResNet18.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
toc

