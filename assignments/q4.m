clear;clc;

x = 4*randn(1,1000);
index = randperm(1000);
t = x(:,index(1:750));
v = x(:,index(751:1000));

ll = [0 0 0 0 0 0 0 0 0 0 0];
allsigmas = [0.001 0.1 0.2 0.9 1 2 3 5 10 20 100];
i = 1;
for sigma = allsigmas
    for xj = v
        ll(i) = ll(i)+log(p_hat(xj,sigma));
    end
    i=1+1;
end

log_sigmas = log(allsigmas);
figure;
plot(log_sigmas,ll);
xlabel('log(sigma)');
ylabel('LL value');

[val, idx] = max(ll);
sprintf('Value of sigma that yielded best LL value is %f\n',allsigmas(idx));

ii  = idx;
x = -8:0.1:8;
y = -8:0.1:8;
i = 1;
for x_ = x
    y = p_hat(x_,allsigmas(idx));
    i=i+1;
end

real_normal = (exp((-1)*(x.^2)/(2*16)))/(4*sqrt(2*pi));

figure;
plot(x,real_normal,x,y);
xlabel('x');
ylabel('p');
legend({'Gaussian','Kernal Estimation'});


i = 1;
D = [0 0 0 0 0 0 0 0 0 0 0];
for sigma = allsigmas
    for xj = V
        pxi = (exp((-1)*(xj^2)/(2*16)))/(4*sqrt(2*pi));
        pn = p_hat(xj,sigma);
        D(i) = D(i) + (pxi-pn)^2;
    end
    i = i+1;
end

figure;
plot(log_sigmas,D);
xlabel('log(sigma)');
ylabel('D');

[val, idx] = min(D);

sprintf("Value of sigma that yielded best D is %f\n",allsigmas(idx));

disp("D value for the sigma that yielded best LL %f\n",D(ii));

function sum = p_hat(x,sigma)
    sum = 0;
    for xi = t
        sum = sum + exp((-1)*(x-xi)^2/(2*sigma^2))/(750*sigma*sqrt(2*pi));
    end
end

