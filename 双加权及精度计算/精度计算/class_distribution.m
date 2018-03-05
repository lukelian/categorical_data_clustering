%%求各初始类的对象数
function sum=class_distribution(class,attribute,data)%class存储每个新类中每个对象在原数据集中的行标签，attribute初始类标签的标签，data是初始类标签
n=length(class);%n中存储新类中的对象数
k=length(attribute);%k中存储旧类中的类数
sum=zeros(1,k);
for i=1:n
    for j=1:k
        if isequal(data(class(i)),attribute(j)) %旧数据集与新数据集相对比，包括了新类的类数与旧类不同的情况
            sum(j)=sum(j)+1;
            
        end
    end
end

%for i=1:k
   %sum(i)=sum(i)/n;
%end
