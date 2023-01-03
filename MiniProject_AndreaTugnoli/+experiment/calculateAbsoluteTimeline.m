function stages = calculateAbsoluteTimeline(stages)
    % calculateAbsoluteTimeline: Calculate the absolute timeline of the
    % experiment and adds it to the stages.
    %
    % SYNTAX:   stages = experiment.calculateAbsoluteTimeline(stages)
    %
    % INPUTS:
    %           stages          stages structure with all stages of the
    %                           experiment
    %
    % OUTPUTS:
    %           stages          stages structure with all stages of the
    %                           experiment with added absolute timeline
    %
    % EXAMPLE:
    %           nrTrials  = 3;
    %           taskOrder = readtable('taskOrder.txt');
    %           trials    = experiment.createTasks(taskOrder, nrTrials);
    %           stages    = experiment.randomize(trials);
    %           stages    = experiment.calculateAbsoluteTimeline(stages);
    %
    % Other Classes required:
    %           None
    %
    % Other files required:
    %           None
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

    %% calculate absolut timeline for the experiment
    timeline = num2cell(cumsum([stages.duration]));
    [stages.nextStageAt] = timeline{:};

end
