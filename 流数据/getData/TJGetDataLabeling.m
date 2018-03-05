function [out,cluster,zeroLocate,newData,label,numIncluster] = TJGetDataLabeling(origionData,labelCollection,streamData,choose,zero,label_i_1,label_i)
out = 0;
[r,c] = size(streamData);
cluster = zeros(1,r);
[weightingCell,column,k,attributeFrequence] = GetDataNIR(labelCollection,origionData);

numIncluster = zeros(1,k);%统计分到每一类的元素个数

if choose==1
    for i = 1:1:r
        singleData = SplitData(streamData,i);
        [maxResembleInSin,minResembleInCluster,kSuit] = Resemblance(origionData,singleData,weightingCell,column,k);
        if maxResembleInSin < minResembleInCluster(kSuit) || (maxResembleInSin == 0&&minResembleInCluster(kSuit)==0)
            out = out + 1;
        else
            cluster(i) = kSuit;
            
            numIncluster(1,k) = numIncluster(1,k) + 1;%统计每一类中元素的个数
            
        end
    end
end

if choose==2
    for i = 1:1:r
        singleData = SplitData(streamData,i);
        [maxResembleInSin,minResembleInCluster,kSuit] = Resemblance(origionData,singleData,weightingCell,column,k);
        cluster(i) = kSuit;
    end
end

zeroLocate = find(cluster==0);
cluster(:,zeroLocate) = [];
label_i(zeroLocate,:) = [];
label = cat(1,label_i_1,label_i);
[gar,num] = size(labelCollection);
streamData(zeroLocate,:)=[];
zeroLocate = zeroLocate + num;
zeroLocate = cat(2,zero,zeroLocate);
cluster = cat(2,labelCollection,cluster);
newData = cat(1,origionData,streamData);