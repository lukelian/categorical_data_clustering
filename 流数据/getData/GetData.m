function [out,k] = GetData(data)
[r,c] = size(data);
[k,gar] = size(unique(data(:,c)));
kCluster = unique(data(:,c));
out{1} = zeros(1,c);
for i = 1:1:k
    clusterLocate = find(data(:,c)==kCluster(i));
    out{i} = data(clusterLocate,:);
end