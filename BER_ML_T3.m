% this function is the subfunction for ML detector

function [error_ML] = BER_ML(N, sigma, g_L, beta)
Z = rand(3,N+7);
%----------for generate the initial two values X(1) = X(-2), X(0) = X(-1)
%forms uniform distribution
X(1) = 0;
X(2) = 0;
for i = 3:N+7
    if Z(i) > .5
        X(i) = 1;
    elseif Z(i) < .5
        X(i) = -1;
    end % if
end % i

%--------------generate noise Wk----------------
for i = 1:length(sigma)
    n(i,:) = sigma(i) * randn(1,N+3);
    total = N+2;
    for k = 3:total
       W(i, k) = beta(1) * n(i,k) + beta(1) * n(i,k-1) + beta(2)* n(i, k-2);  % noise with ISI
       R(i, k) = 0;
       for l = 1:length(g_L)
           R(i,k) = g_L(l)*X(k+5-l) + R(i,k); % generate received signal
       end % l
       r(i, k) = R(i, k) + W(i, k);
       if real(r(i,k)) > 0
           Y(i,k) = 1;
       elseif real(r(i,k)) < 0
           Y(i,k) = -1;
       end % if
       difference(i,:) = X(k) - Y(i,k);
    end % k
    error_ML(i) = length(find(difference(i,:))) / N;  % compute error bit prob
end % i
%--------------ML detector------------------

end % function