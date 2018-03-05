function out = Evaluate(new_class,class)
[sums,cluster]=equation(new_class);%传入新的类标签，sums中存储新类中每个类的对象数（是一个行向量），cluster存储每个类中每个对象在原数据集中的行标签
[r,cc]=size(class);
l=length(sums);%sums为各类的对象个数,l存储类数，假设l = 2。
cs=unique(class);%class是初始类标签，cs中存储初始类标签的标签
n=length(cs)+2;%n中存储类数+2，假设n = 4
statistic=zeros(l,n);%第一列存储了新标签的各类元素个数，是一个行向量
                               %第二列存储了原始标签的分到正确类中的元素个数
                               %第三列存储了原始标签的分到错误类中的元素个数
                               %l行代表每个类的情况，与k值相同
statistic(:,1)=sums;
ms=0;
PE=0;
AC=0;
RE=0;
for i=1:l    %l存储类数
    s=class_distribution(setdiff(cluster(i,:),0),cs,class);%setdiff是去掉cluster中第i行的0元素
    %s将新类分成了k（旧类的类数）部分，并将该新类中的元素分配到旧类中
    for j=2:n-1         %向第二列和第三列里面存储
        statistic(i,j)=s(j-1);  %第一列中存储了sums（各类的对象个数），本句是向第二列和第三列里面存储
    end
    [maxvalue,maxrow]=max(s);%maxvalue代表正确分到此类中的元素个数
    statistic(i,n)=maxvalue/sums(i);%sums（i）代表所有该类中元素的个数，即al+bl（错误分的+正确分的）
    PE=PE+maxvalue/sums(i); %纯度PE的计算
    ms=ms+max(s);
end

%纯度：PR=sum{al/(al+bl)}/k，其中上面代码计算了sum{al/(al+bl)}的值
%是否存在错误：没有/k

for i=1:l
    [maxvalue,maxrow]=max(statistic(i,[2:n-1]));%statistic中的第一行的第二到三列，此时n = 4
if sum(statistic(:,maxrow+1))~=0%（maxrow+1）表示原始存有最大值的列的号，造成需要+1的原因在于上面语句中实际使用了两列
    RE=RE+maxvalue/sum(statistic(:,maxrow+1));  %召回率RE的计算
    %RE=RE+max(statistic(:,i+1))/sum(statistic(:,i+1));
end

%召回率:RE=sum{al/(al+cl)}/k

end
AC=ms/r;       %准确度AC的计算，r为对象数
PE=PE/l;       %l为类数
RE=RE/l;

out(1:3) = [AC,PE,RE];

%算法缺点：有可能错误分到此类中的对象个数比正确分到的还多，会造成用max函数时的逻辑错误