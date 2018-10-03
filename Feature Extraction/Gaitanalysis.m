
% Clear all the previuos objects

clc
clear all 
close all

% Write a new file to store the feature
% "a" can be used to append the data to a file "w" can be used to write a new
fileID = fopen('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Cooc.arff','a');

% Initializing the variables

avgp=0;
avgcont=0;
avghomg=0;
avgeng=0;
avgcor=0;

Sum = [0 0 0 0 0];
echo off;
data_counter = 0
% Start to read accelerometer and gyroscope data from dataset 
tf=0;
for a=1:155 
File1 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Abnormal copy', ['nsampleacl (' num2str(a) ').mat']);
load(File1) 
File2 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Abnormal copy', ['nsamplegyr (' num2str(a) ').mat']);
load(File2)  

%for a=1:100
%str='nsampleacl_';
%str1 = num2str(a);
%str2=strcat(str,str1);
%str3=strcat(str2,'.mat');
%if (exist(str3, 'file')  == 2)
%load (str3);
%disp(a)
%else
%continue
%end

%str='nsamplegyr_';
%str1 = num2str(a);
%str2=strcat(str,str1);
%str3=strcat(str2,'.mat');
%if (exist(str3, 'file')  == 2)
%load (str3);
%disp(a)
%else
%continue
%end


%acl_P = nsample_acl_1' ;
%gyr_P = nsample_gyr_1' ;
%if size(acl_P,2) ~=  size(gyr_P,2) 
%continue;
%end

tic

if (size(nsample_acl_1,2)>3)      
 if (exist ('nsample_acl_1') && exist ('nsample_gyr_1') )
   acl_P = nsample_acl_1';
   gyr_P = nsample_gyr_1';
   if size(acl_P,2) ~=  size(gyr_P,2) 
     if size(acl_P,2) > size(gyr_P,2)
       acl_P = acl_P(2:4,1:size(gyr_P,2))
       gyr_P = gyr_P(2:4,1:size(gyr_P,2))
     else
       acl_P = acl_P(2:4,1:size(acl_P,2))
       gyr_P = gyr_P(2:4,1:size(acl_P,2))
     end     
end
end   
else  
if (exist ('nsample_acl_1') && exist ('nsample_gyr_1') )
acl_P = nsample_acl_1';
gyr_P = nsample_gyr_1';
if size(acl_P,2) ~=  size(gyr_P,2) 
  if size(acl_P,2) > size(gyr_P,2)
       acl_P = acl_P(:,1:size(gyr_P,2))
  else
       gyr_P = gyr_P(:,1:size(acl_P,2))
  end     
end
end
end

%plot(acl_P);

%   Creating Raw data matrix

K = [ acl_P ; gyr_P  ];   

 % Data should be rounded to create Co-occurrence matrix

K = round (K);    

% Creating the Co-occurrence matrix

glcm=graycomatrix(K, 'offset' , [0 1] , 'GrayLimits' , [] , 'NumLevels', max(K(:))); 
scm =sum(sum(glcm));   % computing the sum of all the elements
New = glcm / scm ;  % Computing Pij

% computing the features

p=max(max(New));   % Feature 1

res= graycoprops(glcm);  

cont= graycoprops(glcm, 'contrast');  % Feature 2

homg= graycoprops(glcm, 'homogeneity');  % Feature 3

eng= graycoprops(glcm, 'Energy');   % Feature 4

cor= graycoprops(glcm, 'Correlation');  % Feature 5

%tmpcell = struct2cell(res);  % convert struct to cell

%AA=cell2mat(tmpcell);  % convert cell to ordinary array
%avgp=avgp+p;
%avgcont=AA(1)+ avgcont;
%avghomg= AA(2)+avghomg;
%avgeng=AA(3)+avgeng;
%avgcor=AA(4)+avgcor;

Feature =[ p  cont.Contrast  homg.Homogeneity  eng.Energy  cor.Correlation ];

data_counter = data_counter + 18
%el=toc

%Sum = [ Sum ; Feature ];
%pc = pca(Sum');

%Plotting the features
%AVG = [ avgp  avgcont  avghomg  avgeng  avgcor]
%hold on;
%bar(Feature,'group')
%set(gca,'XTickLabel',{'P','Contrast','Homogeneity','Energy','Correlation'})
%grid on
%xlabel('Features')
%ylabel('Measure')


% Computing Standard Deviation

A0(:,1) = nsample_acl_1(1:end,1);
A0(:,2) = nsample_acl_1(1:end,2);
A0(:,3) = nsample_acl_1(1:end,3);
x=A0(:,[1:1]);
y=A0(:,[2:2]);
z=A0(:,[3:3]);

%Resultant= sqrt(sum(x.^2 + y.^2 + z.^2, 2));
%numIntervals = 10;
%intervalWidth = (max(Resultant) - min(Resultant))/numIntervals;
%rx = min(Resultant):intervalWidth:max(Resultant);
%ncount = histc(Resultant,rx);
%relativefreq = ncount/length(Resultant);
%sd(a)= std(rx);

% Collecting All the Features

%FF = [ Feature sd(a) ]

% Storing all the features 

timeElapsed =  toc;
tf=tf + timeElapsed 

%fprintf(fileID,'%6.2f %6.2f %6.2f %6.2f %6.2f %6.2f  a \r\n', FF);


%clear nsample_acl_1
%clear str1
%clear str2
%clear str3
clear A0
%clear FF
end

data_counter

%hold on
%bg4=bar(x  , relativefreq,2,'FaceColor',[0.1 0.5 0.1])
%bg4=plot(x,relativefreq,'LineWidth',3)
%legend({'PassoSX-Garrese','TrottoSX-Garrese','GaloppoSX-Garrese','SaltoSX-Garrese'},'Location','northeast')
%xlim([min(x) max(x)])
%hold off
%fclose(fileID);
%AVG = [ avgcont  avghomg  avgcor avgeng   avgp];
%hold on;
%bar(AVG,'group')
%set(gca,'XTickLabel',{'CoSntrast','Homogeneity','Correlation','Uniformity','Maximum'})
%grid on
%xlabel('Features')
%ylabel('Measure')
%pc = pca(Sum');
%fprintf(fileID,'%6.2f %6.2f %6.2f %6.2f a \r\n', pc);



