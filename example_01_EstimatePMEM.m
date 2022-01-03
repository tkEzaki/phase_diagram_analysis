% 2021/12/30 by T. Ezaki 
% Sample code for estimating PMEM

% input: binarized data
binarizedData = dlmread('data\\input_data\\concatenated_binarized_time_series.dat');
[nodeNumber, dataLength] = size(binarizedData)

% estimate h and J
[h, J] = pfunc_02_Inferrer_PL(binarizedData);

% save
dlmwrite('data\\PMEM\\h.dat', h', 'delimiter', '\t')
dlmwrite('data\\PMEM\\J.dat', J, 'delimiter', '\t')


% sample data from the estimated model and compute stats
[m, q, chiUni, chiSG, C, localm, corr] = pfunc_03_Metropolice(h', J, 10000);

% empirical mean and corr 
dataMean = mean(binarizedData,2);
dataCorrelation = (binarizedData*binarizedData')/dataLength;

% plot mean and correlation values PMEM and empirical data
scatter(reshape(dataCorrelation, [1, nodeNumber*nodeNumber]), reshape(corr, [1, nodeNumber*nodeNumber]))
hold on
xlim([-1,1])
ylim([-1,1])
xlabel('Empirical mean and correlation values')
ylabel('PMEM mean and correlation values')
scatter(dataMean, localm)
plot([-1 1],[-1 1])
hold off