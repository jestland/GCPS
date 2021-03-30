clear all;
close all;
clc
%%%%%%%%%%%%%%
SNR = -14:2:14;
standard = categorical({'cw' 'fsk' 'lfm' 'pfm' 'sfm'});
%% 
% load('Net/Trained_STFT/GoogLeNet.mat');
load('Net/Trained_STFT/ResNet18.mat');

tic

for j = 1 : 5
    for k = 1 : 100       
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         path_img_GoogLeNet = strcat('stft224/Set_TFINoise/GradCAMSet_GoogLeNet/Benchmark/', string(standard(j)), '_add/', num2str(k), '.jpg');
        path_img_ResNet18 = strcat('stft224/Set_TFINoise/GradCAMSet_ResNet18/Benchmark/', string(standard(j)), '_add/', num2str(k), '.jpg');
        
        TFI224 = imread(strcat('stft224/Set_TFI/TestSet/', string(standard(j)), '/', num2str(k), '.jpg'));         
        
%         Grad_CAM_GoogLeNet(GoogLeNet, TFI224, 224, path_img_GoogLeNet);
        Grad_CAM_ResNet18(ResNet18, TFI224, 224, path_img_ResNet18);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end

toc


