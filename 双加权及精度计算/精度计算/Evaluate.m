function out = Evaluate(new_class,class)
[sums,cluster]=equation(new_class);%�����µ����ǩ��sums�д洢������ÿ����Ķ���������һ������������cluster�洢ÿ������ÿ��������ԭ���ݼ��е��б�ǩ
[r,cc]=size(class);
l=length(sums);%sumsΪ����Ķ������,l�洢����������l = 2��
cs=unique(class);%class�ǳ�ʼ���ǩ��cs�д洢��ʼ���ǩ�ı�ǩ
n=length(cs)+2;%n�д洢����+2������n = 4
statistic=zeros(l,n);%��һ�д洢���±�ǩ�ĸ���Ԫ�ظ�������һ��������
                               %�ڶ��д洢��ԭʼ��ǩ�ķֵ���ȷ���е�Ԫ�ظ���
                               %�����д洢��ԭʼ��ǩ�ķֵ��������е�Ԫ�ظ���
                               %l�д���ÿ������������kֵ��ͬ
statistic(:,1)=sums;
ms=0;
PE=0;
AC=0;
RE=0;
for i=1:l    %l�洢����
    s=class_distribution(setdiff(cluster(i,:),0),cs,class);%setdiff��ȥ��cluster�е�i�е�0Ԫ��
    %s������ֳ���k����������������֣������������е�Ԫ�ط��䵽������
    for j=2:n-1         %��ڶ��к͵���������洢
        statistic(i,j)=s(j-1);  %��һ���д洢��sums������Ķ������������������ڶ��к͵���������洢
    end
    [maxvalue,maxrow]=max(s);%maxvalue������ȷ�ֵ������е�Ԫ�ظ���
    statistic(i,n)=maxvalue/sums(i);%sums��i���������и�����Ԫ�صĸ�������al+bl������ֵ�+��ȷ�ֵģ�
    PE=PE+maxvalue/sums(i); %����PE�ļ���
    ms=ms+max(s);
end

%���ȣ�PR=sum{al/(al+bl)}/k������������������sum{al/(al+bl)}��ֵ
%�Ƿ���ڴ���û��/k

for i=1:l
    [maxvalue,maxrow]=max(statistic(i,[2:n-1]));%statistic�еĵ�һ�еĵڶ������У���ʱn = 4
if sum(statistic(:,maxrow+1))~=0%��maxrow+1����ʾԭʼ�������ֵ���еĺţ������Ҫ+1��ԭ���������������ʵ��ʹ��������
    RE=RE+maxvalue/sum(statistic(:,maxrow+1));  %�ٻ���RE�ļ���
    %RE=RE+max(statistic(:,i+1))/sum(statistic(:,i+1));
end

%�ٻ���:RE=sum{al/(al+cl)}/k

end
AC=ms/r;       %׼ȷ��AC�ļ��㣬rΪ������
PE=PE/l;       %lΪ����
RE=RE/l;

out(1:3) = [AC,PE,RE];

%�㷨ȱ�㣺�п��ܴ���ֵ������еĶ����������ȷ�ֵ��Ļ��࣬�������max����ʱ���߼�����