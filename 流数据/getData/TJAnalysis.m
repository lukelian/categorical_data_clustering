function [apr,cluster,outliers,zeroLocate] = TJAnalysis(data,winNum,winSize,cluNumInWin,whichClu,choose)%添加进前一个窗口的分析
[window,label,k] = CreateWindow(data,winNum,winSize,cluNumInWin,whichClu);
[r,c] = size(window);
cluster{1} = Correct_Hard_K_Mode(window{1},k);
apr{1} = Evaluate(cluster{1},label{1});
zeroLocate{1} = [];

%计算第一个窗口的比率
numIncluster = zeros(1,k);
bilv = zeros(1,k);
% bilvcha = zeros(1,k);
% bilvchahe = 0;
for i = 1:1:k
    [gar,numIncluster(1,i)] = size(find(cluster{1}==i));
    bilv(1,i) = numIncluster(1,i)/winSize;
end

for i = 2:1:c
%    [outliers(i),cluster{i}] = DataLabeling(window{i-1},cluster{i-1},window{i});
    [outliers(i),cluster{i},zeroLocate{i},window{i},label{i},numInclusterTemp] = TJGetDataLabeling(window{i-1},cluster{i-1},window{i},choose,zeroLocate{i-1},label{i-1},label{i});
    apr{i} = Evaluate(cluster{i},label{i});
    %计算第i个窗口的比率
    numIncluster = cat(1,numIncluster,numInclusterTemp);
    bilvchahe = CalBilv(k,i,winSize,numIncluster);
    
%     for j = 1:1:k
%         bilv(i,j) = numIncluster(i,j)/winSize;
%         bilvcha(i-1,j) = abs(bilv(i,j) - bilv(i-1,j));
%         bilvchahe = bilvchahe + bilvcha(i-1,j);%记住要让它置零
%     end
    l = 2;
    while(l<=10&&bilvchahe>=0.5)
        window{i}(1:(i-1)*winSize,:) = [];
        winSizeTemp = winSize/l;
        for m = 1:1:l
            if m == 1
                [outliers(i),cluster{i},zeroLocate{i},window{i},label{i},numInclusterTemp] = TJGetDataLabeling(window{i-1},cluster{i-1},window{i},choose,zeroLocate{i-1},label{i-1},label{i});
            else
                [outliers(i),cluster{i},zeroLocate{i},window{i},label{i},numInclusterTemp] = TJGetDataLabeling(window{i},cluster{i},window{i}((m-1)*winSizeTemp+1:m*winSizeTemp,:),choose,zeroLocate{i-1},label{i-1},label{i});
            end
            %有问题
        end
        l = l + 1;
    end
    
end