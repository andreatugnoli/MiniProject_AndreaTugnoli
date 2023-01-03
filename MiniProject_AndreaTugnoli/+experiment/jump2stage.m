function [stages, experimentInfo, terminate] = ...
    jump2stage(stages, experimentInfo, newStage)

    % initial variables
    terminate = false;
    
    if ischar(newStage)
        switch newStage
            case {'start', 'first', 'begin'}
                newStage = 1;
            case {'end',   'last',  'final'}
                newStage = numel(stages);
            otherwise
                error('The case %s is not defined!', newStage);
        end
    end
    
    assert(isnumeric(newStage) && newStage > 0 && newStage <= numel(stages), ...
        'experiment:jump2stage:newStage', ...
        ['The input for the new stage should be the stagenumber or a ' ...
        'character array like: start, first, bedin, end, last, final']);


    if any(experimentInfo.currentStage == experimentInfo.positionTaskStages(1,:)-1)
        experimentInfo.timerIdx = tic();
    end

    experimentInfo.currentStage = newStage;
    stages(experimentInfo.currentStage).onSet = toc(experimentInfo.timerIdx);
    stages(experimentInfo.currentStage).daytime = datetime();

end