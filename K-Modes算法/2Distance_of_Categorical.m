function [dataset]=Distance_of_Categorical_new(valuerow,Data)
% valuerow：与data有相同列的一行
% Function :
% 用于k-modes算法中，计算一个样本与各个modes之间的距离
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
        