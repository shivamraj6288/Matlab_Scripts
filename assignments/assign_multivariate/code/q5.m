clear;
close all;
rng(1);
file=load('mnist.mat');
dtest=file.digits_test;
ltest=file.labels_test;
dtrain=file.digits_train;
ltrain=file.labels_train;
reshaped_matrix=reshape(dtest,28*28,[]);
reshaped_matrix=double(reshaped_matrix);
for i=0:9
	figure(i+1);
	image_found=reshaped_matrix(:,ltest==i);
	final_matrix=image_found(:,1);
	changed_image=mynewfunc(ltrain,dtrain,i,final_matrix);
	final_matrix=reshape(final_matrix,28,28);
	final_matrix=uint8(final_matrix);
	changed_image=reshape(changed_image,28,28);
	changed_image=uint8(changed_image);
	subplot(1,2,1),imshow(final_matrix);title('Real Image');
	subplot(1,2,2),imshow(changed_image);title('Change Image');
end

function [out1,out2,out3]=myfunc(A,B,x,I)
	reshape_matrix=reshape(B,28*28,[]);
	reshape_matrix=double(reshape_matrix);
	C=reshape_matrix(:,A==x);
	c_transpose=C.';
	mean1=mean(c_transpose);
	mean2=mean1.';
	covariance_c=cov(c_transpose);
	[R,C]=eig(covariance_c);
	[~,index]=sort(diag(C),'descend');
	aftersorted=R(:,index);
	result=aftersorted(:,1:84);
	out1=result;
	myvar=(result.')*(I-mean2);
	out2=myvar;
	out3=mean2;
end

function g=mynewfunc(A,B,x,I)
	[o1,o2,o3]=myfunc(A,B,x,I);
	myvar=o1*o2;
	myvar=myvar+o3;
	g=myvar;
end

