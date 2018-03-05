function bilvchahe = CalBilv(k,i,winSize,numIncluster)

% numIncluster = zeros(1,k);
bilvchahe = 0;
bilv = zeros(1,k);
bilvcha = zeros(1,k);

% for i = 1:1:k
%     [gar,numIncluster(1,i)] = size(find(cluster{1}==i));
%     bilv(1,i) = numIncluster(1,i)/winSize;
% end

for j = 1:1:k
    bilv(i,j) = numIncluster(i,j)/winSize;
    bilvcha(i-1,j) = abs(bilv(i,j) - bilv(i-1,j));
    bilvchahe = bilvchahe + bilvcha(i-1,j);%记住要让它置零
end