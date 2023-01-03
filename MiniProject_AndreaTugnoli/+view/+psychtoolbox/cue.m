function stageStruct = cue(stageStruct, experimentInfo)
    % cue: creates the cue type specific view
    %
    % SYNTAX:   stageData = types.buffer(stageStruct, experimentInfo)
    %
    % INPUTS:
    %           stageData       stage specific struct for cue
    %           experimentInfo  info struct with the experimental information
    %
    % OUTPUTS:
    %           stageData       updated stage specific struct for cue
    %
    % EXAMPLE:
    %           stageData = types.cue(stageStruct, experimentInfo);
    %

    % type specific variables
    window = experimentInfo.windowIdx;

    if iscell(stageStruct.stageData.scaledData)
        scaledData = stageStruct.stageData.scaledData{stageStruct.stageData.dataSetID};
    else
        scaledData = stageStruct.stageData.scaledData;
    end

    % create texture if image wasn't loaded already
    if isnan(stageStruct.stageData.ptrIdx)
        stageStruct.stageData.ptrIdx = ...
            Screen('MakeTexture', window, scaledData);
    end

    % draw the image centered on the screen
    Screen('DrawTexture', window, stageStruct.stageData.ptrIdx);
end
