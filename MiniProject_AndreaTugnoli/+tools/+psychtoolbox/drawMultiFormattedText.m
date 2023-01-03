function drawMultiFormattedText(experimentInfo, stageView)

    assert(strcmp(experimentInfo.expToolbox, 'psychtoolbox'), ...
        'tools:psychtoolbox:initialize', ...
        'Wrong toolbox is specified! This function just runs with "psychtoolbox"');

    % draw stageView structure with DrawFormattedText
    for currentText = 1:numel(stageView)
        Screen('TextSize', experimentInfo.windowIdx, stageView(currentText).size);
        DrawFormattedText(experimentInfo.windowIdx, ...
                          stageView(currentText).text, ...
                          stageView(currentText).xpos, ...
                          stageView(currentText).ypos, ...
                          tools.colorParser(stageView(currentText).color));
    end

    % set back to default font size
    tools.psychtoolbox.resetFontSize(experimentInfo);
end

