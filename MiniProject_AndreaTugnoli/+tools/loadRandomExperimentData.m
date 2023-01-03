function result = loadRandomExperimentData(nSubjects, file)
% This function returns a randomly created result structure to test the
% analysation scripts/functions 
%
% 1. load your experiment structure (mat file)
% 2. create random values for a bunch of unreal subjects
% 3. start with your analysis
%
% Make sure the script is randomly creating the values for all needed
% result variables.
%   - response
%   - reaction time
%   - correct answer
%   - "previous" fields in response stage
%   - cue before the task
%

%% load experiment data
if nargin < 2
    file = fullfile(pwd, 'randExampleExperimentStructure.mat');
    if nargin < 1
        nSubjects = 5;
    end
end

%% define variables
load(file, 'experimentInfo', 'task');
nTrials = experimentInfo.nrTrials;
correctFactor = 0.9;
vecTrialStages = 1 : size(task, 2);

%% create random data per subject
% a gamma distribution is used for randomization
result = repmat(task, [1, 1, nSubjects]);

% result = struct(size(task, 1), size(task, 2), nSubjects);
for subject = 1:nSubjects
    % overwrite task for new start
    currTask = result(:, :, subject);
    
    % select stage type
    stageType = 'cue';
    cueTypeIdx = vecTrialStages(strcmp({currTask(1,:).type}, stageType));
    stageType = 'task';
    taskTypeIdx = vecTrialStages(strcmp({currTask(1,:).type}, stageType));
    
    % create random variables
    reactionTimes = gamrnd(2, 1, nTrials, 1);
    correct = logical(randn([nTrials, 1]) < correctFactor);
    cueNr = randi([1,2], [nTrials, 1]);
    
    % add variables to task structure
    for trial = 1:nTrials
        % cue
        currTask(trial, cueTypeIdx).stageData.dataSetID = cueNr(trial);
        
        % task
        currTask(trial, taskTypeIdx).stageData.response = reactionTimes(trial) < currTask(1, taskTypeIdx).duration;
        if currTask(trial, taskTypeIdx).stageData.response
            currTask(trial, taskTypeIdx).stageData.responseTime = reactionTimes(trial);
        end
        currTask(trial, taskTypeIdx).stageData.isCorrect = correct(trial) && currTask(trial, taskTypeIdx).stageData.response;
        
        % copy for response stage
        currTask(trial, taskTypeIdx + 1).stageData.previousResponse = currTask(trial, taskTypeIdx).stageData.response;
        currTask(trial, taskTypeIdx + 1).stageData.previousIsCorrect = currTask(trial, taskTypeIdx).stageData.isCorrect;
    end
    
    result(:,:,subject) = currTask;
    clear currTask
end