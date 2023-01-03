function wasReleased = getEventRelease(deviceState, device)
    % getEventRelease: checks if the key or mouse was recently released.
    % This function is that there is no possibility that one click or keypress
    % can trigger a second event immediately after the first one. (flush event)
    %
    % SYNTAX:   wasReleased = experiment.getEventRelease(deviceState, device)
    %
    % INPUTS:
    %           wasReleased     if the key or mouse click was recently released
    %
    % OUTPUTS:
    %           deviceState     true or false of the key press or mouse click
    %           device          name of device e.g. 'mouse' or 'keyboard'
    %
    % EXAMPLE:
    %           wasReleased = experiment.getEventRelease(true, 'mouse')
    %
    % Other Classes required:
    %           Working Psychtoolbox installation.
    %
    % Other files required:
    %           See README.md
    %
    % See also:
    %           experiment.run();
    %           experiment.createTrials()
    %           experiment.createStage()
    %           experiment.createIntro()
    %           experiment.randomize()
    %           experiment.calculateAbsoluteTimeline()
    %           experiment.eventListener()
    %           experiment.nextStage()
    %           tools.calculateJitter()
    %           tools.validateResponse()
    %           tools.initialize()
    %           tools.colorPars()
    %           types
    %           eventHandle
    %           view.psychtoolbox
    %           eventListener.psychtoolbox
    %

% set persistent variables
persistent keyState mouseState

% switch for the given device
switch device
    case 'keyboard'
        % check if keyboard key is still pressed
        if isempty(keyState)
            keyState = deviceState;
            wasReleased = (keyState == 0);
        else
            wasReleased = (keyState == 0);
            keyState = deviceState;
        end

    case 'mouse'
        % check if mouse button is still pressed
        if isempty(mouseState)
            mouseState = deviceState;
            wasReleased = (mouseState == 0);
        else
            wasReleased = (mouseState == 0);
            mouseState = deviceState;
        end
end
