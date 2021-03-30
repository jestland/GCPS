function [RecognitionRate, imds_test, YPred_test, ClassficationRate] = SNRTest(netTransfer,SNR,path)
%%
SNR_num = length(SNR);
RecognitionRate = zeros(1,SNR_num);
ClassficationRate = zeros(5,length(SNR));
standard = categorical({'cw' 'fsk' 'lfm' 'pfm' 'sfm'});
for i = 1 : SNR_num
    snr = SNR(i); 
    path_test = strcat(path, num2str(snr));
    imds_test = imageDatastore(path_test, 'IncludeSubfolders',true,'LabelSource','foldernames');
    YPred_test = classify(netTransfer,imds_test);
    accuracy = mean(YPred_test == imds_test.Labels);
    RecognitionRate(1,i) = accuracy*100;
        
    ClassficationRate(1,i) = sum(YPred_test(1:100)==standard(1))/100*100;    %cw
    ClassficationRate(2,i) = sum(YPred_test(101:200)==standard(2))/100*100;  %fsk
    ClassficationRate(3,i) = sum(YPred_test(201:300)==standard(3))/100*100;  %lfm
    ClassficationRate(4,i) = sum(YPred_test(301:400)==standard(4))/100*100;  %pfm
    ClassficationRate(5,i) = sum(YPred_test(401:500)==standard(5))/100*100; %sfm
    

%     resultput(['TFINoise SNR = ', num2str(SNR(i)), 'dB'], RecognitionRate, imds_test.Labels, YPred_test);
    
 
end


