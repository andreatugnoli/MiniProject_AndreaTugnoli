function [stages, experimentInfo, terminate] = timeFunc(stages, experimentInfo)
    % timeFunc: eventListener for events of timeFunc. Checks the timeFuncline of the
    % experiment and set currentStage to next if timeFunc is up.
    %
    % SYNTAX:   [stages, experimentInfo, terminate] = ...
    %               eventListener.psychtoolbox.timeFunc(stages, experimentInfo)
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
    %           stages    = experiment.calculateAbsolutetimeFuncline(stages);
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

    % check if type specific function is available
    isFunction = exist(['+eventHandle', filesep, ...
                        stages(experimentInfo.currentStage).type], ...
                        'file');

    % call function or follow standard process
    if isFunction
        [stages, experimentInfo, terminate] = ...
            eventHandle.(stages(experimentInfo.currentStage).type) ...
            (stages, experimentInfo);
        % if function throws terminate --> return
        if terminate
            return;
        end
    end
    
    % go to next stage
    [stages, experimentInfo, terminate] = ...
    	eventListener.psychtoolbox.time(stages, experimentInfo);
end
