function [out,cluster] = DataLabeling(origionData,labelCollection,streamData)
out = 0;
[r,c] = size(streamData);
cluster = zeros(1,r);
[weightingCell,column,k,attributeFrequence] = CalculateNIR(labelCollection,origionData);
for i = 1:1:r
    singleData = SplitData(streamData,i);
    [maxResembleInSin,minResembleInCluster,kSuit] = Resemblance(origionData,singleData,weightingCell,column,k);
    if maxResembleInSin < minResembleInCluster(kSuit) || (maxResembleInSin == 0&&minResembleInCluster(kSuit)==0)
        out = out + 1;
    else
        %cluster{kSuit} = cat(1,singleData,cluster{kSuit});
        cluster(i) = kSuit;
    end
end
2;