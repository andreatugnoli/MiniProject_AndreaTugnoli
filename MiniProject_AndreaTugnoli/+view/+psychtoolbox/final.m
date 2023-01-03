function stageStruct = final(stageStruct, experimentInfo)
    % final: creates the final type specific view
    %
    % SYNTAX:   stageData = types.final(stageStruct, experimentInfo)
    %
    % INPUTS:
    %           stageData       stage specific struct for final
    %           experimentInfo  info struct with the experimental information
    %
    % OUTPUTS:
    %           stageData       updated stage specific struct for final
    %
    % EXAMPLE:
    %           stageData = types.final(stageStruct, experimentInfo);
    %

    % type specific variables
    buttom        = stageStruct.stageData.textButtom;
    height        = experimentInfo.screenRect(4);
    textSize      = experimentInfo.defaultParam.FONTSIZE;
    title         = stageStruct.stageData.textTitle;
    titleSize     = 80;
    
    % build view struct of instruction type
    variableNames = {'text',   'xpos',   'ypos',        'color', 'size'   };
    text          = {title,    'center', height * 0.15, 'white', titleSize;
                     buttom,   'center', height * 0.85, 'white', textSize ...
                     };
    
    stageView = cell2struct(text, variableNames, 2);
    stageStruct.stageData.stageView = stageView;
    
    % draw text lines
    tools.psychtoolbox.drawMultiFormattedText(experimentInfo, stageView);
end
