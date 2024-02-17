function Out = EcaF_Saturate(In, minValue,maxValue)
% Saturate an input between a min and a max
%
% :usage: Out = EcaF_Saturate(In, minValue,maxValue)
%
% :param In: scalar to saturate
% :param minValue: min scalar value
% :param maxValue: max scalara value
%
% :returns: saturated value between min and max value

if maxValue < minValue
    [minValue,maxValue] = SwapValues(minValue,maxValue);
end

Out = SaturateMin(In,   minValue);
Out = SaturateMax(Out,  maxValue);
end

function Out = SaturateMin(In,minValue)
Out = max(In,minValue);
end

function Out = SaturateMax(In,maxValue)
Out = min(In,maxValue);
end

function [minValue,maxValue] = SwapValues(minValue,maxValue)
tmpMin =    minValue;
minValue =  maxValue;
maxValue =  tmpMin;
end
