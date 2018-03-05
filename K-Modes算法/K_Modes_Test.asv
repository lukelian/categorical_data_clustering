
function K_Modes_Test(Data,time)%对0-1匹配打标签的算法进行测试
%输入：
%Data ：数据集(包括决策属性-最后一列)
%time  运行次数
%输出：算法聚类结果（包括精度，召回率，纯度）
[N,Col] = size(Data);            %N:总的对象数  Col 属性个数(包括决策属性)!!!!!
K = length(unique(Data(:,Col))); %K 聚类个数
tic;
t =1;
TotalAC = 0;
TotalPR = 0;
TotalRE = 0;
disp('K-Modes算法开始');
while t <= time
  estimatedlabel = Hard_K_Mode(Data(:,[1:Col-1]),K);
  Result_Matrix=Generate_Cluster_Matrix(estimatedlabel',Data(:,size(Data,2)));
  % estimatedlabel=[1,1,1,2,2,2];
  % Result_Matrix=Generate_Cluster_Matrix(estimatedlabel',[1,1,2,2,3,3]');
    [AC,PR,RE]=Three_measure(Result_Matrix,size(Data,1));
    disp(strcat('第',int2str(t),'次计算的结果如下:'));
     disp(strcat('AC:',num2str(AC),',    PR:',num2str(PR),',   RE:',num2str(RE)));
    TotalAC = TotalAC + AC;
    TotalPR = TotalPR + PR;
    TotalRE = TotalRE + RE;
    t = t +1;
end

   AC = TotalAC/time;
   PR = TotalPR/time;
   RE = TotalRE/time;
 disp('***************************************************');
 disp(strcat('   K-Modes算法:',int2str(time),'次计算的平均结果如下:'));
 disp(strcat('   AC:',num2str(AC),',     PR:',num2str(PR),',   RE:',num2str(RE)));
 disp('***************************************************');
 toc;