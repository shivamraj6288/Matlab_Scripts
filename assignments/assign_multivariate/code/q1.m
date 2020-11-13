clear; clc;
rng(314);

for power = 1:8
    rand_mat = single(2*(rand(10^power,2)-0.5)); % 2*[0-0.5,1-0.5]
    num_true = (sum(rand_mat.^2,2)<=1);
    fprintf('N= 10^%d : pi => %1.10f\n',power,sum(4*num_true/10^power));
end
%now wait
num_true = 0;
for iter = 1:100
    rand_mat = single(2*(rand(10^7,2)-0.5));
    num_true = single(num_true+sum(sum(rand_mat.^2,2)<=1));
end
fprintf('N= 10^9 : pi => %1.10f\n',sum(4*single(num_true)/10^9));

% part (d)
syms P(m,k)
P(m,k) = nchoosek(m,k) * (pi/4.0)^k * (1.0-pi/4.0)^(m-k);

M = int32(1);
while(true)
    pro_sum = 0.0;
    arr = ceil(M*(pi/4-0.0025)):floor(M*(pi/4+0.0025));
    for pts = arr
        ptsf = single(pts);
        update = P(M,pts);
        previous_digits = digits(2);
        pro_sum = pro_sum+vpa(update);
    end
    if pro_sum > 0.94   % we set digits(2) so this works
        fprintf("For getting pi+-0.01 with .95 probability => %d samples works\n",M);
        break
    end
    M = M*10;
end