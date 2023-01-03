function trials = createTask(trialStages, experimentInfo, taskID)
    % createTask: Create all trials in the experiment task, following the
    % trialStages and the Number of Trials.
    %
    % SYNTAX:   trials = experiment.createTask(trialStages, experimentInfo, taskID)
    %
    % INPUTS:
    %           trialStages     struct with fieldnames of the stage variables
    %           experimentInfo  information to the experiment
    %           taskID          identifier for the task (usefull, if there
    %                           is more than one task in the experiment,
    %                           default: 1)
    %
    % OUTPUTS:
    %           trials          trials structure with all trials of the
    %                           experiment
    %
    % EXAMPLE:
    %           nrTrials = 3;
    %           taskOrder = readtable('taskOrder.txt');
    %           trials = experiment.createTask(trialStages, ...
    %               experimentInfo, taskID);
    %
    % Other Classes required:
    %           None
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

    if nargin < 3
        taskID = 1;
    end
    
    %% variables
    currTaskID = taskID;
    
    % max number of defined nTrials (needed when defined as Array)
    maxTrials = numel(experimentInfo.nrTrials);
    if taskID > maxTrials
        currTaskID = maxTrials;
    end
    
    nrTrials = experimentInfo.nrTrials(currTaskID);
    
    %% Define base structure of the stages
    baseStruct = experiment.createStage();

    %% repeat baseStruct for one trial
    trial = repmat(baseStruct, 1, size(trialStages, 1));

    %% fills the data from the trialStages into the tasks struct
    variableNames = fieldnames(trialStages);
    
    for currentVariable = 1:numel(variableNames)
        [trial(:).(variableNames{currentVariable})] = ...
            trialStages.(variableNames{currentVariable});
    end
    
    %% Call the type function for each type
    for currentTrialStage = 1:size(trial, 2)
            trial(currentTrialStage).stageData = ...
                types.(trial(currentTrialStage).type)();
    end

    %% Add taskID to trial stages
    [trial(:).taskID] = deal(taskID);
    
    %% Create full experiment task structure
    trials = repmat(trial, nrTrials, 1);

    %% Create jitter, if a jitter is given
    if any(strcmp('jitter', variableNames))
        shuffle = @(x)randperm(nrTrials);

        for currentTrialStage = 1:size(trials, 2)
            jitter = ...
                tools.calculateJitter( ...
                trialStages(currentTrialStage).jitter, nrTrials ...
                ) + trialStages(currentTrialStage).duration;
            jitter = num2cell(jitter(shuffle()));

            [trials(:, currentTrialStage).duration] = jitter{:};
        end
    end

    %% Add the sequence number to the tasks
    for currentTrialStage = 1:size(trials, 1)
        [trials(currentTrialStage, :).desMatNr] = deal(currentTrialStage);
    end
end
