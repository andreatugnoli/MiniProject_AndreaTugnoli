function stageData = fixation()
    % fixation: creates the fixation type specific stage data
    %
    % SYNTAX:   stageData = types.fixation()
    %
    % INPUTS:
    %           None
    %
    % OUTPUTS:
    %           stageData       stage specific struct for fixation
    %
    % EXAMPLE:
    %           stageData = types.fixation();
    %

    % initial BaseStruct for this type
    stageData = struct([]);
    
    % defining parameters for this type
    stageData = tools.addSymbol(stageData);
end
