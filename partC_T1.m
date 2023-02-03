%this for when alpha = .5 and plot the equivalant frequency response G(f)
clc;
clear;
T = 25;
ff = .0001; % frequncy interval
beta0 = .5; 
beta1 = 1/sqrt(2);
beta2 = .5;
range = 1/T;
f = -range:ff:range; % frequency range
T = 25;
load('Grc.mat'); % load filter
P = Grc(2,:);  % since alpha = 0.5, the second filter we save
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
   G(i) = P(i) * C(i) * C(i);
   G_am(i) = abs(G(i));
end % i
figure;
plot(f, G_am);
title('Magnitude of the Equivalent Channel Frequency Response |G(f)|.');
xlabel('f(Hz)');
ylabel('|G(f)|');
grid on;
