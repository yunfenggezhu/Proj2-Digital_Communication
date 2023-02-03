%% Output of the matched filter r[k] without noise

clc;
clear;
%----------parameter setting---------
beta_0 = .5;
beta_2 = .5;
beta_1 = 1/sqrt(2);
alpha = .5;
sigma = 0;
N = 1000;
n = sigma.*randn(1,N+7);
Z = rand(1,N+7);
g1 = 1;  % g_0
g2 = 2/sqrt(2);   %g_1
g3 = 2/sqrt(2);   %g_-1
g4 = .25; %g_2
g5 = .25; %g_-2
g = [g5 g3 g1 g2 g4];

%-------------generate noise wk---------------
for k = 1:N+2
   w(k+2) = beta_0*n(k+2) + beta_1*n(k+1) + beta_2*n(k);  % generate noise with ISI
end % k
 
%-------------generate X(k)-------------------
for k = 3:N+7
    if Z(k) > .5
        X(k) = 1;
    elseif Z(k) < .5
        X(k) = -1;
    end % if
end % k

%-----------generate r(k)--------------------
for k = 3:N+2
    r(k) = 0;
    for l = 1:5
       r(k) = r(k) + g(l)*X(k+5-l) + w(k);
    end % l
end % k
r = [r(3:end)];
t = 1:N;
figure;
stem(t,r);
title('The output of the matched filter r[k] without noise(N_{0} = 1)');
xlabel('k');
ylabel('r[k]');
