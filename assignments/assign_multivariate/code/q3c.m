clc;clear;
s=load("points2D_Set2.mat");
x=s.x;
y=s.y;
coeffficient = polyfit(x, y, 1);
value = polyval(coeffficient, x);
scatter(x,y);

hold on

plot(x,value);
xlabel("X axis");
ylabel("Y axis");
title("plot for part c of q3");
legend("scatter plot","line graph");
hold off;