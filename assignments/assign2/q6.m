clc;clear;

cor_cof = zeros(21,1);
quadMutInf = zeros(21,1);
image1 = double(imread('T1.jpg'));
image2 = double(imread('T2.jpg'));
i=1;
[rs,cs] = size(image2);
x = (-10:10);
for tx=-10:10
    shift_image2 = imtranslate(image2,[tx,0]);  % shifting the image
    if tx<0
        shift_image2(:,cs+tx+1:cs) = 0;
    elseif tx>0
        shift_image2(:,1:tx) = 0;
    end
    corr = corrcoef(image1(:),shift_image2(:));  % computing correlation coficient
    cor_cof(i) = corr(1,2);
    val=joint_histogram(floor(image1/10),floor(shift_image2/10));
    m1 = marginal_1(val);
    m2 = marginal_2(val);
    quadMutInf(i) = quad_mut_ind(val,m1,m2);  % computing Quadratic Mutual Information
    i = i+1;
end

plot(x,cor_cof,'b')
xlabel('tx');
ylabel('r(x,y)');
title('correlation cofficient vs tx');
saveas(gcf,'cor_cof1.png')
pause(1);
plot(x,quadMutInf,'r')
xlabel('tx');
ylabel('QMI(x,y)');
title('quadratic mutual independence vs tx');
saveas(gcf,'quadMutInf1.png')
pause(1);

cor_cof2 = zeros(21,1);
quadMutInf2 = zeros(21,1);
i=1;
rev_image1 = 255-image1;

% repeating same steps

for tx=-10:10
    shift_rev_image1 = imtranslate(rev_image1,[tx,0]);
    if tx<0
        shift_rev_image1(:,cs+tx+1:cs) = 0;
    elseif tx>0
        shift_rev_image1(:,1:tx) = 0;
    end
    corr = corrcoef(image1(:),shift_rev_image1(:));
    cor_cof2(i) = corr(1,2);
    val2=joint_histogram(floor(image1/10),floor(shift_rev_image1/10));
    m1 = marginal_1(val2);
    m2 = marginal_2(val2);
    quadMutInf2(i) = quad_mut_ind(val2,m1,m2);
    i = i+1;
end

plot(x,cor_cof2,'b')
xlabel('tx');
ylabel('r(x,y)');
title('correlation cofficient vs tx');
saveas(gcf,'cor_cof2.png')
pause(1);
plot(x,quadMutInf2,'r')
xlabel('tx');
ylabel('QMI(x,y)');
title('quadratic mutual independence vs tx');
saveas(gcf,'quadMutInf2.png')
pause(1);

function val=marginal_2(val)
    val=sum(val,1);
end


function val=marginal_1(val)
    val=sum(val,2);
end


function quadMutInf=quad_mut_ind(val,marginal1,marginal2)
    quadMutInf_arr = (val-marginal1*marginal2).^2;
    quadMutInf = sum(sum(quadMutInf_arr));
end

function val=joint_histogram(x,y)  % finding joint_histogram
rows = size(x,1);
cols = size(y,2);
N=26;
val=zeros(N,N);
for i=1:rows   
  for j=1:cols
    val(x(i,j)+1,y(i,j)+1)= val(x(i,j)+1,y(i,j)+1)+1;
  end
end
val = double(val);
m = sum(sum(val));
val = val/m;
end
