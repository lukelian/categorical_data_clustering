%%�����ʼ��Ķ�����
function sum=class_distribution(class,attribute,data)%class�洢ÿ��������ÿ��������ԭ���ݼ��е��б�ǩ��attribute��ʼ���ǩ�ı�ǩ��data�ǳ�ʼ���ǩ
n=length(class);%n�д洢�����еĶ�����
k=length(attribute);%k�д洢�����е�����
sum=zeros(1,k);
for i=1:n
    for j=1:k
        if isequal(data(class(i)),attribute(j)) %�����ݼ��������ݼ���Աȣ��������������������಻ͬ�����
            sum(j)=sum(j)+1;
            
        end
    end
end

%for i=1:k
   %sum(i)=sum(i)/n;
%end
