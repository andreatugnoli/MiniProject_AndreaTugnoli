function [stages, experimentInfo, terminate] = keytrigger(stages, experimentInfo)
    % keytrigger: eventListener for events of keytrigger. Checks keyboard input
    % and calls the type specific eventHandle if available, before checking the
    % remaining time till the next stage starts.
    %
    % SYNTAX:   [stages, experimentInfo, terminate] = ...
    %               eventListener.psychtoolbox.keytrigger(stages, experimentInfo)
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

    % check keyboard input
    [keyIsDown, ~, keyCode]   = KbCheck(-3);
    keyCode = find(keyCode, 1);

    % check if any key was released (flush event)
    keyWasReleased = tools.getEventRelease(keyIsDown, 'keyboard');
    keyFlush = ~flushEvents || (flushEvents && keyWasReleased);

    % call type specific function
    if keyIsDown && keyFlush
        [stages, experimentInfo, terminate] = ...
            eventHandle.(stages(experimentInfo.currentStage).type) ...
            (stages, experimentInfo, keyCode);
        % if fuction throws terminate --> return
        if terminate
            return;
        end
    end

    % go to next stage
    [stages, experimentInfo, terminate] = ...
    	eventListener.psychtoolbox.time(stages, experimentInfo);
end
