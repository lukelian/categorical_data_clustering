function [AC,PR,RE]=Three_measure(data,n)
% ******** Author :  Fuyuan Cao
% ******** Data   : 2009-02-17
% ******** Function*************
% Data是类结果分布矩阵(行：原始标签角度，列：聚类得到标签角度) 即:Generate_Cluster_Matrix产生的label
% 分布矩阵的第一列表示实际类的分布数，剩余的每一列表示聚类后的结果在不同类中的分布
% n是数据集的对象数
% 问题，如果在某一列中出现两个相同的值，程序还没有考虑
[r,c]=size(data);

%计算精度，从聚类得到标签的角度看，即每一列的最大值累加除以对象个数
accuracy=0;
for i=2:c
    accuracy=accuracy+max(data(:,i));
end
AC=accuracy/n;

%计算纯度，从聚类得到标签的角度看，即每一列的最大值除以该列的和，然后累加
precision=0;
for i=2:c
   aa=max(data(:,i));
   bb=sum(data(:,i));
   precision=precision+aa/bb;
end
%PR=precision/r;
PR=precision/(c-1);  %是否除以聚类新得到的类个数比较合理？

%计算召回率，从原始类标签角度看，即每一行的最大值除以该行的和，然后累加???
% recall=0;
% for i=1:r
%     recall=recall+max(data(i,[2:c]))/data(i,1);
% end
% RE=recall/r;

%计算召回率，从聚类得到标签的角度看，即每一列的最大值除以该最大值所在行的和，然后累加
recall=0;
for i=2:c
    [value,index]=max(data(:,i));
    recall=recall+value/data(index,1);
end
RE=recall/(c-1);