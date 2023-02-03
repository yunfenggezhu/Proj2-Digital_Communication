%% this is for generating the Raised Cosine Pulse g_{rc}(t) and
%% quare Root Raised Cosine Pulse g_{src}(t) in time domain

clc;
clear;
alpha = [0 .5]; % factor
T = 25;
dt = .01;
Fs = 1/T;
t = -3*T:dt:3*T-dt; % time range
x = t/T;
m = length(x);
y = sinc(x); % generate the sinc funciton 
for i = 1:2
    for j = 1:m
       factor1(i,j) = cos(pi*alpha(i)*x(j)); % compute factors
       factor2(i,j) = 1-4*alpha(i)*alpha(i)*x(j)*x(j);
       co(i,j) = factor1(i,j)/factor2(i,j);
       g_rc(i,j) = y(j)*co(i,j);  
    end % j
    legend_str{i} = ['\alpha=' num2str(alpha(i))];
end % i

figure;
plot(t, g_rc);
legend(legend_str);
title('Raised Cosine Pulse g_{rc}(t) in Time Domain');
xlabel('t(s)');
ylabel('g_{rc}(t)');
grid on;
