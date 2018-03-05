function [window,label,cluNumInWin] = CreateWindow(data,winNum,winSize,cluNumInWin,whichClu)
[r,c] = size(data);
[cluData,k] = GetData(data);
cluSize = winSize/cluNumInWin;
for i = 1:1:winNum
    window{i} = zeros(1,c);
    for j = 1:1:cluNumInWin
        window{i} = cat(1,window{i},cluData{whichClu(j)}((i-1)*cluSize+1:i*cluSize,:));
    end
end
for i = 1:1:winNum
%    label{i} = zeros(1,1);
    window{i}(1,:) = [];
    label{i} = window{i}(:,c);
    window{i}(:,c) = [];
%    label{i}(1,:) = [];
end
2;