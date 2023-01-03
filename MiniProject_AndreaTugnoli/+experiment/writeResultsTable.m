function writeResultsTable(result, experimentInfo, relevantStages, foldername, fileending)

    % check inputs
    if nargin < 4
        foldername   = 'result';
    end

    if nargin < 5
        fileending = '.csv';
    end
    
    % transform relevantStages from row vector into column vector
    if size(relevantStages,2) > 1
        relevantStages = relevantStages.';
    end

    % validate input
    assert(isstruct(result), 'experiment:writeResultsTable:result', ...
        'Make sure that the result is of type struct.');
    
    % set filepath
    resultsfolder = sprintf('%s_%s', foldername, datestr(now, 'yymmdd_HHMM'));
    filepath = fullfile(pwd, resultsfolder);
    mkdir(filepath);

    % get result information
    resultTaskStages = result([result.trialNr] > 0);
    
    relStageDataTables = cell(numel(relevantStages), 1);

    for currentStageData = 1:numel(relevantStages)
        relStageDataTables{currentStageData} = ...
            struct2table([resultTaskStages(strcmp({resultTaskStages.type}, ...
                          relevantStages{currentStageData})).stageData]);
    end
    
    % adding total resultTable
    dataTables = [{struct2table(result)}; relStageDataTables];
    tableNames = [{'allStages'}; relevantStages];
    
    % restruct all stages
    resultStructures = cell(experimentInfo.nrRuns, 1);
    for currentRun = 1:experimentInfo.nrRuns
        resultRunStages = resultTaskStages([resultTaskStages.runNr] == currentRun);
        resultRunTask = resultRunStages([resultRunStages.taskID] == 1).';
        resultStructures{currentRun} = ...
            reshape(resultRunTask, experimentInfo.nrTrials, []);
    end
    
    % write tables
    for currentTable = 1:numel(dataTables)
        filename = sprintf('%s', tableNames{currentTable});
        writetable(dataTables{currentTable}, fullfile(filepath, sprintf('%s%s', filename, fileending)));
    end
    
    % save matlab results file
    save(fullfile(filepath, 'sourceResultData.mat'), ...
        'result', 'experimentInfo', 'resultStructures');
end