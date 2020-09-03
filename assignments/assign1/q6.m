clear;clc;
x = -3:0.02:3;
y = 5*sin(1.8*x+pi/3);

noise = [zeros(1,211), ones(1,90)].*(rand(1,301)*20+100);
i = randperm(301);
noise = noise(i);
z = y+noise;

clean_med = zeros(1,301);
% moving median
for j = 1:301
    clean_med(j) = median(z(max(1,j-8):min(301,j+8)));
end
disp('Relative m.s.e. (moving median)(30% corruption)')
display(sum((clean_med-y).^2)/sum(y.^2));

clean_mean = zeros(1,301);
% moving mean
for j = 1:301
    clean_mean(j) = mean(z(max(1,j-8):min(301,j+8)));
end
disp('Relative m.s.e. (moving mean)(30% corruption)')
display(sum((clean_mean-y).^2)/sum(y.^2));

clean_quart = zeros(1,301);
% moving quartile
for j = 1:301
    clean_quart(j) = prctile(z(max(1,j-8):min(301,j+8)),25);
end
disp('Relative m.s.e. (moving quartile)(30% corruption)')
display(sum((clean_quart-y).^2)/sum(y.^2));

figure;
plot(x,y,x,z,x,clean_med,x,clean_mean,x,clean_quart);
title('30% corruption');
legend('orignal','corrupted','median','mean','quartile')
set(gca,'DataAspectRatio', [1 60 1]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

noise = [zeros(1,121), ones(1,180)].*(rand(1,301)*20+100);
i = randperm(301);
noise = noise(i);
z = y+noise;

clean_med = zeros(1,301);
% moving median
for j = 1:301
    clean_med(j) = median(z(max(1,j-8):min(301,j+8)));
end
disp('Relative m.s.e. (moving median)(60% corruption)')
display(sum((clean_med-y).^2)/sum(y.^2));

clean_mean = zeros(1,301);
% moving mean
for j = 1:301
    clean_mean(j) = mean(z(max(1,j-8):min(301,j+8)));
end
disp('Relative m.s.e. (moving mean)(60% corruption)')
display(sum((clean_mean-y).^2)/sum(y.^2));

clean_quart = zeros(1,301);
% moving quartile
for j = 1:301
    clean_quart(j) = prctile(z(max(1,j-8):min(301,j+8)),25);
end
disp('Relative m.s.e. (moving quartile)(60% corruption)')
display(sum((clean_quart-y).^2)/sum(y.^2));

figure;
plot(x,y,x,z,x,clean_med,x,clean_mean,x,clean_quart);
title('60% corruption');
legend('orignal','corrupted','median','mean','quartile')
set(gca,'DataAspectRatio', [1 60 1]);
