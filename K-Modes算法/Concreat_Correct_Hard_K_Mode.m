function [cid]=Concreat_Correct_Hard_K_Mode(Data,K)
% 参数说明 ：Data 为输入的数据集（不包括类标签）,K为要求聚类的个数，cid为聚类算法执行之后各个对象所属的类标签
% Function :实现k-mode算法，随机生成初始聚类中心

[n,d] = size(Data);   %获得数据集的对象个数n、属性个数d
 %InitialCenters = ceil(fix(rand(1,K)*n)); 

 %以下while语句的作用为(1)判断产生的随机数是否相同;(2)判断产生的随机数对应的对象是否相同，若相同则重新产生随机数
 

InitialCentersno = [1,2]   %输出初始类中心的序号

cid = zeros(1,n);   % cid保存聚类之后各个对象所属类标签

maxgn= 1000;    %设置算法迭代的最大次数
iter = 0;
InitialCenter=Data(InitialCentersno,:); %初始聚类中心     
ni=InitialCenter;
%bool=0;%标记是否为第一次迭代
while iter < maxgn
    %计算每个数据到聚类中心的距离
    %for i = 1:n
     %  if bool==0 && ~isempty(find(InitialCenters==i))  %如果当前对象正好选为初始聚类中心，则直接赋给标签
     %      cid(i)=find(InitialCenters==i); 
     %      continue;
     %  end; 
    for i = 1:n 
       dist= Distance_of_Categorical(repmat(Data(i,:),K,1),ni);% 调用两个对象之间的距离函数
       [m,ind] = min(dist(:,2)); % 将当前聚类结果存入cid中                                                         %改进：[m,ind] = min(dist);或者  ind = min(dist);
       cid(i) = ind;  %给当前对象赋予类标签
    end
   % bool=1;

    for i = 1:K  %找到每一类的所有数据，计算他们的Mode，作为下次计算的聚类中心
        ind = find(cid==i);               
        if ~isempty(ind)
            nj(i,:)=Correct_Find_Mode(Data(ind,:));
        end
    end

    if ni==nj  %如果两次类中心相同则终止迭代，否则把新的类中心作为下一次的类中心继续进行迭代
        break;
    else
        ni=nj;
    end
 
  iter = iter + 1;%迭代次数加1
end

