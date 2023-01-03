function [stages, experimentInfo, terminate] = time(stages, experimentInfo)
    % time: eventListener for events of time. Checks the timeline of the
    % experiment and set currentStage to next if time is up.
    %
    % SYNTAX:   [stages, experimentInfo, terminate] = ...
    %               eventListener.psychtoolbox.time(stages, experimentInfo)
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

    % variable
    terminate = false;

    % logicals for if loops
    hasTime    = ~isnan(stages(experimentInfo.currentStage).duration);
    noDountil  =  isnan(stages(experimentInfo.currentStage).nextStageAt);
    isTimeOver = stages(experimentInfo.currentStage).nextStageAt < ...
        toc(experimentInfo.timerIdx);

    % check if time is over
    if isTimeOver
        if isfield(stages(experimentInfo.currentStage).stageData, 'response')
            stages(experimentInfo.currentStage).stageData.response = false;
        end
        if isfield(stages(experimentInfo.currentStage).stageData, 'isCorrect')
            stages(experimentInfo.currentStage).stageData.isCorrect = false;
        end
            [stages, experimentInfo, terminate] = ...
                experiment.nextStage(stages, experimentInfo);
    elseif hasTime && noDountil
        % exeption for intro stages who will have no nextStageAt value
        if toc(experimentInfo.timerIdx) > stages(experimentInfo.currentStage).onSet + ...
                            stages(experimentInfo.currentStage).duration
            [stages, experimentInfo, terminate] = ...
                experiment.nextStage(stages, experimentInfo);
        end
    end % if
end
