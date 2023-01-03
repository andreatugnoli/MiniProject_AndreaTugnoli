function [intro, experimentInfo] = createIntro(expStages, experimentInfo, introID)
    % createIntro: Create all intro elements for the experiment.
    %
    % SYNTAX:   [intro, experimentInfo] = ...
    %               experiment.createIntro(expOrder, experimentInfo)
    %
    % INPUTS:
    %           expOrder        table with column-names for the different
    %                           fieldnames
    %           experimentInfo  info structure with all the informations about
    %                           the experiment
    %
    % OUTPUTS:
    %           intro           intro structure with all intro elements of
    %                           the experiment
    %           experimentInfo  updated info structure with all the informations
    %                           about the experiment
    %
    % EXAMPLE:
    %           expOrder = readtable('expOrder.txt');
    %           exp = experiment.createIntro(expOrder);
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

    if nargin < 3
        introID = 'intro';
    end
    
    %% Define Parameters
    intro = experiment.createTask(expStages, experimentInfo, introID);

    %% set all intro stages into a row
    intro = intro(1,:).';
    intro = intro(:);

    expStagesVec = 1:size(expStages, 1);
    experimentInfo.positionTaskStages = ...
        repmat(expStagesVec(strcmp({intro.type}, 'allTasks')), 2,1);
    experimentInfo.nrIntroStages = ...
        experimentInfo.positionTaskStages(1) - 1;
    experimentInfo.nrFinalStages = ...
        numel(intro) - experimentInfo.positionTaskStages(end);
    [intro(:).trialNr] = deal(0);
end
