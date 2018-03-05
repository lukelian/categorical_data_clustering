function [apr,cluster,outliers,zeroLocate] = Analysis(data,winNum,winSize,cluNumInWin,whichClu,choose)%����ǰһ��������ӵķ���
[window,label,k] = CreateWindow(data,winNum,winSize,cluNumInWin,whichClu);
[r,c] = size(window);
cluster{1} = Correct_Hard_K_Mode(window{1},k);
apr{1} = Evaluate(cluster{1},label{1});
for i = 2:1:c
%    [outliers(i),cluster{i}] = DataLabeling(window{i-1},cluster{i-1},window{i});
    [outliers(i),cluster{i},zeroLocate{i}] = GetDataLabeling(window{i-1},cluster{i-1},window{i},choose);
    window{i}(zeroLocate{i},:)=[];%��outliers��ԭ���ݼ���ȥ��
    label{i}(zeroLocate{i},:) = [];%��outliers��Ӧ���˹�labelȥ��
    apr{i} = Evaluate(cluster{i},label{i});
end