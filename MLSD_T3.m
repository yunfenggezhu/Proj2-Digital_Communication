% This one is for MLSD detector

function [error,r] = MLSD(N, sigma, g_L, beta)

%generate X everytime when calling this function
Z = rand(1,N+7);
%----------for generate the initial two values X(1) = X(-2), X(0) = X(-1)
%forms uniform distribution 
X(1) = 0;
X(2) = 0;
for i = 3:N+7
    if Z(i) >= .5
        X(i) = 1;
    elseif Z(i) < .5
        X(i) = -1;
    end % if
end % i

%--------------generate noise Wk----------------
for i = 1:length(sigma)
    n(i,:) = sigma(i) * randn(1,N+3);
    total = N+3;
    for k = 3:total
       W(i, k) = beta(1) * n(i,k) + beta(2) * n(i,k-1) + beta(3)* n(i, k-2);  % noise with ISI
       R(i, k) = 0;
       for l = 1:length(g_L)
           temp = g_L(l)*X(k+3-l);
           R(i,k) = temp + R(i,k);
       end % l
       r(i, k) = R(i, k) + W(i, k);
    end % k
end % i

%-------------initial the first value, since our L is 2-------------
%the original points represent X0 and X-1 X(1) and X(2)
original = [1 1; 1 -1; -1 1; -1 -1];

%---------------initialize the cost function at C(3) which is equal to C(1)
% two values before it is X0 and X1, in our sequence is X(2) and X(3), C(3) = C(2) + delta_C(3)
for i = 1:length(sigma)
   C(i,:) = zeros(1,N+2);
   for j = 1:4
      C_initial(i,j) = - 2*r(i,3)*original(j,2) + 1 - 2*r(i,4)*original(j,2) + sqrt(2)*original(j,1)*original(j,2);
   end % j
   
   
   [row, column] = find(C_initial(i,:) == min(C_initial(i,:))); %find and pick the minumum cost as the initial cost
   C(i,3) = min(C_initial(i,:));

   X_hat(i,2) = original(column,1);
   X_hat(i,3) = original(column,2);
   for k = 4:N+2
      delta_C_positive(i,k)= -2*r(i,k)*1 + 1 + sqrt(2)*X_hat(i, k-1)*1 + 0.5*X_hat(i, k-2)*1;  %when x_hat is 1
      delta_C_negative(i,k)= -2*r(i,k)*(-1) + 1 + sqrt(2)*X_hat(i, k-1)*(-1) + 0.5*X_hat(i, k-2)*(-1);  %when x_hat is -1
      if delta_C_positive(i,k) < delta_C_negative(i,k)  
         C(i,k) = C(i,k-1)+delta_C_positive(i,k);
         X_hat(i,k) = 1;
      else 
         C(i,k) = C(i,k-1)+delta_C_negative(i,k);
         X_hat(i,k) = -1;
      end % if
   end % k
   for f = 3:N+2
      difference(i,:) = X_hat(i,f) - X(f);
   end % f
   error(i) = length(difference(i,:)) .* sigma(i).^4/(N); % error bit prob
end % i
end % function