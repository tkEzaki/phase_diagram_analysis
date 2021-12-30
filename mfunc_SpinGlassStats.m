function [m, q, chiSG, chiUni] = mfunc_SpinGlassStats(binarizedData)
mLocal = sum(binarizedData, 2) / size(binarizedData,2) 
nodeNumber = size(mLocal,1)
m = sum(mLocal,1) / nodeNumber
q = dot(mLocal, mLocal) / nodeNumber;
covariance = cov(binarizedData')
lambda = eig(covariance);
chiSG = dot(lambda, lambda) / nodeNumber;
chiUni = sum(sum(covariance)) / nodeNumber;
end

