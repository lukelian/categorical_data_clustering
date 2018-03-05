function distance = CalDBetweenCluster(data1,labelCollection1,data2,labelCollection2)
[gar,k1] = size(unique(labelCollection1));
[r1,c1] = size(data1);
%[r2,c2] = size(data2);
%[gar,k2] = size(unique(labelCollection2));
for i = 1:1:k1
    locatePre{i} = find(labelCollection1 == i);
    locateCorrent{i} = find(labelCollection2 == i);
    [gar,clusterPreNum(i)] = size(locatePre{i});
    [gar,clusterCorrentNum(i)] = size(locateCorrent{i});
end

locatePre{k1+1} = find(labelCollection1 == 0);
locateCorrent{k1+1} = find(labelCollection2 == 0);
[gar,clusterPreNum(k1+1)] = size(locatePre{k1+1});
[gar,clusterCorrentNum(k1+1)] = size(locateCorrent{k1+1});

deNumCorrentToPre = ((1/r1)*(clusterPreNum - clusterCorrentNum)).^2;
standardDeviation = sqrt((1/k1)*sum(deNumCorrentToPre));
distance = standardDeviation/(sqrt(2/k1));