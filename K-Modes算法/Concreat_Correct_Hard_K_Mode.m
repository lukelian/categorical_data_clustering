function [cid]=Concreat_Correct_Hard_K_Mode(Data,K)
% ����˵�� ��Data Ϊ��������ݼ������������ǩ��,KΪҪ�����ĸ�����cidΪ�����㷨ִ��֮������������������ǩ
% Function :ʵ��k-mode�㷨��������ɳ�ʼ��������

[n,d] = size(Data);   %������ݼ��Ķ������n�����Ը���d
 %InitialCenters = ceil(fix(rand(1,K)*n)); 

 %����while��������Ϊ(1)�жϲ�����������Ƿ���ͬ;(2)�жϲ������������Ӧ�Ķ����Ƿ���ͬ������ͬ�����²��������
 

InitialCentersno = [1,2]   %�����ʼ�����ĵ����

cid = zeros(1,n);   % cid�������֮����������������ǩ

maxgn= 1000;    %�����㷨������������
iter = 0;
InitialCenter=Data(InitialCentersno,:); %��ʼ��������     
ni=InitialCenter;
%bool=0;%����Ƿ�Ϊ��һ�ε���
while iter < maxgn
    %����ÿ�����ݵ��������ĵľ���
    %for i = 1:n
     %  if bool==0 && ~isempty(find(InitialCenters==i))  %�����ǰ��������ѡΪ��ʼ�������ģ���ֱ�Ӹ�����ǩ
     %      cid(i)=find(InitialCenters==i); 
     %      continue;
     %  end; 
    for i = 1:n 
       dist= Distance_of_Categorical(repmat(Data(i,:),K,1),ni);% ������������֮��ľ��뺯��
       [m,ind] = min(dist(:,2)); % ����ǰ����������cid��                                                         %�Ľ���[m,ind] = min(dist);����  ind = min(dist);
       cid(i) = ind;  %����ǰ���������ǩ
    end
   % bool=1;

    for i = 1:K  %�ҵ�ÿһ����������ݣ��������ǵ�Mode����Ϊ�´μ���ľ�������
        ind = find(cid==i);               
        if ~isempty(ind)
            nj(i,:)=Correct_Find_Mode(Data(ind,:));
        end
    end

    if ni==nj  %���������������ͬ����ֹ������������µ���������Ϊ��һ�ε������ļ������е���
        break;
    else
        ni=nj;
    end
 
  iter = iter + 1;%����������1
end

