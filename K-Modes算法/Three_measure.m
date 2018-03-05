function [AC,PR,RE]=Three_measure(data,n)
% ******** Author :  Fuyuan Cao
% ******** Data   : 2009-02-17
% ******** Function*************
% Data�������ֲ�����(�У�ԭʼ��ǩ�Ƕȣ��У�����õ���ǩ�Ƕ�) ��:Generate_Cluster_Matrix������label
% �ֲ�����ĵ�һ�б�ʾʵ����ķֲ�����ʣ���ÿһ�б�ʾ�����Ľ���ڲ�ͬ���еķֲ�
% n�����ݼ��Ķ�����
% ���⣬�����ĳһ���г���������ͬ��ֵ������û�п���
[r,c]=size(data);

%���㾫�ȣ��Ӿ���õ���ǩ�ĽǶȿ�����ÿһ�е����ֵ�ۼӳ��Զ������
accuracy=0;
for i=2:c
    accuracy=accuracy+max(data(:,i));
end
AC=accuracy/n;

%���㴿�ȣ��Ӿ���õ���ǩ�ĽǶȿ�����ÿһ�е����ֵ���Ը��еĺͣ�Ȼ���ۼ�
precision=0;
for i=2:c
   aa=max(data(:,i));
   bb=sum(data(:,i));
   precision=precision+aa/bb;
end
%PR=precision/r;
PR=precision/(c-1);  %�Ƿ���Ծ����µõ���������ȽϺ���

%�����ٻ��ʣ���ԭʼ���ǩ�Ƕȿ�����ÿһ�е����ֵ���Ը��еĺͣ�Ȼ���ۼ�???
% recall=0;
% for i=1:r
%     recall=recall+max(data(i,[2:c]))/data(i,1);
% end
% RE=recall/r;

%�����ٻ��ʣ��Ӿ���õ���ǩ�ĽǶȿ�����ÿһ�е����ֵ���Ը����ֵ�����еĺͣ�Ȼ���ۼ�
recall=0;
for i=2:c
    [value,index]=max(data(:,i));
    recall=recall+value/data(index,1);
end
RE=recall/(c-1);