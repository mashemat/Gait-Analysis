clear all
close all
clc


%===============================Initialize==================================

y=[];
for i = 1:100
 
File = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/newDataset/new_Normal copy', ['nsampleacl (' num2str(i) ').mat']);  
% File= fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Normal', ['nsampleacl (' num2str(i) ').mat']);
 load(File)
 y = [y; nsample_acl_1(:,2)]
% y=[y; sqrt(nsample_acl_1(:,1).^2+nsample_acl_1(:,2).^2+nsample_acl_1(:,3).^2)];

end
y=y;

K=1;                            % K step Prediction
BasisFunc=20                    % Max Basis Function
Order=10                    % Maximum Model Order na,nb

L=length(y);

ye=y';
yv=y';

%=============================Identification================================
L1=length(ye);
L2=length(yv);


c=fix(clock);
fprintf('Identification started at %2i.%2i.%2i\n',c(4),c(5),c(6));

        
NetDef = ['H';'L'];
for i=1:BasisFunc-1;
    NetDef = [NetDef ['H';'-']];
end

na=Order;

NN=[na];
trparms=settrain;
trparms=settrain(trparms,'maxiter',500);

[W1,W2]=nnarx(NetDef,NN,[],[],trparms,ye);

Ypred=kpredict('nnarx',NetDef,NN,K,W1,W2,yv);

Npred=length(Ypred);

c=fix(clock);
fprintf('\nIdentification ended at %2i.%2i.%2i\n',c(4),c(5),c(6));

%============================Find Best Model===============================

RMSEp=sqrt(norm(yv(na+1:end)-Ypred)^2/(Npred));
FIT_p=1-norm(yv(na+1:end)-Ypred,2)/norm(yv(na+1:end)-mean(ye))

%==================================Plot=====================================

figure,grid on,hold on ,plot(1:L2,yv,na+1:L2,Ypred,'r'),legend('data','predicted')

save nn.mat W1 W2 K NN NetDef na