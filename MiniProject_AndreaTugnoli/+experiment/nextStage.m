function [stages, experimentInfo, terminate] = ...
    nextStage(stages, experimentInfo)
    % nextStage: encreases the currentStage by one and writes the onSet variable
    % to the next stage.
    %
    % SYNTAX:   [stages, experimentInfo, terminate] = ...
    %               experiment.eventListener(stages, experimentInfo)
    %
    % INPUTS:
    %           stages          stages structure with all stages of the
    %                           experiment
    %           experimentInfo  info structure with all the informations about
    %                           the experiment
    %
    % OUTPUTS:
    %           stages          updated stages structure of the experiment
    %           experimentInfo  updated info structure with all the informations
    %                           about the experiment
    %           terminate       call for terminating the experiment
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

    % initial variables
    terminate = false;

    % check if there is a next stage
    hasNextStage = experimentInfo.currentStage <= numel(stages) - 1;
    
    % run custom events
    if ~isempty(stages(experimentInfo.currentStage).customEvents)
        stages(experimentInfo.currentStage).customEvents.run( ...
            stages(experimentInfo.currentStage).customEvents.arguments)
    end

    if hasNextStage
        if any(experimentInfo.currentStage == experimentInfo.positionTaskStages(1,:)-1)
            experimentInfo.timerIdx = tic();
        end
        
        experimentInfo.currentStage = experimentInfo.currentStage + 1;
        stages(experimentInfo.currentStage).onSet = toc(experimentInfo.timerIdx);
        stages(experimentInfo.currentStage).daytime = datetime();
        if strcmp(experimentInfo.expToolbox, 'cmdline')
            disp(stages(experimentInfo.currentStage).type);
        end
    else
        % no next stage --> terminate experiment
        terminate = true;
        return;
    end
end
