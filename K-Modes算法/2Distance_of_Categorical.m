function [dataset]=Distance_of_Categorical_new(valuerow,Data)
% valuerow����data����ͬ�е�һ��
% Function :
% ����k-modes�㷨�У�����һ�����������modes֮��ľ���
[row,column]=size(Data);
dataset=[];
for i = 1:row
    Distance=0;
    for j=1:column
        if valuerow(j)~=Data(i,j)
            Distance=Distance+1;
        end;
    end;
   dataset=cat(1,dataset, [i,Distance]);
end;
        