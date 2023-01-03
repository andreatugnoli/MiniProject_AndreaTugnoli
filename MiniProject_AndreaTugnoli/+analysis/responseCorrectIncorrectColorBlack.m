function responseColor = responseCorrectIncorrectColorBlack(stageStruct)
    
     % getting the correct/incorrect/no response answers
    % responseStages = [result(strcmp({result.type}, 'task')).stageData];
    % Color=Landscape
    %Black=Portrait
    responseStages  = [stageStruct(:, 4).stageData];
    allIsCorrect    = [responseStages.isCorrect];
    allResponseTime = ~isnan([responseStages.responseTime]);
    
    responseColor.nrCorrect   = sum(allIsCorrect);
	responseColor.nrIncorrect = sum(allIsCorrect(allResponseTime) == 0);
	responseColor.nrNone      = sum(allResponseTime == 0);
    
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
allCues(allCues<99)=1;
allCues(allCues>300)=0;
allCues(allCues>200)=1;
allCues(allCues>100)=0;
A=allCues;
 isColorBefore=logical(A);
 
responseColor.nrCorrectColor = ...
        sum(allIsCorrect( isColorBefore));
    responseColor.nrCorrectBlack = ...
        sum(allIsCorrect(~isColorBefore));
    
    responseColor.nrNoneColor = ...
        sum(allResponseTime( isColorBefore) == 0);
    responseColor.nrNoneBlack = ...
        sum(allResponseTime(~isColorBefore) == 0);
    
    responseColor.nrIncorrectColor = sum(isColorBefore) - ...
        responseColor.nrCorrectColor - ...
        responseColor.nrNoneColor;
    responseColor.nrIncorrectBlack = sum(~isColorBefore) - ...
        responseColor.nrCorrectBlack - ...
        responseColor.nrNoneBlack;
    
    responseColor.nrColors = sum(isColorBefore);
    responseColor.nrBlacks = numel(allCues) - responseColor.nrColors;
end