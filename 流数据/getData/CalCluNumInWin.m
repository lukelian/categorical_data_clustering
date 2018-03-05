function cluNum = CalCluNumInWin(cluster)
[gar,c] = size(cluster);
[gar,k] = size(unique(cluster{1}));
cluNum = zeros(c,k);
for i = 1:1:c
    for j = 1:1:k
        kLocate = find(cluster{i}==j);
        [gar,cluNum(i,j)] = size(kLocate);
    end
end