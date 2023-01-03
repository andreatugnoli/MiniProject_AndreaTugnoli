function [stages, experimentInfo, terminate] = ...
         	eventListener(stages, experimentInfo)
    % eventListener: checks the experiment timeline and the pressed keys.
    % For checking the different stages, use the given "eventNext" variable
    % of the stages to define how the next stage should be reached. The
    % implemented eventNext are in eventListener.psychtoolbox located
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

    % variables
    terminate = false;

    % switch to seperate between different types of stages
    isFunction = exist( ...
        fullfile( ...
            '+eventListener', ...
            sprintf('+%s', experimentInfo.expToolbox), ...
            stages(experimentInfo.currentStage).eventNext), ...
        'file');

    if isFunction
        [stages, experimentInfo, terminate] = ...
            eventListener.(experimentInfo.expToolbox).(stages(experimentInfo.currentStage).eventNext) ...
            (stages, experimentInfo);
    end
end
