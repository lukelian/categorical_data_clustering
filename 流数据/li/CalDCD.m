function Cluster = CalDCD(labelCollection,data,S,theta,alpha)
[finalCluster,finalLabel,outliers] = CalD(labelCollection,data,S);
[gar,k] = size(unique(labelCollection));
[correntNum,c] = size(S);
cluster{1} = 0;
objNumInK(1) = 0;
if outliers/correntNum>theta
    disp('�ڵ�ǰ���ڷ�������Ư��,����outliers����');
    Cluster = Correct_Hard_K_Mode(S,k);
else
%     for i = 1:1:k
%         labelK = find(labelCollection(i) == classLabel(i));
%         [gar,objNumInK(i)] = size(labelK);
%         cluster{i} = data(labelK(1),:);
%         for j = 1:1:objNumInK(i)-1
%             cluster{i} = cat(1,cluster{i},data(labelK(j+1),:));
%         end
%     end
    distance = CalDBetweenCluster(data,labelCollection,S,finalLabel);
    if distance>alpha
        disp('�ڵ�ǰ���ڷ�������Ư��,������ķֲ�����');
    end
    Cluster = finalLabel;
end