function experimentInfo = initialize(experimentInfo)
% initialize: initializes the screen window
    %
    % SYNTAX:   experimentInfo = tools.initialize(experimentInfo)
    %
    % INPUTS:
    %           experimentInfo  info structure with all the informations about
    %                           the experiment
    %
    % OUTPUTS:
    %           experimentInfo  updated info structure with all the informations
    %                           about the experiment
    %
    % EXAMPLE:
    %           experimentInfo = addInfo(5);
    %           experimentInfo = tools.initialize(experimentInfo);
    %

    % check if experimentInfo is given as input
    if ~exist('experimentInfo', 'var')
        experimentInfo.screenRect            = [0, 0, 800, 600];
        experimentInfo.screenNumber          = max(Screen('Screens'));
        experimentInfo.defaultParam.FONTNAME = 'Vivaldi';
        experimentInfo.defaultParam.FONTSIZE = 30;
        experimentInfo.expToolbox            = 'psychtoolbox';
        experimentInfo.backgroundColor       = 'blue';
    end
    
    assert(strcmp(experimentInfo.expToolbox, 'psychtoolbox'), ...
        'tools:psychtoolbox:initialize', ...
        'Wrong toolbox is specified! This function just runs with "psychtoolbox"');

    % Update sync test option depending on OS
    if ~ispc()
%         Screen('Preference', 'SkipSyncTests', 1);
        Screen('Preference', 'SyncTestSettings', 0.002);
%         Screen('Preference', 'SuppressAllWarnings', 1);
%         Screen('Preference', 'VisualDebugLevel', 0);
    end

    % Select specific text font, style and size:
    Screen('Preference', 'DefaultFontName', experimentInfo.defaultParam.FONTNAME);
    Screen('Preference', 'DefaultFontSize', experimentInfo.defaultParam.FONTSIZE);
    Screen('Preference', 'DefaultFontStyle', 0);

    background = tools.colorParser('blue');

    % Open initialized window on screenNr
    [window, rect] = Screen('OpenWindow', ...
                            experimentInfo.screenNumber, ... 
                            background, ...
                            experimentInfo.screenRect);

    KbName('UnifyKeyNames');
    while KbCheck; end

    % write window pointer and screenRect back to the experimentInfo
    experimentInfo.windowIdx  = window;
    experimentInfo.screenRect = rect;
end

