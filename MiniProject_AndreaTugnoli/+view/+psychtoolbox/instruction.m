function stageStruct = instruction(stageStruct, experimentInfo)
    % instruction: creates the instruction type specific view
    %
    % SYNTAX:   stageData = types.instruction(stageStruct, experimentInfo)
    %
    % INPUTS:
    %           stageData       stage specific struct for instruction
    %           experimentInfo  info struct with the experimental information
    %
    % OUTPUTS:
    %           stageData       updated stage specific struct for instruction
    %
    % EXAMPLE:
    %           stageData = types.instruction(stageStruct, experimentInfo);
    %

    % type specific variables
    buttom        = stageStruct.stageData.textButtom;
    fixation      = stageStruct.stageData.symbol;
    fixationColor = experimentInfo.viewParam.fixationColor;
    fixationSize  = experimentInfo.viewParam.fixationSize;
    height        = experimentInfo.screenRect(4);
    text2invert   = stageStruct.stageData.text2invert;
    textColor     = experimentInfo.viewParam.fontColor;
    textSize      = experimentInfo.viewParam.fontSize;
    title         = stageStruct.stageData.textTitle;
    titleSize     = 80;
    top           = stageStruct.stageData.textTop;
    width         = experimentInfo.screenRect(3);

    if stageStruct.responseInvert
        fliplr(text2invert);
    end

    left  = sprintf(stageStruct.stageData.textLeft, text2invert{1});
    right = sprintf(stageStruct.stageData.textRight, text2invert{2});

    % build view struct of instruction type
    variableNames = { ...
        'text',   'xpos',        'ypos',        'color',       'size'};
    text = { ...
        title,    'center',      height * 0.15, textColor,     titleSize;
        top,      'center',      height * 0.30, textColor,     textSize;
        buttom,   'center',      height * 0.85, textColor,     textSize;
        left,     width * 0.075, 'center',      textColor,     textSize;
        right,    width * 0.625, 'center',      textColor,     textSize;
        fixation, 'center',      'center',      fixationColor, fixationSize ...
        };

    stageView = cell2struct(text, variableNames, 2);
    stageStruct.stageData.stageView = stageView;

    % draw text lines
    tools.psychtoolbox.drawMultiFormattedText(experimentInfo, stageView);
end
