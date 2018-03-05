function [out,cluster,zeroLocate] = GetDataLabeling(origionData,labelCollection,streamData,choose)
out = 0;
[r,c] = size(streamData);
cluster = zeros(1,r);
[weightingCell,column,k,attributeFrequence] = GetDataNIR(labelCollection,origionData);
if choose==1%����outliers�����Ĺ���
    for i = 1:1:r
        singleData = SplitData(streamData,i);
        [maxResembleInSin,minResembleInCluster,kSuit] = Resemblance(origionData,singleData,weightingCell,column,k);
        if maxResembleInSin < minResembleInCluster(kSuit) || (maxResembleInSin == 0&&minResembleInCluster(kSuit)==0)
            out = out + 1;
        else
            cluster(i) = kSuit;
        end
    end
end

if choose==2%������outliers�����Ĺ���
    for i = 1:1:r
        singleData = SplitData(streamData,i);
        [maxResembleInSin,minResembleInCluster,kSuit] = Resemblance(origionData,singleData,weightingCell,column,k);
        cluster(i) = kSuit;
    end
end

zeroLocate = find(cluster==0);
cluster(:,zeroLocate)=[];
%streamData(zeroLocate,:)=[];