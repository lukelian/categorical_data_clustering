function [dataset]=Distance_of_Categorical(Data1,Data2)
% Author Fuyuan Cao
% Data : 2008-02-13
% Function :
% ��������������ͬ�����еľ����У���ͬ�еľ���
[row,column]=size(Data1);
dataset=[];
for i = 1:row
    Distance=0;
    for j=1:column
        if Data1(i,j)~=Data2(i,j)
            Distance=Distance+1;
        end;
    end;
   dataset=cat(1,dataset, [i,Distance]);
end;
        

