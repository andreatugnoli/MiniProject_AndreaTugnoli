%% In this script I analyze the results
% I duplicate the results of the experiment for 25 participants
% I find;
% -the difference in correct answers for landscape and portraits
% -the difference in correct answers for color and black and white figures
% -response time for each question
%-I display the results with charts

%% load data
nrSubjects = 25;

%% generate experminet data
taskResult = tools.loadSubjectExperimentData(nrSubjects, 'PNT_S00001_01_221212_0934');

%% variables
nrSequences = size(taskResult, 1);
nrSubjects  = size(taskResult, 3);

%% Test one: difference in correct answers for landscape and portraits
% getting the data for the plots
for currentSubject = 1:nrSubjects
    responseLandscape(currentSubject,1) = ...
        analysis.responseCorrectIncorrectLandscapePortrait(taskResult(:,:,currentSubject));
end

% calculation of the average of correct answers in %
avgCorrectAll       = mean([responseLandscape.nrCorrect]) ...
                        ./ nrSequences .* 100;
avgCorrectLandscape  = mean([responseLandscape.nrCorrectLandscape]) ...
                        ./ responseLandscape(1).nrLandscapes .* 100;
avgCorrectPortrait = mean([responseLandscape.nrCorrectPortrait]) ...
                        ./ responseLandscape(1).nrPortraits .* 100;
%% Test two: difference in correct answers for Color and Black/white
% getting the data for the plots
for currentSubject = 1:nrSubjects
    responseColor(currentSubject,1) = ...
        analysis.responseCorrectIncorrectColorBlack(taskResult(:,:,currentSubject)); 
end

% calculation of the average of correct answers in %
avgCorrectColor  = mean([responseColor.nrCorrectColor]) ...
                        ./ responseColor(1).nrColors .* 100;
avgCorrectBlack = mean([responseColor.nrCorrectBlack]) ...
                        ./ responseColor(1).nrBlacks .* 100;
%% Test three: displaying the responseTime over the whole experiment
allResponseTimes = nan(nrSubjects, nrSequences);
for currentSubject = 1:nrSubjects
    curSubResponse = [taskResult(:,4,currentSubject).stageData];
    allResponseTimes(currentSubject, :) = [curSubResponse.responseTime];
end

%% Test four: plotting the results
figure(1);
% subplot for all answers
subplot(2, 2, 1);
chart.barplotAllResponses(avgCorrectAll, ...
    [responseLandscape.nrCorrect].', ...
    [responseLandscape.nrIncorrect].', ...
    [responseLandscape.nrNone].');

% subplot for all answers
subplot(2, 2, 2);
bar([sum([responseLandscape.nrCorrect]), sum([responseLandscape.nrIncorrect]), sum([responseLandscape.nrNone])]);

axis square;
title('Total over all subjects')
xlabel(sprintf(['1. Total of correct answers  \n' ...
                '2. Total of incorrect answers\n' ...
                '3. Total of no responses       ']));

% subplot for all answers after Landscape
subplot(2, 2, 3);
chart.plotResponseTimes(allResponseTimes)

%% Test five: plotting the results(2)
figure(2)

% subplot for all answers after Landscape
subplot(2, 2, 1);
chart.barplotResponseLandscape(avgCorrectLandscape, ...
    [responseLandscape(1).nrCorrectLandscape].', ...
    [responseLandscape(1).nrIncorrectLandscape].', ...
    [responseLandscape(1).nrNoneLandscape].');
xlabel(sprintf(['1. Total of correct answers  \n' ...
                '2. Total of incorrect answers\n' ...
                '3. Total of no responses       ']));

% subplot for all answers after the Portrait
subplot(2, 2, 2);
chart.barplotResponsePortrait(avgCorrectPortrait, ...
    [responseLandscape(2).nrCorrectPortrait].', ...
    [responseLandscape(2).nrIncorrectPortrait].', ...
    [responseLandscape(2).nrNonePortrait].');
xlabel(sprintf(['1. Total of correct answers  \n' ...
                '2. Total of incorrect answers\n' ...
                '3. Total of no responses       ']));
% subplot for all answers after Color Painting
subplot(2, 2, 3);
chart.barplotResponseColor(avgCorrectColor, ...
    [responseColor(1).nrCorrectColor].', ...
    [responseColor(1).nrIncorrectColor].', ...
    [responseColor(1).nrNoneColor].');
xlabel(sprintf(['1. Total of correct answers  \n' ...
                '2. Total of incorrect answers\n' ...
                '3. Total of no responses       ']));
% subplot for all answers after Black and white Painting
subplot(2, 2, 4);
chart.barplotResponseColor(avgCorrectBlack, ...
    [responseColor(2).nrCorrectBlack].', ...
    [responseColor(2).nrIncorrectBlack].', ...
    [responseColor(2).nrNoneBlack].');
xlabel(sprintf(['1. Total of correct answers  \n' ...
                '2. Total of incorrect answers\n' ...
                '3. Total of no responses       ']));

