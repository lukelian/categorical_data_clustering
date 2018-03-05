function [Mode]=Find_Mode(Data)
% 参数说明 ：Data 为输入的数据集
% Function : 得到一个数据集合的mode
[row,column]=size(Data);
Mode=[];
for i=1:column
    ColumnValue=unique(Data(:,i));% 得到每一列中不同的属性值
    [Colrow, ColCol]=size(ColumnValue) ;% 得到该列不同属性值的维数
    %Colrow的值表示该列中一共有多少个不同的属性值
    %ColCol的值始终都是1
    ColumnValueSum=0;                                                        %改进：可以删除 
    dataset=[];
    for j=1:Colrow
       [Rowresult,Colresult]=size(find(Data(:,i)==ColumnValue(j,1)));        %错误：find(Data(:,i)==ColumnValue(j,i))
      %Data(:,i)表示第i列，ColumnValue(j,1)表示该列中的一个属性值
      %Rowresult的值表示ColumnValue(j,1)这个属性值在它原来那一列中出现的次数
      %Colresult的值始终是1
       dataset=cat(1,dataset,[ColumnValue(j,1),Rowresult]);                  %错误：cat(1,dataset,[ColumnValue(j,i),Rowresult])
    end;
    [MaxValue,Maxrow]=max(dataset(:,2));                                     
    Mode(1,i)=ColumnValue(Maxrow,1);                                         %错误：ColumnValue(Maxrow,i)
end;


                                                                             %会不会发生行的错位  解决：虚拟类中心
       
        
    
    