function taskResult = loadSubjectExperimentData(nSubjects, srcSubjectDataDir)

    if nargin < 2
        srcSubjectDataDir = 'PNT_S00001_01_221207_0911';
        if nargin < 1
            nSubjects = 5;
        end
    end

    %% load result data
    load(fullfile(srcSubjectDataDir, 'sourceResultData.mat'), 'experimentInfo', 'result');

    %% restructure data [nStages x 1] --> [nTrials x stagesPerTrial]
    taskStages = experimentInfo.positionTaskStages;

    taskResult = result(taskStages(1):taskStages(2));
    taskResult = reshape(taskResult, [], experimentInfo.nrTrials).';

    % assume all n subjects all equal
    taskResult = repmat(taskResult, 1, 1, nSubjects);
end

