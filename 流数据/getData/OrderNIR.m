function [resembleInOrder,newRestData,minResembleInCluster,oldResemble] = OrderNIR(originData,weightingCell,column,k)
%计算该元素与每个类的相似度，存储在resemble中
[numOfRest,attri] = size(originData);

resemble = zeros(numOfRest,k);
for i = 1:1:numOfRest
    singleData = originData(i,:);
    for t = 1:1:k
        for j = 1:1:attri
            [gar,attributeValueNum] = size(column{j,1});
            for l = 1:1:attributeValueNum
                if column{j,1}(1,l) == singleData(j)
                    resemble(i,t) = resemble(i,t) + weightingCell{t}(j,l);
                else
                    resemble(i,t) = resemble(i,t) + 0;
                end
            end
        end
    end
end

oldResemble = resemble;
for i = 1:1:k
    [resembleInOrder{i},sortLine{i}] = sort(resemble(:,i));
    newRestData{i} = originData(sortLine{i}(:),:);
end

%minResembleInCluster = 0;
minResemble = zeros(k,attri);
%计算每个类的最小类内相似度，存储在minResembleInCluster中
for i = 1:1:k
    for j = 1:1:attri
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