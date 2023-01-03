%% Is this a painting?
% In this experiment, participants have to guess if the picture shown is a
% painting. In this experiment, we show only paintings. Specifically, there
% are 10 paintings shown both in color and black and white. 5 paintings are
% landascape and 5 paintings are portraits. We show the same paintings in
% color and black and white.
% This experiment wants the following hypothesis:
% 1. Participants make more mistake when the painting is black and white
%    compared to color.
% 2. Participants make more mistake when the painting is a portrait
%    compared to a landscape.
% 3. The response time is higher for black and white than color pictures.
% 4. The response time is higher for portraits compared to landscapes.
% 5. The effect of black and white on response rate is higher on portraits 
% compared to landscapes.
% 6. The effect of black and white on mistakes is higher on portraits 
% compared to landscapes.
%
% Engineered by: Andrea Tugnoli
% Date: 30.12.2022

rng("shuffle"); 
fileparts(fileparts(mfilename("fullpath")))

[trialStages, expStages] = tools.loadStruct('trialStages.txt', 'expStages.txt');

%% Build experiment information structure
experimentInfo = experiment.addInfo( ...
    'title', 'Is it a painting?', ...
    'experimenter', 'Andrea Tugnoli', ...
    'nrTrials', 10, ...
    'screenRect', [0, 0, 800, 600], ... 
    'expToolbox', 'psychtoolbox' ...
    );
experimentInfo.viewParam.fontSize      = 30;
experimentInfo.viewParam.fixationSize  = 90;

%% check the values in the command window
disp(experimentInfo);

%% create the task for the experiment
task = experiment.createTask(trialStages, experimentInfo);

%% add data set ID for random parameters over all task trials
% define overall variable
maxContRep = 2;

% create the data set ID for the task
nrOptions  = 4;
stageType  = 'task';
task = experiment.addDataSetID(task, stageType, nrOptions, maxContRep, 1);

% create the data set ID for the cues
nrOptions  = 20;
stageType  = 'cue';
task = experiment.addDataSetID(task, stageType, nrOptions, maxContRep, 1);

%% create the start/end of the experiment
[intro, experimentInfo] = experiment.createIntro(expStages, experimentInfo);

%% clear unused variables
clear expStages trialStages maxContRep nrOptions stageType

%% Subject information
experimentInfo.subject = 'PNT_S00001_01';

randInvert = logical(randi([0, 1], 1));
[task, intro] = experiment.invertSubject(task, intro, randInvert);

%% randomize the Experiment ORDER
stages = experiment.randomize(task, experimentInfo);

%% include intro and end of experiment
[stages, experimentInfo] = experiment.combine(stages, intro, experimentInfo);

%% show experiment
disp(struct2table(stages));

%% Prove consistency of Experiment
experiment.checkTimeLine(stages, experimentInfo);

%% clear unneeded variables before running experiment
clear randInvert intro task

%% Run the Experiment
[result, experimentInfo] = experiment.run(stages, experimentInfo);

%% show tasks in a table with dataSetID and combinations
paintTaskStages = result(strcmp({result.type}, 'task'));
paintTaskStageData = [paintTaskStages.stageData];

disp(struct2table(paintTaskStageData));
disp([paintTaskStageData.dataSetID]);
disp(paintTaskStageData(1).combinations);

%% write result into a file
foldername   = experimentInfo.subject;
relevantStages = {'task', 'response', 'cue'};
experiment.writeResultsTable(result, experimentInfo, relevantStages, foldername);

