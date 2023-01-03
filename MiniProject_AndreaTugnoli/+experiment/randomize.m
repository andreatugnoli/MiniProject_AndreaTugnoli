function [stages, experimentInfo] = randomize(task, experimentInfo)
    % randomize: randomizes the experiment trials
    %
    % SYNTAX:   stages = experiment.randomize(trials)
    %
    % INPUTS:
    %           taskTrials      trials structure or cell with all trials of
    %                           the experiment
    %           blockSize       blockSize if there are more than one task
    %                           per run. e.g. blockSize = 5 means that each
    %                           block is exactly 5 trials long, blockSize =
    %                           [3 7] means that the blockSize randomly
    %                           vary between 3 and 7. (default is 5)
    %
    % OUTPUTS:
    %           stages          randomized the experiment structure with
    %                           all stages of the experiment
    %
    % EXAMPLE:
    %           nrTrials  = 3;
    %           taskOrder = readtable('taskOrder.txt');
    %           trials    = experiment.createTrials(taskOrder, nrTrials);
    %           stages    = experiment.randomize(trials);
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
    
    % validation of inputs
    assert(isstruct(task), ...
        'experiment:randomize:task', ...
        'The input for randomize has to be in a struct');
    
    % initialize variable
    nrTrialsInTask = size(task, 1);
    
    assert(experimentInfo.nrTrials == nrTrialsInTask, ...
        'experiment:randomize:trials', ...
        'The experiment info has a different number of trials than the task.');
    
    % cell by cell randomizing the tasks
    task = task(randperm(nrTrialsInTask), :);
    
    % add the trialNr to all stages
    for currentTrialNr = 1:nrTrialsInTask
        [task(currentTrialNr, :).trialNr] = deal(currentTrialNr);
    end
    
    task = task.';
    stages = experiment.calculateAbsoluteTimeline(task(:));
end
