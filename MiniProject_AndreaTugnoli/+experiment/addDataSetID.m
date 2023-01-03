function task = addDataSetID(task, stageType, nrOptions, maxContRep, idNr)
    % addDataSetID: adds a data set ID to a specific stageType. Creates a
    % vector with random numbers with boundarys for number of options and
    % maximum of continuous repetition of each number.
    %
    % SYNTAX:   task = experiment.addDataSetID(task, stageType, ...
    %               nrOptions, maxContRep);
    %
    % INPUTS:
    %           task        	struct with the task information
    %           stageType       add a new dataSetID to the specified type
    %           nrOptions       number of possible options for the dataSetID
    %           maxContRep      max of continues repetition of random numbers
    %           idNr            data set number (element nr in the array)
    %
    % OUTPUTS:
    %           tasks           struct with the updated task information
    %
    % EXAMPLE:
    %           experiment.addDataSetID(task, 'fixation', 4, 2);
    %
    % Other Classes required:
    %           Working Psychtoolbox installation
    %
    % Other files required:
    %           See README.md
    %
    % See also:
    %           experiment.run();
    %           experiment.createTask()
    %           experiment.createStage()
    %           experiment.createIntro()
    %           experiment.randomize()
    %           experiment.eventListener()
    %           experiment.nextStage()
    %           tools.calculateJitter()
    %           tools.validateResponse()
    %           tools.initialize()
    %           tools.colorParser()
    %           types
    %           eventHandle
    %           view.psychtoolbox
    %           eventListener.psychtoolbox
    %
 
    % validate input arguments
    hasIDnr = false;
    if nargin > 4
        assert(isnumeric(idNr) && idNr > 0 && round(idNr) == idNr, ...
            'experiment:addDataSetID:IDnr', ...
            'The ID number has to be numeric and positive integers')
        hasIDnr = true;
    end
    
    assert(isstruct(task), 'experiment:addDataSetID:trials', ...
        'The input variable trials has to be of type struct.');
    assert(ischar(stageType), ...
        'experiment:addDataSetID:stageType', ...
        'The input variable stageType has to be a character array.');

    % define variables
    nrTrials       = size(task, 1);
    nrRepetitions  = ceil(nrTrials / nrOptions);
    vecTrialStages = 1 : size(task, 2);

    % create data set ids
    dataSetID = tools.randArrWithMaxRep(nrOptions, nrRepetitions, maxContRep);
    
    % add ids to trials
    typeIdx = vecTrialStages(strcmp({task(1,:).type}, ...
        stageType));

    for currentTrial = 1:nrTrials
        currentDataSetID = task(currentTrial, typeIdx).stageData.dataSetID;
        if hasIDnr && all(isnan(currentDataSetID))
            task(currentTrial, typeIdx).stageData.dataSetID = ...
                [zeros(1, idNr-1), dataSetID(currentTrial)];
        elseif hasIDnr
            task(currentTrial, ...
                typeIdx).stageData.dataSetID(1, idNr) = dataSetID(currentTrial);
        elseif isnan(currentDataSetID)
            task(currentTrial, typeIdx).stageData.dataSetID = ...
                dataSetID(currentTrial);
        else
            task(currentTrial, typeIdx).stageData.dataSetID = ...
                [currentDataSetID, dataSetID(currentTrial)];
        end
        nrIDs = numel(task(currentTrial, typeIdx).stageData.dataSetID);
    end
        
    if nrIDs > 1
        warning('The trial stage type %s has now %d dataSetID''s', ...
            stageType, nrIDs);
    end
end