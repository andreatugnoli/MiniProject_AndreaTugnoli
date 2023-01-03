function stageStruct = wait(stageStruct, experimentInfo)
    % wait: creates the wait type specific view
    %
    % SYNTAX:   stageData = types.wait(stageStruct, experimentInfo)
    %
    % INPUTS:
    %           stageData       stage specific struct for wait
    %           experimentInfo  info struct with the experimental information
    %
    % OUTPUTS:
    %           stageData       updated stage specific struct for wait
    %
    % EXAMPLE:
    %           stageData = types.wait(stageStruct, experimentInfo);
    %

    % variables
    fixation      = stageStruct.stageData.symbol;
    fixationColor = experimentInfo.viewParam.fixationColor;
    fixationSize  = experimentInfo.viewParam.fixationSize;
    height        = experimentInfo.screenRect(4);
    textColor     = experimentInfo.viewParam.fontColor;
    textSize      = experimentInfo.viewParam.fontSize;
    top           = stageStruct.stageData.textTop;
    
    % build view struct of instruction type
    variableNames = { ...
        'text',   'xpos',   'ypos',        'color',       'size'};
    text = { ...
        top,      'center', height * 0.30, textColor,     textSize;
        fixation, 'center', 'center',      fixationColor, fixationSize ...
        };

    stageView = cell2struct(text, variableNames, 2);
    stageStruct.stageData.stageView = stageView;
    
    % draw text lines
    tools.psychtoolbox.drawMultiFormattedText(experimentInfo, stageView);
end
