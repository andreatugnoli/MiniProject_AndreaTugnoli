function [task, intro] = invertSubject(task, intro, subjInvert)

    % validate input
    assert(isstruct(task), 'experiment:addSubjectInfo:stages', ...
        'stages has to be of format struct.');
    assert(islogical(subjInvert) || isnumeric(subjInvert), ...
        'experiment:addSubjectInfo:subjInvert', ...
        'subjInvert has to be logical.');
    
    % add if subject is inverted (only logical)
    [task(:).responseInvert] = deal(subjInvert);
   
    % add info to intro stages
    [intro(:).responseInvert] = deal(subjInvert);
end