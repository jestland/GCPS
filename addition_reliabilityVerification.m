clear all;
close all;
%% GCPS reliability verification

SNR = -14:2:14;
load('Net/Trained_STFT/GoogLeNet.mat');
load('Net/Trained_STFT/ResNet18.mat');
load('Result/STFT/RecognitionRate_GoogLeNet.mat');
load('Result/STFT/RecognitionRate_ResNet18.mat');
%%%%%%%%%%%%%%%%%%%% GoogLeNet %%%%%%%%%%%%%%%%%%%
% path_test_TFINoise = 'stft224/Set_TFINoise/Testset/snr';
% GoogLeNet_biasNumber = SNRSTest(GoogLeNet, SNR, path_test_TFINoise, RecognitionRate_GoogLeNet);

%%%%%%%%%%%%%%%%%%%%%%%%% ResNet18 %%%%%%%%%%%%%%%%%%%%%%%%%%%
path_test_TFINoise = 'stft224/Set_TFINoise/Testset/snr';
ResNet18_biasNumber = SNRSTest(ResNet18, SNR, path_test_TFINoise, RecognitionRate_ResNet18);


% figure();
% %make line better
% C = linspecer(5); 
% axes('NextPlot','replacechildren', 'ColorOrder',C); 
% plot(SNR, GoogLeNet_biasNumber, '-^', SNR,  ResNet18_biasNumber, '-o', 'LineWidth', 3);
% xlabel('SNR/dB', 'Fontname', 'Times New Roman', 'FontSize', 16); ylabel('BiasNumber', 'Fontname', 'Times New Roman', 'FontSize', 16); 
% set(gca, 'Fontname', 'Times New Roman', 'FontSize', 16);
% legend('GoogLeNet', 'ResNet18', 'FontSize', 16, 'Fontname', 'Times New Roman', 'Location','southeast'); grid on;



function [biasNumber] = SNRSTest(netTransfer,SNR,path, RecognitionRate_net)
%%
SNR_num = length(SNR);
biasNumber = zeros(1, 15);
for i = 5 : 7
    snr = SNR(i); 
    path_test = strcat(path, num2str(snr));
    imds_test = imageDatastore(path_test, 'IncludeSubfolders',true,'LabelSource','foldernames');
    YPred_test = classify(netTransfer,imds_test);
    accuracy = sum(YPred_test == imds_test.Labels);
    biasNumber(i) = RecognitionRate_net(i) / 100 * length(YPred_test) - accuracy;
    
    figure();
    cm = confusionchart(imds_test.Labels,YPred_test, 'Fontname', 'Times New Roman');
    cm.Title = 'Confusion Matrix for ResNet-18';
    cm.XLabel = 'Predicted Class';
    cm.YLabel = 'True Class';
    cm.FontSize = 16;
    cm.FontName = 'Times New Roman';
    
  
end
end