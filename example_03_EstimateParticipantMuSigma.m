% 2021/12/30 by T. Ezaki 
% Example code for estimating the location of each participant in the 
% phase diagram. 

% read single participant data
data = dlmread("data\\input_data\\pat_1.dat")

% compute chiSG and chiUni for the participant 
binarizedData = pfunc_01_Binarizer(data, 0)
[m, q, chiSG, chiUni] = mfunc_SpinGlassStats(binarizedData)

% read sample phase diagram data
muList = dlmread("data\\phase_diagrams\\mu_list_sample.dat")
sigmaList = dlmread("data\\phase_diagrams\\sigma_list_sample.dat")
pdChiUni = dlmread("data\\phase_diagrams\\pd_chiUni_sample.dat")
pdChiSG = dlmread("data\\phase_diagrams\\pd_chiSG_sample.dat")

% plot pdChiUni
surf(sigmaList, muList, pdChiUni, "FaceColor", "r", "FaceAlpha", 0.3)
ylabel("\mu")
xlabel("\sigma")
hold on

% estimate mu-sigma curve satisfying pdChiUni(mu, sigma) = chiUni
cUni = contourc(sigmaList, muList,pdChiUni, [chiUni,chiUni])
cxUni = cUni(1,2:end);
cyUni = cUni(2,2:end);

% limit to paramagnetic phase
sigmaMax = 0.05 
muMax = 0.005
[cxUni, cyUni] = mfunc_SplitCurves(cxUni,cyUni, sigmaMax, muMax)

% plot mu-sigma curve for chiUni
plot3(cxUni, cyUni, chiUni * ones(size(cxUni)), "LineWidth", 4, "Color", "r");


% plot pdChiSG
surf(sigmaList, muList, pdChiSG, "FaceColor", "b", "FaceAlpha", 0.3)

% estimate mu-sigma curve satisfying pdChiUni(mu, sigma) = chiUni
cSG = contourc(sigmaList, muList,pdChiSG, [chiSG,chiSG]);
cxSG = cSG(1,2:end);
cySG = cSG(2,2:end);
[cxSG, cySG] = mfunc_SplitCurves(cxSG,cySG, sigmaMax, muMax)

% plot mu-sigma curve for chiSG
plot3(cxSG, cySG, chiSG * ones(size(cxSG)), "LineWidth", 4, "Color", "b");

xlim([-0.001 0.1]);
ylim([-0.001 0.01]);

hold off

% obtain intersection between the two mu-sigma curves
[sigma, mu] = intersections(cxUni, cyUni, cxSG, cySG)
