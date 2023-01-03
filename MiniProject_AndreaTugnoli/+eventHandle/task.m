function [stages, experimentInfo, terminate] = task(stages, experimentInfo, keyCode)
    % task: eventHandle of the type task. Does the nessesary calculation and checks
    % while the stages of this type are shown.
    %
    % SYNTAX:   [stages, experimentInfo, terminate] = ...
    %               eventHandle.task(stages, experimentInfo, keyCode)
    %
    % INPUTS:
    %           stages       	  stages structure with all stages of the
    %                           experiment
    %           experimentInfo  info structure with all the informations about
    %                           the experiment
    %           keyCode         keyCode of the pressed key
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
    %           experiment.run()
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
    responseColors = {'white', 'white'};  % related to the cell responses
    % read correct color for this stage
    correctResponseColor = stages(...
        experimentInfo.currentStage).stageData.combinations{ ...
        stages(experimentInfo.currentStage).stageData.dataSetID, 1};

    % keys
    escapeKey    = KbName('ESCAPE');
    responses{1} = KbName('j'); % related to the cell responseColors
    responses{2} = KbName('k'); % related to the cell responseColors
    
    if stages(experimentInfo.currentStage).responseInvert
        responseColors = fliplr(responseColors);
        responses      = fliplr(responses);
    end

    if keyCode == escapeKey
        terminate = true;
        return;
    end

    % set values
    stages(experimentInfo.currentStage).stageData.response     = true;
    stages(experimentInfo.currentStage).stageData.responseTime = ...
        toc(experimentInfo.timerIdx) - stages(experimentInfo.currentStage).onSet;

    % check key color
    isKeyCode = keyCode == KbName('j');
    stages(experimentInfo.currentStage).stageData.isCorrect = any(isKeyCode) && ...
        tools.validateResponse(responseColors{isKeyCode}, ...
                                correctResponseColor);

    % set the nextStageAt for response (so, that response isn't the buffer)
    stages(experimentInfo.currentStage).nextStageAt = toc(experimentInfo.timerIdx);
    stages(experimentInfo.currentStage + 1).nextStageAt = ...
        stages(experimentInfo.currentStage).nextStageAt + ...
        stages(experimentInfo.currentStage + 1).duration;

    % set responses in the next stage
    stages(experimentInfo.currentStage + 1).stageData.previousIsCorrect = ...
        stages(experimentInfo.currentStage).stageData.isCorrect;
    stages(experimentInfo.currentStage + 1).stageData.previousResponse = ...
        stages(experimentInfo.currentStage).stageData.response;

    % go to next stage
    [stages, experimentInfo, terminate] = ...
        experiment.nextStage(stages, experimentInfo);
end
