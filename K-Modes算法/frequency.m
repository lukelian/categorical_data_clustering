function da=frequency(Data)
[row,column]=size(Data);
dist=[];
da=zeros(row,2);
for i=1:row    
    sum=0;
    for j=1:column
        sum=sum+length(find(Data(:,j)==Data(i,j)))/row;
    end
    dist=cat(1,dist,[sum/column,i]); % �ܸ�Ԫ2008-06-26 �޶�������ͷ���ֵ�е������ʼ��������
end
da=dist;
% [m,n]=sort(dist(:,1));
% da(:,1)=m;
% da(:,2)=n;