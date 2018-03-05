function [window,minResembleInCluster,minResembleInCluster2,resembleInOrder3,weightingCell2,newRestData3] = GetData2(data)
[r,c] = size(data);
allDataCluster = GetData(data);
%构造第一个滑动窗口
originNumOfCluster = 100;
cluster1 = allDataCluster{3}(1:originNumOfCluster,1:(c-1));%1-->3
cluster2 = allDataCluster{2}(1:originNumOfCluster,1:(c-1));
label(1:originNumOfCluster) = 0;
label(originNumOfCluster+1:2*originNumOfCluster) = 1;
window{1} = cat(1,cluster1,cluster2);
%计算半径扩大数据集的NIR
[weightingCell,column,k,attributeFrequence] = GetDataNIR(label,window{1});
%构造第二类剩余数据NIR由小到大排列的序列
[numOfAvi,gar] = size(allDataCluster{2});
restData = allDataCluster{2}(originNumOfCluster+1:numOfAvi,1:c-1);
[resembleInOrder,newRestData,minResembleInCluster,oldResemble] = OrderNIR(restData,weightingCell,column,k);

%计算每个类的最小类内相似度，存储在minResembleInCluster中

% [newRestData2_r,newRextData2_c] = size(newRestData{2});
% [newRestData1_r,newRextData1_c] = size(newRestData{1});
% cluster1MaxNIR = newRestData{1}(newRestData1_r-originNumOfCluster+1:newRestData1_r,:);
% cluster2MaxNIR = newRestData{2}(newRestData2_r-originNumOfCluster+1:newRestData2_r,:);
% window{1} = cat(1,cluster1MaxNIR,cluster2MaxNIR);
% [weightingCell,column,k,attributeFrequence] = GetDataNIR(label,window{1});
% [resembleInOrderNew,newRestDataNew,minResembleInClusterNew,oldResembleNew] = OrderNIR(restData,weightingCell,column,k);

temp1 = allDataCluster{3}(originNumOfCluster+1:(2*originNumOfCluster),1:(c-1));%1-->3
temp2 = newRestData{2}(1:originNumOfCluster,:);


window{2} = cat(1,temp1,temp2);
%window{2} = cat(1,allDataCluster{1}(originNumOfCluster+1:(2*originNumOfCluster),1:(c-1)),newRestData(1:originNumOfCluster,:));
window{3} = cat(1,allDataCluster{3}(2*originNumOfCluster+1:(3*originNumOfCluster),1:(c-1)),newRestData{2}(originNumOfCluster+1:2*originNumOfCluster,:));%1-->3

%新的由前三个滑动窗口组成的第二类，由两部分组成，第一部分cluster2MaxNIR，第二部分newRestData（1：2*originNumOfCluster）
newCluster2 = cat(1,cluster2,newRestData{2}(1:2*originNumOfCluster,:));
[newCluster2_r,newCluster2_c] = size(newCluster2);
%新的由前三个滑动窗口组成的第一类
%newCluster1 = allDataCluster{1}(1:3*originNumOfCluster,1:(c-1));
newCluster1 = cat(1,cluster1,allDataCluster{3}(originNumOfCluster+1:3*originNumOfCluster,1:(c-1)));%1-->3
[newCluster1_r,newCluster1_c] = size(newCluster1);
%由前三个滑动窗口组成的总数据集
label1(1,1:newCluster1_r) = 0;
label2(1,1:newCluster2_r) = 1;
label12 = cat(2,label1,label2);
newCluster12 = cat(1,newCluster1,newCluster2);
%计算半径扩大数据集的NIR
[weightingCell2,column2,k2,attributeFrequence2] = GetDataNIR(label12,newCluster12);
[resembleInOrder2,newRestData2,minResembleInCluster2,oldResemble2] = OrderNIR(newCluster12,weightingCell2,column2,k2);

%第三类中的数据NIR由小到大排列的数据序列
restData3 = allDataCluster{1}(:,1:c-1);%3-->1
restData4 = allDataCluster{4}(:,1:c-1);
restData5 = allDataCluster{5}(:,1:c-1);
restData6 = allDataCluster{6}(:,1:c-1);
% [numOfRest,attri] = size(restData3);
[resembleInOrder3,newRestData3,minResembleInCluster3,oldResemble3] = OrderNIR(restData3,weightingCell2,column2,k2);
[resembleInOrder6,newRestData6,minResembleInCluster6,oldResemble6] = OrderNIR(restData4,weightingCell2,column2,k2);
[resembleInOrder7,newRestData7,minResembleInCluster7,oldResemble7] = OrderNIR(restData5,weightingCell2,column2,k2);
[resembleInOrder8,newRestData8,minResembleInCluster8,oldResemble8] = OrderNIR(restData6,weightingCell2,column2,k2);

%第一类中的数据NIR由小到大排列的数据序列
[resembleInOrder4,newRestData4,minResembleInCluster4,oldResemble4] = OrderNIR(newCluster1,weightingCell2,column2,k2);

%第二类中的数据NIR由小到大排列的数据序列
[resembleInOrder5,newRestData5,minResembleInCluster5,oldResemble5] = OrderNIR(newCluster2,weightingCell2,column2,k2);
2;
