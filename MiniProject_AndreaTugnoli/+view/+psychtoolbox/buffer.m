function stageStruct = buffer(stageStruct, experimentInfo)
    % buffer: creates the buffer type specific view
    %
    % SYNTAX:   stageData = types.buffer(stageStruct, experimentInfo)
    %
    % INPUTS:
    %           stageData       stage specific struct for buffer
    %           experimentInfo  info struct with the experimental information
    %
    % OUTPUTS:
    %           stageData       updated stage specific struct for buffer
    %
    % EXAMPLE:
    %           stageData = types.buffer(stageStruct, experimentInfo);
    %

    % type specific variables
    fixation      = stageStruct.stageData.symbol;
    fixationColor = experimentInfo.viewParam.fixationColor;
    fixationSize  = experimentInfo.viewParam.fixationSize;

    % build view struct of buffer type
    variableNames = {'text',   'xpos',   'ypos',   'color',       'size'      };
    text          = {fixation, 'center', 'center', fixationColor, fixationSize};

    stageView = cell2struct(text, variableNames, 2);
    stageStruct.stageData.stageView = stageView; % store data to stageStruct

    % draw text lines
    tools.psychtoolbox.drawMultiFormattedText(experimentInfo, stageView);
end
