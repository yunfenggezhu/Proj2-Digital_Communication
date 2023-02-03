%% this is for the frequency response by using grc_(t) as the filter
%--------------this is for plot H(f), part b, alpha = 0------------
clc;
clear;
T = 25;
ff = .0001; % frequency interval
beta0 = .5;  % factors
beta1 = 1/sqrt(2);
beta2 = .5;
range = 1/T;
f = -range:ff:range; % frequency range
T = 25;
load('Gsrc.mat'); % load the Gsrc data we already generated
P = Gsrc(1,:);  % since alpha = 0, idea low pass filter
n = length(f);

for i = 1:n
   theta1(i) = -2*pi*f(i)*T;
   theta2(i) = -2*pi*f(i)*2*T;
   real1(i) = beta1*cos(theta1(i));
   imag1(i) = beta1*sin(theta1(i));
   com1(i) = complex(real1(i), imag1(i));
   real2(i) = beta2*cos(theta2(i));
   imag2(i) = beta2*sin(theta2(i));
   com2(i) = complex(real2(i), imag2(i));
   C(i) = beta0 + com1(i) + com2(i);
   H(i) = P(i) * C(i);
   H_am(i) = abs(H(i));
end % i
figure;
plot(f, H_am);
title('Magnitude of the Channel Frequency Response |H(f)|.');
xlabel('f(Hz)');
ylabel('|H(f)|');
grid on;
