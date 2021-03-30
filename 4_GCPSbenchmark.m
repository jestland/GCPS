clear all;
close all;
clc

%%%%%%%%%%%%%%%%
SNR = -14:2:14;
standard = categorical({'cw' 'fsk' 'lfm' 'pfm' 'sfm'});
% size = 224; 
samplenum = 100;
chartsize = 16;
linesize = 3;
Net224 = {'_GoogLeNet', '_ResNet18'};
TFD = 'STFT'; %STFT or other time-frequency distribution
%% GCPS Calculation
% GoogLeNet_IN = zeros(length(standard), samplenum, length(SNR));
% GoogLeNet_OUT = zeros(length(standard), samplenum, length(SNR));
% GoogLeNet_BaselineIN = zeros(length(standard), samplenum, length(SNR));
% GoogLeNet_BaselineOUT = zeros(length(standard), samplenum, length(SNR));

% ResNet18_IN = zeros(length(standard), samplenum, length(SNR));
% ResNet18_OUT = zeros(length(standard), samplenum, length(SNR));
% ResNet18_BaselineIN = zeros(length(standard), samplenum, length(SNR));
% ResNet18_BaselineOUT = zeros(length(standard), samplenum, length(SNR));
% 
% IN_GradCAMNum = 0;
% OUT_GradCAMNum = 0;
% BaselineIN = 0;
% BaselineOUT = 0;
% tic
% 
% for j = 1 : length(standard)
%     for k = 1 : samplenum
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Benchmark = imread(strcat('stft224/Set_TFINoise/GradCAMSet', string(Net224(2)), '/Benchmark/', string(standard(j)), '/', num2str(k), '.jpg'));
%         [xIN, yIN, xOUT, yOUT, BaselineIN, BaselineOUT] = Pretreatment_BenchmarkContour(Benchmark);
% 
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         for i = 1 : length(SNR)
%            GradCAM_TFINoise = imread(strcat('stft224/Set_TFINoise/GradCAMSet', string(Net224(2)), '/snr', num2str(SNR(i)), '/', string(standard(j)), '/', num2str(k), '.jpg'));
%            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            for w = 1 : length(xIN)
%                 if GradCAM_TFINoise(xIN(w), yIN(w), 1) >= 250
%                     IN_GradCAMNum = IN_GradCAMNum + 1;        
%                 end
%            end
%            for h = 1 : length(xOUT)
%                 if GradCAM_TFINoise(xOUT(h), yOUT(h), 1) >= 250
%                     OUT_GradCAMNum = OUT_GradCAMNum + 1;        
%                 end              
%            end 
%            
% %            GoogLeNet_IN(j, k, i) = IN_GradCAMNum;
% %            GoogLeNet_OUT(j, k, i) = OUT_GradCAMNum;
% %            GoogLeNet_BaselineIN(j, k, i) = BaselineIN;
% %            GoogLeNet_BaselineOUT(j, k, i) = BaselineOUT;
%            
%             ResNet18_IN(j, k, i) = IN_GradCAMNum;
%             ResNet18_OUT(j, k, i) = OUT_GradCAMNum;
%             ResNet18_BaselineIN(j, k, i) = BaselineIN;
%             ResNet18_BaselineOUT(j, k, i) = BaselineOUT;
% 
%            IN_GradCAMNum = 0;
%            OUT_GradCAMNum = 0;            
%           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%         end
%     end
% end
% 
% toc
% 
% % save(strcat('Result/', TFD, '/GCPSBenchmark/new/GoogLeNet_IN.mat'));
% % save(strcat('Result/', TFD, '/GCPSBenchmark/new/GoogLeNet_OUT.mat'));
% % save(strcat('Result/', TFD, '/GCPSBenchmark/new/GoogLeNet_BaselineIN.mat'));
% % save(strcat('Result/', TFD, '/GCPSBenchmark/new/GoogLeNet_BaselineOUT.mat'));
% 
% save(strcat('Result/', TFD, '/GCPSBenchmark/new/ResNet18_IN.mat'));
% save(strcat('Result/', TFD, '/GCPSBenchmark/new/ResNet18_OUT.mat'));
% save(strcat('Result/', TFD, '/GCPSBenchmark/new/ResNet18_BaselineIN.mat'));
% save(strcat('Result/', TFD, '/GCPSBenchmark/new/ResNet18_BaselineOUT.mat'));
%% Compare different categories
load(strcat('Result/STFT/GCPSBenchmark/new/GoogLeNet_IN.mat'));       
load(strcat('Result/STFT/GCPSBenchmark/new/GoogLeNet_OUT.mat'));        
load(strcat('Result/STFT/GCPSBenchmark/new/GoogLeNet_BaselineIN.mat'));
load(strcat('Result/STFT/GCPSBenchmark/new/GoogLeNet_BaselineOUT.mat'));
load(strcat('Result/STFT/GCPSBenchmark/new/ResNet18_IN.mat'));        
load(strcat('Result/STFT/GCPSBenchmark/new/ResNet18_OUT.mat'));        
load(strcat('Result/STFT/GCPSBenchmark/new/ResNet18_BaselineIN.mat'));
load(strcat('Result/STFT/GCPSBenchmark/new/ResNet18_BaselineOUT.mat'));

GCPS_GoogLeNet_IN = shiftdim(mean(GoogLeNet_IN./GoogLeNet_BaselineIN, 2),2);
GCPS_GoogLeNet_OUT = shiftdim(mean(GoogLeNet_OUT./GoogLeNet_BaselineOUT, 2),2);

GCPS_ResNet18_IN = shiftdim(mean(ResNet18_IN./ResNet18_BaselineIN, 2),2);
GCPS_ResNet18_OUT = shiftdim(mean(ResNet18_OUT./ResNet18_BaselineOUT, 2),2);

figure();
%make line better
C = linspecer(5); 
axes('NextPlot','replacechildren', 'ColorOrder',C); 
plot(SNR, GCPS_GoogLeNet_IN(:, 1), '-^', SNR,  GCPS_GoogLeNet_IN(:, 2), '-o', SNR, GCPS_GoogLeNet_IN(:, 3), '-+',...,
     SNR, GCPS_GoogLeNet_IN(:, 4), '-*',SNR, GCPS_GoogLeNet_IN(:, 5), '-p', 'LineWidth', linesize);
xlabel('SNR/dB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); ylabel('GCPS-IB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); 
set(gca, 'Fontname', 'Times New Roman', 'FontSize', chartsize);
legend('CW', 'FSK', 'LFM', 'PFM', 'SFM', 'FontSize', chartsize, 'Fontname', 'Times New Roman', 'Location','southeast'); grid on;

figure();
%make line better
C = linspecer(5); 
axes('NextPlot','replacechildren', 'ColorOrder',C); 
plot(SNR, GCPS_GoogLeNet_OUT(:, 1), '-^', SNR,  GCPS_GoogLeNet_OUT(:, 2), '-o', SNR, GCPS_GoogLeNet_OUT(:, 3), '-+',...,
     SNR, GCPS_GoogLeNet_OUT(:, 4), '-*',SNR, GCPS_GoogLeNet_OUT(:, 5), '-p', 'LineWidth', linesize);
xlabel('SNR/dB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); ylabel('GCPS-EB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); 
set(gca, 'Fontname', 'Times New Roman', 'FontSize', chartsize);
legend('CW', 'FSK', 'LFM', 'PFM', 'SFM', 'FontSize', chartsize, 'Fontname', 'Times New Roman', 'Location','northeast'); grid on;


figure();
%make line better
C = linspecer(5); 
axes('NextPlot','replacechildren', 'ColorOrder',C); 
plot(SNR, GCPS_ResNet18_IN(:, 1), '-^', SNR,  GCPS_ResNet18_IN(:, 2), '-o', SNR, GCPS_ResNet18_IN(:, 3), '-+',...,
     SNR, GCPS_ResNet18_IN(:, 4), '-*',SNR, GCPS_ResNet18_IN(:, 5), '-p', 'LineWidth', linesize);
xlabel('SNR/dB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); ylabel('GCPS-IB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); 
set(gca, 'Fontname', 'Times New Roman', 'FontSize', chartsize);
legend('CW', 'FSK', 'LFM', 'PFM', 'SFM', 'FontSize', chartsize, 'Fontname', 'Times New Roman', 'Location','southeast'); grid on;


figure();
%make line better
C = linspecer(5); 
axes('NextPlot','replacechildren', 'ColorOrder',C); 
plot(SNR, GCPS_ResNet18_OUT(:, 1), '-^', SNR,  GCPS_ResNet18_OUT(:, 2), '-o', SNR, GCPS_ResNet18_OUT(:, 3), '-+',...,
     SNR, GCPS_ResNet18_OUT(:, 4), '-*',SNR, GCPS_ResNet18_OUT(:, 5), '-p', 'LineWidth', linesize);
xlabel('SNR/dB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); ylabel('GCPS-EB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); 
set(gca, 'Fontname', 'Times New Roman', 'FontSize', chartsize);
legend('CW', 'FSK', 'LFM', 'PFM', 'SFM', 'FontSize', chartsize, 'Fontname', 'Times New Roman', 'Location','northeast'); grid on;
axis([-15, 15, 0, 0.2]);
%% overall
IN1 = load(strcat('Result/', TFD, '/GCPSBenchmark/new/GoogLeNet_IN.mat'));       
OUT1 = load(strcat('Result/', TFD, '/GCPSBenchmark/new/GoogLeNet_OUT.mat'));        
BaselineIN1 = load(strcat('Result/', TFD, '/GCPSBenchmark/new/GoogLeNet_BaselineIN.mat'));      
BaselineOUT1 = load(strcat('Result/', TFD, '/GCPSBenchmark/new/GoogLeNet_BaselineOUT.mat'));     

IN2 = load(strcat('Result/', TFD, '/GCPSBenchmark/new/ResNet18_IN.mat'));     
OUT2 = load(strcat('Result/', TFD, '/GCPSBenchmark/new/ResNet18_OUT.mat'));     
BaselineIN2 = load(strcat('Result/', TFD, '/GCPSBenchmark/new/ResNet18_BaselineIN.mat'));     
BaselineOUT2 = load(strcat('Result/', TFD, '/GCPSBenchmark/new/ResNet18_BaselineOUT.mat'));  


GCPS_GoogLeNet_IN = shiftdim(mean(IN1.GoogLeNet_IN./BaselineIN1.GoogLeNet_BaselineIN, 2),2);
GCPS_GoogLeNet_OUT = shiftdim(mean(OUT1.GoogLeNet_OUT./BaselineOUT1.GoogLeNet_BaselineOUT, 2),2);
GCPS_GoogLeNet_IN = sum(GCPS_GoogLeNet_IN, 2) ./ 5;
GCPS_GoogLeNet_OUT = sum(GCPS_GoogLeNet_OUT, 2) ./ 5;

GCPS_ResNet18_IN = shiftdim(mean(IN2.ResNet18_IN./BaselineIN2.ResNet18_BaselineIN, 2),2);
GCPS_ResNet18_OUT = shiftdim(mean(OUT2.ResNet18_OUT./BaselineOUT2.ResNet18_BaselineOUT, 2),2);
GCPS_ResNet18_IN = sum(GCPS_ResNet18_IN, 2) ./ 5;
GCPS_ResNet18_OUT = sum(GCPS_ResNet18_OUT, 2) ./ 5;

% figure();
% %make line better
% C = linspecer(2); 
% axes('NextPlot','replacechildren', 'ColorOrder',C); 
% plot(SNR, GCPS_GoogLeNet_IN, '-^', SNR,  GCPS_ResNet18_IN, '-o', 'LineWidth', linesize);
% xlabel('SNR/dB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); ylabel('GCPS-IB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); 
% set(gca, 'Fontname', 'Times New Roman', 'FontSize', chartsize);
% legend('GoogLeNet', 'ResNet18', 'FontSize', chartsize, 'Fontname', 'Times New Roman', 'Location','southeast'); grid on;
% axis([-15, 15, 0, 1]);
% 
% figure();
% %make line better
% C = linspecer(2); 
% axes('NextPlot','replacechildren', 'ColorOrder',C); 
% plot(SNR, GCPS_GoogLeNet_OUT, '-^', SNR,  GCPS_ResNet18_OUT, '-o', 'LineWidth', linesize);
% xlabel('SNR/dB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); ylabel('GCPS-EB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); 
% set(gca, 'Fontname', 'Times New Roman', 'FontSize', chartsize);
% legend('GoogLeNet', 'ResNet18', 'FontSize', chartsize, 'Fontname', 'Times New Roman', 'Location','northeast'); grid on;

%% GCPS and recognition rate
load(strcat('Result/', TFD, '/RecognitionRate_GoogLeNet.mat'));
load(strcat('Result/', TFD, '/RecognitionRate_ResNet18.mat'));
load(strcat('Result/', TFD, '/ClassificationRate_GoogLeNet.mat'));
load(strcat('Result/', TFD, '/ClassificationRate_ResNet18.mat'));
%========================= same CNN ===========================%
figure();
%make line better
C = linspecer(5); 
axes('NextPlot','replacechildren', 'ColorOrder',C); 
plot(SNR, ClassificationRate_GoogLeNet(1, :), '-^', SNR,  ClassificationRate_GoogLeNet(2, :), '-o', SNR, ClassificationRate_GoogLeNet(3, :), '-+',...,
     SNR, ClassificationRate_GoogLeNet(4, :), '-*',SNR, ClassificationRate_GoogLeNet(5, :), '-p', 'LineWidth', linesize);
xlabel('SNR/dB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); ylabel('Recognition Rate/%', 'Fontname', 'Times New Roman', 'FontSize', chartsize); 
set(gca, 'Fontname', 'Times New Roman', 'FontSize', chartsize);
legend('CW', 'FSK', 'LFM', 'PFM', 'SFM', 'FontSize', chartsize, 'Fontname', 'Times New Roman'); grid on;

figure();
%make line better
C = linspecer(5); 
axes('NextPlot','replacechildren', 'ColorOrder',C); 
plot(SNR, ClassificationRate_ResNet18(1, :), '-^', SNR,  ClassificationRate_ResNet18(2, :), '-o', SNR, ClassificationRate_ResNet18(3, :), '-+',...,
     SNR, ClassificationRate_ResNet18(4, :), '-*',SNR, ClassificationRate_ResNet18(5, :), '-p', 'LineWidth', linesize);
xlabel('SNR/dB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); ylabel('Recognition Rate/%', 'Fontname', 'Times New Roman', 'FontSize', chartsize); 
set(gca, 'Fontname', 'Times New Roman', 'FontSize', chartsize);
legend('CW', 'FSK', 'LFM', 'PFM', 'SFM', 'FontSize', chartsize, 'Fontname', 'Times New Roman'); grid on;
%========================= different CNN ===========================%
% figure();
% % make line better
% C = linspecer(2); 
% axes('NextPlot','replacechildren', 'ColorOrder',C); 
% plot(SNR,  RecognitionRate_GoogLeNet, '-^', SNR, RecognitionRate_ResNet18, '-o', 'LineWidth', linesize);
% xlabel('SNR/dB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); ylabel('Recognition Rate/%', 'Fontname', 'Times New Roman', 'FontSize', chartsize); 
% set(gca, 'Fontname', 'Times New Roman', 'FontSize', chartsize);
% legend('GoogLeNet', 'ResNet18', 'FontSize', chartsize, 'Fontname', 'Times New Roman'); grid on;
% axis([-15, 15, 19, 100]);
% % 
% figure();
% %make line better
% C = linspecer(2); 
% axes('NextPlot','replacechildren', 'ColorOrder',C); 
% plot(GCPS_GoogLeNet_IN, RecognitionRate_GoogLeNet, '-^', GCPS_ResNet18_IN, RecognitionRate_ResNet18, '-o', 'LineWidth', 2);
% xlabel('GCPS-IB', 'Fontname', 'Times New Roman'); ylabel('Recognition Rate/%', 'Fontname', 'Times New Roman');
% set(gca, 'Fontname', 'Times New Roman');%±ä×ø±êÖáÎªtimes new roman
% legend('GoogLeNet', 'ResNet18', 'FontSize', 8, 'Fontname', 'Times New Roman'); grid on;
% 
% figure();
% %make line better
% C = linspecer(2); 
% axes('NextPlot','replacechildren', 'ColorOrder',C); 
% plot(GCPS_GoogLeNet_OUT, RecognitionRate_GoogLeNet, '-^', GCPS_ResNet18_OUT, RecognitionRate_ResNet18, '-o', 'LineWidth', 2);
% xlabel('GCPS-EB', 'Fontname', 'Times New Roman'); ylabel('Recognition Rate/%', 'Fontname', 'Times New Roman'); 
% set(gca, 'Fontname', 'Times New Roman');
% legend('GoogLeNet', 'ResNet18', 'FontSize', 8, 'Fontname', 'Times New Roman'); grid on;


%========================= Scatter plot ===========================%
figure();
% %make line better
C = linspecer(2); 
axes('NextPlot','replacechildren', 'ColorOrder',C); 
scatter(GCPS_GoogLeNet_OUT, GCPS_GoogLeNet_IN, 80, RecognitionRate_GoogLeNet, '^','filled' ); hold on;
scatter(GCPS_ResNet18_OUT, GCPS_ResNet18_IN, 80, RecognitionRate_ResNet18,  'filled');
xlabel('GCPS-EB', 'Fontname', 'Times New Roman', 'FontSize', chartsize); ylabel('GCPS-IB', 'Fontname', 'Times New Roman', 'FontSize', chartsize);
set(gca, 'Fontname', 'Times New Roman', 'FontSize', chartsize);
h =  colorbar;
colormap jet;
set(get(h, 'label'), 'string', 'Recognition Rate/%', 'FontSize', chartsize, 'Fontname', 'Times New Roman');
legend('GoogLeNet', 'ResNet18', 'FontSize', chartsize, 'Fontname', 'Times New Roman', 'Location','northeast'); grid on;
axis([0, 0.1, 0, 1]);
