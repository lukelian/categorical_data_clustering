function [maxResembleInSin,minResembleInCluster,kSuit,k] = Resemblance(origionData,singleData,weightingCell,column,k)
%[weightingCell,column,k,attributeFrequence] = CalculateNIR(labelCollection,origionData);
[r,c] = size(origionData);
data = origionData';
resemble = zeros(1,k);
%计算该元素与每个类的相似度，存储在resemble中
for i = 1:1:k
    for j = 1:1:c
        [gar,attributeValueNum] = size(column{j,1});
        for l = 1:1:attributeValueNum
            if column{j,1}(1,l) == singleData(j)
                resemble(1,i) = resemble(1,i) + weightingCell{i}(j,l);
            else
                resemble(1,i) = resemble(1,i) + 0;
            end
        end
    end
end
[maxResembleInSin,kSuit] = max(resemble);
%minResembleInCluster = 0;
minResemble = zeros(k,c);
%计算每个类的最小类内相似度，存储在minResembleInCluster中
for i = 1:1:k
    for j = 1:1:c
        minTemp = find(weightingCell{i}(j,:)~=0);
        [gar,minC] = size(minTemp);               %注意size必须用这种形式表示
        if minC ~= 0
            minT = weightingCell{i}(j,minTemp(1));
            for o = 1:1:minC
                if minT>weightingCell{i}(j,minTemp(o))
                    minT = weightingCell{i}(j,minTemp(o));
                end
            end
        else
            minT = 0;
        end
        minResemble(i,j) = minT;
    end
end
minResembleInCluster = sum(minResemble,2);