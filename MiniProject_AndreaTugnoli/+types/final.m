function stageData = final()
    % final: creates the final type specific stage data
    %
    % SYNTAX:   stageData = types.final()
    %
    % INPUTS:
    %           None
    %
    % OUTPUTS:
    %           stageData       stage specific struct for final
    %
    % EXAMPLE:
    %           stageData = types.final();
    %

    % type specific variables
    title      = 'The End';
    textButtom = ...
        ['Thanks for your participation!'];

    % initial BaseStruct of type task
    stageData = struct([]);

    % defining parameters for type task
    stageData = tools.addText(stageData, 'textTitle',  title);
    stageData = tools.addText(stageData, 'textButtom', textButtom);
end
