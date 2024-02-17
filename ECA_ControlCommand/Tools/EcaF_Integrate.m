function integral = EcaF_Integrate(previousIntegral, previousValue,currentValue,timeStep)
% Integration of a value according to the previous integral the difference at the previous step the difference at the current step (timeStep)
%
% :usage: integral = EcaF_Integrate(previousIntegral, previousValue,currentValue,timeStep)

if timeStep < 0
    ThrowNegativeTimeStep();
end

value_average =     AveragePastValues(  previousValue,  currentValue);
innovation =        CalculateInnovation(value_average,  timeStep);
integral =          previousIntegral + innovation;
end


function average = AveragePastValues(previousValue,currentValue)
average = (previousValue + currentValue)/2;
end

function innovation = CalculateInnovation(valueAverage,timeStep)
innovation = timeStep * valueAverage;
end

function ThrowNegativeTimeStep()
error('EcaF_Integrate:NegativeTimeStep','Time Step must have positive values!');
end

