function screenFlip(experimentInfo)

    assert(strcmp(experimentInfo.expToolbox, 'psychtoolbox'), ...
        'tools:psychtoolbox:initialize', ...
        'Wrong toolbox is specified! This function just runs with "psychtoolbox"');
    
    % Flip the screen
    Screen('Flip', experimentInfo.windowIdx);
end

