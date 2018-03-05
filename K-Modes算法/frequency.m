function da=frequency(Data)
[row,column]=size(Data);
dist=[];
da=zeros(row,2);
for i=1:row    
    sum=0;
    for j=1:column
        sum=sum+length(find(Data(:,j)==Data(i,j)))/row;
    end
    dist=cat(1,dist,[sum/column,i]); % 曹付元2008-06-26 修订，这个和符号值中的随机初始化有区别
end
da=dist;
% [m,n]=sort(dist(:,1));
% da(:,1)=m;
% da(:,2)=n;