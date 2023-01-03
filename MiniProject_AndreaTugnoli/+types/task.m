function stageData = task()
    % task: creates the task type specific stage data
    %
    % SYNTAX:   stageData = types.task()
    %
    % INPUTS:
    %           None
    %
    % OUTPUTS:
    %           stageData       stage specific struct for task
    %
    % EXAMPLE:
    %           stageData = types.task();
    %

    % type specific variables
    color = {'white', 'white'};
    word  = {'Is it a painting?', 'Is it a painting?'};
    repColor  = repmat(color, numel(color), 1);
    repWord   = repmat(word, 1, numel(word));

    % BaseStruct of type task
    stageData = struct(...
        'combinations', '', ...
        'dataSetID',    nan, ...
        'response',     nan, ...
        'responseTime', nan, ...
        'isCorrect',    nan ...
        );

    % defining parameters for type task
    stageData.combinations = reshape({repColor{:}, repWord{:}}, numel(repColor), []); %#ok
    stageData = tools.addSymbol(stageData);
end
