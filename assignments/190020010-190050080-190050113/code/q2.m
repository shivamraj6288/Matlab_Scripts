clear;clc;
rng(3000);
Nvals = [ 5, 10, 20, 40, 60, 80, 100, 500, 1000, 10000];
error_ml = zeros([100,10]);
error_bay = zeros([100,10]);

for i = 1:10
   N = Nvals(i);
   x = rand(100,N);
   y = -1*log(x)/5;
   alpha = (N+4.5)./(sum(y,2)+1);
   error_ml(:,i) = abs(N./sum(y,2)-5)/5;
   error_bay(:,i) = abs((N+5.5)./(sum(y,2)+1)-5)/5;
end

figure(1);
boxplot(error_ml,Nvals);
xlabel('N');
ylabel('|{λ}-λ_{true}| / λ_{true}');
title('Maximum likelihood estimate');

figure(2);
boxplot(error_bay,Nvals);
xlabel('N');
ylabel('|{λ}-λ_{true}| / λ_{true}');
title('Bayesian estimate');
