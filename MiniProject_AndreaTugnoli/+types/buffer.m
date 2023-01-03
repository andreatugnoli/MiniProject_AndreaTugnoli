function stageData = buffer()
    % buffer: creates the buffer type specific stage data
    %
    % SYNTAX:   stageData = types.buffer()
    %
    % INPUTS:
    %           None
    %
    % OUTPUTS:
    %           stageData       stage specific struct for buffer
    %
    % EXAMPLE:
    %           stageData = types.buffer();
    %

    % initial BaseStruct for this type
    stageData = struct([]);

    % defining parameters for this type
    stageData = tools.addSymbol(stageData);
end