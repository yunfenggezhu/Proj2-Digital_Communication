%% this is a function for compute Grc(f)

clc;
clear;
T = 25;
amplititude = T/2; % amplititude 
ff = .0001; % frequency interval
range = 1/T;
f = -range:ff:range; % x axis
n = length(f); 
alpha = 0.5; % factors
factor1 = (1-alpha)/(2*T);
factor2 = (1+alpha)/(2*T);
coefficient = T/2;
for j = 1:n
    if abs(f(j)) >=0 && abs(f(j)) <= factor1
        theta(j) = 0;
        Grc(j) = T;
        r(j) = 0;
    elseif abs(f(j)) >=factor1 && abs(f(j)) <= factor2
        theta(j) = 2*pi*abs(f(j))*T-0.5*pi;
        Grc(j) = amplititude * (1+cos(theta(j)));
        r(j) = 1+cos(theta(j));
    elseif abs(f(j)) > factor2
        theta(j) = 0;
        Grc(j) = 0;
        r(j) = 0;
    end % if
end %j
plot(f, r);
