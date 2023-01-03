function stageStruct = start(stageStruct, experimentInfo)
    % start: creates the start type specific view
    %
    % SYNTAX:   stageData = types.start(stageStruct, experimentInfo)
    %
    % INPUTS:
    %           stageData       stage specific struct for start
    %           experimentInfo  info struct with the experimental information
    %
    % OUTPUTS:
    %           stageData       updated stage specific struct for start
    %
    % EXAMPLE:
    %           stageData = types.start(stageStruct, experimentInfo);
    %

    % type specific variables
    buttom    = stageStruct.stageData.textButtom;
    height    = experimentInfo.screenRect(4);
    textSize  = experimentInfo.viewParam.fontSize;
    textColor = experimentInfo.viewParam.fontColor;
    title     = stageStruct.stageData.textTitle;
    titleSize = 80;
    top       = stageStruct.stageData.textTop;
    
    % build view struct of start type
    variableNames = { ...
        'text', 'xpos',   'ypos',        'color',   'size'};
    text = { ...
        title,  'center', height * 0.15, textColor, titleSize;
        top,    'center', height * 0.30, textColor, textSize;
        buttom, 'center', height * 0.85, textColor, textSize ...
        };

    stageView = table2struct(cell2table(text, 'VariableNames', variableNames));
    stageStruct.stageData.stageView = stageView;
    
    % draw text lines
    tools.psychtoolbox.drawMultiFormattedText(experimentInfo, stageView);
end
