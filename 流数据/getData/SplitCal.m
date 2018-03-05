function out = SplitCal(i,minValue,n,window)
l = 2;
while(l<=n&&bilvchahe>=minValue)
    window{i}(1:(i-1)*winSize,:) = [];
    winSizeTemp = winSize/l;
    for m = 1:1:l
        if m == 1
            [outliers(i),cluster{i},zeroLocate{i},window{i},label{i},numInclusterTemp] = TJGetDataLabeling(window{i-1},cluster{i-1},window{i},choose,zeroLocate{i-1},label{i-1},label{i});
        else
            [outliers(i),cluster{i},zeroLocate{i},window{i},label{i},numInclusterTemp] = TJGetDataLabeling(window{i},cluster{i},window{i}((m-1)*winSizeTemp+1:m*winSizeTemp,:),choose,zeroLocate{i-1},label{i-1},label{i});
        end
            %”–Œ Ã‚
    end
    l = l + 1;
end