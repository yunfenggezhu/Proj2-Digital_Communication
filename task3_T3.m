clear;
clc;
%----------parameters setting ---------------
SNR = [0:2:10];
gamma = 10.^(SNR/10);
sigma = 10.^(-SNR/20);
g_L = [.25 1/sqrt(2) 1 1/sqrt(2) .25];
g = [1 1/sqrt(2) .25]; 
N = 100;
blocks = 5000;
beta = [.5 1/sqrt(2) .5];

%----------theoretical value----------------
for i = 1:length(SNR)
   BER_theo(i) = qfunc(sqrt(2*gamma(i))); 
end % i

for run = 1:blocks
   [error(run,:), ] = MLSD(N, sigma, g_L, beta);
   error_ML(run,:) = BER_ML(N, sigma, g_L, beta);
end % run
BER_MLSD = mean(error); % take average value of error bit prob
BER_ML = mean(error_ML);

a = semilogy(SNR,BER_MLSD,'b+-.');
hold on;
b = semilogy(SNR,BER_ML,'rv:');
hold on;
c = semilogy(SNR,BER_theo,'mx-.');
title('Comparison of performance between MLSD detector and ML detector with theoretical analysis');
xlabel('SNR(dB)');
ylabel('Error bit probability');
legend([a,b,c],'MLSD', 'ML ignores ISI', 'Theoretical Value','Location', 'southwest');
grid on;

