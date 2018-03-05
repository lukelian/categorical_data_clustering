function valueHInCluster = CalH(labelCollection,data)
[r,c] = size(data);
[gar,k] = size(unique(labelCollection));
data = data';
attributeFrequence = zeros(100,100);
%ͳ��ÿһ������ֵ�ڻ��������г��ֵĴ���
for i = 1:1:c
    column{i,1} = unique(data(i,:));%column�д洢ÿ�����Ե�����ֵ����Щ����һ����������ÿ��Ԫ����һ��������
    [gar,attributeValueNum] = size(column{i,1});%attributeValueNum�洢�����Ե�����ֵ�ж��ٸ�
    for j = 1:1:attributeValueNum
        for p = 1:1:r
            if data(i,p) == column{i,1}(1,j);
                attributeFrequence(i,j) = attributeFrequence(i,j)+1;%attributeFrequence�д洢ÿ������ֵ�ڴ˻��������г��ֵĴ���
            end
        end
    end
end

for i = 1:1:100
    attributeValueInCluster{i,1} = zeros(1,100);
end

%ͳ��ÿһ������ֵ��ÿһ�����г��ֵĴ���
classLabel = unique(labelCollection);
for i = 1:1:k
    labelK = find(labelCollection==classLabel(i));%labelK�д洢��i���Ԫ��λ��,��һ��������
    [gar,objNumInK] = size(labelK);%objNumInK�洢��I���ж��ٸ�Ԫ��
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

%����p
pSave{1} = 0;
for i = 1:1:k
    labelK = find(labelCollection==classLabel(i));
    [gar,objNumInK] = size(labelK);
    for j = 1:1:c
        [gar,attributeValueNum] = size(column{j,1});
        for l = 1:1:attributeValueNum
            pSave{i}(j,l) = clusterCell{i}{j,1}(1,l)/objNumInK;
        end
    end
end

%����H
valueHInCluster = zeros(1,1);
tempH = 0;
for i = 1:1:k
    for j = 1:1:c
        [gar,attributeValueNum] = size(column{j,1});
        for l = 1:1:attributeValueNum
            tempH = tempH + pSave{i}(j,l)*log2(pSave{i}(j,l));
        end
    end
    valueHInCluster(i) = tempH;
    tempH = 0;
end