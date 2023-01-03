function [expStages, experimentInfo] = combine(stages, intro, experimentInfo, overwrite)
    % combine: takes the experiment order which was build in intro and
    % exchange the yieldtasks with the corresponding stages.
    %
    % SYNTAX:   [expStages] = experiment.combine(stages, intro)
    %           % for an experiment that holds three runs:
    %           [expStages] = ...
    %               experiment.combine({stagesRun1, stagesRun2, stagesRun3}, intro)
    %
    % INPUTS:
    %           stages          cell or struct with all taskstages
    %                           in the right order (if there is more than
    %                           one yieldTask, but just a cell with one
    %                           structure it will copy it to all yieldTasks)
    %           intro           intro structure, holds the order of the
    %                           experiment in it
    %
    % OUTPUTS:
    %           expStages       combined structure with all stages for the
    %                           experiment
    %
    % EXAMPLE:
    %           None available
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

    if isstruct(stages)
        stages = {stages};
    end
    
    if nargin < 4
        overwrite = true;
    end
    
    % check that the experiment doesn't start with a task
    assert(~strcmp(intro(1).type, 'allTasks'), ...
        'experiment:combine:allTasks', ...
        'You can not start with a task.');
    
    assert(iscell(stages), 'experiment:combine:stages', ...
        'The stages input for combine has to be in a struct or cell.');
    
    % initial variables
    runCounter = 1;
    expStages  = intro(1);
    
    if experimentInfo.nrRuns > numel(stages)
        % duplicate first run elements (if just one is given)
        [stages{numel(stages)+1:experimentInfo.nrRuns}] = deal(stages{1});
    elseif experimentInfo.nrRuns < numel(stages) && overwrite
        experimentInfo.nrRuns = numel(stages);
    end
    
    % add runNr to the stages
    for currentRun = 1:experimentInfo.nrRuns
        [stages{currentRun}.runNr] = deal(currentRun);
        
        % calculate total experiment time
        experimentInfo.totalTime(currentRun) = sum([stages{currentRun}(:).duration]);
    end
    
    % fill the expStages structure
    for currentexpStage = 2:numel(intro)
        if strcmp(intro(currentexpStage).type, 'allTasks')
            
            % update "allTasks" position to experimentInfo
            experimentInfo.positionTaskStages(:, runCounter) = ...
                [numel(expStages) + 1; ...
                 numel(expStages) + numel(stages{runCounter})];
            
            % add "allTasks" stages to expStages
            expStages  = [expStages; stages{runCounter}]; %#ok
            
            runCounter = runCounter + 1;
        else
            expStages = [expStages; intro(currentexpStage)]; %#ok
        end
    end
end