clear;clc;
xyz = readmatrix('XYZ.txt');
x = xyz(:,1); y = xyz(:,2); z = xyz(:,3);

m = [[sum(x.^2),sum((x).*(y)),sum((x))];
    [sum((x).*(y)),sum(y.^2),sum((y))];
    [sum((x)),sum((y)),2000]];

b = [sum((z).*(x));sum((z).*(y));sum((z))];

a = linsolve(m,b);

j = 1;
for i=a'
    fprintf('a_%d = %f \n',[j,i]);
    j=j+1;
end

var = sum((z-a(1,1)*x-a(2,1)*y-a(3,1)).^2)/2000;
fprintf('ML estimate of variance is %f',var);
