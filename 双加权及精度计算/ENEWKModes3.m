function [statistic,t,ms,AC,PE,RE,FSS,new_class,times]=ENEWKModes3(data,enter,class,a,T1,T2)%enter��ѡȡ�ĳ�ʼ�����ģ�class�ǳ�ʼ���ǩ
t0=clock;
enter=sort(enter);              %
[r,cc]=size(data);          
k=length(enter);        %����
modes=zeros(k,cc);      
FSS=[];             
OLDFSS=0;           
NEWFSS=0;
clen=zeros(1,cc);           %
for i=1:cc
    column=unique(data(:,i)); %����ȥ��      
    clen(i)=length(column);   %����ȡֵ����
    for j=1:clen(i)
        attr(j,i)=column(j);        %attr����洢����i�µ�����ֵ
    end
end
qus=0;
[ar,ac]=size(attr);     
attr_count=zeros(ar,ac);       
for i=1:r
    for j=1:cc
        w=find(attr(:,j)==data(i,j));%����data��ÿ����ÿ������ֵ��attr�е�λ�õ���������wΪλ��������
        x=w(1);         
        attr_count(x,j)=attr_count(x,j)+1;      %�ڸ�����ֵ��attr��i�е�λ�ã���������ֵ���ֵĸ�����attr_count�洢ÿ������ֵ�ڸ��г��ֵĴ���
    end
end
% for i=1:cc
%     [maxv,maxr]=max(attr_count(:,i));
%     qus=qus+r-maxv;
% end
% qus=qus/cc/k;

for i=1:cc
    for j=1:clen(i)
        x=length(find(data(:,i)==attr(j,i)));     % x�洢data��ÿһ��ÿ������ֵ���ֵĴ���
        qus=qus+(r-x)/k;                        % r-xΪ���˸������⣬���������ܹ��ĸ�����kΪ����  ����������������������������
    end
end
qus=qus/(sum(clen));%que/���ж���
qus=1;              %%%�����ֽ�qus��Ϊ1                                            ������
modeSum=ones(k,cc);     
for i=1:k
    modes(i,:)=data(enter(i),:);%  modes��k,cc��    data(r,cc)     mode(,)�д洢�˳�ʼ������
end

t=0;
new_class=zeros(1,r);  
old_class=zeros(1,r);
weight=zeros(2,k,cc);       
weight(2,:,:)=1/cc;
weight(1,:,:)=1/cc;         %%��ʼ��Ȩ��
while 1==1                 %%��if ������ѭ����ֹ                 
    fun=0;              %%                                                      
     if t>22            % ���22���޶��ĵ�������                                                        
         break;
     end
    t=t+1;
    new_mode=zeros(k,ar,cc);                  %��new_mode��¼k����cc�����µĵ�ar������ȡֵ�µĶ������
    classsum=zeros(1,k);                        %classsum�Ǹ���Ķ������
    NEWFSS=0;
    for i=1:r
        distance=zeros(1,k);                    %����distance��ȷ��������������ڸ���ľ��룬û�м���W��ͨ������ȷ����������ڸ���Ĺ���
        for j=1:k      
            
            for h=1:cc
                if ~isequal(data(i,h),modes(j,h))       
                     distance(j)=distance(j)+1+(weight(1,j,h))^a;               %������mode����ִ��
                else
                     distance(j)=distance(j)+(weight(2,j,h))^a;%*modeSum(j,h);      
                end
            end
            
        end
        [MinValue,MinRow]=min(distance);                %ȷ������i��������ڵڼ����distance��С��ȷ�������ǵ�MinRow��

        old_class(i)=MinRow;                    %ȷ����i����������ǩ
        NEWFSS=NEWFSS+MinValue;
        classsum(MinRow)=classsum(MinRow)+1;    %�����MinRow��Ķ�����Ŀ
        for e=1:cc
            w=find(attr(:,e)==data(i,e),1); 
            %x=w(1);
            new_mode(MinRow,w,e)=new_mode(MinRow,w,e)+1;  %ȷ���ĵڼ��࣬�ڼ������Ժ����Ե�ȡֵ�����沢+1
        end
    end
    for i=1:k
        for h=1:cc
         NEWFSS=NEWFSS+T1*weight(1,i,h)^a+T2*weight(2,i,h)^a;       
        end
    end
    new_sum=zeros(k,cc);                    
    modeSum=zeros(k,cc);        %�����е�
    for i=1:k       
        s_sum=0; 
        z_sum=0;
        for j=1:cc                                              
            if classsum(i)~=0
                [Maxe,Maxr]=max(new_mode(i,:,j));               %�ҳ���i�����У�j�����µ���Ŀ�����ǵڼ�������
                modes(i,j)=attr(Maxr,j);                        %����Ŀ�������Ը�ֵ����Modes
                modeSum(i,j)=(classsum(i)-Maxe)+T1;             
                new_sum(i,j)=Maxe+T2;
            else          
                %modeSum(i,:)=ones(1,cc);
                new_sum(i,j)=1;
            end
            s_sum=s_sum+(1/new_sum(i,j))^(1/(a-1));
            z_sum=z_sum+(1/modeSum(i,j))^(1/(a-1));
        end
        s_z=find(modeSum(i,[1:cc])==0);%�ҳ���i������������û�ж����λ��
        s_zl=length(s_z);
        if s_zl~=0
            weight(1,i,:)=zeros(1,cc);   %�Ƚ���������Ȩ�ؾ�����Ϊ0                                               
            for h=1:s_zl
                weight(1,i,s_z(h))=1/s_zl;  %��û�ж��������Ȩ����Ϊ1/m
            end
        else
            for j=1:cc 
                weight(1,i,j)=(1/modeSum(i,j))^(1/(a-1))/z_sum;%���ж��������Ȩ�ظ���Ϊ��ʽ
            end
        end
         for j=1:cc 
             weight(2,i,j)=(1/new_sum(i,j))^(1/(a-1))/s_sum;                        
             %weight(1,i,j)=(1/modeSum(i,j))^(1/(a-1))/z_sum;
         end
        
    end
   NEWFSS=round(NEWFSS*100000)/100000;              %%round��ȡ������
    FSS(t)=NEWFSS;                         %��¼���������ĺ���
    if OLDFSS==NEWFSS
        break;
    else
        OLDFSS=NEWFSS;
          new_class=old_class;      %ԭʼ���ǩ�����µ����ǩ
    end
%     if isequal(old_class,new_class)
%         break;
%     else
% 
%         new_class=old_class;
%   
%         
%     end
end
times=etime(clock,t0);%                        

%������αȽ��鷳�������Ƚ��ҡ�
[sums,cluster]=equation(new_class);%�����µ����ǩ��sums�д洢������ÿ����Ķ���������һ������������cluster�洢ÿ������ÿ��������ԭ���ݼ��е��б�ǩ
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
AC=ms/r     %׼ȷ��AC�ļ��㣬rΪ������
PE=PE/l       %lΪ����
RE=RE/l

%�㷨ȱ�㣺�п��ܴ���ֵ������еĶ����������ȷ�ֵ��Ļ��࣬�������max����ʱ���߼�����