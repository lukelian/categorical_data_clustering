function enters=firstenter(data,k,num)
[r,c]=size(data);

cs=k;
enters=zeros(num,cs);
for i=1:num
    while 1==1
    en=fix(rand(1,cs)*(r-1)+1);
    if cs==length(unique(en))
       enters(i,:)=en;
       break;
    end
    end
end