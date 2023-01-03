function stageStruct = task(stageStruct, experimentInfo)
    % task: creates the task type specific view
    %
    % SYNTAX:   stageData = types.task(stageStruct, experimentInfo)
    %
    % INPUTS:
    %           stageData       stage specific struct for task
    %           experimentInfo  info struct with the experimental information
    %
    % OUTPUTS:
    %           stageData       updated stage specific struct for task
    %
    % EXAMPLE:
    %           stageData = types.task(stageStruct, experimentInfo);
    %

    % type specific variables
    fixation      = stageStruct.stageData.symbol;
    fixationColor = experimentInfo.viewParam.fixationColor;
    fixationSize  = experimentInfo.viewParam.fixationSize;
    height        = experimentInfo.screenRect(4);
    word          = stageStruct.stageData.combinations{stageStruct.stageData.dataSetID, 2};
    wordColor     = stageStruct.stageData.combinations{stageStruct.stageData.dataSetID, 1};
    wordSize      = 80;

    % build view struct of instruction type
    variableNames = { ...
        'text',   'xpos',   'ypos',        'color',       'size'};
    text = { ...
        word,     'center', height * 0.30, wordColor,     wordSize;
        fixation, 'center', 'center',      fixationColor, fixationSize ...
        };

    stageView = cell2struct(text, variableNames, 2);
    stageStruct.stageData.stageView = stageView;
    
    % draw text lines
    tools.psychtoolbox.drawMultiFormattedText(experimentInfo, stageView);
end
