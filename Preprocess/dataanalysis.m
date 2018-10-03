clc
clear all
close all

Max_ax = zeros(18,1)
Max_ay = zeros(18,1)
Max_az = zeros(18,1)
Max_gx = zeros(18,1)
Max_gy = zeros(18,1)
Max_gz = zeros(18,1)

Mean_ax = zeros(18,1)
Mean_ay = zeros(18,1)
Mean_az = zeros(18,1)
Mean_gx = zeros(18,1)
Mean_gy = zeros(18,1)
Mean_gz = zeros(18,1)

Variance_ax = zeros(18,1)
Variance_ay = zeros(18,1)
Variance_az = zeros(18,1)
Variance_gx = zeros(18,1)
Variance_gy = zeros(18,1)
Variance_gz = zeros(18,1)

Low_band_ax = zeros(18,1)
Low_band_ay = zeros(18,1)
Low_band_az = zeros(18,1)
Low_band_gx = zeros(18,1)
Low_band_gy = zeros(18,1)
Low_band_gz = zeros(18,1)

High_band_ax = zeros(18,1)
High_band_ay = zeros(18,1)
High_band_az = zeros(18,1)
High_band_gx = zeros(18,1)
High_band_gy = zeros(18,1)
High_band_gz = zeros(18,1)


data_counter = 0
tf=0
 nnn=0;
 
for a=2:2 
  File1 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Band/Normal', ['nsampleacl (' num2str(a) ').mat']);
  File2 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Band/Abnormal', ['nsampleacl (' num2str(a) ').mat']);
  
% File1 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Abnormal copy', ['nsampleacl (' num2str(a) ').mat']);
% File1 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Normal copy', ['nsampleacl (' num2str(a) ').mat']);
 load(File1) 
% File2 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Abnormal copy', ['nsamplegyr (' num2str(a) ').mat']);
% File2 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Normal copy', ['nsamplegyr (' num2str(a) ').mat']);
 load(File2)  

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
  
a  = nsample_acl_1 
%b  = nsample_gyr_1 ; 
b  = asample_acl_1  


xa = a(:,1);
ya = a(:,2);
za = a(:,3);

xg = b(:,1);
yg = b(:,2);
zg = b(:,3);

%resultant = z;


%resultant = sqrt(sum(x.^2 + y.^2 + z.^2, 2));
tic

% = mean(xa([1:5:end;5:5:end;]));
%Av_ya = mean(ya([1:5:end;5:5:end;]));
%Av_za = mean(za([1:5:end;5:5:end;]));
%Av_xg = mean(xg([1:5:end;5:5:end;]));
%Av_yg = mean(yg([1:5:end;5:5:end;]));
%Av_zg = mean(zg([1:5:end;5:5:end;]));

index=1;
outsum_ax=0; 
outsum_ay=0;      
outsum_az=0;      
outsum_gx=0;      
outsum_gy=0;      
outsum_gz=0;
tmp_max_ax=0;
tmp_max_ay=0;
tmp_max_az=0;
tmp_max_gx=0;
tmp_max_gy=0;
tmp_max_gz=0;

for i = 1:size(xa,1)  % every thing can be used since the size of all are the same
    outsum_ax = outsum_ax + xa(i);
    outsum_ay = outsum_ay + ya(i);
    outsum_az = outsum_az + za(i);
    outsum_gx = outsum_gx + xg(i);
    outsum_gy = outsum_gy + yg(i);
    outsum_gz = outsum_gz + zg(i);

    if (xa(i) > tmp_max_ax )
        tmp_max_ax = xa(i);
    end    
    if (ya(i) > tmp_max_ay )
        tmp_max_ay = ya(i);
    end    
    if (za(i) > tmp_max_az )
        tmp_max_az = za(i);
    end    
    if (xg(i) > tmp_max_gx )
        tmp_max_gx = xg(i);
    end    
    if (yg(i) > tmp_max_gy )
        tmp_max_gy = yg(i);
    end
    if (zg(i) > tmp_max_gz )
        tmp_max_gz = zg(i);
    end
    
    if ( mod(i,5) == 0 ) 
        
       Mean_ax(index,1)= outsum_ax/5;
       Max_ax(index,1)= tmp_max_ax;
       Variance_ax(index,1) = tmp_max_ax - (outsum_ax/5)   ;
       Low_band_ax(index,1) = Mean_ax(index,1) - Variance_ax(index,1)
       
       Mean_ay(index,1)= outsum_ay/5;
       Max_ay(index,1)= tmp_max_ay;
       Variance_ay(index,1) = tmp_max_ay - (outsum_ay/5)   ;
       Low_band_ay(index,1) = Mean_ay(index,1) - Variance_ay(index,1)
       
       Mean_az(index,1)= outsum_az/5;
       Max_az(index,1)= tmp_max_az;
       Variance_az(index,1) = tmp_max_az - (outsum_az/5)   ;
       Low_band_az(index,1) = Mean_az(index,1) - Variance_az(index,1)
       
       Mean_gx(index,1)= outsum_gx/5;
       Max_gx(index,1)= tmp_max_gx;
       Variance_gx(index,1) = tmp_max_gx - (outsum_gx/5)   ;
       Low_band_gx(index,1) = Mean_gx(index,1) - Variance_gx(index,1)
       
       Mean_gy(index,1)= outsum_gy/5;
       Max_gy(index,1)= tmp_max_gy;
       Variance_gy(index,1) = tmp_max_gy - (outsum_gy/5)   ;
       Low_band_gy(index,1) = Mean_gy(index,1) - Variance_gy(index,1)
       
       Mean_gz(index,1)= outsum_gz/5;
       Max_gz(index,1)= tmp_max_gz;
       Variance_gz(index,1) = tmp_max_gz - (outsum_gz/5)   ;
       Low_band_gz(index,1) = Mean_gz(index,1) - Variance_gz(index,1)       
 %      High_band(index,1)= Mean(index,1) + Variance(index,1)
       index=index+1;
       outsum_ax=0; 
       outsum_ay=0;      
       outsum_az=0;      
       outsum_gx=0;      
       outsum_gy=0;      
       outsum_gz=0;      
    end    
end
timeElapsed =  toc;
tf=tf + timeElapsed 
fH = figure(1);

subplot(2,3,1);
hold on;
plot(Max_ax,'--', 'markersize', 10); 
plot(Mean_ax,':r*', 'markersize', 10); 
plot(Low_band_ax,'-.', 'markersize', 10); 

%Tl=title('Angular velocity')
Tl=title('X')
xl = xlabel('Sliding window')
yl = ylabel('Normal acceleration')
%yl = ylabel('Acceleration')
large=legend('Max','Mean','Lower band')
large.FontSize = 10;
set(large,'FontName','Times New Roman');
Tl.FontSize = 15;
set(Tl,'FontName','Times New Roman');
xl.FontSize = 15;
set(xl,'FontName','Times New Roman');
yl.FontSize = 15;
set(yl,'FontName','Times New Roman');

subplot(2,3,2);
hold on;
plot(Max_ay,'--', 'markersize', 10); 
plot(Mean_ay,':r*', 'markersize', 10); 
plot(Low_band_ay,'-.', 'markersize', 10); 


Tl=title('Y')
xl.FontSize = 15;
set(xl,'FontName','Times New Roman');
yl.FontSize = 15;
set(yl,'FontName','Times New Roman');
Tl.FontSize = 15;
set(Tl,'FontName','Times New Roman');

subplot(2,3,3);
hold on;
plot(Max_az,'--', 'markersize', 10); 
plot(Mean_az,':r*', 'markersize', 10); 
plot(Low_band_az,'-.', 'markersize', 10); 

Tl=title('Z')
xl.FontSize = 15;
set(xl,'FontName','Times New Roman');
yl.FontSize = 15;
set(yl,'FontName','Times New Roman');
Tl.FontSize = 15;
set(Tl,'FontName','Times New Roman');



subplot(2,3,4);
hold on;
plot(Max_gx,'--', 'markersize', 10); 
plot(Mean_gx,':r*', 'markersize', 10); 
plot(Low_band_gx,'-.', 'markersize', 10); 

Tl=title('X')
xl = xlabel('Sliding window')
yl = ylabel('Abnormal acceleration')
large=legend('Max','Mean','Lower band')
large.FontSize = 10;
set(large,'FontName','Times New Roman');
Tl.FontSize = 15;
set(Tl,'FontName','Times New Roman');
xl.FontSize = 15;
set(xl,'FontName','Times New Roman');
yl.FontSize = 15;
set(yl,'FontName','Times New Roman');

subplot(2,3,5);
hold on;
plot(Max_gy,'--', 'markersize', 10); 
plot(Mean_gy,':r*', 'markersize', 10); 
plot(Low_band_gy,'-.', 'markersize', 10); 


Tl=title('Y')
xl.FontSize = 15;
set(xl,'FontName','Times New Roman');
yl.FontSize = 15;
set(yl,'FontName','Times New Roman');
Tl.FontSize = 15;
set(Tl,'FontName','Times New Roman');

subplot(2,3,6);
hold on;
plot(Max_gz,'--', 'markersize', 10); 
plot(Mean_gz,':r*', 'markersize', 10); 
plot(Low_band_gz,'-.', 'markersize', 10); 

Tl=title('Z')
xl.FontSize = 15;
set(xl,'FontName','Times New Roman');
yl.FontSize = 15;
set(yl,'FontName','Times New Roman');
Tl.FontSize = 15;
set(Tl,'FontName','Times New Roman');

set(gcf, 'Units', 'Inches', 'Position', [0, 0, 10, 7], 'PaperUnits', 'Inches', 'PaperSize', [10, 7])
%print(gcf, '-dpng', 'last.tif');

saveas(gcf,'last.tif');
data_counter = data_counter + 50

end

data_counter


