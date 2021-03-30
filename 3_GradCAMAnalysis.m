clear all;
close all;
clc
%%%%%%%%%%%%%%
SNR = -14:2:14;
standard = categorical({'cw' 'fsk' 'lfm' 'pfm' 'sfm'});
%% Grad-CAM
load('Net/Trained_STFT/GoogLeNet.mat');
load('Net/Trained_STFT/ResNet18.mat');

tic
for i = 15 : length(SNR)
    for j = 1 : length(standard)
        for k = 1 : 1       
            %%%%%%%%%%%%%%%%%%% GoogLeNet %%%%%%%%%%%%%%%%%%%
            path_img = strcat('stft224/Set_TFINoise/GradCAMSet_GoogLeNet/snr', num2str(SNR(i)), '/', string(standard(j)), '/', num2str(k), '.jpg');
            TFINoise = imread(strcat('stft224/Set_TFINoise/TestSet/snr', num2str(SNR(i)), '/', string(standard(j)), '/', num2str(k), '.jpg'));
            Grad_CAM_GoogLeNet(GoogLeNet, TFINoise, 224, path_img);           
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
    end
% end
for i = 15 : length(SNR)
    for j = 1 : length(standard)
        for k = 1 : 1       
            %%%%%%%%%%%%%%%%%%% ResNet18 %%%%%%%%%%%%%%%%%%%
            path_img = strcat('stft224/Set_TFINoise/GradCAMSet_ResNet18/snr', num2str(SNR(i)), '/', string(standard(j)), '/', num2str(k), '.jpg');
            TFINoise = imread(strcat('stft224/Set_TFINoise/TestSet/snr', num2str(SNR(i)), '/', string(standard(j)), '/', num2str(k), '.jpg'));  
            Grad_CAM_ResNet18(ResNet18, TFINoise, 224, path_img);            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
    end
end

toc


