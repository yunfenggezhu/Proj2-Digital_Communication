%% this is for generating the Raised Cosine Pulse g_{rc}(t) and
%% quare Root Raised Cosine Pulse g_{src}(t) in frequency domain

clc;
clear;
T = 25; % total time
ff = .0001; % small interval
theta = [];
range = 1/T;
f = [-range:ff:range]; % range of frequency
n = length(f);
alpha = [0 .5]; % factor
Grc = [];
Gsrc = [];
factor1 = [];
factor2 = [];
coefficient = T/2;
for i = 1:2
    factor1(i) = (1-alpha(i))/(2*T); % compute factor
    factor2(i) = (1+alpha(i))/(2*T);
    for j = 1:n
        if abs(f(j)) >=0 && abs(f(j)) <= factor1(i) % write the formula according to the original formula
            theta(i,j) = 0;
            Grc(i,j) = T;
            Gsrc(i,j) = sqrt(Grc(i,j));
        elseif abs(f(j)) >=factor1(i) && abs(f(j)) <= factor2(i)
            theta(i,j) = 2*pi*abs(f(j))*T-0.5*pi;
            Grc(i,j) = coefficient * (1+cos(theta(i,j)));
            Gsrc(i,j) = sqrt(Grc(i,j));
        elseif abs(f(j)) > factor2(i)
            theta(i,j) = 0;
            Grc(i,j) = 0;
            Gsrc(i,j) = sqrt(Grc(i,j));
        end % if
    end % j
    legend_str{i} = ['\alpha=' num2str(alpha(i))];
end % i

figure;
plot(f, Grc);
legend(legend_str);
title('Freqency Response G_{rc}(f) of Raised Cosine Pulse g_{rc}(t)');
xlabel('f(Hz)');
ylabel('G_{rc}(f)');
grid on;
figure;
plot(f, Gsrc);
legend(legend_str);
title('Freqency Response G_{src}(f) of Square Root Raised Cosine Pulse g_{src}(t)');
xlabel('f(Hz)');
ylabel('G_{src}(f)');
grid on;