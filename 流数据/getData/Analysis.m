function [apr,cluster,outliers,zeroLocate] = Analysis(data,winNum,winSize,cluNumInWin,whichClu,choose)%不向前一个窗口添加的分析
[window,label,k] = CreateWindow(data,winNum,winSize,cluNumInWin,whichClu);
[r,c] = size(window);
cluster{1} = Correct_Hard_K_Mode(window{1},k);
apr{1} = Evaluate(cluster{1},label{1});
for i = 2:1:c
%    [outliers(i),cluster{i}] = DataLabeling(window{i-1},cluster{i-1},window{i});
    [outliers(i),cluster{i},zeroLocate{i}] = GetDataLabeling(window{i-1},cluster{i-1},window{i},choose);
    window{i}(zeroLocate{i},:)=[];%将outliers从原数据集中去除
    label{i}(zeroLocate{i},:) = [];%将outliers对应的人工label去除
    apr{i} = Evaluate(cluster{i},label{i});
end