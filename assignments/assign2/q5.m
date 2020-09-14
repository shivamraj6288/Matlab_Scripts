clc; clear;
p = [0.05 0.4 0.15 0.3 0.1];
pd = makedist('Multinomial','Probabilities',p);
samples = 1000;
mad = zeros(10,1);
i=1;
for N = [5 10 20 50 100 200 500 1000 5000 10000]
    list = random(pd,samples,N);
    mean_list = mean(list,2);
    % in the following line change 'off' to 'on' if you want to see figures
    f=figure('visible','off');
    set(gca,'DataAspectRatio', [20 20 1]);
    histogram(mean_list, 50);
    title(sprintf('N = %d',N));
    % remove the following line if you do not want to save the figures
    saveas(f, sprintf('p1_%d.jpg', N));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    f=figure('visible','off');
    set(gca,'DataAspectRatio', [20 20 1]);
    [cdf, x] = ecdf(mean_list);
    gcdf = normcdf(x,3,sqrt(1.3/N));% calculated that mu=3 sigma=sqrt(1.30/N)
    plot(x,cdf,x,gcdf);
    legend('Empirical CDF','Gaussian CDF');
    title(sprintf('N = %d',N));
    % remove the following line if you do not want to save the figures
    saveas(f, sprintf('p2_%d.jpg', N));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    maxdiff = max(max(abs(gcdf-cdf)));
    mad(i) = maxdiff;
    i=i+1;
end

% in the following line change 'off' to 'on' if you want to see figures
f=figure('visible','off');
vals = {'5' ;'10'; '20'; '50'; '100'; '200'; '500'; '1000'; '5000'; '10000'};
plot(mad);
set(gca, 'XTick', 1:10, 'XTickLabel', vals);
title('Variation of MAD for different values of N');
% remove the following line if you do not want to save the figures
saveas(f, 'p3.jpg');
