function [cid] = createTable(k,Data)
[c,n] = size(Data);
cid = zeros(n,k);
for i = 1:1:n
    cid(i,Data(i)) = 1;
end