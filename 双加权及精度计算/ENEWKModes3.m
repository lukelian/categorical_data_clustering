function [statistic,t,ms,AC,PE,RE,FSS,new_class,times]=ENEWKModes3(data,enter,class,a,T1,T2)%enter是选取的初始类中心，class是初始类标签
t0=clock;
enter=sort(enter);              %
[r,cc]=size(data);          
k=length(enter);        %类数
modes=zeros(k,cc);      
FSS=[];             
OLDFSS=0;           
NEWFSS=0;
clen=zeros(1,cc);           %
for i=1:cc
    column=unique(data(:,i)); %属性去重      
    clen(i)=length(column);   %属性取值个数
    for j=1:clen(i)
        attr(j,i)=column(j);        %attr矩阵存储属性i下的属性值
    end
end
qus=0;
[ar,ac]=size(attr);     
attr_count=zeros(ar,ac);       
for i=1:r
    for j=1:cc
        w=find(attr(:,j)==data(i,j));%返回data中每列里每个属性值在attr中的位置的列向量，w为位置列向量
        x=w(1);         
        attr_count(x,j)=attr_count(x,j)+1;      %在该属性值在attr第i列的位置，计算属性值出现的个数，attr_count存储每个属性值在该列出现的次数
    end
end
% for i=1:cc
%     [maxv,maxr]=max(attr_count(:,i));
%     qus=qus+r-maxv;
% end
% qus=qus/cc/k;

for i=1:cc
    for j=1:clen(i)
        x=length(find(data(:,i)==attr(j,i)));     % x存储data中每一列每个属性值出现的次数
        qus=qus+(r-x)/k;                        % r-x为除了该属性外，其他属性总共的个数，k为类数  ？？？？？？？？？？？？？？
    end
end
qus=qus/(sum(clen));%que/所有对象
qus=1;              %%%这里又将qus置为1                                            ！！！
modeSum=ones(k,cc);     
for i=1:k
    modes(i,:)=data(enter(i),:);%  modes（k,cc）    data(r,cc)     mode(,)中存储了初始类中心
end

t=0;
new_class=zeros(1,r);  
old_class=zeros(1,r);
weight=zeros(2,k,cc);       
weight(2,:,:)=1/cc;
weight(1,:,:)=1/cc;         %%初始化权重
while 1==1                 %%用if 语句控制循环终止                 
    fun=0;              %%                                                      
     if t>22            % 这个22是限定的迭代次数                                                        
         break;
     end
    t=t+1;
    new_mode=zeros(k,ar,cc);                  %用new_mode记录k类中cc属性下的第ar个属性取值下的对象个数
    classsum=zeros(1,k);                        %classsum是各类的对象个数
    NEWFSS=0;
    for i=1:r
        distance=zeros(1,k);                    %计算distance来确定出各个对象对于各类的距离，没有计算W，通过距离确定各对象对于各类的归属
        for j=1:k      
            
            for h=1:cc
                if ~isequal(data(i,h),modes(j,h))       
                     distance(j)=distance(j)+1+(weight(1,j,h))^a;               %数据与mode不等执行
                else
                     distance(j)=distance(j)+(weight(2,j,h))^a;%*modeSum(j,h);      
                end
            end
            
        end
        [MinValue,MinRow]=min(distance);                %确定出第i个对象对于第几类的distance最小并确定该类是第MinRow类

        old_class(i)=MinRow;                    %确定第i个对象的类标签
        NEWFSS=NEWFSS+MinValue;
        classsum(MinRow)=classsum(MinRow)+1;    %计算第MinRow类的对象数目
        for e=1:cc
            w=find(attr(:,e)==data(i,e),1); 
            %x=w(1);
            new_mode(MinRow,w,e)=new_mode(MinRow,w,e)+1;  %确定的第几类，第几个属性和属性的取值，储存并+1
        end
    end
    for i=1:k
        for h=1:cc
         NEWFSS=NEWFSS+T1*weight(1,i,h)^a+T2*weight(2,i,h)^a;       
        end
    end
    new_sum=zeros(k,cc);                    
    modeSum=zeros(k,cc);        %各类中的
    for i=1:k       
        s_sum=0; 
        z_sum=0;
        for j=1:cc                                              
            if classsum(i)~=0
                [Maxe,Maxr]=max(new_mode(i,:,j));               %找出第i个类中，j属性下的数目最大的是第几个属性
                modes(i,j)=attr(Maxr,j);                        %将数目最大的属性赋值给新Modes
                modeSum(i,j)=(classsum(i)-Maxe)+T1;             
                new_sum(i,j)=Maxe+T2;
            else          
                %modeSum(i,:)=ones(1,cc);
                new_sum(i,j)=1;
            end
            s_sum=s_sum+(1/new_sum(i,j))^(1/(a-1));
            z_sum=z_sum+(1/modeSum(i,j))^(1/(a-1));
        end
        s_z=find(modeSum(i,[1:cc])==0);%找出第i类所有属性中没有对象的位置
        s_zl=length(s_z);
        if s_zl~=0
            weight(1,i,:)=zeros(1,cc);   %先讲所有属性权重均设置为0                                               
            for h=1:s_zl
                weight(1,i,s_z(h))=1/s_zl;  %将没有对象的属性权重设为1/m
            end
        else
            for j=1:cc 
                weight(1,i,j)=(1/modeSum(i,j))^(1/(a-1))/z_sum;%将有对象的属性权重更新为左式
            end
        end
         for j=1:cc 
             weight(2,i,j)=(1/new_sum(i,j))^(1/(a-1))/s_sum;                        
             %weight(1,i,j)=(1/modeSum(i,j))^(1/(a-1))/z_sum;
         end
        
    end
   NEWFSS=round(NEWFSS*100000)/100000;              %%round是取整函数
    FSS(t)=NEWFSS;                         %记录迭代次数的函数
    if OLDFSS==NEWFSS
        break;
    else
        OLDFSS=NEWFSS;
          new_class=old_class;      %原始类标签赋给新的类标签
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

%后面这段比较麻烦。参数比较乱。
[sums,cluster]=equation(new_class);%传入新的类标签，sums中存储新类中每个类的对象数（是一个行向量），cluster存储每个类中每个对象在原数据集中的行标签
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
AC=ms/r     %准确度AC的计算，r为对象数
PE=PE/l       %l为类数
RE=RE/l

%算法缺点：有可能错误分到此类中的对象个数比正确分到的还多，会造成用max函数时的逻辑错误