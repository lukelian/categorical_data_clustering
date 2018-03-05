function CU = CalculateCU(labelCollection,data)
[r,c] = size(data);
[weightingCell,column,k,attributeFrequence] = CalculateNIR(labelCollection,data);
classLabel = unique(labelCollection);
attributeFrequence = 1/r*attributeFrequence;
weightingAll = attributeFrequence.*attributeFrequence;
weightingAllSum = sum(weightingAll(:));
braket = 0;
for i = 1:1:k
    [gar,numInK] = size(find(labelCollection==classLabel(i)));
    Pck(i) = numInK/r;
    weightingCell{i} = 1/numInK * weightingCell{i};
    weightingInK{i} = weightingCell{i}.*weightingCell{i};
    weightingInKSum(i) = sum(weightingInK{i}(:));
end

for i = 1:1:k
    braket = Pck(i)*(weightingInKSum(i) - weightingAllSum) + braket;
end

CU = 1/k*braket;

