function Distance=Distance_of_Categorical(Data1,Data2)
% Author Fuyuan Cao
% Data : 2008-02-13
% Function :
% ��������������ͬ�����еľ����У���ͬ�еľ���
[row,column]=size(Data1);
    Distance=0;
    for j=1:column
        if Data1(1,j)~=Data2(1,j)
            Distance=Distance+1;
        end;
    end;

        

