clear all
close all
clc

%===============================Initialize==================================
% in the "NARX" we minimize the prediction error but in "noe" we minimize the
% simulation error  ( in the sense that previous output can be real
% measured values but the simulated values )  for simulation NOE works
% better than NARX

y=[];
for i = 1:73
%Fileacl= fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Hemmat/NEW/Normal', ['nsampleacl (' num2str(i) ').mat']);
%Filegyr= fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Hemmat/NEW/Normal', ['nsamplegyr (' num2str(i) ').mat']);
File = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Normal', ['nsampleacl (' num2str(i) ').mat']);
load(File)
%load(Filegyr)
%y= [y;nsample_acl_1(:,2)];
%y=[y; sqrt(nsample_gyr_1(:,3).^2+nsample_gyr_1(:,2).^2+nsample_gyr_1(:,1).^2)];
y=[y; sqrt(nsample_acl_1(:,3).^2+nsample_acl_1(:,2).^2+nsample_acl_1(:,1).^2)];
end
y=y;

K=1;                       % K step Prediction
BasisFunc=10              % Max Basis Function
Order=8                  % Maximum Model Order na,nb

L=length(y);

ye=y';
yv=y';

%=============================Identification================================
L1=length(ye);
L2=length(yv);


c=fix(clock);
fprintf('Identification started at %2i.%2i.%2i\n',c(4),c(5),c(6));

        
NetDef = ['H';'L']; %   Each H corespond to one basis function H means it is Sigmoid function - Each L means the output 
for i=1:BasisFunc-1;
    NetDef = [NetDef ['H';'-']];
end
% if we increase the number of basis function we may face overfitting 
na=Order;

NN=[na];  % na = number of past values of output (y)  nb = number of pas values of u  nk = the number of foward predicted value.   [na  nb nk]
trparms=settrain; % this and next are choose to find an optimization algorithm 
trparms=settrain(trparms,'maxiter',500);

%[W1,W2]=nnarx(NetDef,NN,[],[],trparms,ye); % the two [] [] are not important can be free the last parameter are the data 
 % W1 and W2 are the coefficients of the mdodel 

 %a1 = W1 (:, 1:end-1); this is the alpha1
 %b1 = W (:, end);    this is the beta1
 
model=arx([y ones(length(y),1)],[Order 0 0])
Ypred = compare([y ones(length(y),1)], model, 1); 
Ypred=Ypred';


%Ypred=kpredict('nnarx',NetDef,NN,K,W1,W2,yv);

Npred=length(Ypred);


c=fix(clock);
fprintf('\nIdentification ended at %2i.%2i.%2i\n',c(4),c(5),c(6));

%============================Find Best Model===============================

%RMSEp=sqrt(norm(yv(na+1:end)-Ypred)^2/(Npred));
%FIT_p=1-norm(yv(na+1:end)-Ypred,2)/norm(yv(na+1:end)-mean(ye))

RMSEp=sqrt(norm(yv-Ypred)^2/(Npred));
FIT_p=1-norm(yv-Ypred,2)/norm(yv-mean(ye))

%==================================Plot=====================================

%figure,grid on,hold on ,plot(1:L2,yv,na+1:L2,Ypred,'r','LineWidth',2),legend('data','Model')

%save nn.mat W1 W2 K NN NetDef na