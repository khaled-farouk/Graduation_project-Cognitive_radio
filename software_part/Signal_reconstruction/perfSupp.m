function [F, P, R, ind] = perfSupp(estSource, trueSourceIndex, varargin)



if length(varargin) == 2
    switch lower(varargin{1})
        case 'firstlargest'
            numThreshold = varargin{2};
            estSource = sum(estSource.^2,2);
            [sortedSource,sortInd] = sort(estSource, 1, 'descend');
            ind = sortInd(1:numThreshold);

        case 'largerthan'
            valThreshold = varargin{2};
            estSource = sum(estSource.^2,2);
            ind = find(estSource >= valThreshold);

    end
else
    error('Optional parameters are wrong!\n');
end

commonSupp = intersect(ind,trueSourceIndex);

if isempty(commonSupp), 
    F = 0; P = 0; R = 0;
else
    P = length(commonSupp)/length(ind);
    R = length(commonSupp)/length(trueSourceIndex);
    F = 2 * P * R/(P + R);
end



