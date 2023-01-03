function responseLanscape = responseCorrectIncorrectLandscapePortrait(stageStruct)
    
    % getting the correct/incorrect/no response answers
    % responseStages = [result(strcmp({result.type}, 'task')).stageData];
    responseStages  = [stageStruct(:, 4).stageData];
    allIsCorrect    = [responseStages.isCorrect];
    allResponseTime = ~isnan([responseStages.responseTime]);
    
    responseLanscape.nrCorrect   = sum(allIsCorrect);
	responseLanscape.nrIncorrect = sum(allIsCorrect(allResponseTime) == 0);
	responseLanscape.nrNone      = sum(allResponseTime == 0);
    
    % getting the right wrong answers after landscape or second portrait
    cueStages = [stageStruct(:,2).stageData];
    allCues   = [cueStages.image];
    allCues   = arrayfun(@(x) allCues(x), [cueStages.dataSetID]);
    allCues=string(allCues);

    for i=1:10;
yourString = allCues{i};
deleteMe = isletter(yourString); % Detect which ones are letters
yourString(deleteMe) = [];  
allCues{i}=  yourString;
    end

for i=1:10;
   noPoint= erase(allCues{i}, '.'); % Delete .
   allCues{i}=noPoint;
end
for i=1:10;
   noSlash= erase(allCues{i}, '\\'); % Delete \\
   allCues{i}=noSlash;
end
allCues=strtrim(allCues);
allCues=double(allCues); 
%Assign values 1 to landscape and 0 to portraits
allCues(allCues<199)=1; 
allCues(allCues>200)=0;
A=allCues;
 isLandscapeBefore=logical(A);
 
responseLanscape.nrCorrectLandscape = ...
        sum(allIsCorrect( isLandscapeBefore));
    responseLanscape.nrCorrectPortrait = ...
        sum(allIsCorrect(~isLandscapeBefore));
    
    responseLanscape.nrNoneLandscape = ...
        sum(allResponseTime( isLandscapeBefore) == 0);
    responseLanscape.nrNonePortrait = ...
        sum(allResponseTime(~isLandscapeBefore) == 0);
    
    responseLanscape.nrIncorrectLandscape = sum(isLandscapeBefore) - ...
        responseLanscape.nrCorrectLandscape - ...
        responseLanscape.nrNoneLandscape;
    responseLanscape.nrIncorrectPortrait = sum(~isLandscapeBefore) - ...
        responseLanscape.nrCorrectPortrait - ...
        responseLanscape.nrNonePortrait;
    
    responseLanscape.nrLandscapes = sum(isLandscapeBefore);
    responseLanscape.nrPortraits = numel(allCues) - responseLanscape.nrLandscapes;
end