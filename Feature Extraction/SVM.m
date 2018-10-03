clc
clear all 
close all
fileID = fopen('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/svm.arff','a');
tf=0;
data_counter=0;
for a=1:155 
%File = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Abnormal copy', ['nsampleacl (' num2str(a) ').mat']);  
File = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Normal copy', ['nsampleacl (' num2str(a) ').mat']);
load(File)    
    
%str='nsampleacl_';
%str1 = num2str(a);
%str2=strcat(str,str1);
%str3=strcat(str2,'.mat');

%if (exist(str3, 'file')  == 2)
%    continue;

    %load (str3);
%disp(a)
%else
%continue
%end
tic
acl_sample_1 = nsample_acl_1;
ta  = nsample_acl_1 ;

x = ta(:,1);
y = ta(:,2);
z = ta(:,3);

SVM = sqrt(sum(x.^2 + y.^2 + z.^2, 2));
%SVM = nsample_acl_1(1:size(nsample_acl_1,1),2);
%fprintf(fileID,'%6.2f \r\n', SVM);

%SMA = (1/10)*(trapz(x) + trapz(y) + trapz(z));
SMA = (1/10)*(trapz(nsample_acl_1) + trapz(nsample_acl_1) + trapz(nsample_acl_1));

derivate_magnitude = diff(SVM);
max_amplitude = max(SVM)-min(SVM);
max_derivative_magnitude = max(diff(SVM));
[pks, locs] = findpeaks(SVM, 'MinPeakProminence', 0.3 );
max_peak_2_peak_derivative =  max(diff(SVM)) - min(diff(SVM));
max_peak_2_peak_amplitude = max(diff(pks)) - min(diff(pks));
%SVM = SVM(1:end-1);
Energy = trapz(SVM);
%Mob_A = sqrt ( var(diff(SVM)) / var(SVM) );
%Com_A = sqrt ( var( diff( diff(SVM) ) ) / var( diff(SVM) ) ) / Mob_A ;

b =  [  SMA   max_amplitude  max_derivative_magnitude  max_peak_2_peak_derivative   max_peak_2_peak_amplitude    Energy   ];

%b =  [  Energy Mob_A Com_A  ];
data_counter= data_counter + 6 ;
timeElapsed =  toc;
tf=tf + timeElapsed 
fprintf(fileID,'%6.2f %6.2f %6.2f %6.2f %6.2f %6.2f  n \r\n', b);

end

data_counter
