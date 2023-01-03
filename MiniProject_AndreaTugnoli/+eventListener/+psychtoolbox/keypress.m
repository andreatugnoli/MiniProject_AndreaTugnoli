function [stages, experimentInfo, terminate] = keypress(stages, experimentInfo)
    % keypress: eventListener for events of keypress. Checks keyboard input and
    % calls the type specific eventHandle if available.
    %
    % SYNTAX:   [stages, experimentInfo, terminate] = ...
    %               eventListener.psychtoolbox.keypress(stages, experimentInfo)
    %
    % INPUTS:
    %           stages       	  stages structure with all stages of the
    %                           experiment
    %           experimentInfo  info structure with all the informations about
    %                           the experiment
    %
    % OUTPUTS:
    %           stages       	  updated stages structure with all stages of the
    %                           experiment
    %           experimentInfo  updated info structure with all the informations
    %                           about the experiment
    %           terminate       returns if the experiment is to terminate
    %
    % EXAMPLE:
    %           nrTrials  = 3;
    %           taskOrder = readtable('taskOrder.txt');
    %           trials    = experiment.createTasks(taskOrder, nrTrials);
    %           stages    = experiment.randomize(trials);
    %           stages    = experiment.calculateAbsoluteTimeline(stages);
    %           result    = experiment.run(stages);
    %
    % Other Classes required:
    %           Working Psychtoolbox installation
    %
    % Other files required:
    %           See README.md
    %
    % See also:
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

    if isfield(stages(experimentInfo.currentStage).stageData, 'flushEvents') && ...
        ~isnan(stages(experimentInfo.currentStage).stageData.flushEvents(1))
        flushEvents = stages(experimentInfo.currentStage).stageData.flushEvents;
    else
        flushEvents = true;
    end

    % variables
    terminate = false;

    % check keyboard input
    [keyIsDown, ~, keyCode]   = KbCheck(-3);
    keyCode = find(keyCode, 1);

    % check if any key was released (flush event)
    keyWasReleased = tools.getEventRelease(keyIsDown, 'keyboard');
    keyFlush = ~flushEvents || (flushEvents && keyWasReleased);

    % check if type specific function is available
    isFunction = exist(['+eventHandle', filesep, ...
                        stages(experimentInfo.currentStage).type], ...
                        'file');

    % call function or follow standard process
    if keyIsDown && keyFlush && isFunction
        [stages, experimentInfo, terminate] = ...
            eventHandle.(stages(experimentInfo.currentStage).type) ...
            (stages, experimentInfo, keyCode);

    elseif keyIsDown && keyFlush && ~isFunction
        % when there is no special handling for the type
        escapeKey    = KbName('ESCAPE');

        if keyCode == escapeKey
            terminate = true;
            return;
        end

        % set values
        stages(experimentInfo.currentStage).stageData.response     = true;
        stages(experimentInfo.currentStage).stageData.responseTime = ...
            toc(experimentInfo.timerIdx)- stages(experimentInfo.currentStage).onSet;

        % go to next stage
        [stages, experimentInfo, terminate] = ...
            experiment.nextStage(stages, experimentInfo);
    end
end
