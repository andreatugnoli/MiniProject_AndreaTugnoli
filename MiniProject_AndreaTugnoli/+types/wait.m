function stageData = wait()
    % wait: creates the wait type specific stage data
    %
    % SYNTAX:   stageData = types.wait()
    %
    % INPUTS:
    %           None
    %
    % OUTPUTS:
    %           stageData       stage specific struct for wait
    %
    % EXAMPLE:
    %           stageData = types.wait();
    %

    % type specific variables
    textTop    = '..............';

    % initial BaseStruct for this type
    stageData = struct([]);
    
    % defining parameters for this type
    stageData = tools.addText(stageData, 'textTop', textTop);
    stageData = tools.addSymbol(stageData);
end
