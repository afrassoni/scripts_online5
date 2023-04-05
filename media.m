clear all;
close all;
dado=load("tabela_RMS_EN_cte.txt");
a1=dado(1:5,4);
clear x;
x=dado(find(dado(:,4)==a1(1)),1);
a2=x(1:5);

idx=1;
for i=1:size(a2)
   for j=1:size(a1)
   md(idx,:)=mean(dado(find(dado(:,1)==a2(i)&dado(:,4)==a1(j)),:));
   idx=idx+1;
   end
end

fileID = fopen('media_exp.txt','w');
for i=1:size(a1)*size(a2)
   fprintf(fileID,"%5d %5d %5d %5d %5d %9.5f %9.5f\n",i,md(i,:));
end
