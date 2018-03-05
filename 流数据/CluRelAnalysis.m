function weightingTable = CluRelAnalysis(labelLast,dataLast,labelCorrent,dataCorrent,t)
%使用时t从1开始递增
[weightingCellLast,columnLast,k,attributeFrequence] = CalculateNIR(labelLast,dataLast);
[weightingCellCorrent,columnCorrent,k,attributeFrequence] = CalculateNIR(labelCorrent,dataCorrent);
weightingCellLastSum = 0;
weightingCellCorrentSum = 0;
weightingCellSum = 0;
for i = 1:1:k
    for n = 1:1:k
        weightingCellMul{i,n} = weightingCellLast{i}.*weightingCellCorrent{n};
        weightingCellLastMul{i,n} = weightingCellLast{i}.*weightingCellLast{n};
        weightingCellCorrentMul{i,n} = weightingCellCorrent{i}.*weightingCellCorrent{n};
        [c,r] = size(weightingCellMul{i});
        for j = 1:1:c
            for m = 1:1:r
                weightingCellSum = weightingCellSum + weightingCellMul{i,n}(j,m);
                weightingCellLastSum = sqrt(weightingCellLastSum + weightingCellLastMul{i,n}(j,m));
                weightingCellCorrentSum = sqrt(weightingCellCorrentSum + weightingCellCorrentMul{i,n}(j,m));
            end
        end
        weightingTable(i,n) = weightingCellSum/(weightingCellLastSum*weightingCellCorrentSum);
        weightingCellLastSum = 0;
        weightingCellCorrentSum = 0;
        weightingCellSum = 0;
    end
end

%接下来是画图程序
weightingCorrent = zeros(100,100);
weightingLast = zeros(100,100);
for i = 1:1:k
    weightingLast = weightingLast + weightingCellLast{i};
    weightingCorrent = weightingCorrent + weightingCellCorrent{i};
end

for i = 1:1:k
    for j = 1:1:c
        [valueLast(i,j),positionLast(i,j)] = max(weightingCellLast{i}(j,:));
        [valueCorrent(i,j),positionCorrent(i,j)] = max(weightingCellCorrent{i}(j,:))
    end
end

hold on
for i = 1:1:k
    rectangle('position',[i,t,0.5,0.5],'curvature',[1,1],'edgecolor','r');
    text(i,t,num2str(positionLast(i,:)));
    rectangle('position',[i,t+1,0.5,0.5],'curvature',[1,1],'edgecolor','r');
    text(i,t+1,num2str(positionCorrent(i,:)));
end
plot([t i],[t+1 i]);
hold off
axis([0,t+2,0,k+2]);
%{
begin
    for m = 1 to k(t-1)
        drawing a circle with the center location (t-1,m) for c(t-1)m
    end
    if outliers(t-1)~=0
        drawing a circle with the center location (t-1,m+1) for outliers(t-1)
    end
    for m = 1 to k(t)
        drawing a circle with the center location (t,m) for c(t)m
    end
    if outliers(t)~=0
        drawing a circle with the center location (t,m+1) for outliers(t)
    end
    for m = 1 to k(t-1)
        for n = 1 to k(t)
            calculate CM(cm,cn)
        end
    end
end
%}





