clear y
close all

%load nn.mat
data_counter =0;
True_Abnormal=0;
False_Abnormal=0;
True_Normal=0;
False_Normal=0;
lamda=0.09;
   
%% Normal Test

for i = 1:155
 clear y
 File = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/newDataset/new_Normal copy', ['nsampleacl (' num2str(i) ').mat']);  
% File= fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Normal copy', ['nsampleacl (' num2str(i) ').mat']);
 load(File)
 y=nsample_acl_1(:,2);
 %y=sqrt(nsample_acl_1(:,1).^2+nsample_acl_1(:,2).^2+nsample_acl_1(:,3).^2);

y=y';

Ypred=kpredict('nnarx',NetDef,NN,K,W1,W2,y);
Npred=length(Ypred);

RMSE_Normal(i)=sqrt(norm(y(na+1:end)-Ypred)^2/(Npred));
FIT_Normal(i)=1-norm(y(na+1:end)-Ypred,2)/norm(y(na+1:end)-mean(y));


    if FIT_Normal(i)>lamda
        True_Normal=True_Normal+1;
    else
        False_Normal=False_Normal+1;
    end
    
data_counter = data_counter +  53 
end

%% Abnormal Test
tf=0

for i = 1:155
     
 clear y
  File = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/newDataset/new_Abnormal copy', ['nsampleacl (' num2str(i) ').mat']);  
% File= fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Abnormal copy', ['nsampleacl (' num2str(i) ').mat']);
 load(File)
 
tic
y=nsample_acl_1(:,2); 
%y=sqrt(nsample_acl_1(:,1).^2+nsample_acl_1(:,2).^2+nsample_acl_1(:,3).^2);
 
y=y';

Ypred=kpredict('nnarx',NetDef,NN,K,W1,W2,y);

timeElapsed =  toc;
tf = tf + timeElapsed

Npred=length(Ypred);
RMSE_Abnormal(i)=sqrt(norm(y(na+1:end)-Ypred)^2/(Npred));
FIT_Abnormal(i)=1-norm(y(na+1:end)-Ypred,2)/norm(y(na+1:end)-mean(y)); 

    if FIT_Abnormal(i)<lamda
        True_Abnormal=True_Abnormal+1;
    else
        False_Abnormal=False_Abnormal+1;
    end
    
end

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

%figure,
%plot(RMSE_Normal)
%hold on
%plot(RMSE_Abnormal)

%figure,
%plot(FIT_Normal)
%hold on
%plot(FIT_Abnormal)

True_Abnormal
False_Abnormal

True_Normal
False_Normal


Accuracy_Abnormal=True_Abnormal/155
Accuracy_Normal=True_Normal/155
Accuracy=(True_Abnormal+True_Normal)/310

data_counter