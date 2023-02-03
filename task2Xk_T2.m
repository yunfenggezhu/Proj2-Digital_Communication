clc;
clear;
%----------parameter setting---------
beta_0 = .5;
beta_2 = .5;
beta_1 = 1/sqrt(2);
alpha = .5; % factors
SNR = 0:2:10; % SNR range
sigma = 10.^(-SNR/20);
N = 1000;
Z = rand(1,N+7);
g1 = 1;  % g_0
g2 = 2/sqrt(2);   %g_1
g3 = 2/sqrt(2);   %g_-1
g4 = .25; %g_2
g5 = .25; %g_-2
g = [g5 g3 g1 g2 g4];

%-----------generate noise nk and wk----------
for i = 1:length(SNR)
    n(i,:) = sigma(i).*randn(1,N+7);
    for k = 1:N+2
        w(i, k+2) = beta_0*n(i, k+2) + beta_1*n(i, k+1) + beta_2*n(i, k);  % generate noise with ISI
    end % k
end % i

%-------------generate X(k) based on uniform distribution-------------------
for k = 3:N+7
    if Z(k) > .5
        X(k) = 1;
    elseif Z(k) < .5
        X(k) = -1;
    end % if
end % k

%-------------generate r(k)------------------
for i = 1:length(SNR)
    for k = 3:N+2
        r(i, k) = 0;
        for l = 1:5
           r(i, k) = r(i, k) + g(l)*X(k+5-l) + w(i, k);
        end % l
    end % k
end % i

%------------generate s(k)--------------------
result = r(:, 3:end);
X = X(3:N+2);
for i = 1:length(SNR)
    error(i) = 0; 
    for k = 1:N
       S(i, k) = (r(i,k)-X(k)).^2; 
    end % k
end % i
