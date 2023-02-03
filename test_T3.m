clear;
clc;
SNR = [0:2:10]; % SNR range
gamma = 10.^(SNR/10); % SNR in linear domain
sigma = 10.^(-SNR/20); % sigma2
g_L = [.25 1/sqrt(2) 1 1/sqrt(2) .25]; 
g = [1 1/sqrt(2) .25]; 
N = 1000;
blocks = 500;
beta = [.5 1/sqrt(2) .5];
[error ,r] = MLSD(N, sigma, g_L, beta); % compute error bit prob by MLSD detector