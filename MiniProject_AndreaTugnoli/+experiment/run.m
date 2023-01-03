function [result, experimentInfo] = run(stages, experimentInfo)
    % run: function that runs the whole experiment. The experiment is event
    % driven, so it refreshes the screen as fast as possible and encreases the
    % stage when the "eventNext" is reached.
    %
    % SYNTAX:   result = experiment.run(stages, experimentInfo)
    %
    % INPUTS:
    %           stages       	stages structure with all stages of the
    %                           experiment
    %           experimentInfo  info structure with all the informations about
    %                           the experiment
    %
    % OUTPUTS:
    %           result          structure of the experiment with the
    %                           results
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

    % initial variable
    experimentInfo.currentStage = 1;
    % initialize the experiment screen
    experimentInfo = tools.(experimentInfo.expToolbox).initialize(experimentInfo);

    % setup timer
    experimentInfo.timerIdx = tic();
    % set onSet time for first stage
    stages(experimentInfo.currentStage).onSet = toc(experimentInfo.timerIdx);

    while true
        % call timer or response check function
        [stages, experimentInfo, terminate] = ...
            experiment.eventListener(stages, experimentInfo);

        % if state terminate is true --> quit
        if terminate
            break;
        end

        % call the type specific function for the view (toolbox related call)
        stages(experimentInfo.currentStage) = ...
            view.(experimentInfo.expToolbox).(stages(experimentInfo.currentStage).type) ...
            (stages(experimentInfo.currentStage), experimentInfo);

        % flip screen
        tools.(experimentInfo.expToolbox).screenFlip(experimentInfo)
    end

    % close all screens
    sca;
    % save the actual stagesStruct as result
    result = stages;
end
