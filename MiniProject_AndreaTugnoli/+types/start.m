function stageData = start()
    % start: creates the start type specific stage data
    %
    % SYNTAX:   stageData = types.start()
    %
    % INPUTS:
    %           None
    %
    % OUTPUTS:
    %           stageData       stage specific struct for start
    %
    % EXAMPLE:
    %           stageData = types.start();
    %

    % type specific variables
    title      = 'Is it a painting?';
    textTop    = ['Designed by A. Tugnoli\n' ...
        ' GSEM - IEE - Unige'];
    textButtom = 'Press any key to start with the instructions';

    % initial BaseStruct of type task
    stageData = struct(...
        'infoAlreadyDisp', false ...
        );

    % defining parameters for type task
    stageData = tools.addText(stageData, 'textTitle', title);
    stageData = tools.addText(stageData, 'textTop', textTop);
    stageData = tools.addText(stageData, 'textButtom', textButtom);
end
