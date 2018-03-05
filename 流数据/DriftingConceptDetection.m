function [outlier,cluster,numdiffcluster,newData,newLabel,NIR] = DriftingConceptDetection(origionData,labelCollection,streamData,thet,eta,delta)%0.4 0.5 0.3
[outlier,cluster] = DataLabeling(origionData,labelCollection,streamData);
numdiffcluster = 0;
[gar,k] = size(unique(labelCollection));
labelSimple = unique(labelCollection);
[numOfLast,c] = size(origionData);
[numOfCorrent,c] = size(streamData);
%计算发生重大变化的类的个数
for i = 1:1:k
    [gar,numLabelKLast] = size(find(labelCollection==labelSimple(i)));
    [gar,numLabelKCorrent] = size(find(cluster==labelSimple(i)));
    if abs(numLabelKLast/numOfLast-numLabelKCorrent/numOfCorrent)>delta
        numdiffcluster = numdiffcluster+1;
    end
end
%判断是否发生概念漂移
if outlier/numOfCorrent>thet || numdiffcluster/k>eta
    disp('在当前窗口发生概念漂移,需要重新选择学校');
    newData = streamData;
    newLabel = Correct_Hard_K_Mode(newData,k);
    [weightingCell,column] = CalculateNIR(newLabel,newData);
    for i = 1:1:k
        for j = 1:1:c
            [maxValue,maxLocation] = max(weightingCell{i}(c,:));
            NIR(i,j) = column{j}(maxLocation);
        end
    end
else
    disp('在当前窗口没有发生概念漂移');
    %add CCorrent to CLast
    newData = cat(1,origionData,streamData);
    newLabel = cat(2,labelCollection,cluster);
    %updata NIR
    [weightingCell,column] = CalculateNIR(newLabel,newData);
    for i = 1:1:k
        for j = 1:1:c
            [maxValue,maxLocation] = max(weightingCell{i}(j,:));
            NIR(i,j) = column{j}(maxLocation);
        end
    end
end