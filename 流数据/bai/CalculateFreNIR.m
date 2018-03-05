function [weightingCell,column,k,attributeFrequence] = CalculateFreNIR(labelCollection,data)
[r,c] = size(data);%rΪ��������cΪ������
data = data';
[gar,k] = size(unique(labelCollection));
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

sumFrequenceInCluster = zeros(100,100);%��ͬ�����ݼ�ע���޸ĳ�ʼ����С
for i = 1:1:c
    column{i,1} = unique(data(i,:));%column�д洢ÿ�����Ե�����ֵ����Щ����һ����������ÿ��Ԫ����һ��������
    [gar,attributeValueNum] = size(column{i,1});%attributeValueNum�洢�����Ե�����ֵ�ж��ٸ�
    for j = 1:1:attributeValueNum
        for l = 1:1:k
            labelK = find(labelCollection==classLabel(i));%labelK�д洢��i���Ԫ��λ��,��һ��������
            [gar,objNumInK] = size(labelK);%objNumInK�洢��I���ж��ٸ�Ԫ��
            sumFrequenceInCluster(i,j) = clusterCell{l}{i,1}(1,j)/attributeValueNum + sumFrequenceInCluster(i,j);
        end
    end
end

%����p
pSave{1} = 0;
for i = 1:1:k
    labelK = find(labelCollection==classLabel(i));%labelK�д洢��i���Ԫ��λ��,��һ��������
    [gar,objNumInK] = size(labelK);%objNumInK�洢��I���ж��ٸ�Ԫ��
    for j = 1:1:c
        [gar,attributeValueNum] = size(column{j,1});
        for l = 1:1:attributeValueNum
            pSave{i}(j,l) = (clusterCell{i}{j,1}(1,l)/objNumInK)/sumFrequenceInCluster(j,l);
        end
    end
end

%����weighting function
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
%        �˴���������0��������û�и������������ڼ����ʱ����˵��ˣ������������������������������˶���԰�ˣ��߼����Ⱑ�������������������������������賿�����˿�����������
            weightingFun(i,j) = 1-weightingFun(i,j);
%        end
    end
end

%����weight
weightingSave = zeros(100,100);
for i = 1:1:k
    labelK = find(labelCollection==classLabel(i));%labelK�д洢��i���Ԫ��λ��,��һ��������
    [gar,objNumInK] = size(labelK);%obiNumInK�洢��I���ж��ٸ�Ԫ��
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





