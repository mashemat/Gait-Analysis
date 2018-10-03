clear y
close all

%load nn.mat

True_Abnormal=0;
False_Abnormal=0;
True_Normal=0;
False_Normal=0;
lamda=0.03;

%% Normal Test

for i = 1:145
 clear y
 File= fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Normal copy', ['nsampleacl (' num2str(i) ').mat']);
 load(File)
% y=sqrt(nsample_acl_1(:,1).^2+nsample_acl_1(:,2).^2+nsample_acl_1(:,3).^2);
y=sqrt(nsample_acl_1(:,3).^2+nsample_acl_1(:,2).^2+nsample_acl_1(:,1).^2);

y= sqrt(nsample_acl_1(:,3).^2+nsample_acl_1(:,2).^2);

y=y;

Ypred = compare([y ones(length(y),1)], model, 1);
Ypred=Ypred;
Npred=length(Ypred);

 
RMSE_Normal(i)=sqrt(norm(y-Ypred)^2/(Npred));
FIT_Normal(i)=1-norm(y-Ypred,2)/norm(y-mean(y));

%Ypred=kpredict('nnarx',NetDef,NN,K,W1,W2,y);
%Npred=length(Ypred);

%RMSE_Normal(i)=sqrt(norm(y(na+1:end)-Ypred)^2/(Npred));
%FIT_Normal(i)=1-norm(y(na+1:end)-Ypred,2)/norm(y(na+1:end)-mean(y));


    if FIT_Normal(i)>lamda
        True_Normal=True_Normal+1;
    else
        False_Normal=False_Normal+1;
    end

end

%% Abnormal Test
tic
for i = 1:150
 clear y
 File= fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Abnormal copy', ['nsampleacl (' num2str(i) ').mat']);
 load(File)
 y=sqrt(nsample_acl_1(:,3).^2+nsample_acl_1(:,2).^2+nsample_acl_1(:,1).^2);

y=y;

%Ypred=kpredict('nnarx',NetDef,NN,K,W1,W2,y);

Ypred = compare([y ones(length(y),1)], model, 1);
Ypred=Ypred;
Npred=length(Ypred);

%RMSE_Abnormal(i)=sqrt(norm(y(na+1:end)-Ypred)^2/(Npred));
%FIT_Abnormal(i)=1-norm(y(na+1:end)-Ypred,2)/norm(y(na+1:end)-mean(y));
 
RMSE_Abnormal(i)=sqrt(norm(y-Ypred)^2/(Npred));
FIT_Abnormal(i)=1-norm(y-Ypred,2)/norm(y-mean(y));
 

    if FIT_Abnormal(i)<lamda
        True_Abnormal=True_Abnormal+1;
    else
        False_Abnormal=False_Abnormal+1;
    end

end
el=toc
%% plot 

figure,
plot(RMSE_Normal,':','DisplayName','Normal','LineWidth',3)
hold on
plot(RMSE_Abnormal,'DisplayName','Abnormal','LineWidth',3)
title('RMSE of Normal and Abnormal walks')
legend('show')

figure,
plot(FIT_Normal,':','DisplayName','Normal','LineWidth',3)
hold on
plot(FIT_Abnormal,'DisplayName','Abnormal','LineWidth',3)
title('FIT of Normal and Abnormal walks')
legend('show')


True_Abnormal
False_Abnormal


True_Normal
False_Normal

Accuracy_Abnormal=True_Abnormal/150
Accuracy_Normal=True_Normal/145
Accuracy=(True_Abnormal+True_Normal)/295
