function stageData = response()
    % response: creates the response type specific stage data
    %
    % SYNTAX:   stageData = types.response()
    %
    % INPUTS:
    %           None
    %
    % OUTPUTS:
    %           stageData       stage specific struct for response
    %
    % EXAMPLE:
    %           stageData = types.response();
    %

    % BaseStruct of type task
    stageData = struct(...
        'previousResponse',  false, ...
        'previousIsCorrect', false ...
        );

    % defining parameters for type task
    stageData        = tools.addSymbol(stageData);
end
