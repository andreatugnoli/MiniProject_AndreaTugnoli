function stageStruct = response(stageStruct, experimentInfo)
    % response: creates the response type specific view
    %
    % SYNTAX:   stageData = types.response(stageStruct, experimentInfo)
    %
    % INPUTS:
    %           stageData       stage specific struct for response
    %           experimentInfo  info struct with the experimental information
    %
    % OUTPUTS:
    %           stageData       updated stage specific struct for response
    %
    % EXAMPLE:
    %           stageData = types.response(stageStruct, experimentInfo);
    %

    % type specific variables
    fixation      = stageStruct.stageData.symbol;
    fixationColor = experimentInfo.viewParam.fixationColor;
    fixationSize  = experimentInfo.viewParam.fixationSize;
    height        = experimentInfo.screenRect(4);
    textSize      = experimentInfo.viewParam.fontSize;
    textColor     = experimentInfo.viewParam.fontColor;

    % checking the data from the response for build up the screen
    response = 'No response! You have to answer in max 3 seconds!';
    if stageStruct.stageData.previousIsCorrect
        response = 'Yes! the answer is correct';
    elseif stageStruct.stageData.previousResponse && ...
            ~stageStruct.stageData.previousIsCorrect
        response = 'No! The picture is a painting!';
    end

    % build view struct of instruction type
    variableNames = { ...
        'text',   'xpos',        'ypos',        'color',       'size'};
    text = { ...
        response, 'center',      height * 0.85, textColor,     textSize;
        fixation, 'center',      'center',      fixationColor, fixationSize ...
        };

    stageView = cell2struct(text, variableNames, 2);
    stageStruct.stageData.stageView = stageView;
    
    % draw text lines
    tools.psychtoolbox.drawMultiFormattedText(experimentInfo, stageView);
end
