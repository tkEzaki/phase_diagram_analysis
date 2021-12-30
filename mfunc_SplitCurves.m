function [splitCurvex,splitCurvey] = mfunc_SplitCurves(curvex,curvey, xmax, ymax)
% trims a curve by x < xmax and y < ymax

splitCurvex = []
splitCurvey = []
record = false

for i = 1:size(curvex, 2)
    if curvex(i) < xmax & curvey(i) < ymax
        if ~record
            record = true
            splitCurvex = [splitCurvex curvex(i)];
            splitCurvey = [splitCurvey curvey(i)];
        else
            splitCurvex = [splitCurvex curvex(i)];
            splitCurvey = [splitCurvey curvey(i)];
        end
    elseif record
        if size(splitCurvex, 2) < 5 % if fragmented
            splitCurvex = []
            splitCurvey = []
            record = false % continue
        else
            % end search
            break
        end
    end    
end