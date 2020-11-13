clear; clc;
rng(314);
a = [1.6250, -1.9486;-1.9486, 3.8750];
[Q,D,Qt] = eig(a);
mu_p = Qt*[1;2];
point = [0 0 0 0 0];
for power = 1:5
    for iter = 1:100
        samples = [D(1,1)*randn([1,10^power])+mu_p(1);
               D(2,2)*randn([1,10^power])+mu_p(2)];
        samples = Q*samples;
        mean = sum(samples,2)/10^power;
        point(power) = sum((mean-[1;2]).^2)/sum([1;2].^2);
    end
end
boxplot([1:5;point])