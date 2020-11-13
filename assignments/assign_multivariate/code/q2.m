clear; clc;
rng(314);
[Q,D,Qt] = eig([1.6250, -1.9486;-1.9486, 3.8750]);
mu_p = Qt*[1;2];
error_mean = zeros([100,5]);

for power = 1:5
    for iter = 1:100
        samples = [D(1,1)^(1/2) *randn([1,10^power])+mu_p(1);
                   D(2,2)^(1/2) *randn([1,10^power])+mu_p(2)];
        samples = Q*samples;
        mean = sum(samples,2)/10^power;
        error_mean(iter,power)=...
            sqrt(sum((mean-[1;2]).^2, 1)/sum(([1;2]).^2, 1));
    end
end
boxplot(error_mean);
xlabel('log_{10} N');
ylabel('Relative Error (mean)');

%%%
error_cov = zeros([100,5]);
figure;
for power = 1:5
    for iter = 1:100
        samples = [D(1,1)^(1/2) * randn([1,10^power]) + mu_p(1);
                   D(2,2)^(1/2) * randn([1,10^power]) + mu_p(2)];
        samples = Q*samples;
        mean_cov = (samples-sum(samples,2)/10^power)*(samples-sum(samples,2)/10^power).'/10^power;
        error_cov(iter,power)=...
            sqrt(sum((mean_cov-[1.6250, -1.9486;-1.9486, 3.8750]).^2, 'all')...
            /sum(([1.6250, -1.9486;-1.9486, 3.8750]).^2, 'all'));
    end
end
boxplot(error_cov);
xlabel('log_{10} N');
ylabel('Relative Error (covariance)');
