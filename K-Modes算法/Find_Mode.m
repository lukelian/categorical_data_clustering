function [Mode]=Find_Mode(Data)
% ����˵�� ��Data Ϊ��������ݼ�
% Function : �õ�һ�����ݼ��ϵ�mode
[row,column]=size(Data);
Mode=[];
for i=1:column
    ColumnValue=unique(Data(:,i));% �õ�ÿһ���в�ͬ������ֵ
    [Colrow, ColCol]=size(ColumnValue) ;% �õ����в�ͬ����ֵ��ά��
    %Colrow��ֵ��ʾ������һ���ж��ٸ���ͬ������ֵ
    %ColCol��ֵʼ�ն���1
    ColumnValueSum=0;                                                        %�Ľ�������ɾ�� 
    dataset=[];
    for j=1:Colrow
       [Rowresult,Colresult]=size(find(Data(:,i)==ColumnValue(j,1)));        %����find(Data(:,i)==ColumnValue(j,i))
      %Data(:,i)��ʾ��i�У�ColumnValue(j,1)��ʾ�����е�һ������ֵ
      %Rowresult��ֵ��ʾColumnValue(j,1)�������ֵ����ԭ����һ���г��ֵĴ���
      %Colresult��ֵʼ����1
       dataset=cat(1,dataset,[ColumnValue(j,1),Rowresult]);                  %����cat(1,dataset,[ColumnValue(j,i),Rowresult])
    end;
    [MaxValue,Maxrow]=max(dataset(:,2));                                     
    Mode(1,i)=ColumnValue(Maxrow,1);                                         %����ColumnValue(Maxrow,i)
end;


                                                                             %�᲻�ᷢ���еĴ�λ  ���������������
       
        
    
    