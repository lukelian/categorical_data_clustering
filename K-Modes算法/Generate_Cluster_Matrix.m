function label=Generate_Cluster_Matrix(Data,Decision)
% ************************* Author :  Fuyuan Cao
% ************************* Data   : 2008-03-05
% ************************* Function
% 生成类分布矩阵
%  Data : 聚类以后的结果 产生的决策值
%  Decision : 实际的决策结果
[row, column]=size(Data);
%计算实际的聚类标签
%????????????????????????????
 DecisionCluster=unique(Decision); % 类别数
 [decrow,deccol]=size(DecisionCluster);
 %计算每一个类别值在Decision中出现的对象数
  DataCluster=unique(Data); % 类别数
 [datarow,datacol]=size(DataCluster);
 label=[];
 tempmatrix=[];
 for i=1:decrow
     Dectemp=find(Decision==DecisionCluster(i));    
     temp=length(Dectemp);                          %位于相同类的个数
     tempmatrix=[];
     for j=1:datarow                                %1—非相同类
         Datatemp=find(Data==DataCluster(j));
         tempmatrix=cat(2,tempmatrix,length(intersect(Dectemp,Datatemp)));
     end;
 
     templabel=cat(2,temp,tempmatrix);
     label=cat(1,label,templabel);
 end;
 