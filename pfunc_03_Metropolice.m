function [m, q, chiUni, chiSG, C, localm, corr] = pfunc_03_Metropolice(h, J, t_max)
nodeNumber = size(h,2);
localm = zeros(nodeNumber,1);
corr = zeros(nodeNumber);

sigma = ones(nodeNumber,1);
step_max = t_max * nodeNumber;
E = 0;
E2 = 0;

for t = 1 : step_max
    n = randi([1,nodeNumber]);
    dE  = - 2 * h(n) * sigma(n) - 2 * dot(J(:, n), sigma) * sigma(n);
    p = min(1, exp(dE));
    if rand <= p
        sigma(n) = sigma(n) * (-1);
    end
end


for t = 1 : step_max
    n = randi([1,nodeNumber]);
    dE  = - 2 * h(n) * sigma(n) - 2 * dot(J(:, n), sigma) * sigma(n);
    p = min(1, exp(dE));
    if rand <= p
        sigma(n) = sigma(n) * (-1);
    end
    
    if mod(t, nodeNumber) == 0
        localm = localm + sigma;
        corr = corr + sigma * sigma';
        energy = -(0.5 * J * sigma)' * sigma - dot(h, sigma); 
        E = E - energy;
        E2 = E2 + energy * energy ;
    end
end

localm = localm / t_max;
corr = corr / t_max;
covariance = corr - localm * localm';
E = E / t_max;
E2 = E2 / t_max;
C = (E2 - E * E) / nodeNumber;
q = dot(localm, localm) / nodeNumber;
m = sum(localm) / nodeNumber;
lambda = eig(covariance);
chiSG = dot(lambda, lambda) / nodeNumber;
chiUni = sum(sum(covariance)) / nodeNumber;

end

