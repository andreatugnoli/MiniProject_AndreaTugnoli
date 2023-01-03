function stageStruct = fixation(stageStruct, experimentInfo)
    % fixation: creates the fixation type specific view
    %
    % SYNTAX:   stageData = types.fixation(stageStruct, experimentInfo)
    %
    % INPUTS:
    %           stageData       stage specific struct for fixation
    %           experimentInfo  info struct with the experimental information
    %
    % OUTPUTS:
    %           stageData       updated stage specific struct for fixation
    %
    % EXAMPLE:
    %           stageData = types.fixation(stageStruct, experimentInfo);
    %

    % type specific variables
    fixation      = stageStruct.stageData.symbol;
    fixationColor = experimentInfo.viewParam.fixationColor;
    fixationSize  = experimentInfo.viewParam.fixationSize;
    
    % build view struct of fixation type
    variableNames = {'text',   'xpos',   'ypos',   'color',       'size'      };
    text          = {fixation, 'center', 'center', fixationColor, fixationSize};
    
    stageView = cell2struct(text, variableNames, 2);
    stageStruct.stageData.stageView = stageView;
    
    % draw text lines
    tools.psychtoolbox.drawMultiFormattedText(experimentInfo, stageView);
end
