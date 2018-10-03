clc
clear all
close all
%xa = zeros(,1) ya = zeros(18,1) za = zeros(18,1) xg = zeros(18,1) yg =
%zeros(18,1) zg = zeros(18,1)
for counter=1:155
clear nsample_acl_1;
clear nsample_gyr_1;
File1 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Abnormal copy', ['nsampleacl (' num2str(counter) ').mat']);
%File1 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Normal copy', ['nsampleacl (' num2str(counter) ').mat']);
load(File1)
File2 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Abnormal copy', ['nsamplegyr (' num2str(counter) ').mat']);
%File2 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/Dataset/Normal copy', ['nsamplegyr (' num2str(counter) ').mat']);
load(File2)  


%File3 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/newDataset/Normal copy', ['nsampleacl (' num2str(counter) ').mat']);
%File4 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/newDataset/Normal copy', ['nsamplegyr (' num2str(counter) ').mat']);

File3 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/newDataset/Abnormal copy', ['nsampleacl (' num2str(counter) ').mat']);
File4 = fullfile('/Users/masoudhemmatpour/Google Drive/PHD-Research/OPLON/Narx/newDataset/Abnormal copy', ['nsamplegyr (' num2str(counter) ').mat']);


if (exist ('nsample_acl_1') && exist ('nsample_gyr_1') )    
    
if (size(nsample_acl_1,2)>3)
    nsample_acl_1 = Acl(1:size(Acl,1),2:4);
    nsample_gyr_1 = Gyr(1:size(Gyr,1),2:4);
%    nsample_acl_1 = Acl;
%    nsample_gyr_1 = Gyr;
end

ac  = nsample_acl_1 ;
gr  = nsample_gyr_1 ; 

xa = ac(:,1);
ya = ac(:,2);
za = ac(:,3);

xg = gr(:,1);
yg = gr(:,2);
zg = gr(:,3);


clear nsample_acl_1;
clear nsample_gyr_1;

nsample_acl_1 = sqrt(sum(xa.^2 + ya.^2 + za.^2, 2));
nsample_gyr_1 = sqrt(sum(xg.^2 + yg.^2 + zg.^2, 2));

save (File3, 'nsample_acl_1') ;
save (File4, 'nsample_gyr_1') ;

%saveas(gcf,'last.tif');
else
    
if (size(Acl,2)>3)
    nsample_acl_1 = Acl(1:size(Acl,1),2:4);
   if (exist ('Gyr'))
    nsample_gyr_1 = Gyr(1:size(Gyr,1),2:4);
   else
    tmp = nsample_gyr_1(1:size(nsample_gyr_1,1),2:4);
    clear nsample_gyr_1;
    nsample_gyr_1=tmp;
   end    
end    
ac  = nsample_acl_1 ;
gr  = nsample_gyr_1 ; 

xa = ac(:,1);
ya = ac(:,2);
za = ac(:,3);

xg = gr(:,1);
yg = gr(:,2);
zg = gr(:,3);

clear nsample_acl_1;
clear nsample_gyr_1;

nsample_acl_1 = sqrt(sum(xa.^2 + ya.^2 + za.^2, 2));
nsample_gyr_1 = sqrt(sum(xg.^2 + yg.^2 + zg.^2, 2));

save (File3, 'nsample_acl_1') ;
save (File4, 'nsample_gyr_1') ;    
    
end

end
