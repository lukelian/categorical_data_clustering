function [times,new_class1]=kMeans(data,km)   
enter=firstenter(data,km,1);
[r,c]=size(data);

time1=clock;
means1=zeros(km,c);
for i=1:km
    means1(i,:)=data(enter(i),:);
end
t=0;
new_class1=zeros(1,r);
old_class1=zeros(1,r);
while 1==1    
    if t>20  %kmeans粗略划分km类
        break;
    end
    t=t+1;
    new_mean1=zeros(km,c);
    classsum=zeros(1,km);
    for i=1:r
        distance=zeros(1,km);
        for j=1:km
            for h=1:c
                distance(j)=distance(j)+(data(i,h)-means1(j,h))^2;  %各km类距离
            end
        end
        [MinValue,MinRow]=min(distance);    %返回第j类和其distance
        old_class1(i)=MinRow;   %各对象的类标签
        classsum(MinRow)=classsum(MinRow)+1;    %把第i个对象划分到第j类中，j类中对象数+1
        for e=1:c
            new_mean1(MinRow,e)=new_mean1(MinRow,e)+data(i,e);  %求和
        end
    end
    for i=1:km
        if classsum(i)~=0
            means1(i,:)=new_mean1(i,:)/classsum(i); %新的类中心,求平均数
        else
            means1(i,:)=zeros(1,c);
        end
    end
    if isequal(old_class1,new_class1)
        break;
    else
        new_class1=old_class1;
    end
end   %执行kmeans，划分为km类


times=etime(clock,time1);
 %[sums,cluster]=equation(new_class);
 %    l=length(sums);
 %   cs=unique(new_class);
 %   n=length(cs)+2;
 %    statistic=zeros(l,n);
 %    statistic(:,1)=sums;
 %    ms=0;
 %    PE=0;
 %    AC=0;
 %    RE=0;
  %   true_class=zeros(1,r);
 %    for i=1:l
%       s=class_distribution(setdiff(cluster(i,:),0),cs,class);
 %        for j=2:n-1
 %            statistic(i,j)=s(j-1);
%         end
%         [maxvalue,maxrow]=max(s);
 %        attr_class=unique(class);
%         for clusteri=1:length(setdiff(cluster(i,:),0))
%             if isequal(class(cluster(i,clusteri)),attr_class(maxrow))
%                 true_class(cluster(i,clusteri))=1;
%             end
%         end
%         statistic(i,n)=maxvalue/sums(i);
%         PE=PE+maxvalue/sums(i);
%        ms=ms+max(s);
%     end
%     for i=1:l
%         [maxvalue,maxrow]=max(statistic(i,[2:n-1]));
%     if sum(statistic(:,maxrow+1))~=0
%        RE=RE+maxvalue/sum(statistic(:,maxrow+1));
%         %RE=RE+max(statistic(:,i+1))/sum(statistic(:,i+1));
%     end
%     end
%     AC=ms/r
%     PE=PE/l
%     RE=RE/l

end