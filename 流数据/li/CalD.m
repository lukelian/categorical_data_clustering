function [finalCluster,finalLabel,outliers] = CalD(labelCollection,data,S)  
%返回分好类的数据集finalCluster，数据标签集finalLabel,异常点个数outliers
[r,c] = size(data);
[gar,k] = size(unique(labelCollection));
outliers = 0;
valueHInCluster = CalH(labelCollection,data);
classLabel = unique(labelCollection);
cluster{1} = 0;
objNumInK(1) = 0;
for i = 1:1:k
    labelK = find(labelCollection(i) == classLabel(i));
    [gar,objNumInK(i)] = size(labelK);
    cluster{i} = data(labelK(1),:);
    for j = 1:1:objNumInK(i)-1
        cluster{i} = cat(1,cluster{i},data(labelK(j+1),:));
    end
end

everyObjH{1} = zeros(1,1);
for i = 1:1:k
    singleLabel = zeros(1,objNumInK(i)+1);
    singleLabel(:,:) = classLabel(i);
    for j = 1:1:objNumInK(i)
        cluster{i}(objNumInK(i)+1,:) = cluster{i}(j,:);
        value = CalH(singleLabel,cluster{i});
        everyObjH{i}(j) = (objNumInK(i)+1)*value(1) - objNumInK(i)*valueHInCluster(i);
    end
end

objH(1) = 0;
for i = 1:1:k
    objH(i) = max(everyObjH{i});
end

for i = 1:1:k
    finalCluster{i} = zeros(1,c);
end
[currentWindowSize,gar] = size(S);
finalLabel = zeros(1,currentWindowSize);
everyObjDCorrent{1} = zeros(1,1);
for i = 1:1:currentWindowSize
    rawData = SplitData(S,i);
    for j = 1:1:k
        singleLabel = zeros(1,objNumInK(j)+1);
        singleLabel(:,:) = classLabel(j);
        cluster{j}(objNumInK(j)+1,:) = rawData;
        value = CalH(singleLabel,cluster{j});
        everyObjDCorrent{i}(j) = (objNumInK(j)+1)*value(1) - objNumInK(j)*valueHInCluster(j);
    end
    [minValue,whichCluster] = min(everyObjDCorrent{i});
    if minValue<=objH(whichCluster);
        finalCluster{whichCluster} = cat(1,finalCluster{whichCluster},rawData);
        finalLabel(i) = whichCluster;
    else
        outliers = outliers+1;
    end
end
for i = 1:1:k
    finalCluster{i}(1,:) = [];
end











