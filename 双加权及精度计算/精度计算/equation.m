function [sum,class]=equation(Column) 
k=unique(Column);%k为列向量，存储类数标签
m=length(k);%类数
n=length(Column);%n中存储对象数
sum=zeros(1,m); 
for i=1:n
    for j=1:m
        if isequal(Column(i),k(j))%第i个对象的类标签是第j类的话，就把j类中的对象数+1
            sum(j)=sum(j)+1;%sum中存储每类中的对象个数
            class(j,sum(j))=i;%class中存储在某个类中每个对象在data中的行标签
        end
    end
end
