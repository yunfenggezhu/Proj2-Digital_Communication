clc;
clear;
%------this is for checking the symbol-------------
%----------parameter setting---------
beta_0 = .5;
beta_2 = .5;
beta_1 = 1/sqrt(2);
alpha = .5;
SNR = [0:2:10];
sigma = zeros(1,length(SNR));
N = 1000;
Z = rand(1,N+7);
g1 = 1;  % g_0
g2 = 2/sqrt(2);   %g_1
g3 = 2/sqrt(2);   %g_-1
g4 = .25; %g_2
g5 = .25; %g_-2
g = [g5 g3 g1 g2 g4];

%-------------generate noise wk---------------

for i = 1:length(SNR)
   sigma(i) =sqrt(1/(10.^(SNR(i)/10))); 
   n(i,:) = sigma(i)*randn(1, N+7);
   gamma(i) = 10.^(SNR(i)/10);  %compute SNR in linear domain
   BER_AWGN(i) = qfunc(sqrt(2*gamma(i)));% compute theoretical values
   for k = 1:N+2
        w(i, k+2) = beta_0*n(i, k+2) + beta_1*n(i, k+1) + beta_2*n(i, k);  % with ISI
   end % k
end % i
%-------------generate X(k)-------------------
for k = 3:N+7
    if Z(k) > .5
        X(k) = 1;
    elseif Z(k) < .5
        X(k) = -1;
    end % if
end % k

%-----------generate r(k)--------------------
for i = 1:length(SNR)
   for k = 3:N+2
        error(i) = 0;
        r(i, k) = 0;
            for l = 1:5
               r(i, k) = r(i, k) + g(l)*X(k+5-l) + w(i, k);
               if r(i, k) > 0
                  Y(i, k) = 1;
                  if Y(i, k) ~= X(k)
                      error(i) = error(i) + 1;
                  end
               elseif r(i, k) < 0
                   Y(i, k) = -1;
                   if Y(i, k) ~= X(k)
                       error(i) = error(i) + 1;
                   end
               end % if                
            end % l
    end % k
end % i
BER = error / N; % compute the error bit prob
BER_1 = semilogy(SNR, BER, 'r>--');
hold on;
BER_2 = semilogy(SNR, BER_AWGN, 'bd-.');
legend([BER_1, BER_2], 'Simulation Result(with ISI)', 'Ideal AWGN', 'Location', 'southwest');
title('Performance comparison between ideal AWGN and symbol with ISI');
xlabel('SNR(dB)');
ylabel('Error Bit Probability(P_{e}');
