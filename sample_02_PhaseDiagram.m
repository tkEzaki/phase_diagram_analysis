% 2021/12/30 by T. Ezaki 
% Sample code for computing the phase diagram.
% Parallelization may be needed in practice (with sufficiently large tMax).

% read h and J estimated for the input data
h = dlmread('data\\PMEM\\h_sample.dat');
J = dlmread('data\\PMEM\\J_sample.dat');

% tMax = 10^6
% sufficient tMax value depends on N
tMax = 1000;

% visualize the results
show = true;

% initialize results variables
mResults = zeros(23,21);
qResults = zeros(23,21);
chiUniResults = zeros(23,21);
chiSGResults = zeros(23,21);
CResults = zeros(23,21);


for i = 1:23
    mu = - 0.0015 + 0.0005 * i;
    for j = 1:21
        stdev = 0.005 * (j - 1);
        
        % main computation part
        JTilde = mfunc_AffineTransJ(J, mu, stdev);
        [m, q, chiUni, chiSG, C, localm, corr] = pfunc_03_Metropolice(h, JTilde, tMax);
        
        % store results
        mResults(i,j) = m;
        qResults(i,j) = q;
        chiUniResults(i,j) = chiUni;
        chiSGResults(i,j) = chiSG;
        CResults(i,j) = C;
        i, j
    end
end

% save results
dlmwrite('data\\phase_diagrams\\pd_m.dat', mResults,'delimiter','\t')
dlmwrite('data\\phase_diagrams\\pd_q.dat', qResults,'delimiter','\t')
dlmwrite('data\\phase_diagrams\\pd_chiUni.dat', chiUniResults,'delimiter','\t')
dlmwrite('data\\phase_diagrams\\pd_chiSG.dat', chiSGResults,'delimiter','\t')
dlmwrite('data\\phase_diagrams\\pd_C.dat',CResults,'delimiter','\t')

% mu and sigma conditions used
muList = linspace(-0.001, 0.01, 23)'
sigmaList = linspace(0, 0.1,21)
dlmwrite('data\\phase_diagrams\\mu_list.dat', muList,'delimiter','\t')
dlmwrite('data\\phase_diagrams\\sigma_list.dat', sigmaList,'delimiter','\t')

% visualization
if show
    surf(sigmaList, muList, mResults)
    % surf(sigmaList, muList, qResults)
    % surf(sigmaList, muList, chiUniResults)
    % surf(sigmaList, muList, chiSGResults)
    % surf(sigmaList, muList, CResults)
    hold on
    xlim([-0.001 0.1]);
    ylim([-0.001 0.01]);
    ylabel("\mu")
    xlabel("\sigma")
    hold off
end