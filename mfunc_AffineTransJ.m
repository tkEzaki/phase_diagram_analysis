function [JTilde] = mfunc_AffineTransJ(J, mu, stdev)
%M_FUNC_AFFINETRANSJ この関数の概要をここに記述
%   詳細説明をここに記述
JTemp = J;
a = size(JTemp,1);
JTemp(1:a+1:end) = [];
JOffDiag = reshape(JTemp, a-1, []);

stdOrig = std(JOffDiag(:));
muOrig = mean(JOffDiag(:));

JTilde = (J - (ones(size(J))-eye(size(J)))* muOrig) * stdev / stdOrig +  ones(size(J)) * mu;
end

