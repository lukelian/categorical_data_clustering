function [weightingCell,column,k,attributeFrequence] = CalculateFreNIR(labelCollection,data)
[r,c] = size(data);%r为对象数，c为属性数
data = data';
[gar,k] = size(unique(labelCollection));
attributeFrequence = zeros(100,100);
%统计每一个属性值在滑动窗口中出现的次数
for i = 1:1:c
    column{i,1} = unique(data(i,:));%column中存储每个属性的属性值有哪些，是一个列向量，每个元素是一个行向量
    [gar,attributeValueNum] = size(column{i,1});%attributeValueNum存储该属性的属性值有多少个
    for j = 1:1:attributeValueNum
        for p = 1:1:r
            if data(i,p) == column{i,1}(1,j);
                attributeFrequence(i,j) = attributeFrequence(i,j)+1;%attributeFrequence中存储每个属性值在此滑动窗口中出现的次数
            end
        end
    end
end

for i = 1:1:100
    attributeValueInCluster{i,1} = zeros(1,100);
end

%统计每一个属性值在每一个类中出现的次数
classLabel = unique(labelCollection);
for i = 1:1:k
    labelK = find(labelCollection==classLabel(i));%labelK中存储第i类的元素位置,是一个行向量
    [gar,objNumInK] = size(labelK);%objNumInK存储第I类有多少个元素
    for j = 1:1:objNumInK
        for l = 1:1:c
            [gar,attributeValueNum] = size(column{l,1});
            for m = 1:1:attributeValueNum
                if data(l,labelK(j))==column{l,1}(1,m)
                    attributeValueInCluster{l,1}(1,m) = attributeValueInCluster{l,1}(1,m)+1;
                end
            end
        end
    end
    clusterCell{i} = attributeValueInCluster;
    for n = 1:1:100
        attributeValueInCluster{n,1} = zeros(1,100);
    end
end

sumFrequenceInCluster = zeros(100,100);%不同的数据集注意修改初始化大小
for i = 1:1:c
    column{i,1} = unique(data(i,:));%column中存储每个属性的属性值有哪些，是一个列向量，每个元素是一个行向量
    [gar,attributeValueNum] = size(column{i,1});%attributeValueNum存储该属性的属性值有多少个
    for j = 1:1:attributeValueNum
        for l = 1:1:k
            labelK = find(labelCollection==classLabel(i));%labelK中存储第i类的元素位置,是一个行向量
            [gar,objNumInK] = size(labelK);%objNumInK存储第I类有多少个元素
            sumFrequenceInCluster(i,j) = clusterCell{l}{i,1}(1,j)/attributeValueNum + sumFrequenceInCluster(i,j);
        end
    end
end

%计算p
pSave{1} = 0;
for i = 1:1:k
    labelK = find(labelCollection==classLabel(i));%labelK中存储第i类的元素位置,是一个行向量
    [gar,objNumInK] = size(labelK);%objNumInK存储第I类有多少个元素
    for j = 1:1:c
        [gar,attributeValueNum] = size(column{j,1});
        for l = 1:1:attributeValueNum
            pSave{i}(j,l) = (clusterCell{i}{j,1}(1,l)/objNumInK)/sumFrequenceInCluster(j,l);
        end
    end
end

%计算weighting function
weightingFun = zeros(100,100);
for i = 1:1:k
    for j = 1:1:c
        [gar,attributeValueNum] = size(column{j,1});
        for l = 1:1:attributeValueNum
            if pSave{i}(j,l)~=0
                weightingFun(j,l) = (-1/log(k)*(pSave{i}(j,l)*log(pSave{i}(j,l)))) + weightingFun(j,l);
            end
        end
    end
end
for i = 1:1:c
    [gar,attributeValueNum] = size(column{i,1});
    for j = 1:1:attributeValueNum
%        if weightingFun(i,j)~=0
%        此处出错，等于0不代表它没有个数，可能是在计算的时候给乘掉了！！！！！！！！！！！我真是日了动物园了，逻辑问题啊啊啊啊啊啊啊！！！！！！！现在凌晨两点了靠靠靠！！！
            weightingFun(i,j) = 1-weightingFun(i,j);
%        end
    end
end

%计算weight
weightingSave = zeros(100,100);
for i = 1:1:k
    labelK = find(labelCollection==classLabel(i));%labelK中存储第i类的元素位置,是一个行向量
    [gar,objNumInK] = size(labelK);%obiNumInK存储第I类有多少个元素
    for j = 1:1:c
        [gar,attributeValueNum] = size(column{j,1});
        for l = 1:1:attributeValueNum
             weightingSave(j,l) = (clusterCell{i}{j,1}(1,l)/objNumInK)*weightingFun(j,l);
        end
    end
    weightingCell{i} = weightingSave;
    weightingSave(:,:) = 0;
end
%weightingCell
%pSave
%clusterCell
%attributeFrequence





